Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6491D0B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbgEMI6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 04:58:53 -0400
Received: from 8bytes.org ([81.169.241.247]:42270 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730346AbgEMI6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:58:53 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9252C379; Wed, 13 May 2020 10:58:51 +0200 (CEST)
Date:   Wed, 13 May 2020 10:58:50 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Will Deacon <will@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Robin Murphy <robin.murphy@arm.com>,
        Hai Nguyen Pham <hai.pham.ud@renesas.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/renesas: fix unused-function warning
Message-ID: <20200513085850.GG9820@8bytes.org>
References: <20200508220224.688985-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508220224.688985-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 12:02:16AM +0200, Arnd Bergmann wrote:
> gcc warns because the only reference to ipmmu_find_group
> is inside of an #ifdef:
> 
> drivers/iommu/ipmmu-vmsa.c:878:28: error: 'ipmmu_find_group' defined but not used [-Werror=unused-function]
> 
> Change the #ifdef to an equivalent IS_ENABLED().
> 
> Fixes: 6580c8a78424 ("iommu/renesas: Convert to probe/release_device() call-backs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied, thanks.
