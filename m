Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05829FE40
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgJ3HLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgJ3HLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:11:13 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B02620723;
        Fri, 30 Oct 2020 07:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604041872;
        bh=V1B3zTrOlgVd4h3vpMZj/K/GsTcNyXOel/WGljI3aNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EsJJioOekw/EM/SGrOkke3G4/gVGoFCPSCk/3UdC4M6pODdiW+QlVi4x4P22v969S
         sy2aDKg7VZaIY821eQ8s6MAQgIYMJtIF6HQtrfrxTyt1Bjxb2LDjre2pdr8DjNmJxo
         4u3ezIMnD7L1dy+i7vXQhBL+1M0m94BIIvyKFGYk=
Date:   Fri, 30 Oct 2020 15:11:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/12] dt-bindings: arm: fsl: fix and document compatibles
Message-ID: <20201030071102.GF28755@dragon>
References: <20201001170759.9592-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001170759.9592-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 07:07:47PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> This is a continuation of my series:
> https://lore.kernel.org/linux-arm-kernel/20200930190143.27032-1-krzk@kernel.org/
> 
> It is rebased on top of it and finally fixes remaining i.MX2 - i.MX8
> boards compatibles.
> 
> There is ongoing discussion in my previous patchset about imx6q-pico
> (Technexion) board compatibles so the DTS is marked as RFC.
> 
> Best regards,
> Krzysztof
> 
> 
> Krzysztof Kozlowski (12):
>   dt-bindings: vendor-prefixes: add Element14
>   dt-bindings: arm: fsl: document i.MX6Q boards
>   dt-bindings: arm: fsl: document i.MX6QP boards
>   dt-bindings: arm: fsl: document i.MX6SL boards
>   dt-bindings: arm: fsl: document i.MX6SX boards
>   dt-bindings: arm: fsl: document i.MX6UL boards
>   dt-bindings: arm: fsl: document i.MX6ULL boards
>   dt-bindings: arm: fsl: document i.MX7S boards

This one doesn't apply ...

>   dt-bindings: arm: fsl: document i.MX7D boards
>   ARM: dts: imx6q-pico: fix board compatibles

This one was applied from previous post ...

>   ARM: dts: imx6sl-warp: correct vendor in compatible to Revotics
>   ARM: dts: imx7s-warp: correct vendor in compatible to Element14

All others are applied.

Shawn
