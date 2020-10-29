Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BCB29E9D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgJ2LAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgJ2LAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:00:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4FC0613CF;
        Thu, 29 Oct 2020 04:00:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i7so101769pgh.6;
        Thu, 29 Oct 2020 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sf7Mt/9aAW63sbYQiNJIywd7guGaxmGyi9OLU5knt9k=;
        b=HXlMWRjWYrTkYtOlApx6XBBfCdalWH4fyRaWPEMybT2MMUjGKEhrWW7Zwe6xR5VXMF
         /ciiXhpH43ensX/hmYcUfet+qDQLc7EfAfJe7Jw3VWNH9md1raxiuXjfgyXpbhr653g2
         HOF5xzOOItQe/yg5Tvjxv96UDJjaEOzhgEZbcZKzHwwGmxjTWIRdXAENwVqK7f+wlrLN
         UDy6C97Q/p7WQ5nJj3wSHQQ5YzRfKB0BZ7sFgNYxgImNsDMueejpxG48Sp86wdNYCQFl
         6XI1Y57w9ErAQ4vnmWhhPFldywgfpoEDsBKT+GmCt5T77SX7XeprCmcRVAc5eVtLwZW8
         e8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sf7Mt/9aAW63sbYQiNJIywd7guGaxmGyi9OLU5knt9k=;
        b=UVFzR5/CI9P3MjaOq89coQXwIiGQ971yAcHtyfkFpyIYtz+ntexPRh5GO3K15zjdpV
         PFYGf6U+4zfZnprN6MjrJRdRzFJ1SiMCJ1iGX1sMzeYxuD9SejP7YHiTJ5Uoms4ohIz5
         HyU0+SFRIix9hYViXOgqQEj3Ijm7C+NZ/LBquky/xWcUG+b9sV622lwCC6RFtckuX+/i
         B6wM10k0l8YveRNQu9xGg+vkNGkVut4o11VZIuqeblo2oW+9uWAGAGNjXe2Xreo+3HHs
         XFb+zfNd5EUf7PckUwo1MhDMCJ/O8AMD00uP8ZP4TV68SQtjAzQWxrIOdah8R5isEPAn
         +JhQ==
X-Gm-Message-State: AOAM5332x9G3cxJ0VQfiuq/QbLgLgxJxtNQVsixD+vKzoBx+524mqKIo
        EAR5sfUdC0fjnRAtkigFwQQ=
X-Google-Smtp-Source: ABdhPJy8sQ7kQ0CvEcrxzMNIMcNf+NNwlb3Al8UBVJNb3lDScOUNEAVKImbuclJKKDmwur1oVlzedw==
X-Received: by 2002:a62:78d5:0:b029:154:ebc0:c92c with SMTP id t204-20020a6278d50000b0290154ebc0c92cmr3762635pfc.24.1603969203964;
        Thu, 29 Oct 2020 04:00:03 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id z10sm2532488pff.218.2020.10.29.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 04:00:03 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Thu, 29 Oct 2020 18:59:41 +0800
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 PLATFORM DRIVERS - ARCH" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: olpc_battery: remove unnecessary
 CONFIG_PM_SLEEP
Message-ID: <20201029105941.i2kr2424wnrgtvz5@Rk>
References: <20201029074100.225806-1-coiby.xu@gmail.com>
 <5350ef53-cf70-c4b6-cdf8-5738e9d4b10a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5350ef53-cf70-c4b6-cdf8-5738e9d4b10a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thank you for reviewing this patch!

On Thu, Oct 29, 2020 at 11:04:36AM +0100, Hans de Goede wrote:
>Hi,
>
>On 10/29/20 8:41 AM, Coiby Xu wrote:
>> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
>
>No it does not, when CONFIG_PM_SLEEP is not set then the
>SET_SYSTEM_SLEEP_PM_OPS macro which SIMPLE_DEV_PM_OPS uses
>is a no-op, so nothing will reference xo15_sci_resume leading to
>a compiler warning when CONFIG_PM_SLEEP is not set.
>
>You could drop the ifdef and add __maybe_unused to the definition
>of xo15_sci_resume, but that feels like needless churn, best to
>just keep this as is IMHO.
>

Actually, this is a tree-wide change by some semi-automation scripts.
Thank you for pointing out the issue to prevent me from releasing
another ~150 emails to flood other mailing lists.

Currently there are 929 drivers has device PM callbacks,

$ grep -rI "\.pm = &" --include=*.c  ./|wc -l
929

I put all files having device PM callbacks into four categories
based on weather a file has CONFIG_PM_SLEEP or PM macro like
SET_SYSTEM_SLEEP_PM_OPS, here are the statistics,
   1. have both CONFIG_PM_SLEEP and PM_OPS macro: 213
   2. have CONFIG_PM_SLEEP but no PM_OPS macro: 19
   3. have PM macro but not CONFIG_PM_SLEEP: 347
   4. no PM macro or CONFIG_PM_SLEEP: 302

Some drivers which have PM macro but not CONFIG_PM_SLEEP like
sound/x86/intel_hdmi_audio.c indeed use __maybe_unused to eliminate
the compiling warning. In 2011, there's a patch proposing to remove
ONFIG_PM altogether but an objection was turning CONFIG_PM on would
increase the kernel size [1]. So __maybe_unused also have this issue.
(I made a mistake when I thought PM macros like SIMPLE_DEV_PM_OPS
didn't have this issue). What do you think? Btw, It's easy for me to
add CONFIG_PM_SLEEP for those drivers have PM macro but not
CONFIG_PM_SLEEP since I have already written the necessary automation
scripts.

[1] https://lists.linux-foundation.org/pipermail/linux-pm/2011-February/030215.html

>Also s/CONFIG_PM_CONFIG/CONFIG_PM_SLEEP/ in the commit message.
>

Thank you for pointing out the typo. I've written some scripts to
automate the whole process from changing code to submitting patches.
Somehow there is still this issue.

>Regards,
>
>Hans
>
>
>>
>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>> ---
>>  arch/x86/platform/olpc/olpc-xo15-sci.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
>> index 85f4638764d6..716eefd735a4 100644
>> --- a/arch/x86/platform/olpc/olpc-xo15-sci.c
>> +++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
>> @@ -192,7 +192,6 @@ static int xo15_sci_remove(struct acpi_device *device)
>>  	return 0;
>>  }
>>
>> -#ifdef CONFIG_PM_SLEEP
>>  static int xo15_sci_resume(struct device *dev)
>>  {
>>  	/* Enable all EC events */
>> @@ -204,7 +203,6 @@ static int xo15_sci_resume(struct device *dev)
>>
>>  	return 0;
>>  }
>> -#endif
>>
>>  static SIMPLE_DEV_PM_OPS(xo15_sci_pm, NULL, xo15_sci_resume);
>>
>>
>

--
Best regards,
Coiby
