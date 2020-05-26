Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9F1E0C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 12:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389896AbgEYKnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 06:43:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52722 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbgEYKnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:43:53 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jdAa8-0007fu-Cf; Mon, 25 May 2020 12:43:44 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 1/2] phy: rockchip: Fix return value of inno_dsidphy_probe()
Date:   Mon, 25 May 2020 12:43:43 +0200
Message-ID: <2126910.YdF4jQdSac@diego>
In-Reply-To: <1590379739-18729-1-git-send-email-yangtiezhu@loongson.cn>
References: <1590379739-18729-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 25. Mai 2020, 06:08:58 CEST schrieb Tiezhu Yang:
> When call function devm_platform_ioremap_resource(), we should use IS_ERR()
> to check the return value and return PTR_ERR() if failed.
> 
> Fixes: b7535a3bc0ba ("phy/rockchip: Add support for Innosilicon MIPI/LVDS/TTL PHY")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


