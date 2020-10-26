Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C27298D96
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1776592AbgJZNNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:13:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37964 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392224AbgJZNN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:13:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id b2so7352485ots.5;
        Mon, 26 Oct 2020 06:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s1UuzHdFCfjwHcFLrPZqlXZZN81zkyKRH1qvGeQd3K0=;
        b=dmXyrLoY8CKTcKAfHRT1NiyzkE5JA/tJYFL06lVEDH+zGX/n+YW1zvZcvHOKsiG59M
         DHUyhmBo02Hj8at99WoBwwDkDFZ1MyiIA3Z//a8kKYoMZmUuze8tk9r5GJ0n3oouCDXd
         fHCMogeVnV7Cw2JS1kEpc1IxMqBPJAEbPsV7l6bLRJ6Hp+jnH8f/I3IaJH1qja3gKCy1
         dCtnxUdzkGsOkBXFQaZEB/xjSWlaIsWwGdlkZ74C7jGC9VGu+tslvZdboeY8K0R0bS6K
         VY1EFEQSO2llG+fsM97lbrYH6WLbkSKbRk5KJYfkCT11lHvlquzXRNhE+4xMSi5Nnyvr
         PxQQ==
X-Gm-Message-State: AOAM533ZXsLf+L0CJWyqjsRYdperbwFSoueLiPt02oCFrMikuL3hlOQC
        UC/uuZ/qH9Cu15uxZsbNLnoVRNmobQ==
X-Google-Smtp-Source: ABdhPJzDpmgA2mhOfO1BNzZj8/v9x24IC+8aikYlkWINJUfOORj/86QtUOFnqWJeHk3CwnwnTi+aag==
X-Received: by 2002:a05:6830:1e96:: with SMTP id n22mr13369727otr.66.1603718005215;
        Mon, 26 Oct 2020 06:13:25 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x13sm2413929otq.75.2020.10.26.06.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:13:24 -0700 (PDT)
Received: (nullmailer pid 10098 invoked by uid 1000);
        Mon, 26 Oct 2020 13:13:24 -0000
Date:   Mon, 26 Oct 2020 08:13:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: timer: Add new OST support for the
 upcoming new driver.
Message-ID: <20201026131324.GA7627@bogus>
References: <20201016165602.55720-1-zhouyanjie@wanyeetech.com>
 <20201016165602.55720-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201016165602.55720-2-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 12:56:02AM +0800, 周琰杰 (Zhou Yanjie) wrote:
> The new OST has one global timer and two or four percpu timers, so there
> will be three combinations in the upcoming new OST driver: the original
> GLOBAL_TIMER + PERCPU_TIMER, the new GLOBAL_TIMER + PERCPU_TIMER0/1 and
> GLOBAL_TIMER + PERCPU_TIMER0/1/2/3, For this, add the macro definition
> about OST_CLK_PERCPU_TIMER0/1/2/3. And in order to ensure that all the
> combinations work normally, the original ABI values of OST_CLK_PERCPU_TIMER
> and OST_CLK_GLOBAL_TIMER need to be exchanged to ensure that in any
> combinations, the clock can be registered (by calling clk_hw_register())
> from index 0.

You need to state why breaking the ABI is okay.

> 
> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>     v1->v2:
>     Rewrite the commit message so that each line is less than 80 characters.
> 
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
