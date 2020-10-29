Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2458029E842
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgJ2KEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgJ2KEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603965881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Wsea6lI7KZlbuttRrb54ASLPe+z2GQfiPXTwSVGoos=;
        b=K6/rsIQ8uLJz7oey68fSHdrDgqnT+H13svv2rmaGk3N3myxbV/V8C6b2DtvZ4wPPnXpjEM
        YeYF4Fo/empy8j5KYekave1pVmBuLzqQyrVOymJwuGOFsCOL4oz0UiyGQbZyDfYH6WsivD
        JREgiY5gIgDomQBLnkVv14PZtc3yrQc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-uCgZaxw5OeKDI3hS_nZacw-1; Thu, 29 Oct 2020 06:04:39 -0400
X-MC-Unique: uCgZaxw5OeKDI3hS_nZacw-1
Received: by mail-ed1-f71.google.com with SMTP id dc23so966557edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Wsea6lI7KZlbuttRrb54ASLPe+z2GQfiPXTwSVGoos=;
        b=BgqF5omQ9FLsPPfIi4P0c2k8USbNM5spyjQh1Hw7RAkeIBg/RMC8Xsmh9QRzX6dor9
         9xwjOSozi5Ty39csDVGGmTy9ICZ5h03DzowyHA3veqng3/rfFd3I41fVfK9J8HnaVKPf
         SOOVvch0xswoOZfJnhoOOYv470bWG7Ag1pRMbN+nLrsRL5lzJ/isnUfKPydXKtS0ct9q
         uXQD4u1U85BEj6ZHeCUpbMswhlq3fbUoLq5e0npXf5cJDm5j+CwmwSDSuY5RczTDGxy2
         ov6JBRNjMSBanxlujmRL/YAonLluh72lYmtP14oXSfZFbXWAunsxES48AsRRxSR6duKW
         /9fQ==
X-Gm-Message-State: AOAM533f36f9kTQuny1x1YAQht+qOq5SkkVJlaf3IHanllGmGMGxLMJ4
        M3w2+ysnqOgPWpZdxk6F+HIAWvIZe8GBcovfQU6nd3Q0t5jRRCAQG0d5XjLnKW4FG26TgNuJU6C
        D7PEhSvNiGjTIs2PP13yb4xhi
X-Received: by 2002:a17:906:3799:: with SMTP id n25mr3179389ejc.6.1603965878211;
        Thu, 29 Oct 2020 03:04:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2v/rHZRlH+fM+PZr3VrbNZQ1O0RHqSbvBNqxokz7pgCJmvesDdNrMzFHhZ+G3yp0yAaDk+w==
X-Received: by 2002:a17:906:3799:: with SMTP id n25mr3179375ejc.6.1603965878044;
        Thu, 29 Oct 2020 03:04:38 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id q19sm1218091ejz.90.2020.10.29.03.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 03:04:37 -0700 (PDT)
Subject: Re: [PATCH] power: supply: olpc_battery: remove unnecessary
 CONFIG_PM_SLEEP
To:     Coiby Xu <coiby.xu@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andy@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 PLATFORM DRIVERS - ARCH" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20201029074100.225806-1-coiby.xu@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5350ef53-cf70-c4b6-cdf8-5738e9d4b10a@redhat.com>
Date:   Thu, 29 Oct 2020 11:04:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029074100.225806-1-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/29/20 8:41 AM, Coiby Xu wrote:
> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

No it does not, when CONFIG_PM_SLEEP is not set then the
SET_SYSTEM_SLEEP_PM_OPS macro which SIMPLE_DEV_PM_OPS uses
is a no-op, so nothing will reference xo15_sci_resume leading to
a compiler warning when CONFIG_PM_SLEEP is not set.

You could drop the ifdef and add __maybe_unused to the definition
of xo15_sci_resume, but that feels like needless churn, best to
just keep this as is IMHO.

Also s/CONFIG_PM_CONFIG/CONFIG_PM_SLEEP/ in the commit message.

Regards,

Hans


> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  arch/x86/platform/olpc/olpc-xo15-sci.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
> index 85f4638764d6..716eefd735a4 100644
> --- a/arch/x86/platform/olpc/olpc-xo15-sci.c
> +++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
> @@ -192,7 +192,6 @@ static int xo15_sci_remove(struct acpi_device *device)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int xo15_sci_resume(struct device *dev)
>  {
>  	/* Enable all EC events */
> @@ -204,7 +203,6 @@ static int xo15_sci_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static SIMPLE_DEV_PM_OPS(xo15_sci_pm, NULL, xo15_sci_resume);
>  
> 

