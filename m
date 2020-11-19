Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5906C2B8B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgKSGTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgKSGTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:19:36 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1729C246A5;
        Thu, 19 Nov 2020 06:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605766776;
        bh=rb13EWU1X7fI0daXoTj4tyz1I6Xr8M1enBLvznw/Mk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aqc6OsF6PDb47biuwSiysXWCWntguikwhVkSj1yg9hcNcW0N4FkPw7IMhKGsmXwbp
         UPSRDQ2uzUjfac/5kdztXwJzyE2XZQ/vEXDXIwzXu8Pg8hb+KrPs3iAR8p32WM9gTy
         SK+SM4v/532MoZYBB5MZ6DknFwqBwDEi3BgT84Q8=
Date:   Thu, 19 Nov 2020 11:49:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     tiny.windzz@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [RESEND PATCH 08/19] phy: sun4i-usb: remove enable_pmu_unk1 from
 sun50i_h6_cfg
Message-ID: <20201119061931.GC50232@vkoul-mobl>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <dc8cbb7b3cd59902a6719f207d18a232903fac8a.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc8cbb7b3cd59902a6719f207d18a232903fac8a.1604988979.git.frank@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-11-20, 14:32, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> For the current code, enable_pmu_unk1 only works in non-a83t and non-h6
> types. So let's delete it from the sun50i_h6_cfg.

Applied, thanks

-- 
~Vinod
