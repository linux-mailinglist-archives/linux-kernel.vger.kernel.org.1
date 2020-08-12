Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0D0242685
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 10:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHLIB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 04:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgHLIB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:01:29 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84EFC20768;
        Wed, 12 Aug 2020 08:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597219288;
        bh=Xr/8WQ4NV9CVHwHYVG4mEdreG4szPGq3UOfQhBPhNeI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Krc/UNetVSV8lJEJTc5Ud0jyiUXXcE1ZM0CA3t+sJ7rb3Ncb3tZWPCvgd8aTuLcSU
         WB3YJhS+p/o1rP7HRz/QnpIjDjhG4wDqoCmqITJg9qDQOUeVQoM1q2o8pTUygRHPWH
         851l7J+ttPa40b72z5c/HfyXGWKE3VoZOJ1mWwdU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1596583049-7305-1-git-send-email-Anson.Huang@nxp.com>
References: <1596583049-7305-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH] clk: imx: Explicitly include bits.h
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, festevam@gmail.com, horia.geanta@nxp.com,
        j.remmet@phytec.de, kernel@pengutronix.de,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        yuehaibing@huawei.com
Date:   Wed, 12 Aug 2020 01:01:27 -0700
Message-ID: <159721928737.33733.15281221160982745981@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-08-04 16:17:29)
> It is better to explicitly include the required header file rather
> then get it through some recursive include.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
