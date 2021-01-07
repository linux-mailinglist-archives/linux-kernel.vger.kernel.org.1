Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF032EC8E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbhAGDLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbhAGDLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:11:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 823AE2229C;
        Thu,  7 Jan 2021 03:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609989023;
        bh=+qd4peApsQU6SUTyExxo2EJrZVjRPpbAM3e3LuXtF3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxZwARMtCcOzSdmzSNzDI0HodQQjBd2JZvpJ3jGchCtWjXpXdxRTHo53XKrqSB6Il
         9P8u++irxbJ1MBPX7IHVOjyAaXZP0KPz+53Oc1J63gfi7WXXcqXVoJUZrREL/hSULe
         FpfVwfrxURU+TZVYkSQ9OyhabixGHEZ7oBMibko1KjFhURatmoJLwrzQselZNW0i+o
         puybmj6NVolDFDgAacmG5h/kx4WuXkm0ZQnr+0tYitdysLJLQR7PWOAuaGtgdIVrfx
         1MEcD/uKyMQ+PWbFpZ7a8JP15zvVzJ992V4jabdS0aHh8p4ZkslCVLV6je5t6auwb2
         YeEy/9of/qUAw==
Date:   Thu, 7 Jan 2021 11:10:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 0/8] mainline Plymovent M2M and BAS board
Message-ID: <20210107031015.GR4142@dragon>
References: <20201207140939.31297-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207140939.31297-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 03:09:31PM +0100, Oleksij Rempel wrote:
> changes v7:
> - panel-simple.yaml: fix comments and part order
> - panel-simple.yaml: invent a product description for the Kyocera tcg070wvlq panel
> 
> changes v6:
> - do more panel-simple.yaml related cleanups
> 
> changes v5:
> - rebase against latest shawngup/for-next
> - add patch to fix checkpatch warning on PLYM2M dts
> 
> changes v4:
> - add PLYBAS board
> - PLYM2M: add touchscreen node
> - PLYM2M: add rename led nodes to led-x
> 
> changes v3:
> - use old style copyright text
> 
> changes v2:
> - fsl.yaml: reorder ply,plym2m
> - imx6dl-plym2m.dts: use hyphen instead of underscore in phy-clock
> 
> Oleksij Rempel (8):
>   dt-bindings: display: simple: fix alphabetical order for EDT
>     compatibles
>   dt-bindings: display: simple: add EDT compatibles already supported by
>     the driver
>   dt-bindings: display: simple: Add Kyocera tcg070wvlq panel
>   dt-bindings: vendor-prefixes: Add an entry for Plymovent
>   dt-bindings: arm: fsl: add Plymovent M2M board
>   ARM: dts: add Plymovent M2M board
>   dt-bindings: arm: fsl: add Plymovent BAS board
>   ARM: dts: add Plymovent BAS board

Applied all, thanks.
