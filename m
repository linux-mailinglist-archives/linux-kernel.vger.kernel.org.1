Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463D1300042
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbhAVK2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:28:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:37529 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbhAVKV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:21:59 -0500
IronPort-SDR: ZKhIgKbTA5XlUFrEReOTC5a0QMK+8r4JTxCNm+lD/5KIYxD6XsFRTxLcUhtgLCRBxcVMNGJHLw
 il5gINJNKPZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264245478"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="264245478"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 02:20:14 -0800
IronPort-SDR: cy94oec0NER4g5RXDyf0t6yYcdKMnrdxi4RgSqnlKco9AI/cS/eLuts1/5i6sL5pvNA8QVLq2p
 T/+LGOIZeBGQ==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="351781528"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 02:20:10 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2tZ2-008kBR-F5; Fri, 22 Jan 2021 12:21:12 +0200
Date:   Fri, 22 Jan 2021 12:21:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "zhaowei1102@thundersoft.com" <zhaowei1102@thundersoft.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kerneldev <kerneldev@karsmulder.nl>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>,
        gpiccoli <gpiccoli@canonical.com>, aquini <aquini@redhat.com>,
        gustavoars <gustavoars@kernel.org>, ojeda <ojeda@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        guohanjun <guohanjun@huawei.com>,
        mchehab+huawei <mchehab+huawei@kernel.org>
Subject: Re: Re: [PATCH v2 0/2] Make it possible to reserve memory on 64bit
 platform
Message-ID: <YAqnGNEkUmTcWzoC@smile.fi.intel.com>
References: <1610793673-64008-1-git-send-email-zhaowei1102@thundersoft.com>
 <CAPcyv4hGu3r=m+7Wkf3a94G=ZM4cQB87pt0ThadoUrk8cY7ovw@mail.gmail.com>
 <202101181151049299923@thundersoft.com>
 <15269a61-3b16-4c07-2486-6940c559261e@redhat.com>
 <202101221536190259795@thundersoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202101221536190259795@thundersoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 03:36:19PM +0800, zhaowei1102@thundersoft.com wrote:
> On 18.01.21 04:51, zhaowei1102@thundersoft.com wrote:
> > >     On Sat, Jan 16, 2021 at 2:43 AM Wesley Zhao
> > >     <zhaowei1102@thundersoft.com> wrote:

> > Dan's point is that you should look into using "memmap=" instead of
> > "reserve=".
> Oh~，sorry miss understand，i can try this， thanks！！

And AFAICS you don't need to alter cmdline.c. But if you are going to, don't
forget test cases (and FYI: I have few patches pending against it here [1]).

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git/log/?h=for-next

-- 
With Best Regards,
Andy Shevchenko


