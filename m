Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF3A274967
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgIVTpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgIVTpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:45:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34FFF23787;
        Tue, 22 Sep 2020 19:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600803902;
        bh=yBAsRkgb+YjtLB+er/pY3xx7d5wgjjdSRJG+VAjtO3I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fw/WQkx9C1Hvt3/1k76ShL8h+i2T8H6yk9lS8zStPVeK8XwJpRz0iZt5TWD7789J8
         XlWtlnXD9KzrcI6IDwKDB4ozCiHLBRUxgSlCr0MLRTEdj1RpaT/Tw2RoKRPGxJBnHw
         O8Y9H1u0nk5gMEvulPnojcfbWlUQrjir5I+n7Mes=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200916161740.14173-3-krzk@kernel.org>
References: <20200916161740.14173-1-krzk@kernel.org> <20200916161740.14173-3-krzk@kernel.org>
Subject: Re: [PATCH 3/6] clk: davinci: add missing kerneldoc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Lechner <david@lechnology.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sekhar Nori <nsekhar@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Date:   Tue, 22 Sep 2020 12:45:00 -0700
Message-ID: <160080390093.310579.11470222037564752365@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2020-09-16 09:17:37)
> Add missing kerneldoc to fix compile warning:
>=20
>   drivers/clk/davinci/da8xx-cfgchip.c:578: warning: Function parameter or=
 member 'dev' not described in 'da8xx_cfgchip_register_usb1_clk48'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: David Lechner <david@lechnology.com>
> ---

Applied to clk-next
