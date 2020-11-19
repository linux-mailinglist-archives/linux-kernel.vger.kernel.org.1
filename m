Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3312B8B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgKSG10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:27:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgKSG10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:27:26 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48EF4246AD;
        Thu, 19 Nov 2020 06:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605767245;
        bh=2cPdxv/aidp+RTwTPRs1N04PixksnJO6TyfiZnvlIrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iySRVa3Vor5ebmlMvirwz6LcE/cK83Z50SHin4jcM63e+pEmefCA7FRC4dSwphk/n
         MbFTOQFIKBKTpxOcfcrIpywFuJDXrofD7PHE2YlLMIrdxAxSoFm40gh3Y+ss4b91Io
         T6FChglMmdKP6/3bhCVfYCZ0ezHQRf5IeeGjHey0=
Date:   Thu, 19 Nov 2020 11:57:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] phy: phy-bcm-ns-usb3: drop support for deprecated DT
 binding
Message-ID: <20201119062720.GE50232@vkoul-mobl>
References: <20201113113423.9466-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113113423.9466-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-11-20, 12:34, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Initially this PHY driver was implementing MDIO access on its own. It
> was caused by lack of proper hardware design understanding.
> 
> It has been changed back in 2017. DT bindings were changed and driver
> was updated to use MDIO layer.
> 
> It should be really safe now to drop the old deprecated code. All Linux
> stored DT files don't use it for 3,5 year. There is close to 0 chance
> there is any bootloader with its own DTB using old the binding.

Applied, thanks

While applying, it gave me a minor conflict, please do check the
resolution

-- 
~Vinod
