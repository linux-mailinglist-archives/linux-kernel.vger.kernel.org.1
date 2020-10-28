Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0429DEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403779AbgJ2A5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731604AbgJ1WRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:35 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 732942464E;
        Wed, 28 Oct 2020 08:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603874207;
        bh=4lM6iYOIZikmQpB9cJqKV4kQrh4O9NaVgsLByu35P0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRYKekbhtcYMnTn+963U+c5weMsobT1CFB7mZaxMUOlpU4zkasrMBQhw/ojS4mHIk
         mgb7TMLLAi1s/0d4pmkvon5IjSwKXrzLJgc6iK2+OB6hUEzl/S+PBctknZNgyxYMMn
         efiN3U+fpyr8Z+MrKXz+lYmds5Hf3WNnWDAA6ZUg=
Date:   Wed, 28 Oct 2020 16:36:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/13] ARM: dts: imx7-mba7: update compatible strings
Message-ID: <20201028083641.GD28755@dragon>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
 <20200918112942.1367-3-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918112942.1367-3-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 01:29:32PM +0200, Matthias Schiffer wrote:
> Include the SoM compatible string.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied, thanks.
