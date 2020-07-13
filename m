Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9817921CDAC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 05:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgGMDZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 23:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgGMDZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:25:44 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 333182075F;
        Mon, 13 Jul 2020 03:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594610743;
        bh=42sLvH16N/p1HskAxb6+19GTRr4RU7NszcgWHIbzNNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+vq889PbBP/HPLp1htvu05JLh1JfilE/FtoRY/RMTjoe86+AEDmvnuuaopV74V+B
         0yUS9c+lOyAyV8CSXChGYykC4hxFa/qrPA0CnZkOkSzr+W2x2T+N7Px8QiNPYiDrtV
         UJTiDSqsIhO0P75OYsxXcUhG0Fr+234mD4/hR+O4=
Date:   Mon, 13 Jul 2020 11:25:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v9 0/5] mainline Protonic boards
Message-ID: <20200713032532.GD21277@dragon>
References: <20200701130330.9089-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701130330.9089-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 03:03:25PM +0200, Oleksij Rempel wrote:
> Oleksij Rempel (5):
>   dt-bindings: arm: fsl: add different Protonic boards
>   ARM: dts: add Protonic PRTI6Q board
>   ARM: dts: add Protonic WD2 board
>   ARM: dts: add Protonic VT7 board
>   ARM: dts: add Protonic RVT board

Applied all, thanks.
