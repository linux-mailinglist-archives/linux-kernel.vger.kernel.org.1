Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D51E1DA763
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 03:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgETBpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 21:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgETBpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:45:17 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BD3720709;
        Wed, 20 May 2020 01:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589939116;
        bh=2lme2RoM2eTNoqbX0+bCWBeIeWNWaSeDiokWRr0bJNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5sIW75VHEsEri4mvDfO+OmOn6SaVit072XrcdA8GrIpw40OYuPDsOgF66jTSC0Vz
         pKb0SL6Tg1XP1SMqHd8nUUI940Qjl0KdyAk3D7inbT8mJ/fhXwgIwUiLy4KW5yYiI4
         6tTccPR23F8ayxgn9zpX+SOQB0rMZkjrwZpZwIdo=
Date:   Wed, 20 May 2020 09:45:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] ARM: dts: imx51: Add src node interrupt
Message-ID: <20200520014510.GM11739@dragon>
References: <1589250307-29662-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589250307-29662-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:25:06AM +0800, Anson Huang wrote:
> Interrupt is a required property according to SRC binding, add
> it for SRC node.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
