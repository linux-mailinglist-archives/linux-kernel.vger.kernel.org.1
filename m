Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1F821D246
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgGMI4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgGMI4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:56:18 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 304F02068F;
        Mon, 13 Jul 2020 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594630577;
        bh=Bj5vZ3+CTnRBIkKiuUpgL9L/ChDAOAHz3wVUXrfL5p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWxkQPasQCfurIkSzXVuGME7W2SgViBtta63DRt1v/8fyz1f21eXVKH5KXkSuraeq
         vpn84Pq914TxRtejYxJFCS1n2hdIqe5aJZD0EDPA4fq23BgbZ4LIl55LSFTHEB6n0X
         XO1XE9g1qjZqRyblXuhZTlYKi0iuGbeedHg2wzZE=
Date:   Mon, 13 Jul 2020 16:56:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Wasim Khan <wasim.khan@oss.nxp.com>
Cc:     robh+dt@kernel.org, zhiqiang.hou@nxp.com, V.sethi@nxp.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wasim Khan <wasim.khan@nxp.com>
Subject: Re: [PATCH] arm64: dts: lx2160a: Increase configuration space size
Message-ID: <20200713085612.GH15718@dragon>
References: <1594374704-11323-1-git-send-email-wasim.khan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594374704-11323-1-git-send-email-wasim.khan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 03:21:44PM +0530, Wasim Khan wrote:
> From: Wasim Khan <wasim.khan@nxp.com>
> 
> lx2160a rev2 requires 4KB space for type0 and 4KB
> space for type1 iATU window. Increase configuration
> space size to 8KB to have sufficient space for type0
> and type1 window.
> 
> Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
> Reviewed-by: Li Yang <leoyang.li@nxp.com>
> Acked-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Applied, thanks.
