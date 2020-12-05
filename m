Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286402CFA94
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 09:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgLEIWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 03:22:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbgLEIRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 03:17:35 -0500
Date:   Sat, 5 Dec 2020 13:39:41 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607155785;
        bh=Sf1YRnbImSd7hCd/MVpu0h/SeRbvcgUw5D13UFupUfY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQAwG/I9uiCnAdeQScfLRocyscNpR3JypwXmHmRBl6cl0KLXAuNJxF14mzYZtIRU0
         p3I+wHPtGKN8l+7cLONgqaSxeo/IHTkidd4B7gZblMAeoaYTc9i8HNSR4kVK2ODFQe
         KvEpmYe0wqtQ9mSMxW+eQbFonQs88R3sSUceSwyBoDww6hGt1t/PkZCYqwrmy7Bhgs
         oUyKAcy2GYvKPUIYKtSdgY51e4bhPqLtrlXuMv/9WijzbC8VYPt8Y6xfF6HWghO2Qm
         YkMPI6a5OO/QD7sq/OVQ9d1ruasRH7G13Krq3X+iNywyxtZ4fBGw6JF+crr7TS98+F
         /wa3Mahsu10cA==
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        kishon@ti.com, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
Subject: Re: [PATCH v9 0/3] Use the generic PHY framework for Ingenic USB PHY.
Message-ID: <20201205080941.GX8403@vkoul-mobl>
References: <20201116141906.11758-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116141906.11758-1-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 22:19, 周琰杰 (Zhou Yanjie) wrote:
> v3->v4:
> Only add new generic-PHY driver, without removing the old one. Because the
> jz4740-musb driver is not ready to use the generic PHY framework. When the
> jz4740-musb driver is modified to use the generic PHY framework, the old
> jz4770-phy driver can be "retired".
> 
> v4->v5:
> 1.Add an extra blank line between "devm_of_phy_provider_register" and "return".
> 2.Remove unnecessary "phy_set_drvdata".
> 3.Add Paul Cercueil's Reviewed-by.
> 
> v5->v6:
> 1.Revert the removal of "phy_set_drvdata" in v5, removing "phy_set_drvdata" will
>   cause a kernel panic on CI20.
>   Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> 2.Rewrite the macro definitions, replace the original code with "FIELD_PREP()"
>   and "u32p_replace_bits()" according to Vinod Koul's suggestion.
> 
> v6->v7:
> 1.Remove the stray tab character.
> 2.Remove unnecessary "platform_set_drvdata".
> 3.Remove the "dev" field in priv structure, and use &phy->dev instead.
> 
> v7->v8:
> Add support for Ingenic JZ4775 SoC and X2000 SoC.
> 
> v8->v9:
> Correct the path errors in "ingenic,phy-usb.yaml" and "ingenic,cgu.yaml".

Applied, thanks

-- 
~Vinod
