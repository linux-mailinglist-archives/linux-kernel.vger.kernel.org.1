Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161C22C82C2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387394AbgK3LCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgK3LCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:02:12 -0500
Received: from localhost (unknown [122.171.214.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E437207F7;
        Mon, 30 Nov 2020 11:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606734092;
        bh=u2ceb1FjNxP1Dx10zTQidfx6V8dt7vhYLK26IK2uKBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jesh5qnt6HKNiA2NUpIIQdXrXalDtPsfJE3eWCGpv0ZLMI07P0YSf/2S6slY17SPb
         4TXa+2nElExsghiE2/nIwWG6YKwxL5lQSKeAiu3/JcZRI+FyBGVaOXw+buTUf9BoGN
         iMjthMcbzHZsHy+70wAI1BhhHBBzJy94bMJzpL6w=
Date:   Mon, 30 Nov 2020 16:31:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3] phy: amlogic: phy-meson-gxl-usb2: keep ID pull-up
 even in Host mode
Message-ID: <20201130110113.GR8403@vkoul-mobl>
References: <20201120153855.3920757-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120153855.3920757-1-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-20, 16:38, Neil Armstrong wrote:
> In order to keep OTG ID detection even when in Host mode, the ID line of
> the PHY (if the current phy is an OTG one) pull-up should be kept
> enable in both modes.
> 
> This fixes OTG switch on GXL, GXM & AXG platforms, otherwise once switched
> to Host, the ID detection doesn't work anymore to switch back to Device.

Applied, thanks

-- 
~Vinod
