Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6270A1BD305
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 05:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgD2Dje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 23:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgD2Djd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:39:33 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D02F7206D8;
        Wed, 29 Apr 2020 03:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588131573;
        bh=orkxRHn+N+RYYxUbCBgUPuZKuerrqDe2irKMLhkSJQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6a6hc0yElrC0bJ5rCY7Er66ixPzcpiR6EaPvWIhc24AU5SSdIUbz2abZiPHWU3Ps
         0e9KcK5WXhPio7DZCrLH3DUUDKLQqDfD1yJ1/dHOrvVRAghL17OmBki11Xg+359AWO
         kQ93ju+V1zWFYe4KU5VFY1K5vYanBzAVDdNC2OSM=
Date:   Wed, 29 Apr 2020 11:39:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, leonard.crestez@nxp.com, horia.geanta@nxp.com,
        peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mn: Update VDD_ARM 1.2GHz setpoint
 voltage
Message-ID: <20200429033927.GQ32592@dragon>
References: <1587817790-21698-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587817790-21698-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 08:29:50PM +0800, Anson Huang wrote:
> The latest datasheet Rev. 0.1, 03/2020 removes below constrain:
> 
> "If VDD_SOC/GPU/DDR = 0.95V, then VDD_ARM must be >= 0.95V."
> 
> So, for 1.2GHz setpoint VDD_ARM can use its typical voltage
> directly.
> 
> The datasheet can be downloaded from below link:
> https://www.nxp.com/docs/en/data-sheet/IMX8MNCEC.pdf
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
