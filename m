Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010F620480F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 05:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgFWDsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 23:48:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730650AbgFWDsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 23:48:08 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 898FD206C1;
        Tue, 23 Jun 2020 03:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592884087;
        bh=E9eZQEJooa0JO07752ol9GWC74vajGcJB67vu55NA40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5CLwRAi8Dh3E201cy5oomFaZ/qvQP2OANuRmqHn4epE+4PRdU06yI/z6bZHvcYJx
         LNn8+vx6kpog28zso7r/ziwsQmKLQnaSv1hs/AUj0XKrtcvQ0qZi0IeHssDsWC6DJq
         9wHMxtqSBL/3VQ0smtebh9wmyiF+gpdDafs4SUHc=
Date:   Tue, 23 Jun 2020 11:47:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6qdl-gw54xx: allow boot firmware to set
 eth1 MAC
Message-ID: <20200623034756.GL30139@dragon>
References: <1590695596-1462-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590695596-1462-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:53:16PM -0700, Tim Harvey wrote:
> The GW54xx has a PCIe based GbE as the 2nd ethernet device. The
> boot firmware will populate the local-mac-address field of the
> device aliased to ethernet1 thus adding the PCIe device to
> dt allows boot firmware to set its MAC address.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
