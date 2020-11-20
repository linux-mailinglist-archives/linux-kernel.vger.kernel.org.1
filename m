Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653672BA6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgKTJ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:58:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgKTJ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:58:56 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD2A22240;
        Fri, 20 Nov 2020 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605866336;
        bh=pwb55qO6JWZ7TpRPh8d8nTkVtoTV/uG6cIMurpYtnlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=phr7UZhYJQ5Gribf658npeOHcZ2FigibRFeyOJ/EZ3X9grHJDxnEuU9LTiSlfaaf6
         ekRXsSvFdyKhO7NV+C40Z33/urGFtHkCeji4ZlLsKiKBw7Hadf9KQ+E351Kk5C0+OQ
         u7jwMUaL0Orh1rR2cuuElUkGRTbpTatGeIQP10gE=
Date:   Fri, 20 Nov 2020 15:28:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 0/2] phy: amlogic: Add support for AXG MIPI
 D-PHY
Message-ID: <20201120095842.GE2925@vkoul-mobl>
References: <20201116101315.71720-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116101315.71720-1-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 11:13, Neil Armstrong wrote:
> The Amlogic AXg SoCs embeds a MIPI D-PHY to communicate with DSI
> panels, this adds the bindings.
> 
> This D-PHY depends on a separate analog PHY.

Applied, thanks

-- 
~Vinod
