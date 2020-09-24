Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810E12776CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgIXQf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:35:58 -0400
Received: from ms.lwn.net ([45.79.88.28]:59126 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXQf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:35:58 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 05B52382;
        Thu, 24 Sep 2020 16:35:57 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:35:56 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wilken Gottwalt <wilken.gottwalt@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3] documentation: arm: sunxi: Allwinner H2+/H3 update
Message-ID: <20200924103556.272065ca@lwn.net>
In-Reply-To: <20200923065954.GA22809@monster.powergraphx.local>
References: <20200923065954.GA22809@monster.powergraphx.local>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 08:59:54 +0200
Wilken Gottwalt <wilken.gottwalt@mailbox.org> wrote:

> Replaced the link to the datasheet by a link to the current version.
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
> ---
> Changes in v3:
>         - removed the description of the H2+/H3 differences
> Changes in v2:
>         - addressed comments/proposals from Maxime
> ---
>  Documentation/arm/sunxi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm/sunxi.rst b/Documentation/arm/sunxi.rst
> index b037428aee98..62b533d0ba94 100644
> --- a/Documentation/arm/sunxi.rst
> +++ b/Documentation/arm/sunxi.rst
> @@ -108,7 +108,7 @@ SunXi family
>  
>          * Datasheet
>  
> -          http://dl.linux-sunxi.org/H3/Allwinner_H3_Datasheet_V1.0.pdf
> +          https://linux-sunxi.org/images/4/4b/Allwinner_H3_Datasheet_V1.2.pdf

Applied, thanks.

jon
