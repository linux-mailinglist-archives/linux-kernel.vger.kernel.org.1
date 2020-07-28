Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BA5231245
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 21:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbgG1TPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 15:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732631AbgG1TP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:15:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC99C2065C;
        Tue, 28 Jul 2020 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595963728;
        bh=Qd59wd3izmmkxlJvLgZuIyOO6hBZW915rmrytim7/ms=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dRlhxuGafyckGjq+tLKrbmQN4gTbtBZJygDY4sJJNi8TllUwi1qfodRS5NQ91S1ff
         8+RF3F9bF8lRvEe7cg5yzijPV9vnW4v73MXEXVKYn+yNivLocm1iFN7F0nObrffWJX
         kqp+UvTlKoTkHW2+msPAGlLTEVBKUVH91yenF/LY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595926999-14934-2-git-send-email-peng.fan@nxp.com>
References: <1595926999-14934-1-git-send-email-peng.fan@nxp.com> <1595926999-14934-2-git-send-email-peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] clk: imx: imx8m: use devm_of_clk_add_hw_provider()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To:     abel.vesa@nxp.com, festevam@gmail.com, peng.fan@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Tue, 28 Jul 2020 12:15:26 -0700
Message-ID: <159596372694.1360974.17715148016737584628@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting peng.fan@nxp.com (2020-07-28 02:03:19)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Use devm_of_clk_add_hw_provider() to simplify code.
> To i.MX8MP, also add err handling.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
