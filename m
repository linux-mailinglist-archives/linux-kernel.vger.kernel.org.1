Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730DB2C5EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 03:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404107AbgK0CqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 21:46:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:1330 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbgK0CqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 21:46:07 -0500
IronPort-SDR: sNkgTFkN2Gxkux9rHmd2Od79eJeXX8QuDBkVvhebKV4iUNLhQzdkumBvmH6sy3vwmM6aIUwzir
 NSsWcwPA2jqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="159390653"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="159390653"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 18:46:06 -0800
IronPort-SDR: iA6kORbtUJkScIIr2NpQtD3e2CzuS7Tupqp6R3y02zRVe6bg59NvKbYG0M1yTzaUeOJKa6TceX
 1MVyeiYOLaJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="433394877"
Received: from lkp-server02.sh.intel.com (HELO e51121f5de4e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2020 18:46:05 -0800
Received: from kbuild by e51121f5de4e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiTlj-00005O-Hq; Fri, 27 Nov 2020 02:45:55 +0000
Date:   Fri, 27 Nov 2020 10:45:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v2 1/1] usb: typec: tps6598x: Export some power supply
 properties
Message-ID: <202011271005.zJVawX74-lkp@intel.com>
References: <616993b62e4a8a39f2d8d874d95189b875dd05d8.1606410063.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <616993b62e4a8a39f2d8d874d95189b875dd05d8.1606410063.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Guido,

I love your patch! Yet something to improve:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on v5.10-rc5 next-20201126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Guido-G-nther/usb-typec-tps6598x-Export-some-power-supply-properties/20201127-010748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: x86_64-rhel
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/e2127770a7cde95b57cbdc55a68d783382282517
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Guido-G-nther/usb-typec-tps6598x-Export-some-power-supply-properties/20201127-010748
        git checkout e2127770a7cde95b57cbdc55a68d783382282517
        # save the attached .config to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/power/supply/Kconfig:2:error: recursive dependency detected!
   drivers/power/supply/Kconfig:2: symbol POWER_SUPPLY is selected by TYPEC_TPS6598X
   drivers/usb/typec/Kconfig:64: symbol TYPEC_TPS6598X depends on REGMAP_I2C
   drivers/base/regmap/Kconfig:19: symbol REGMAP_I2C is selected by CHARGER_ADP5061
   drivers/power/supply/Kconfig:93: symbol CHARGER_ADP5061 depends on POWER_SUPPLY
   For a resolution refer to Documentation/kbuild/kconfig-language.rst
   subsection "Kconfig recursive dependency limitations"

vim +2 drivers/power/supply/Kconfig

8c0984e5a75337d Sebastian Reichel 2016-06-17 @2  menuconfig POWER_SUPPLY
8c0984e5a75337d Sebastian Reichel 2016-06-17  3  	bool "Power supply class support"
8c0984e5a75337d Sebastian Reichel 2016-06-17  4  	help
8c0984e5a75337d Sebastian Reichel 2016-06-17  5  	  Say Y here to enable power supply class support. This allows
8c0984e5a75337d Sebastian Reichel 2016-06-17  6  	  power supply (batteries, AC, USB) monitoring by userspace
8c0984e5a75337d Sebastian Reichel 2016-06-17  7  	  via sysfs and uevent (if available) and/or APM kernel interface
8c0984e5a75337d Sebastian Reichel 2016-06-17  8  	  (if selected below).
8c0984e5a75337d Sebastian Reichel 2016-06-17  9  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
