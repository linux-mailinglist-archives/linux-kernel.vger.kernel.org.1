Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D742D2B73AA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 02:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgKRBSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 20:18:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:10924 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgKRBSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 20:18:20 -0500
IronPort-SDR: rrwjOLOgXqaHYS+DuRUBjr+BfINOb1wP4ULxhgi2fXeXWkrQJs9m2s4msN154u/cK3rrOvmHyb
 +r2ZyrpYDJsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="170264475"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="170264475"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 17:18:20 -0800
IronPort-SDR: 95rPe/ac1LH6QVYzBzJHaGVjNcLiNHZp1Edc7RE0rVXjVhX72nvXKlgCzUkOJfvnRLjfidBcHj
 hQSJqNuxgmAQ==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544285306"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 17:18:18 -0800
Date:   Wed, 18 Nov 2020 09:17:32 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>
Subject: drivers/net/phy/mscc/mscc_ptp.c:138:12: warning: Redundant
 condition: cond. '!cond || (cond && upper)' is equivalent to '!cond ||
 upper'
Message-ID: <20201118011732.GE3723@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9c87c9f41245baa3fc4716cf39141439cf405b01
commit: ab2bf933935710ac545f94e49d16b5eab01f846f net: phy: mscc: 1588 block initialization
compiler: h8300-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <rong.a.chen@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> kernel/taskstats.c:220:0: warning: syntax error [syntaxError]
   
   ^
--
>> drivers/net/phy/mscc/mscc_ptp.c:138:12: warning: Redundant condition: cond. '!cond || (cond && upper)' is equivalent to '!cond || upper' [redundantCondition]
    if (!cond || (cond && upper))
              ^

vim +138 drivers/net/phy/mscc/mscc_ptp.c

