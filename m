Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E62D91ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 03:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438257AbgLNC5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 21:57:33 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:54338 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgLNC5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 21:57:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id D0F7920138C7;
        Mon, 14 Dec 2020 10:56:31 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sDG8LkYOmztR; Mon, 14 Dec 2020 10:56:31 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id AB2F420138C6;
        Mon, 14 Dec 2020 10:56:31 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.105])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 2E953C01FAD;
        Mon, 14 Dec 2020 10:56:31 +0800 (HKT)
Subject: Re: [PATCH 0/3] rockchip: emmc: rk3399 add vendor prefix
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20201214024720.24656-1-chris.ruehl@gtsys.com.hk>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <3de52cae-f790-9881-b540-328118de45cc@gtsys.com.hk>
Date:   Mon, 14 Dec 2020 10:56:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201214024720.24656-1-chris.ruehl@gtsys.com.hk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/12/2020 10:47 am, Chris Ruehl wrote:
> This patchset follow up with commit
> Following the reference in vendor-prefixes.yaml, update implementation,
> devicetree binding dtsi and documentation for the phy-rockchip-emmc.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
> Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 19 ++++++++++---------
> arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi               |  2 +-
> arch/arm64/boot/dts/rockchip/rk3399.dtsi                    |  2 +-
> drivers/phy/rockchip/phy-rockchip-emmc.c                    |  6 +++---
> 4 files changed, 15 insertions(+), 14 deletions(-)
> 

Sorry send incomplete patch-set accidentally

v1 follow.

Chris
