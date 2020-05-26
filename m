Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2699E1B4CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 20:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDVSfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 14:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgDVSfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:35:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F24A62075A;
        Wed, 22 Apr 2020 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587580544;
        bh=T4kdhqCafwM/UbR3FZ9TP5rqIAkCxdB3G9X/CnrP4R8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pP4psPYht7hIgvKBMdgBgzqJ1QwCsALKq0LqIzcICVQIq5EFrd2XTLKUQh6VdwckK
         NFTbf9IuoerGuGX903Jz9eLrqQbjg2J3xGuGaAmt1RG5HJF53lgw/oOG7vuRILanV5
         qtjuprGc/zDGbrnB5FgTVA0KrPoUlCK3GpHl//DQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1586937773-5836-6-git-send-email-abel.vesa@nxp.com>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com> <1586937773-5836-6-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH v3 05/13] clk: imx: gate2: Allow single bit gating clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Lee Jones <lee.jones@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Wed, 22 Apr 2020 11:35:43 -0700
Message-ID: <158758054316.163502.7559386766986350752@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2020-04-15 01:02:45)
> Audiomix on i.MX8MP registers two gates that share the same enable count
> but use the same bit to control the gate instead of two bits. By adding
> the flag IMX_CLK_GATE2_SINGLE_BIT we allow the gate2 to use the generic
> gate ops for enable, disable and is_enabled.
> For the disable_unused, nothing happens if this flag is specified.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
