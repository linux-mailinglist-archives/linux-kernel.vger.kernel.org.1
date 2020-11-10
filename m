Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863DC2ACA00
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgKJBDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:03:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbgKJBDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:03:46 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 006CD206D8;
        Tue, 10 Nov 2020 01:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604970225;
        bh=gGSInnaKv5xhmKCSxqBvLRq4dcBhkF+PG6c5nCf1ZwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=01HQpp5JGqC3E8gSH7X4rMXXI8MgOd/tvnM/N3ccYjP9mxA0BUSbIfV+qZKAEWx/E
         Xx7jdnEjQXbrOLgtFvSSwl+SCBLN6PYjorYfs2vhYn/afxh+Yp9GnQWD3eBEKh9wRN
         hDZ9WLb7a0SnzuCiyvQH0rhBmaTgcSrgAgJ9iOTw=
Date:   Tue, 10 Nov 2020 09:03:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: fsl: add Van der Laan LANMCU
 board
Message-ID: <20201110010338.GJ31601@dragon>
References: <20201102090212.6298-1-o.rempel@pengutronix.de>
 <20201102090212.6298-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102090212.6298-2-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 10:02:11AM +0100, Oleksij Rempel wrote:
> Add Van der Laan LANMCU iMX6dl based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks.
