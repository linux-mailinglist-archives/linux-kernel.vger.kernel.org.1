Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2222889AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbgJINX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:23:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:46079 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729935AbgJINX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:23:57 -0400
IronPort-SDR: KfeAXzQI+rV8xx7uUyr6SQHVXv0dL/UVan2e4yGBuZx8jWVJKmC5OYzZndcxXPmJ1gh1lnQz2J
 US81Y8JzH3Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="164693633"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="164693633"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 06:23:56 -0700
IronPort-SDR: geQbGFMdRwREImRhiev463DqY7f4SNYSPUTboRfBzWAsQBRw2Zvky5GmHWSeSbURHiH8uSIiB8
 3G4FA4SmwuNg==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="298435646"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 06:23:55 -0700
Date:   Fri, 9 Oct 2020 21:37:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: drivers/power/supply/mp2629_charger.c:522:9: warning: %d in format
 string (no. 1) requires 'int' but the argument type is 'unsigned int'.
Message-ID: <20201009133734.GE8133@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   549738f15da0e5a00275977623be199fbbf7df50
commit: 3bc6d790c39dfc4539c36525e6bcb617abbae467 power: supply: Add support for mps mp2629 battery charger
date:   4 months ago
:::::: branch date: 12 hours ago
:::::: commit date: 4 months ago
compiler: sh4-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


vim +522 drivers/power/supply/mp2629_charger.c

3bc6d790c39dfc Saravanan Sekar 2020-05-26  508  
3bc6d790c39dfc Saravanan Sekar 2020-05-26  509  static ssize_t batt_impedance_compensation_show(struct device *dev,
3bc6d790c39dfc Saravanan Sekar 2020-05-26  510  					   struct device_attribute *attr,
3bc6d790c39dfc Saravanan Sekar 2020-05-26  511  					   char *buf)
3bc6d790c39dfc Saravanan Sekar 2020-05-26  512  {
3bc6d790c39dfc Saravanan Sekar 2020-05-26  513  	struct mp2629_charger *charger = dev_get_drvdata(dev->parent);
3bc6d790c39dfc Saravanan Sekar 2020-05-26  514  	unsigned int rval;
3bc6d790c39dfc Saravanan Sekar 2020-05-26  515  	int ret;
3bc6d790c39dfc Saravanan Sekar 2020-05-26  516  
3bc6d790c39dfc Saravanan Sekar 2020-05-26  517  	ret = regmap_read(charger->regmap, MP2629_REG_IMPEDANCE_COMP, &rval);
3bc6d790c39dfc Saravanan Sekar 2020-05-26  518  	if (ret)
3bc6d790c39dfc Saravanan Sekar 2020-05-26  519  		return ret;
3bc6d790c39dfc Saravanan Sekar 2020-05-26  520  
3bc6d790c39dfc Saravanan Sekar 2020-05-26  521  	rval = (rval >> 4) * 10;
3bc6d790c39dfc Saravanan Sekar 2020-05-26 @522  	return sprintf(buf, "%d mohm\n", rval);
3bc6d790c39dfc Saravanan Sekar 2020-05-26  523  }
3bc6d790c39dfc Saravanan Sekar 2020-05-26  524  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

