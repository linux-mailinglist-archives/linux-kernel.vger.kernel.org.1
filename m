Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021F728CF22
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgJMN36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:29:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45672 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgJMN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:29:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id f37so18969007otf.12;
        Tue, 13 Oct 2020 06:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z0lp6xWsI01a1m0ANLoo+l8DVqU+FBadGPQQZjFQa50=;
        b=fymanlgrq5FtFzStHbdK7n3JQwJo1sSCKncssZTj6+cPt9cH6dzvQBOsR4/0maMmAP
         vSeUyVmp+xD3lrb1JMcFg6vQ3tm+83zDGkeSBE8l4yB/h7yMnxCNZ6txAftfX7BsAIxJ
         nAnSQcFJ49M20GXTY5HZMbbivwzXzTMGVs4Z553YIazeDmOM3eWjdkV7sOFF5q9eE5d/
         Z32MLRp3bW6eA7cx5dvgXteOzAtgCehl0DV82GdoMyrUfkupkWo9YG73bX1ZEiiULlS5
         LCkVS1djbFHgtmGQ9r7l2hbQGCefm1dY/+i67lhEMk11jV81X5O4KYYosssvnZE8bYQl
         BiSw==
X-Gm-Message-State: AOAM5320r/mnE1yVgVac9eqoBA2b0tTXwBGONb0++U9XCdwaCopFftGv
        qGrI/OEXm7Wd9YqQ+z96brZ28nvOrA7W
X-Google-Smtp-Source: ABdhPJzQ1HJ8z0yv6TYdclRehXwZHFO4qTGszihrvWLAnSEqAtYX2bXzbJzwkizSVE3KllkQAzsg3g==
X-Received: by 2002:a05:6830:1f01:: with SMTP id u1mr22072157otg.271.1602595794545;
        Tue, 13 Oct 2020 06:29:54 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l3sm10056262oth.36.2020.10.13.06.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 06:29:53 -0700 (PDT)
Received: (nullmailer pid 3379445 invoked by uid 1000);
        Tue, 13 Oct 2020 13:29:53 -0000
Date:   Tue, 13 Oct 2020 08:29:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sernia.zhou@foxmail.com
Subject: Re: [PATCH 1/1] dt-bindings: clock: Add new OST support for the
 upcoming new driver.
Message-ID: <20201013132953.GA3367990@bogus>
References: <20201007181407.46889-1-zhouyanjie@wanyeetech.com>
 <20201007181407.46889-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007181407.46889-2-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 02:14:07AM +0800, 周琰杰 (Zhou Yanjie) wrote:
> The new OST has one global timer and two or four percpu timers, so there will be three
> combinations in the upcoming new OST driver: the original GLOBAL_TIMER + PERCPU_TIMER,
> the new GLOBAL_TIMER + PERCPU_TIMER0/1 and GLOBAL_TIMER + PERCPU_TIMER0/1/2/3, For this,
> add the macro definition about OST_CLK_PERCPU_TIMER0/1/2/3. And in order to ensure that
> all the combinations work normally, the original ABI values of OST_CLK_PERCPU_TIMER and
> OST_CLK_GLOBAL_TIMER need to be exchanged to ensure that in any combinations, the clock
> can be registered (by calling clk_hw_register()) from index 0.

Wrap lines at <80 characters.

> 
> I'm sure that exchanging the ABI values of OST_CLK_PERCPU_TIMER and OST_CLK_GLOBAL_TIMER
> will not affect the existing related drivers and the SoCs whitch using these drivers, so
> we should be able to exchange them safely.

Why exactly is this okay?

> 
> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  include/dt-bindings/clock/ingenic,sysost.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings/clock/ingenic,sysost.h
> index 9ac88e90babf..063791b01ab3 100644
> --- a/include/dt-bindings/clock/ingenic,sysost.h
> +++ b/include/dt-bindings/clock/ingenic,sysost.h
> @@ -1,12 +1,16 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * This header provides clock numbers for the ingenic,tcu DT binding.
> + * This header provides clock numbers for the Ingenic OST DT binding.
>   */
>  
>  #ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
>  #define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
>  
> -#define OST_CLK_PERCPU_TIMER	0
> -#define OST_CLK_GLOBAL_TIMER	1
> +#define OST_CLK_PERCPU_TIMER	1
> +#define OST_CLK_GLOBAL_TIMER	0
> +#define OST_CLK_PERCPU_TIMER0	1
> +#define OST_CLK_PERCPU_TIMER1	2
> +#define OST_CLK_PERCPU_TIMER2	3
> +#define OST_CLK_PERCPU_TIMER3	4
>  
>  #endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
> -- 
> 2.11.0
> 
