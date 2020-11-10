Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A952ACA02
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbgKJBEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:04:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbgKJBEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:04:43 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0DE4206D8;
        Tue, 10 Nov 2020 01:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604970282;
        bh=OlWWjsTl4WMGc24vKtK9w41I4b37bco/u804uzeO5i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdkL1BpKnp16faDkxQErVyn0DLLn0G2ezBLyk7t2gsNfoHR/g/5kPG2zt1N3akYxe
         Sx6qCPWl2klgGQnjs52YCFZH7GhaGcvIxwpheUktCQ/MdkHfyY9pq5sVPBUnhmyngZ
         PRtCQMMnwVixJgPvJ6fNq2XoWatwuUQNnp/KWpRo=
Date:   Tue, 10 Nov 2020 09:04:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 2/2] ARM: dts: add Van der Laan LANMCU board
Message-ID: <20201110010435.GK31601@dragon>
References: <20201102090212.6298-1-o.rempel@pengutronix.de>
 <20201102090212.6298-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102090212.6298-3-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 10:02:12AM +0100, Oleksij Rempel wrote:
> Van der Laan LANMCU is a module for the food storage rooms to control
> proper gas composition.
> 
> Co-developed-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
