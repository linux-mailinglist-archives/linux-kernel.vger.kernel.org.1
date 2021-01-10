Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883F82F06FB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbhAJMA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbhAJMA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:00:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2D702376E;
        Sun, 10 Jan 2021 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610280016;
        bh=VKYctqG42804wmTyAS+Qd4LIbcl/miI2AGg1f7H2npM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fi5tpZVWHNLkyWWco9lMlmq1ZOigONfwJLqcMpjClMHfC8iDFT1qRDPpiSlwazH2R
         Az45czyBS59q4hQIFT5IgK+z6sxIoDIO+spapfOI1hRR5hJ2+sQpz/5YN3UA5mpqr/
         j6oVcP/6McL6hTjikiFYHbq8HOA6pAo939Lea7VBq/xLvGYAC1k9ipaeNZXi7u+UQT
         4zyq9BmRmbgmwKmh3QeDu/YXG/JdjAhmQMz70WlS22wrJeKzpGlGjNjMUCYZPgFJ+G
         TTfvytWteDlJnAbOhanFsIq6kUQCvXSPSzZ9rFOIEzV4biyKmd8eWB1orSgh26DyVU
         JHwJNnPABjvbQ==
Date:   Sun, 10 Jan 2021 20:00:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Sudhanshu Gupta <sudhanshu.gupta@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Rai Harninder <harninder.rai@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix the offset of the reset register
Message-ID: <20210110120010.GG28365@dragon>
References: <20201215212622.717-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215212622.717-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 10:26:22PM +0100, Michael Walle wrote:
> The offset of the reset request register is 0, the absolute address is
> 0x1e60000. Boards without PSCI support will fail to perform a reset:
> 
> [   26.734700] reboot: Restarting system
> [   27.743259] Unable to restart system
> [   27.746845] Reboot failed -- System halted
> 
> Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
