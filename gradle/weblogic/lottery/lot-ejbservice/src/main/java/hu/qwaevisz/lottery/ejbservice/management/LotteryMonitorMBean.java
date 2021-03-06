package hu.qwaevisz.lottery.ejbservice.management;

import javax.ejb.Local;

@Local
public interface LotteryMonitorMBean {

	String getPuller();

	void setPuller(String name);

	Integer getPrizePool();

	void setPrizePool(Integer value);

	int getDistribution(int hit);

	int[] getDistributions();

	void setDistribution(int hit, int value);

}
