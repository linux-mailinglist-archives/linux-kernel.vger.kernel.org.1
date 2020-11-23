Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EE82BFD95
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 01:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgKWAcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 19:32:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:11424 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgKWAb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 19:31:57 -0500
IronPort-SDR: b0KhVWGkaCihxxcWReW4wcWmI9cAbdJu+MSWMavMbk9dtq8WUo8YTsTdcyKEedVa23gL3/Jbt4
 iQDdJbLPTiCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="150943271"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="150943271"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 16:31:56 -0800
IronPort-SDR: VsniElC7QjjS7UkT7PXPuypVbZn8+pOBSejzrN6fcGZV0k06c0xy3jzdeYVDKoFuaQBOC8mnEz
 WsP4DuFtr7Lg==
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="477925278"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.117])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 16:31:54 -0800
Date:   Mon, 23 Nov 2020 08:31:06 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: cleanup kstrto*() usage
Message-ID: <20201123003106.GX3723@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201122121018.GA48617@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

I love your patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on v5.10-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Alexey-Dobriyan/driver-core-cleanup-kstrto-usage/20201122-201458
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 33c0c9bdf7a59051a654cd98b7d2b48ce0080967
compiler: riscv64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <rong.a.chen@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   drivers/base/core.c:3196:10: warning: Identical inner 'return' condition is always true. [identicalInnerCondition]
     return *tmp;
            ^
   drivers/base/core.c:3195:6: note: outer condition: *tmp
    if (*tmp)
        ^
   drivers/base/core.c:3196:10: note: identical inner condition: *tmp
     return *tmp;
            ^
   drivers/base/core.c:3202:10: warning: Identical inner 'return' condition is always true. [identicalInnerCondition]
     return *tmp;
            ^
   drivers/base/core.c:3201:6: note: outer condition: *tmp
    if (*tmp)
        ^
   drivers/base/core.c:3202:10: note: identical inner condition: *tmp
     return *tmp;
            ^
>> drivers/base/core.c:1725:6: warning: Unused variable: val [unusedVariable]
    int val;
        ^

vim +1725 drivers/base/core.c

ca22e56debc57b Kay Sievers     2011-12-14  1719  
ca22e56debc57b Kay Sievers     2011-12-14  1720  ssize_t device_store_int(struct device *dev,
ca22e56debc57b Kay Sievers     2011-12-14  1721  			 struct device_attribute *attr,
ca22e56debc57b Kay Sievers     2011-12-14  1722  			 const char *buf, size_t size)
ca22e56debc57b Kay Sievers     2011-12-14  1723  {
ca22e56debc57b Kay Sievers     2011-12-14  1724  	struct dev_ext_attribute *ea = to_ext_attr(attr);
e7443ff26978ad Alexey Dobriyan 2020-11-22 @1725  	int val;
f88184bfee48d4 Kaitao cheng    2018-11-06  1726  	int ret;
f88184bfee48d4 Kaitao cheng    2018-11-06  1727  
e7443ff26978ad Alexey Dobriyan 2020-11-22  1728  	ret = kstrtoint(buf, 0, (int *)ea->var);
f88184bfee48d4 Kaitao cheng    2018-11-06  1729  	if (ret)
f88184bfee48d4 Kaitao cheng    2018-11-06  1730  		return ret;
ca22e56debc57b Kay Sievers     2011-12-14  1731  	/* Always return full write size even if we didn't consume all */
ca22e56debc57b Kay Sievers     2011-12-14  1732  	return size;
ca22e56debc57b Kay Sievers     2011-12-14  1733  }
ca22e56debc57b Kay Sievers     2011-12-14  1734  EXPORT_SYMBOL_GPL(device_store_int);
ca22e56debc57b Kay Sievers     2011-12-14  1735  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
