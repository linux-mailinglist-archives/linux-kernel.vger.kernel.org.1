Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F3129D6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbgJ1WRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731514AbgJ1WR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:26 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C2A22267;
        Wed, 28 Oct 2020 08:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603873569;
        bh=veSX3TTwRY1vHW0t5Raf0u7Wsyf4g+ER3MIxByohPDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHW1m8Cuo3qrUPW3vKx4+z1BsVqNtdru/XFHJAeK7h7ZG8Tzyzli0RM4dFXR4D1cX
         BDMev0IVPARRDEjFDrKZfN1ePx9g1ytYdc+Pm331fO8bUOzfWrNyRYIXTOZErkbiBT
         sdtQEH92EGYffwgBhKRc1zyirFJkaoLvWTDzvfoE=
Date:   Wed, 28 Oct 2020 16:26:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/13] dt-bindings: arm: fsl: update TQ-Systems SoMs and
 boards based on i.MX7
Message-ID: <20201028082603.GA28467@dragon>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 01:29:30PM +0200, Matthias Schiffer wrote:
> Introduce compatible strings for the TQMa7x SoMs.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied, thanks.
