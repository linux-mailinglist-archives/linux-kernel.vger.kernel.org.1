Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CBE24679B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgHQNpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 09:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728694AbgHQNpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:45:03 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB90020786;
        Mon, 17 Aug 2020 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597671903;
        bh=QGlbmATnskSVN/Nl3hxctYOP1POSW2fxxhMUaDEiKbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1wE6C9h6+40Ke+PXSG9ImorNqTPtT8gCx3JeKRCVBv7bleBFWEjxeGTCeTswWSIzE
         PuUn8RrRUfKCYArILfXZ319oZ8y7jWEEudFIUszfc0yHx12huTg2vhRu/4uAeEq6iM
         /u49JguaJRfyWe7NeUusJcSnO/92pjXzLIcBr4Ls=
Date:   Mon, 17 Aug 2020 21:44:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vabhav Sharma <vabhav.sharma@oss.nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, V.Sethi@nxp.com,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: qds: enable lpuart1
Message-ID: <20200817134457.GJ16951@dragon>
References: <1595590482-26833-1-git-send-email-vabhav.sharma@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595590482-26833-1-git-send-email-vabhav.sharma@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 05:04:42PM +0530, Vabhav Sharma wrote:
> From: Vabhav Sharma <vabhav.sharma@nxp.com>
> 
> LPUART nodes by default are disabled in LS1028A device
> tree, Enabling LPUART1 node
> 
> Acked-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>

Applied, thanks.
