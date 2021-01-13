Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F4B2F4A86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbhAMLoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:44:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbhAMLoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:44:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99CCB233ED;
        Wed, 13 Jan 2021 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610538203;
        bh=4lfAzIIXpvDgPBgljbfYqu50jIJ3GftaisI4cpyB6LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cH7Q1Mmh8k1Tg7X9NkHaLthBt+Zsk3e8LKYGc7NO2spDW/jO6zbg69p7npgbzjtbK
         m1ChektHDSte7Leb7PcEMROVmrXrjXJmnw4cdq63xG41juyHKrAZBpJV3cBhOwqSDC
         UkhB0gRBLxj0Hqu50/HJrmY6KNlJMGMgp8Q46Kzu6F0EHamlGpzUvSy0PmQKxSvhAL
         tIcYQ237PyW27M8pBu+4hB6EI1N+5xgmoc2Uedzv4FL4i23qViJ2AdRaJCfh6qZCic
         wbCdjLmTt8D/dSD7kFZdSxKigg91d8aB5No+xvOwhz3PlMJIr+pkHmefWXH8CCOSG7
         Dps2UJ/dvL2FQ==
Date:   Wed, 13 Jan 2021 17:13:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] phy: rockchip-emmc: emmc_phy_init() always return 0
Message-ID: <20210113114315.GB2771@vkoul-mobl>
References: <20201210080454.17379-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210080454.17379-1-chris.ruehl@gtsys.com.hk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-20, 16:04, Chris Ruehl wrote:
> rockchip_emmc_phy_init() return variable is not set with the error value
> if clk_get() failed. 'emmcclk' is optional, thus use clk_get_optional()
> and if the return value != NULL make error processing and set the
> return code accordingly.

Applied, thanks

> 
> Fixes: 52c0624a10cce phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
> 

No empty lines after fixes line pls

-- 
~Vinod
