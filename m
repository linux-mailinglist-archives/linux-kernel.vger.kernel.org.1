Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456642A0DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgJ3SpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:45:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45099 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgJ3SpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:45:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id f37so6429559otf.12;
        Fri, 30 Oct 2020 11:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vkMKJ2eqiQquOQSzTOKFv95/64lgkzU1Z0DoWHjMcuA=;
        b=A6FgiZXY0sGrATGX7QBElPppe9uMbfAjlNfLRAQS0XDRfmjkJbZTx+v+LyzaFOdRjn
         lqdbB6qLkmtsQr1//Q9y+LeRcqLxR3VbPRXhvx+DpJOgWh7/taqjvU9mwQaLMZ8/rTkd
         QTGcnte6O3sHFkhajN11nwU4mqzXg1GWo7pUvUP4HsNgOxOVw4e5ZMWTAdpusqYU2DIh
         psUTHbVs8r6qJ8RHo1aeciJMKdUIWCyGNeIy7H5PHe7YXpauJ521WgYOFryq1FtoBHTD
         zBU2v+cmolfFDFDOC/gUqbHgK0Xr+lEcRtlkeIy+7lqRe247OVk8s89iWyOl7poOisu/
         Cufw==
X-Gm-Message-State: AOAM531F0HLMq7gnp13DZ+4rjydYy9Sr+fhcEPmb3uEZp5M4im+2ihip
        1YnnsbxNu4t0NJs/AJJY9g==
X-Google-Smtp-Source: ABdhPJz1noWcHkG0acilS14npra1FTJs7FrC7ortYfxhp6d4ZfvWMrm3RWg2qWwzEfFkMkGYTGwg2g==
X-Received: by 2002:a05:6830:1db6:: with SMTP id z22mr2597009oti.20.1604083520849;
        Fri, 30 Oct 2020 11:45:20 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 186sm1556392ooe.20.2020.10.30.11.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 11:45:16 -0700 (PDT)
Received: (nullmailer pid 4129088 invoked by uid 1000);
        Fri, 30 Oct 2020 18:45:15 -0000
Date:   Fri, 30 Oct 2020 13:45:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     dongsheng.qiu@ingenic.com, rick.tyliu@ingenic.com,
        robh+dt@kernel.org, sernia.zhou@foxmail.com, aric.pzqi@ingenic.com,
        yanfei.li@ingenic.com, zhenwenjin@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org
Subject: Re: [PATCH v3 1/1] dt-bindings: timer: Add new OST support for the
 upcoming new driver.
Message-ID: <20201030184515.GA4129054@bogus>
References: <20201026155842.10196-1-zhouyanjie@wanyeetech.com>
 <20201026155842.10196-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201026155842.10196-2-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 23:58:42 +0800, 周琰杰 (Zhou Yanjie) wrote:
> The new OST has one global timer and two or four percpu timers, so there
> will be three combinations in the upcoming new OST driver: the original
> GLOBAL_TIMER + PERCPU_TIMER, the new GLOBAL_TIMER + PERCPU_TIMER0/1 and
> GLOBAL_TIMER + PERCPU_TIMER0/1/2/3, For this, add the macro definition
> about OST_CLK_PERCPU_TIMER0/1/2/3. And in order to ensure that all the
> combinations work normally, the original ABI values of OST_CLK_PERCPU_TIMER
> and OST_CLK_GLOBAL_TIMER need to be exchanged to ensure that in any
> combinations, the clock can be registered (by calling clk_hw_register())
> from index 0.
> 
> Before this patch, OST_CLK_PERCPU_TIMER and OST_CLK_GLOBAL_TIMER are only
> used in two places, one is when using "assigned-clocks" to configure the
> clocks in the DTS file; the other is when registering the clocks in the
> sysost driver. When the values of these two ABIs are exchanged, the ABI
> value used by sysost driver when registering the clock, and the ABI value
> used by DTS when configuring the clock using "assigned-clocks" will also
> change accordingly. Therefore, there is no situation that causes the wrong
> clock to the configured. Therefore, exchanging ABI values will not cause
> errors in the existing codes when registering and configuring the clocks.
> 
> Currently, in the mainline, only X1000 and X1830 are using sysost driver,
> and the upcoming X2000 will also use sysost driver. This patch has been
> tested on all three SoCs and all works fine.
> 
> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>     v1->v2:
>     Rewrite the commit message so that each line is less than 80 characters.
> 
>     v2->v3:
>     Add the description of why the exchange of ABI values will not affect
>     the existing driver into the commit message.
> 
>  include/dt-bindings/clock/ingenic,sysost.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
