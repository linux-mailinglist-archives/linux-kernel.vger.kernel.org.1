Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1880428D8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgJNC7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgJNC7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:59:21 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D2A21D7F;
        Wed, 14 Oct 2020 02:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602644361;
        bh=eoG+M88eEplhrOQFQd2C8HpK8NxV+vVYAsf3vM96zfg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WRufxizF0QUz2fUAcymtSveq3eh8lwQ8hiJ2XYkzY4H8gqwLqi0KRHpBpUxuSauQD
         ngKwPKWPFxw6DtEabwnv4wXmZS3H3syfr/n5GUxnIneKFPXMM+GLX7Xm67oG+aT7lN
         6xsaKzoGmUAvg9EPBagIghss29OJQix4LEBgzAk4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1598338751-20607-2-git-send-email-claudiu.beznea@microchip.com>
References: <1598338751-20607-1-git-send-email-claudiu.beznea@microchip.com> <1598338751-20607-2-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 1/3] clk: at91: remove the checking of parent_name
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Tue, 13 Oct 2020 19:59:19 -0700
Message-ID: <160264435961.310579.8434973397981372581@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-08-24 23:59:09)
> There is no need to check parent_name variable while assigning it to
> init.parent_names. parent_name variable is already checked at
> the beginning of at91_clk_register_peripheral() function.
>=20
> Fixes: 6114067e437eb ("clk: at91: add PMC peripheral clocks")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next
