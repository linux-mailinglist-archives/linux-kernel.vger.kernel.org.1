Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5612BA6E2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgKTJ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:59:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbgKTJ7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:59:15 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 064F322244;
        Fri, 20 Nov 2020 09:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605866354;
        bh=/hwJuy51LfI8bco1UPEz1z3d4gSZXj9UtjndJ9W73f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGon0kmlXcFqycAt7aES43uF+wOlBpueb39HWVBk3uKnbco/8rN8AElyQiSMNUm+w
         R8qhmRzSs467E72kOihBp7zIJPQgGkQ6jQezkA0Y0bDQw6bipwTndYuE2uyyDb0V4E
         NAkuKMUKBl1ayCvgckgfJ2c1+35TOY+oD+aIVliA=
Date:   Fri, 20 Nov 2020 15:29:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, repk@triplefau.lt,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 0/3] phy: amlogic: add MIPI DSI function to
 analog MIPI+PCIe PHY
Message-ID: <20201120095905.GF2925@vkoul-mobl>
References: <20201116101647.73448-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116101647.73448-1-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 11:16, Neil Armstrong wrote:
> The AXG Analog MIPI-DSI PHY also provides functions to the PCIe PHY,
> thus we need to have inclusive support for both interfaces at runtime.
> 
> This fixes the regmap get from parent node, removes cell param
> to select a mode and implement runtime configuration & power on/off
> for both functions since they are not exclusive.

Applied, thanks

-- 
~Vinod
