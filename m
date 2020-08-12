Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F6724276A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 11:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgHLJYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 05:24:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:34512 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgHLJYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:24:42 -0400
IronPort-SDR: MZ3hK8Y7KKdghSIaftY57W8NUS7C36LlpH/zNL5XObp5OP3Uo0N1vDKgZgT9INAeseBMeJoBxj
 9gV+RWvMFJ4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="153141205"
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; 
   d="scan'208";a="153141205"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 02:24:42 -0700
IronPort-SDR: OlSgHJrGutoTjUF2OKbQZWiX7nMYIKSUKS5+mJul17WvlApBrqmEG5LxrBAA5fxOqUt9lwV1TY
 VACcfbcmJlfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; 
   d="scan'208";a="325021329"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 12 Aug 2020 02:24:40 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k5mTw-008Aey-TZ; Wed, 12 Aug 2020 11:51:36 +0300
Date:   Wed, 12 Aug 2020 11:51:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Seungil Kang <sil.kang@samsung.com>
Cc:     bhe@redhat.com, mingo@kernel.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, herbert@gondor.apana.org.au,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/cmdline: prevent unintented access to address
Message-ID: <20200812085136.GH1891694@smile.fi.intel.com>
References: <CGME20200812025432epcas1p1b810c6b94adf533d5cae3ef6a24ca9a2@epcas1p1.samsung.com>
 <20200812025402.15695-1-sil.kang@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812025402.15695-1-sil.kang@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 11:54:02AM +0900, Seungil Kang wrote:

Thanks for the patch, my comments below.

> When args = "\"\0", "i" will be 0 and args[i-1] is used (line:238)

Can you be less ambiguous with the args value? (Perhaps provide a hexdump of it
for better understanding)

> Because of "i" is an unsigned int type,
> the function will access at args[0xFFFFFFFF]
> It can make a crash

Please, use proper punctuation, I'm lost where is the sentence and what are the
logical parts of them.

Can you point out to the code that calls this and leads to a crash?

>  lib/cmdline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Can you provide a KUnit test module which can check the case?

-- 
With Best Regards,
Andy Shevchenko


