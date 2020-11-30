Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7312C82C1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgK3LBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:01:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgK3LBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:01:16 -0500
Received: from localhost (unknown [122.171.214.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95DC4207F7;
        Mon, 30 Nov 2020 11:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606734035;
        bh=3C6mZOAiilrrDhsn4gHtKKy29/Oth1UBYyR8wF7lPgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xK4SnG+/0O90XbkXzMOQdn+jifYegtaPQL0Ue0QT6Sgm1qem1/94bfm2yUxS4Eru2
         mO8aB2Y+21uaJYK1dpj08GBmkSbD1CP5xJXAZonl9Rlh6vkSVDnGD9eJgLIxZthTcL
         EV5615DQNFyqLrx7PK+6xNCRNkoVqo719wStwLRk=
Date:   Mon, 30 Nov 2020 16:30:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        repk@triplefau.lt
Subject: Re: [PATCH] phy: amlogic: meson-axg-mipi-pcie-analog: replace
 DSI_LANE definitions with BIT() macro
Message-ID: <20201130110031.GQ8403@vkoul-mobl>
References: <20201120150347.3914901-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120150347.3914901-1-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-20, 16:03, Neil Armstrong wrote:
> For consistency, replace DSI_LANE definitions with BIT() macro and remove the unused
> DSI_LANE_MASK definition.

Applied, thanks

-- 
~Vinod
