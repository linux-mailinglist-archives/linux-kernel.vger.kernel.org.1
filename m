Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1BA29DCF8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbgJ1WUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731704AbgJ1WRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:42 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833E72417A;
        Wed, 28 Oct 2020 07:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603870914;
        bh=gcEyFEA/aeXgGSny0EanGvYE1Rv2kIe87PKCk9x+Qfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=os3yReAsKv/h8UKot97Aq+LTnqG3mmOj6xtfO9L6m5VvBRKgeDH0C68AY5mZEzVnP
         12B9DsixMbEkdI3Uq6DRRXBqwMIguZ4OLWUsqOQOcKAuhfUQrxF/s1uEldkwVHKX93
         zAmM0cp/b6RD1BtITbQjCDSk7W709G61xPUqWrhU=
Date:   Wed, 28 Oct 2020 15:41:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/13] ARM: dts: imx7-mba7: disable ethernet PHY clock
 outputs
Message-ID: <20201028074147.GQ9880@dragon>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
 <20200918112942.1367-6-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918112942.1367-6-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 01:29:35PM +0200, Matthias Schiffer wrote:
> The clock outputs are not connected. Disable them to improve EMI
> behaviour.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied, thanks.
