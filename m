Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CCD2185DD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 13:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgGHLQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 07:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgGHLQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:16:21 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB00720739;
        Wed,  8 Jul 2020 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594206981;
        bh=FQJDJx+jzPkra8mqaevwhmjfYTTG3AOP9YtcAEP1U7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJjTAVthLhpGGe7Qloj3DJObPsodL+zuWuZcE0AShu7qGbnW5Usu/4d/++eBios65
         3zcs479+NdLkU7bGT2dot/Z+UlXc0mqXCOssSQNyxk4AJh1OBPGxiU7R11zTlud6iq
         pcFtySW9LVEdjxAsTk4lUi8VDG5ZzaTCSTzssRgs=
Date:   Wed, 8 Jul 2020 16:46:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: allwinner: phy-sun6i-mipi-dphy: Constify structs
Message-ID: <20200708111617.GF34333@vkoul-mobl>
References: <20200629195727.9717-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629195727.9717-1-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-20, 21:57, Rikard Falkeborn wrote:
> sun6i_dphy_ops and sun6i_dphy_regmap_config are not modified so make them
> const structs to allow the compiler to put them in read-only memory.
> 
> Before:
>    text    data     bss     dec     hex filename
>    4407    1944      64    6415    190f drivers/phy/allwinner/phy-sun6i-mipi-dphy.o
> 
> After:
>    text    data     bss     dec     hex filename
>    4835    1496      64    6395    18fb drivers/phy/allwinner/phy-sun6i-mipi-dphy.o

Applied, thanks

-- 
~Vinod
