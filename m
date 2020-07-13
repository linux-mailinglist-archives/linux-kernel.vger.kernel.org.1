Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4F021D18B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgGMIUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMIUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:20:12 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8F920674;
        Mon, 13 Jul 2020 08:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594628412;
        bh=JYqWxpo4yL4jdbOLhB+e27SzzzPd6sbYyeUSppl1MN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3iwQbCB0B5amG/93J+rh/B6llfUmsk+8uU9Q3+T7uXYe8H0185I9f2O1eOMcshW9
         OG7EypxhY/MAW/pl4HDzJ/JS6Uu0H3F3SUB/OAEAAkh7OmrXnpNcxhlWuKC/xnh2pS
         r4jqKIiHc5MjvgPH4TciqCAngcLgUE1B2cYGIiAI=
Date:   Mon, 13 Jul 2020 16:20:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, stefan@agner.ch, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: [PATCH v3] arm: dts: ZII: update MDIO speed and preamble
Message-ID: <20200713082006.GN12113@dragon>
References: <20200708011627.7427-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708011627.7427-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 06:16:27PM -0700, Chris Healy wrote:
> Update MDIO configuration with ZII devices to fully utilize
> MDIO endpoint capabilities.  All devices support 12.5MHz clock and
> don't require MDIO preable.
> 
> Signed-off-by: Chris Healy <cphealy@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

We use prefix 'ARM: ...' for arm dts.  Fixed it up and applied the
patch.

Shawn
