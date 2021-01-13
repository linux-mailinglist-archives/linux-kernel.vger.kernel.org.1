Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFEF2F4AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbhAMLzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbhAMLzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:55:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCB7E22CE3;
        Wed, 13 Jan 2021 11:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610538874;
        bh=UR9Q8J5UKPRcEM0FWW19Ma/gHSEuq+X59AMnoAaIOSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PL8QDmOWZGO+UxzzrOt3vax9wXDKEetmuQ6x34HaMfungR60Gb1OuIHpjRcW1K7lF
         g1fNCYPuNl8WE5bexbvGLHJcXLWcp7SJ3ieFlh/KdW+0iQ5f6+akQDvX7uYsMayIF7
         ytV6Xz4A8Zgwm886qLEyPXZZfJcWqGLzfCqv1gbePDY/HtJiBH9oSfrV0kVN9uLrtK
         h0EgHK2ns9PkZxaQx40lOjfzKBKfHZztik5rW4+C4rvaKQOD0Tulrhlg2DMrbPMflI
         IGWYowpy2uK5k0mwifJ3w4JuM8bmHnU7KgSE0biI9fKqbHlPlP2yAFccZBgM9hp2pP
         4VgYhMqDiJsgg==
Date:   Wed, 13 Jan 2021 17:24:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 0/2] rockchip: emmc: rk3399 add vendor prefix
Message-ID: <20210113115426.GE2771@vkoul-mobl>
References: <20201215014409.905-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215014409.905-1-chris.ruehl@gtsys.com.hk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-12-20, 09:44, Chris Ruehl wrote:
> Following the reference in vendor-prefixes.yaml, update implementation
> and documentation for the phy-rockchip-emmc.
> This patchset follow up with 
> commit 8b5c2b45b8f0a ("phy: rockchip: set pulldown for strobe line in dts")
> commit a8cef928276bb ("phy: rockchip-emmc: output tap delay dt property")

Applied, thanks

-- 
~Vinod
