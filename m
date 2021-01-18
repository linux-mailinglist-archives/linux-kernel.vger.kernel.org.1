Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E3C2FAB12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbhARUKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:10:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:23580 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389232AbhARKn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:43:28 -0500
IronPort-SDR: pV0nXucl3on+nQMRmeLA4d5HrtYoBf38mx6pxCEsEbBnoE5usS/lSyZI8ifV8YYdB80HXmt5Gd
 FwoOdbyHK6eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="157967147"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="157967147"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 02:41:36 -0800
IronPort-SDR: j13oBGugHGY6g+V2YEtSLmZH8wa0lfFS1AwzpxKoLLWrBs5X5mGIoHqXJojDkaQ5xQQQ5KOdVP
 WGmMLq4bSWcw==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="365301118"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 02:41:32 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l1RzW-0020tY-3l; Mon, 18 Jan 2021 12:42:34 +0200
Date:   Mon, 18 Jan 2021 12:42:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wesley Zhao <zhaowei1102@thundersoft.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, kerneldev@karsmulder.nl, nivedita@alum.mit.edu,
        joe@perches.com, gpiccoli@canonical.com, aquini@redhat.com,
        gustavoars@kernel.org, ojeda@kernel.org, ndesaulniers@gooogle.com,
        linux-kernel@vger.kernel.org, david@redhat.com,
        dan.j.williams@intel.com, guohanjun@huawei.com,
        mchehab+huawei@kernel.org
Subject: Re: [PATCH v2 0/2] Make it possible to reserve memory on 64bit
 platform
Message-ID: <20210118104234.GB4077@smile.fi.intel.com>
References: <1610793673-64008-1-git-send-email-zhaowei1102@thundersoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610793673-64008-1-git-send-email-zhaowei1102@thundersoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 02:41:11AM -0800, Wesley Zhao wrote:
> I was trying to reserve some memory to save logs incase that Android panic or hang and then
> I can read the logs from QNX side from the memory reserved before on the Qualcomm 8155 hypervisor platform,
> and I find the "reserve=" parameter only support 32bit,so I made some change and send these patches.

Your series has disrupter in-reply-to change, can you fix your tools to have
all patches in one email thread?

> testcase:
> 	I test on the qemu with some cmdline like[qemu-system-x86_64 -kernel linux-next/arch/x86_64/boot/bzImage
> 	-hda ubuntu-system.ext4 -append "root=/dev/sda init=/bin/bash console=ttyS0 reserve=0x180000000,0x123456"
> 	-nographic]	and check the /proc/iomem with 180000000-180123455 : reserved.
> 	And some other tests with the get_option with the parameter(-12345678) and so on

It's good but I was talking about unit test. Look into cmdline_kunit.c.

> Wesley Zhao (2):
>   lib/cmdline: add new function get_option_ull()
>   resource: Make it possible to reserve memory on 64bit platform

-- 
With Best Regards,
Andy Shevchenko


