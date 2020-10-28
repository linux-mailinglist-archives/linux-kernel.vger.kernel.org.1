Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69A29DCF0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbgJ1WU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731676AbgJ1WRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:41 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3939324631;
        Wed, 28 Oct 2020 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603873833;
        bh=WobJz/u0RsK7osQh8poMpExNNYy3QuDqDTVY5ZlbC7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSY55uWN8+01v/4UAsGG7k4GADvXWKTjugaaTNxRt1xsxoWlD+MMp+aK2HkiAxwNn
         T63jfcG0P/iuVCWSdFGicLk6YBCDYH9lsyMSJILE8eR4OGUKQFaxm+1pGN9JvhyVHF
         WsHglCBl+1kRq0o0edYgZgNLIfKEy78r/TaU7sBk=
Date:   Wed, 28 Oct 2020 16:30:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/13] ARM: dts: imx7-mba7: add audio support
Message-ID: <20201028083024.GD28467@dragon>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
 <20200918112942.1367-9-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918112942.1367-9-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 01:29:38PM +0200, Matthias Schiffer wrote:
> The MBa7x is equipped with a TI TLV320AIC3204 audio codec.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied, thanks.
