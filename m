Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9876B2F4AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbhAMMB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbhAMMBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:01:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 007E023120;
        Wed, 13 Jan 2021 12:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610539274;
        bh=0kcsXKcvhtdNBkgEawvGeAle7LC/iJ2XfAp40mhHTn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9qIWsuTi9rlA9+GN4Fh2S7HojcR/WP6yeXoqPKmcKxR+YFs12wiHNniQx4mv8HzR
         KLSvR45DxIY3zNJxjZEamHBZw3MfKIfrq4f35xs34/x1veoaccY//Rv0yRhYKp+AQA
         lv/s7E87Ir4Uy267BnrvSolox1Kdn8Kl7mzWwwZ+8bpqFVzZqir5o6y+hBi1Lpz9WN
         FdT5uBuG40OLO+SfYQsO45fNdOAMxooXdj9LjfWerURRwwNhXRCjHQb5TQ/wAk4XaU
         MNGoHWGntO1IN4pm2yC0j0sPr+Ce41X8Qw1zfkdA2oz2mDdExn1rx8ugAEuxmTuHQQ
         CMN4XWr/Cs0pw==
Date:   Wed, 13 Jan 2021 17:31:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] phy: cadence-torrent: Fix error code in
 cdns_torrent_phy_probe()
Message-ID: <20210113120109.GG2771@vkoul-mobl>
References: <X9s7Wxq+b6ls0q7o@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9s7Wxq+b6ls0q7o@mwanda>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-12-20, 14:04, Dan Carpenter wrote:
> This error path should return -EINVAL, but currently it returns
> success.

Applied, thanks

-- 
~Vinod
