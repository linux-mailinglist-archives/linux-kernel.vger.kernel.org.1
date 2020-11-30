Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4A82C8867
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgK3PkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgK3PkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:40:08 -0500
Received: from localhost (unknown [122.171.214.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CA2206C0;
        Mon, 30 Nov 2020 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606750767;
        bh=7f4KPZ4iCisw1kDO37mrD2ADltaAvJw3PYEd004KdcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFaE7bMwAMwcR764NAnL3/nzWmHQ0jrv+mfH2NWabKqNrZbLbajElNCV5kGb85xMI
         ahd6Wm1OHFWfzj41bNyrvis7+SmK7ZkEp9H6yw1dGP0QQt2IQMfp0iI/8avfksG/M7
         GxRHpX6WHE9JrJw31d1Jj3ppp7mdLbJ/sDdAJDEE=
Date:   Mon, 30 Nov 2020 21:09:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v2] phy: mediatek: Make PHY_MTK_{XSPHY,TPHY} depend on
 HAS_IOMEM and OF_ADDRESS to fix build errors
Message-ID: <20201130153923.GV8403@vkoul-mobl>
References: <1606289865-692-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606289865-692-1-git-send-email-yangtiezhu@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-11-20, 15:37, Tiezhu Yang wrote:
> devm_ioremap_resource() will be not built in lib/devres.c if
> CONFIG_HAS_IOMEM is not set, of_address_to_resource() will be
> not built in drivers/of/address.c if CONFIG_OF_ADDRESS is not
> set, and then there exists two build errors about undefined
> reference to "devm_ioremap_resource" and "of_address_to_resource"
> in phy-mtk-xsphy.c under COMPILE_TEST and CONFIG_PHY_MTK_XSPHY,
> make PHY_MTK_XSPHY depend on HAS_IOMEM and OF_ADDRESS to fix it.

Applied, thanks

-- 
~Vinod
