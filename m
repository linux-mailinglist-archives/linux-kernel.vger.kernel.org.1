Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82921CFF5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 08:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgGMGq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 02:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgGMGqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:46:25 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0A6220720;
        Mon, 13 Jul 2020 06:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594622785;
        bh=WMpwxz2DK8l8eTJ+kG/nFUEUyFdJiAa4S2CsgmNfFJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0fYJ7GyTxubXsuOUBe4mPAAo/lekrQw4dH4bzNq8KgzbfZwIJqUMjFwjUIHnTl6tB
         PgfY7fH/kaW+KYdAS+AiAS9+OEln2yVBoD/iBurApNG6O0nMCQ1n3l4uMeMMgRYcQw
         KK59akZdNUDB0evd1HweP+TRfQmGlIrSPZS4Xk6o=
Date:   Mon, 13 Jul 2020 12:16:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Igal Liberman <igall@marvell.com>
Subject: Re: [PATCH 1/6] phy-mvebu-a3700-utmi: correct typo in struct
 mvebu_a3700_utmi comments
Message-ID: <20200713064621.GF34333@vkoul-mobl>
References: <20200708132809.265967-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708132809.265967-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-07-20, 18:58, Vinod Koul wrote:
> We get warning with W=1 build:
> drivers/phy/marvell/phy-mvebu-a3700-utmi.c:84: warning: Function
> parameter or member 'usb_misc' not described in 'mvebu_a3700_utmi'

Applied all now

-- 
~Vinod
