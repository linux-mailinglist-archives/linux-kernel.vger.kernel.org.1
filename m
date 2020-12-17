Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620CE2DCF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgLQK3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:29:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgLQK3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:29:36 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608200936;
        bh=Zvlk7cg75+RskE+8n7nwk68d2niVjCId0sFpNAT3Mco=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qqVRVVw5n4r9xsCU400ird2sgTJpGKHlkn0LWj8OXl+oYB9Du68dS7NfnQpHY/a2b
         WKmOH0VSoYD4+fOzaTk3rALFmEM/mWhmVUkdbtjEd1/p/5c82BELpH9bsco8moDcl+
         fdgANs4cSNGN6B6w8c7crx++TmBAgJ+bRu5/xPYG4pak41uPnVuwIMRAnEUZWOgtQ6
         8dtKXij+jvN1OK5ZxoyAvvRjoZVz2fyzzby30BGwqj4Sxcx32/51yGewzeYHtEPt6N
         IvCT6oAj4GxeOpD6NvDU44Q38BzJHT3wCc6N7ywEuQkullQfX685gOYrLoC7Fk317X
         pMDhJFqpo3S8A==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201207045527.1607-2-thunder.leizhen@huawei.com>
References: <20201207045527.1607-1-thunder.leizhen@huawei.com> <20201207045527.1607-2-thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] dt-bindings: clock: imx8qxp-lpcg: eliminate yamllint warnings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 17 Dec 2020 02:28:53 -0800
Message-ID: <160820093389.1580929.3915867007740168331@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhen Lei (2020-12-06 20:55:27)
> Eliminate the following yamllint warnings:
> ./Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
> :32:13:[warning] wrong indentation: expected 14 but found 12 (indentation)
> :35:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
>=20
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
