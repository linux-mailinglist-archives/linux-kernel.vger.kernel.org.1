Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D102073E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 15:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403781AbgFXNB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 09:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390686AbgFXNB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:01:57 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201C320786;
        Wed, 24 Jun 2020 13:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593003717;
        bh=xIgR4etzuuD/XhDz5yuOShAfik5HvT9HtcNcSGjDtYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGw7tGnRPSN/oz+Nfm5oXVPChhbogO7X6Ayqr7/I8r+6DHOcqvnFofqJ2S+HEszig
         d8qiGt8fS/wZUl68abat2h7bRpTYsPNLDKMV6lG4hHcz+h91c1U5UWCVXiHXw5X9XN
         ciXFfANesn54t4GLwVME1p079cUqPt1lxC/4K8n4=
Date:   Wed, 24 Jun 2020 18:31:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v2 1/2] phy: rockchip: Fix return value of
 inno_dsidphy_probe()
Message-ID: <20200624130152.GE2324254@vkoul-mobl>
References: <1590412138-13903-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590412138-13903-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-20, 21:08, Tiezhu Yang wrote:
> When call function devm_platform_ioremap_resource(), we should use IS_ERR()
> to check the return value and return PTR_ERR() if failed.

Applied both, thanks
-- 
~Vinod
