Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E70B24E786
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 14:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHVMsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 08:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgHVMsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 08:48:00 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 023FD2072D;
        Sat, 22 Aug 2020 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598100479;
        bh=bAJMzC297RSNvnS+KubnO+QEOy7vDWbN3uDCkxE6IRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i99FZ7U+HsPIslKptQRSOfRrX5oV07MAhU/rP7AjT8wiC8JSvRBn6UgAHoEy7xY05
         S28JvUPeRodczgj1OeMxUlwMKqO0ZBNiDxA9iXWwKVslli0gOTdTwqqVZg7iIHITgw
         Pkrnf1xwoaBmb9MDcRK0c8pkU17mq6NX6MUbsMqw=
Date:   Sat, 22 Aug 2020 20:47:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1] ARM: dts/imx6q-bx50v3: Add IRQ support for internal
 switch
Message-ID: <20200822124753.GA30094@dragon>
References: <20200805135817.391409-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805135817.391409-1-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 03:58:17PM +0200, Sebastian Reichel wrote:
> This adds missing interrupt support for the internal Marvell
> switch, so that the kernel does not have to keep polling the
> PHYs on the bit-banged MDIO bus all the time.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Changed subject prefix to 'ARM: dts: imx6q-bx50v3: ...', and applied the
patch.

Shawn
