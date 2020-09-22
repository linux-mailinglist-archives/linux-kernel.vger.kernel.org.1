Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91FD274224
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 14:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgIVMh0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Sep 2020 08:37:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39514 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgIVMh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:37:26 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kKhXi-00005Z-Se; Tue, 22 Sep 2020 14:37:10 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 6/6] clk: rockchip: rk3308: drop unused mux_timer_src_p
Date:   Tue, 22 Sep 2020 14:37:10 +0200
Message-ID: <2966215.XPzGgDkocF@diego>
In-Reply-To: <20200916161740.14173-6-krzk@kernel.org>
References: <20200916161740.14173-1-krzk@kernel.org> <20200916161740.14173-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. September 2020, 18:17:40 CEST schrieb Krzysztof Kozlowski:
> The parent names 'mux_timer_src_p' is not used:
> 
>   In file included from drivers/clk/rockchip/clk-rk3308.c:13:0:
>   drivers/clk/rockchip/clk-rk3308.c:136:7: warning: ‘mux_timer_src_p’ defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

applied for 5.10

Thanks
Heiko


