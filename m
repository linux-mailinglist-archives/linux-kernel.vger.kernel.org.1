Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061582743E3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIVOOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgIVOOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:14:36 -0400
Received: from localhost (unknown [122.179.101.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2281D214F1;
        Tue, 22 Sep 2020 14:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600784076;
        bh=UGnBrgFj7oS2c7lAeMSQaa54hQbG6T3Q94/aYM4xf9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQht5MEXHUJe4cbwEuwzZ+wtMgINUaH6C0UZZBN5iVwPGSc7EHNkpETkY7S6MBS7f
         CqgCXPF3Sfnfj9UM5c8IaSAfp/F8gjg3d0ygrBSdRkqrl+XFDQ0AF3w1BysA1NsNwV
         O8YQ3RD4IGAiDJ16QMWyfaDeSBimZeb20K6dnB1Y=
Date:   Tue, 22 Sep 2020 19:44:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH] phy: rockchip-dphy-rx0: Include linux/delay.h
Message-ID: <20200922141427.GA2968@vkoul-mobl>
References: <20200921225618.52529-1-tfiga@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921225618.52529-1-tfiga@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-09-20, 22:56, Tomasz Figa wrote:
> Fix an implicit declaration of usleep_range():
> 
> drivers/phy/rockchip/phy-rockchip-dphy-rx0.c: In function 'rk_dphy_enable':
> drivers/phy/rockchip/phy-rockchip-dphy-rx0.c:203:2: error: implicit declaration of function 'usleep_range' [-Werror=implicit-function-declaration]

Applied, thanks

-- 
~Vinod
