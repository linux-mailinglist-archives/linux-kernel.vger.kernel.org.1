Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE624D152
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 11:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgHUJVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 05:21:03 -0400
Received: from mx.socionext.com ([202.248.49.38]:43608 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHUJVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:21:02 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Aug 2020 18:21:00 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 236CA60060;
        Fri, 21 Aug 2020 18:21:01 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 21 Aug 2020 18:21:01 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 959D940376;
        Fri, 21 Aug 2020 18:21:00 +0900 (JST)
Received: from [10.212.1.43] (unknown [10.212.1.43])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 39EC9120137;
        Fri, 21 Aug 2020 18:21:00 +0900 (JST)
Subject: Re: [PATCH v4 0/2] Add new UniPhier AHCI PHY driver
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1594888344-32066-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <c60c0fc3-cb89-36e3-f18e-9a030ece72f1@socionext.com>
Date:   Fri, 21 Aug 2020 18:20:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1594888344-32066-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping.
Are there any comments in this series?

Thank you,

On 2020/07/16 17:32, Kunihiko Hayashi wrote:
> This series adds support for AHCI PHY interface implemented in Socionext
> UniPhier SoCs. This driver supports PXs2 and PXs3 SoCs.
> 
> Changes since v3:
> - Eliminate a meaningless blank line and a line break
> - Fix misspelling
> 
> Changes since v2:
> - Adjust copyright year
> - Add helper for enabling the controller
> - Remove redundant .init in uniphier_pxs2_data
> - Add comments for dummy read accesses
> - Fix return value in uniphier_ahciphy_init
> - dt-bindings: Add Reviewed-by line
> 
> Changes since v1:
> - dt-bindings: Fix items in reset-names
> 
> Kunihiko Hayashi (2):
>    dt-bindings: phy: Add UniPhier AHCI PHY description
>    phy: socionext: Add UniPhier AHCI PHY driver support
> 
>   .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |  76 +++++
>   drivers/phy/socionext/Kconfig                      |  10 +
>   drivers/phy/socionext/Makefile                     |   1 +
>   drivers/phy/socionext/phy-uniphier-ahci.c          | 321 +++++++++++++++++++++
>   4 files changed, 408 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>   create mode 100644 drivers/phy/socionext/phy-uniphier-ahci.c
> 

---
Best Regards
Kunihiko Hayashi
