Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052DB1C47A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 22:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgEDUEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 16:04:35 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:58565 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgEDUEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:04:35 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BEBEA200003;
        Mon,  4 May 2020 20:04:31 +0000 (UTC)
Date:   Mon, 4 May 2020 22:04:31 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] clk: at91: allow setting all PMC clock parents
 via DT
Message-ID: <20200504200431.GI34497@piout.net>
References: <cover.1588526049.git.mirq-linux@rere.qmqm.pl>
 <ae0c612ce6bc53ea726ddcb25eb36bca78055e33.1588526049.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae0c612ce6bc53ea726ddcb25eb36bca78055e33.1588526049.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/05/2020 19:19:26+0200, Michał Mirosław wrote:
> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> index c3f4aa6a2d29..adcf608b41fa 100644
> --- a/include/dt-bindings/clock/at91.h
> +++ b/include/dt-bindings/clock/at91.h
> @@ -21,6 +21,9 @@
>  #define PMC_MCK2		4
>  #define PMC_I2S0_MUX		5
>  #define PMC_I2S1_MUX		6
> +#define PMC_PLLACK		7
> +#define PMC_PLLBCK		8
> +#define PMC_AUDIOPLLCK		8		/* SAMA5D2-only, no PLLB there */

Just use 9 here because we can't know for sure that a future SoC won't
have both a PLLB and audio PLL.

>  
>  #ifndef AT91_PMC_MOSCS
>  #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
