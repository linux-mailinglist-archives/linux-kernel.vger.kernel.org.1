Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14E2B3DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgKPHu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:50:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgKPHu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:50:56 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC017222B9;
        Mon, 16 Nov 2020 07:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605513055;
        bh=NmNgU7S9AA1s66QzATwj7gQa6ultPwkNACno/5xHXvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OlWlSpvrmPXWIuaEgCildzVLz/8A1v1pWV2yOIkEAUxxFXrp/iTxwINB1eIJfhwSr
         WNckuUgGkoL8J7fi7yLsLFQVPI9ubJ0z5mRhA+XMGewGW2G+8rnHtICXjCj+qRdT4y
         +7mvtWNYKrui9Zs1RlG78xl+Vy/Svz/C4pkMRg0A=
Date:   Mon, 16 Nov 2020 13:20:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] phy: qualcomm: usb: Fix two COMPILE_TEST errors
Message-ID: <20201116075051.GQ7499@vkoul-mobl>
References: <20201113151225.1657600-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113151225.1657600-1-bryan.odonoghue@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-11-20, 15:12, Bryan O'Donoghue wrote:
> kernel build robot fired this email at me about an hour ago
> https://lkml.org/lkml/2020/11/13/414
> 
> The build robot has flagged the super-speed PHY driver but both Kconfig
> entries have the same error. Fix those now.
> 
> verified with "make menuconfig ARCH=s390"

Applied, thanks

-- 
~Vinod
