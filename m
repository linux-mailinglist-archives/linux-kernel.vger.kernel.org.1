Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3759F2FFB90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 05:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbhAVEIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 23:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbhAVEIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 23:08:05 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF23C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:07:25 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id o20so2877971pfu.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PZAAe962Hz8NSa0Kmo+o6/bMATbZfiv0eKAKg5Vny38=;
        b=dCqRMe5QBugm906lQX8CgsV0wXqFbx/sEiHZmBty2Dy1BTAg0q006t+wSMjMbq4+m4
         fcjns6LVoGHCnao8mg5qZQoT69Bafv0WEFdSBR9Q2uLtwYsP33E8txq9x4xQYreyHiDW
         W0XJWB0oBhX13irDYu1ed7/RfOHU0yOI3Ry6mA945fvP+af5qmemev2SyY2aMX8Ma1v6
         sz//DxxVdGZxauEjh/sBTM0pj/CIeyOelebdSAA0JVNtWtNUqPb0w0q+v0c2nRp2BO/l
         rm9xHpfa3SiBdzNj7WypchsftTpby7PwxLykWebWu8L7RQMhKJrbe2mUeFyeML6E/uAh
         GXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PZAAe962Hz8NSa0Kmo+o6/bMATbZfiv0eKAKg5Vny38=;
        b=fXiK/R1dzypOc153C9XQaOXXMbACS7linQ0asOOs11TfBOR67yXLzoaE1PA0qo4AI+
         HLBsSZm0eRIQtIDl7DTUc/6ZxEdDZjCYGmfiq984xDJ4qQTA5k+SFesYlI6qsExXhI9Q
         nlswIvDXunqPAssPQyHttr9+Yhr4LHJKqz0Jb4PqFDFxKsEJooRqmgEHq7JI7/TN67SY
         w+r6M8ytis6uRwe5hnyIXXLxeZaMGlLkXseBKo2tvVAFLIYYo47sD+qTp+rZysNsEj8l
         ii3FhkAy7A6ZQfuIYBZdCcJciLiK1StGzno2oX+wQXNCaEgk5SSpShJA/TS1C/0PhR2e
         v0Lw==
X-Gm-Message-State: AOAM5335Y5q5HcLsgAEdtq1Bc6jIqj5pmo54SEw419rvgy6FQ72FrfPP
        MBvN5uGQZv/Xibl5FvwBv5wwRXH6tA0=
X-Google-Smtp-Source: ABdhPJw3l2/LOLmf1f8qeebLoB1gv30Gcs6xyyeNBxOCqG6m/cKOyQvjp51f10z6ipH218g1elSzLg==
X-Received: by 2002:a63:521e:: with SMTP id g30mr2672067pgb.369.1611288444511;
        Thu, 21 Jan 2021 20:07:24 -0800 (PST)
Received: from ?IPv6:2603:800c:3005:b7d7:4c7f:efac:e352:ce2b? (2603-800c-3005-b7d7-4c7f-efac-e352-ce2b.res6.spectrum.com. [2603:800c:3005:b7d7:4c7f:efac:e352:ce2b])
        by smtp.gmail.com with ESMTPSA id z11sm7677310pjn.5.2021.01.21.20.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 20:07:24 -0800 (PST)
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAM7-yPSa8kJkS2xm8w6hCgme7YmUOR8GBrx-kiQuUjGctF2QVw@mail.gmail.com>
From:   Brooke Basile <brookebasile@gmail.com>
Subject: Re: [PATCH RESEND] irq: export irq_check_status_bit symbol
Message-ID: <51edd12f-3200-2498-a088-c9b17b666211@gmail.com>
Date:   Thu, 21 Jan 2021 18:07:22 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM7-yPSa8kJkS2xm8w6hCgme7YmUOR8GBrx-kiQuUjGctF2QVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/21 10:57 PM, Yun Levi wrote:
> Because of the missing export symbol for irq_chekc_status_bit,
> Building arm_spe_pmu.ko is a failure on the modpost step.
>=20
> Below is an error message I saw:
> ERROR:modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] und=
efined!
> make[4]: *** [scripts/Makefile.modpost:111: Module.symvers] Error 1
> make[4]: *** Deleting file 'Module.symvers'
> make[3]: *** [Makefile:1396: modules] Error 2
> make[2]: *** [debian/rules:7: build-arch] Error 2
> dpkg-buildpackage: error: debian/rules binary subprocess returned exit =
status 2
> make[1]: *** [scripts/Makefile.package:83: bindeb-pkg] Error 2
>=20
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>   kernel/irq/manage.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index ab8567f32501..dec3f73e8db9 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -2859,3 +2859,4 @@ bool irq_check_status_bit(unsigned int irq,
> unsigned int bitmask)
>          rcu_read_unlock();
>          return res;
>   }
> +EXPORT_SYMBOL_GPL(irq_check_status_bit);
> --
> 2.27.0
>=20
>=20

Hi,

I ran into this issue while compiling 5.11-rc4 for my RPi 4B.  Applying=20
this patch fixed the breakage.

Thanks for the fix!

Tested-by: Brooke Basile <brookebasile@gmail.com>

Best,
Brooke Basile

