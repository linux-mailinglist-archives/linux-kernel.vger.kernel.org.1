Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683672C03B5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgKWKwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:52:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:8422 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgKWKwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:52:18 -0500
IronPort-SDR: 5GCIaZWOi0qHqVrUw/p4LlgplUhUK/pTkZ9d5XeU021Rj9DTvUdqrxaeS/jR3qJF3CJtsbmaeA
 B4XZC5GlTBJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="171837063"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="171837063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 02:52:18 -0800
IronPort-SDR: bm7uzLOy0YLzf7VLU9K1QVUt31a6g44NW4A/w4B1Ly++pV9MAQQgoeIQr7A3zLL3omE+UuMHuP
 czE4m+rWvVLA==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="478070135"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 02:52:16 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kh9TB-00982g-Uh; Mon, 23 Nov 2020 12:53:17 +0200
Date:   Mon, 23 Nov 2020 12:53:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: sound/soc/intel/catpt/loader.c:654 catpt_first_boot_firmware()
 warn: consider using resource_size() here
Message-ID: <20201123105317.GZ4077@smile.fi.intel.com>
References: <202011220325.oB7oeTEq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202011220325.oB7oeTEq-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 03:52:27AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   27bba9c532a8d21050b94224ffd310ad0058c353
> commit: 6cbfa11d2694b8a1e46d6834fb9705d5589e3ef1 ASoC: Intel: Select catpt and deprecate haswell
> date:   7 weeks ago
> config: x86_64-randconfig-m001-20201122 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> sound/soc/intel/catpt/loader.c:654 catpt_first_boot_firmware() warn: consider using resource_size() here

...

> a9aa6fb3eb6c7e Cezary Rojewski 2020-09-29  652  	for (res = cdev->dram.child; res->sibling; res = res->sibling)
> a9aa6fb3eb6c7e Cezary Rojewski 2020-09-29  653  		;
> a9aa6fb3eb6c7e Cezary Rojewski 2020-09-29 @654  	__request_region(&cdev->dram, res->end + 1,


This sounds like false positive. From where it gets the idea of resource_size()
for the *start* offset?!

-- 
With Best Regards,
Andy Shevchenko


