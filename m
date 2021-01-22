Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D22D3008AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 17:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbhAVQ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 11:28:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:59017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbhAVQ1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:27:45 -0500
IronPort-SDR: vq1vYF4G+sLiOALn+d68aNs1Bi5boqeFgH9yOXQOqoytT+5zfOBGSuyReHtX1FQp/jRYRB5IAC
 OLV7yCkuGjTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="167148931"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="167148931"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 08:25:49 -0800
IronPort-SDR: G7tH5XRx6siaauSzc71fyxElGptsvoO92l9aFbQNZSlHk7KFYKA9MpwQYA+MJvjOzSndza6Ddh
 monNrlY1iOJg==
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="407789298"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 08:25:45 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2zGp-0097Pp-Jo; Fri, 22 Jan 2021 18:26:47 +0200
Date:   Fri, 22 Jan 2021 18:26:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wesley Zhao <zhaowei1102@thundersoft.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, kerneldev@karsmulder.nl, nivedita@alum.mit.edu,
        joe@perches.com, gpiccoli@canonical.com, aquini@redhat.com,
        gustavoars@kernel.org, ojeda@kernel.org, ndesaulniers@gooogle.com,
        linux-kernel@vger.kernel.org, david@redhat.com,
        dan.j.williams@intel.com, guohanjun@huawei.com,
        mchehab+huawei@kernel.org
Subject: Re: [PATCH v3 0/2] Make it possible to reserve memory on 64bit
 platform
Message-ID: <YAr8xy9t2gYKsjue@smile.fi.intel.com>
References: <1611330937-22654-1-git-send-email-zhaowei1102@thundersoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611330937-22654-1-git-send-email-zhaowei1102@thundersoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 07:55:35AM -0800, Wesley Zhao wrote:
> I was trying to reserve some memory to save logs incase that Android panic or hang and then
> I can read the logs from QNX side from the memory reserved before on the Qualcomm 8155 hypervisor platform,
> and I find the "reserve=" parameter only support 32bit,so I made some change and send these patches.

This part is okay.

> I run the cmdline_kunit.c and got these:
> [    1.663048] 1..1
> [    1.663107]     # Subtest: cmdline
> [    1.663145]     1..3
> [    1.663795]     ok 1 - cmdline_test_noint
> [    1.664139]     ok 2 - cmdline_test_lead_int
> [    1.664553]     ok 3 - cmdline_test_tail_int
> [    1.664788] ok 1 - cmdline

This is not okay, you have to have test cases to be added for your new API.
Besides the fact that you don't need it at all. See my further comments.

> Additionaly:
> 	I test on the qemu with some cmdline like[qemu-system-x86_64 -kernel linux-next/arch/x86_64/boot/bzImage
> 	-hda ubuntu-system.ext4 -append "root=/dev/sda init=/bin/bash console=ttyS0 reserve=0x180000000,0x123456"
> 	-nographic] and check the /proc/iomem with 180000000-180123455 : reserved.
> 	And some other tests with the get_option with the parameter(-12345678) and so on

-- 
With Best Regards,
Andy Shevchenko