ab2bf933935710a Quentin Schulz 2020-06-23  104  
ab2bf933935710a Quentin Schulz 2020-06-23  105  static void vsc85xx_ts_write_csr(struct phy_device *phydev, enum ts_blk blk,
ab2bf933935710a Quentin Schulz 2020-06-23  106  				 u16 addr, u32 val)
ab2bf933935710a Quentin Schulz 2020-06-23  107  {
ab2bf933935710a Quentin Schulz 2020-06-23  108  	struct vsc8531_private *priv = phydev->priv;
ab2bf933935710a Quentin Schulz 2020-06-23  109  	bool base_port = phydev->mdio.addr == priv->ts_base_addr;
ab2bf933935710a Quentin Schulz 2020-06-23  110  	u32 reg, bypass, cnt = 0, lower = val & 0xffff, upper = val >> 16;
ab2bf933935710a Quentin Schulz 2020-06-23  111  	bool cond = (addr == MSCC_PHY_PTP_LTC_CTRL ||
ab2bf933935710a Quentin Schulz 2020-06-23  112  		     addr == MSCC_PHY_1588_INGR_VSC85XX_INT_MASK ||
ab2bf933935710a Quentin Schulz 2020-06-23  113  		     addr == MSCC_PHY_1588_VSC85XX_INT_MASK ||
ab2bf933935710a Quentin Schulz 2020-06-23  114  		     addr == MSCC_PHY_1588_INGR_VSC85XX_INT_STATUS ||
ab2bf933935710a Quentin Schulz 2020-06-23  115  		     addr == MSCC_PHY_1588_VSC85XX_INT_STATUS) &&
ab2bf933935710a Quentin Schulz 2020-06-23  116  		    blk == PROCESSOR;
ab2bf933935710a Quentin Schulz 2020-06-23  117  	enum ts_blk_hw blk_hw;
ab2bf933935710a Quentin Schulz 2020-06-23  118  
ab2bf933935710a Quentin Schulz 2020-06-23  119  	switch (blk) {
ab2bf933935710a Quentin Schulz 2020-06-23  120  	case INGRESS:
ab2bf933935710a Quentin Schulz 2020-06-23  121  		blk_hw = base_port ? INGRESS_ENGINE_0 : INGRESS_ENGINE_1;
ab2bf933935710a Quentin Schulz 2020-06-23  122  		break;
ab2bf933935710a Quentin Schulz 2020-06-23  123  	case EGRESS:
ab2bf933935710a Quentin Schulz 2020-06-23  124  		blk_hw = base_port ? EGRESS_ENGINE_0 : EGRESS_ENGINE_1;
ab2bf933935710a Quentin Schulz 2020-06-23  125  		break;
ab2bf933935710a Quentin Schulz 2020-06-23  126  	case PROCESSOR:
ab2bf933935710a Quentin Schulz 2020-06-23  127  	default:
ab2bf933935710a Quentin Schulz 2020-06-23  128  		blk_hw = base_port ? PROCESSOR_0 : PROCESSOR_1;
ab2bf933935710a Quentin Schulz 2020-06-23  129  		break;
ab2bf933935710a Quentin Schulz 2020-06-23  130  	}
ab2bf933935710a Quentin Schulz 2020-06-23  131  
ab2bf933935710a Quentin Schulz 2020-06-23  132  	mutex_lock(&phydev->mdio.bus->mdio_lock);
ab2bf933935710a Quentin Schulz 2020-06-23  133  
ab2bf933935710a Quentin Schulz 2020-06-23  134  	bypass = phy_ts_base_read(phydev, MSCC_PHY_BYPASS_CONTROL);
ab2bf933935710a Quentin Schulz 2020-06-23  135  
ab2bf933935710a Quentin Schulz 2020-06-23  136  	phy_ts_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_1588);
ab2bf933935710a Quentin Schulz 2020-06-23  137  
ab2bf933935710a Quentin Schulz 2020-06-23 @138  	if (!cond || (cond && upper))
ab2bf933935710a Quentin Schulz 2020-06-23  139  		phy_ts_base_write(phydev, MSCC_PHY_TS_CSR_DATA_MSB, upper);
ab2bf933935710a Quentin Schulz 2020-06-23  140  
ab2bf933935710a Quentin Schulz 2020-06-23  141  	phy_ts_base_write(phydev, MSCC_PHY_TS_CSR_DATA_LSB, lower);
ab2bf933935710a Quentin Schulz 2020-06-23  142  
ab2bf933935710a Quentin Schulz 2020-06-23  143  	phy_ts_base_write(phydev, MSCC_PHY_TS_BIU_ADDR_CNTL, BIU_ADDR_EXE |
ab2bf933935710a Quentin Schulz 2020-06-23  144  			  BIU_ADDR_WRITE | BIU_BLK_ID(blk_hw) |
ab2bf933935710a Quentin Schulz 2020-06-23  145  			  BIU_CSR_ADDR(addr));
ab2bf933935710a Quentin Schulz 2020-06-23  146  
ab2bf933935710a Quentin Schulz 2020-06-23  147  	do {
ab2bf933935710a Quentin Schulz 2020-06-23  148  		reg = phy_ts_base_read(phydev, MSCC_PHY_TS_BIU_ADDR_CNTL);
ab2bf933935710a Quentin Schulz 2020-06-23  149  	} while (!(reg & BIU_ADDR_EXE) && cnt++ < BIU_ADDR_CNT_MAX);
ab2bf933935710a Quentin Schulz 2020-06-23  150  
ab2bf933935710a Quentin Schulz 2020-06-23  151  	phy_ts_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
ab2bf933935710a Quentin Schulz 2020-06-23  152  
ab2bf933935710a Quentin Schulz 2020-06-23  153  	if (cond && upper)
ab2bf933935710a Quentin Schulz 2020-06-23  154  		phy_ts_base_write(phydev, MSCC_PHY_BYPASS_CONTROL, bypass);
ab2bf933935710a Quentin Schulz 2020-06-23  155  
ab2bf933935710a Quentin Schulz 2020-06-23  156  	mutex_unlock(&phydev->mdio.bus->mdio_lock);
ab2bf933935710a Quentin Schulz 2020-06-23  157  }
ab2bf933935710a Quentin Schulz 2020-06-23  158  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
