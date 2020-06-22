Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4451E2031AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 10:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgFVIM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 04:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFVIM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:12:29 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA715206D4;
        Mon, 22 Jun 2020 08:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592813548;
        bh=vd2wwS8aC8dxEcwhaYSYyvRKsvYQ04PvVkUEkJNwvUQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=X0VbN31PpZmQkK5suSc9O/3cllGmm1Zcp7XBSzAaC6Fe8d1YvLXmK73mc8zmJrhQL
         xQNDSkQm781Laq/cnkPPRkRSLGRkPiVCPYLIQDoVj/8UCGrnl9j5jewhbASJCP7y+u
         Ta0963WKojcvNqjvczZv33p4YEBnfrKGm8PpACjA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e361b46511756070277ff10f94e1735bb69cc300.1592407030.git.cristian.ciocaltea@gmail.com>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com> <e361b46511756070277ff10f94e1735bb69cc300.1592407030.git.cristian.ciocaltea@gmail.com>
Subject: Re: [PATCH 09/11] clk: actions: Add Actions S500 SoC Reset Management Unit support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-actions@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     afaerber@suse.de,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Date:   Mon, 22 Jun 2020 01:12:27 -0700
Message-ID: <159281354799.62212.7256905433525537681@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Ciocaltea (2020-06-17 09:48:09)
> Add Reset Management Unit (RMU) support for Actions Semi S500 SoC.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  drivers/clk/actions/owl-s500.c | 80 ++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>=20
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s50=
0.c
> index 025a8f6d6482..3bce72301c65 100644
> --- a/drivers/clk/actions/owl-s500.c
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -10,6 +10,8 @@
>   *
>   * Copyright (c) 2018 LSI-TEC - Caninos Loucos
>   * Author: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> + *
> + * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

You should only add your copyright when you modify a large amount of the
file. Adding 80 lines to a 500 line file doesn't count. Sorry.

>   */
> =20
>  #include <linux/clk-provider.h>
