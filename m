Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B429F9BE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgJ3Adp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ3Adp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:33:45 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A9A20723;
        Fri, 30 Oct 2020 00:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604018023;
        bh=1odeK3gYIGNl5jsY8lj0v24PlT7SNcMRbEc3jxv/AJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=anC68eXWEaRb/UyzfUCsbaLW3RQsHT94ffr5DqVRKiFets7V7vQ33DST+4WzAjOt9
         vgd7TtLaQ+4P2ftq3ktDI6wJDQPIsj+lrHyu90tpO3kiVy0+ry57NWRkRYMkhvrXXC
         24xaamN1uDwt7/amUOxSR3pcz1ydBhmaVlmIHE6o=
Date:   Fri, 30 Oct 2020 08:33:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: fix endianness issue of rcpm
Message-ID: <20201030003337.GY28755@dragon>
References: <20200929013021.46395-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200929013021.46395-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 09:30:21AM +0800, Ran Wang wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> Add little-endian property to RCPM node (for ls1028a,ls1088a,ls208xa),
> otherwise RCPM driver will program hardware with incorrect setting,
> causing system (such as LS1028ARDB) failed to be waked by wakeup source.
> 
> Fixes: 791c88ca5713 (“arm64: dts: ls1028a: Add ftm_alarm0 DT node”)
> Fixes: f4fe3a8665495 (“arm64: dts: layerscape: add ftm_alarm0 node”)
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Acked-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks.
