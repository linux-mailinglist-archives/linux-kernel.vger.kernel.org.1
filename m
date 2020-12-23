Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA5A2E181E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 05:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgLWEaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 23:30:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLWEaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 23:30:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6B0120857;
        Wed, 23 Dec 2020 04:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608697773;
        bh=CPq6biGO5phYDl1PaVoSU6adJOVYTlt+awaTwSBditk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfPm+G1aQAOOXbQRT+lXwz8F5oaPoiGRA5NL7hKBTBrO0cKhambYIw3rG1qpA4/Gx
         t76XfLZQsbNhSzKGg/2BzOYAoCyJuODtZAtw0n7zIL7hy0Luf3CMUP5f0tTP5N17KX
         98dwxERkMhSL/E5e8fzIBc/pqs9lTA0Hn1g3V2onj8543cO95s/5SUOAij4U8VMYk1
         BU9DQFwG04s4HcAD6EnHVFRxJxYj9RkgWz1k8cQ80J6QyzkNXnvFy9b9lve1sx0YOM
         Nt0MFS5zW+R+YG34K+QQWHVZ0DLqVOqSxp6CCrvCnDfvnQTt2JmTgPGPEwt3+PsF4K
         DZ0JZxUDFzk0Q==
Date:   Wed, 23 Dec 2020 09:59:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        =?utf-8?B?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>,
        Paul Cercueil <paul@crapouillou.net>,
        =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH phy] PHY: Ingenic: fix unconditional build of
 phy-ingenic-usb
Message-ID: <20201223042929.GC120946@vkoul-mobl>
References: <20201222131021.4751-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222131021.4751-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-20, 13:10, Alexander Lobakin wrote:
> Currently drivers/phy/ingenic/Makefile adds phy-ingenic-usb to targets
> not depending on actual Kconfig symbol CONFIG_PHY_INGENIC_USB, so this
> driver always gets built[-in] on every system.
> Add missing dependency.

Applied, thanks

-- 
~Vinod
