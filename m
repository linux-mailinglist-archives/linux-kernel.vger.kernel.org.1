Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAB929D712
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgJ1WU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731727AbgJ1WRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:43 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A23E6207E8;
        Wed, 28 Oct 2020 08:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603873664;
        bh=kGeTSVloFHr3vmIk7mbyMryFYqWLWcWuNWQqBFEuTx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/iu6UIO39dVpQ0k+hluHaFX92ReeSUfv1UXBU8Gioupul3N5NHuzi8dsEBnFo8G1
         zN2lT1rlOOAwwvQF62ve+x1kExzCxh0kygwMFEvJ0hZ9DmAHD00kt7WtFyvdNWHGR5
         vOcDeRCd9heQjO89+fVnv6rdFrMCJptn/m+ymVWU=
Date:   Wed, 28 Oct 2020 16:27:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/13] ARM: dts: imx7-mba7: configure watchdog
Message-ID: <20201028082738.GB28467@dragon>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
 <20200918112942.1367-7-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918112942.1367-7-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 01:29:36PM +0200, Matthias Schiffer wrote:
> The external watchdog reset is necessary, as the internal reset is
> unreliable on i.MX7.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied, thanks.
