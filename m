Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0419F2DF151
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 20:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgLSTpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 14:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbgLSTpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 14:45:01 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608407061;
        bh=fBn6lXZfV64Astfjzu3fdYVvoXy6Bi4EdeIjTgzOO3c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BaVxFyHCuzC8XJLD/skqqTnE3EdQyVjy7hCk8xP5vMcet3n1i62YL747IQ290G/IG
         Skvy7D1k4p1pl+ouu1F6y5gZtMhUEipjZEHbeP/oXW2XPfxzq/8sVs5Bh/5UzcB9f0
         KXnd66kQNUjqevXQMHr6iCS3NW5I0ZD++aCwLyCwS1ZMzUilg3iJZNrLFTvAcpfIKG
         4itR3NJmTNn0WCk1lYId4+rT2H9tx3wirFIooqoivGrnsEBa84IJEkMdgRgc5GUebG
         lbuMa7IZpTCcLYmkxNv9lD6PwHcb2VQfUu6uURQcUuGMyWuaoYE5EiQyBd14JgIYcD
         Hxj2Gh4afleWw==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201218201350.GA2089699@robh.at.kernel.org>
References: <20201207045527.1607-1-thunder.leizhen@huawei.com> <20201207045527.1607-2-thunder.leizhen@huawei.com> <160820093389.1580929.3915867007740168331@swboyd.mtv.corp.google.com> <20201218201350.GA2089699@robh.at.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: clock: imx8qxp-lpcg: eliminate yamllint warnings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
To:     Rob Herring <robh@kernel.org>
Date:   Sat, 19 Dec 2020 11:44:19 -0800
Message-ID: <160840705988.1580929.18125222574166820024@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2020-12-18 12:13:50)
> On Thu, Dec 17, 2020 at 02:28:53AM -0800, Stephen Boyd wrote:
> > Quoting Zhen Lei (2020-12-06 20:55:27)
> > > Eliminate the following yamllint warnings:
> > > ./Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
> > > :32:13:[warning] wrong indentation: expected 14 but found 12 (indenta=
tion)
> > > :35:9: [warning] wrong indentation: expected 10 but found 8 (indentat=
ion)
> > >=20
> > > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > > ---
> >=20
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>=20
> If I tagged it, I was expecting you to pick up. But I'm gathering up all =

> the fixes for what landed in Linus' tree, so I'll apply.
>=20

Thanks! I don't see this in clk tree so I guess it went through arm-soc.
