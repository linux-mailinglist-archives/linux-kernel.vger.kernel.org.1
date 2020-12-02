Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388812CB5C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgLBHYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:24:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgLBHYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:24:43 -0500
Date:   Wed, 2 Dec 2020 12:53:58 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606893843;
        bh=GP2qsRdMb9wyNunurbinjChqWadXkhBC/ArZI74JxWA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=BY/hSeVVS2HEYLGI4+RNlqebVKqloj6PeyLHOs1CeHaqGJ3Q0Ov+1XH5AwktRtqPf
         LqJJz4mw4wAEVzSOJnup1Xy30qMPU1xfV29YfQ3s0YtXRRtUaaxh7J1yUqxKXeeCZV
         vZgCh5aqqYkyGS+tsWOXf8uZKqk4qp6KAD2dTNHE=
From:   Vinod Koul <vkoul@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] phy/rockchip: Make PHY_ROCKCHIP_INNO_HDMI depend on
 HAS_IOMEM to fix build error
Message-ID: <20201202072358.GI8403@vkoul-mobl>
References: <1606216287-14648-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606216287-14648-1-git-send-email-yangtiezhu@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-11-20, 19:11, Tiezhu Yang wrote:
> devm_ioremap_resource() will be not built in lib/devres.c if
> CONFIG_HAS_IOMEM is not set, and then there exists a build
> error about undefined reference to "devm_ioremap_resource"
> in the file phy-rockchip-inno-hdmi.c under COMPILE_TEST and
> CONFIG_PHY_ROCKCHIP_INNO_HDMI, make PHY_ROCKCHIP_INNO_HDMI
> depend on HAS_IOMEM to fix it.

Applied, thanks

-- 
~Vinod
