Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8E24674D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 15:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgHQNZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 09:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbgHQNZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:25:18 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF752072D;
        Mon, 17 Aug 2020 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597670717;
        bh=fRSsjlMiQ7T0SidfHl12cOpI7j4a3NuX7eV9gm9EXh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHiZpRKqhmi3LiLIjISwh73O/ByjCTkh+COyWqPsPIo9+eNAiPQ9CYr9YKn5Ik4GC
         Pikr/lHpp3axcNOMDVYlJAGpwCcvxaIDLWm8RSFU0KiLr2iGa7xgw9BjbLLRvCR6Qz
         asc+Q8tZg8ABuua3pj9PK98ZASdGkp6FZDrs34tQ=
Date:   Mon, 17 Aug 2020 21:25:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qp-sabreauto: enable pcie
Message-ID: <20200817132511.GF16951@dragon>
References: <1595316176-8533-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595316176-8533-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 03:22:56PM +0800, Richard Zhu wrote:
> Add the reset-gpio property, and enable PCIe on iMX6QP SABREAUTO board.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Applied, thanks.
