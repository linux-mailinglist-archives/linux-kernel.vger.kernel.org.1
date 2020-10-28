Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7529D5B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgJ1WIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:08:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:45140 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730132AbgJ1WH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:07:58 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EA361AA9;
        Wed, 28 Oct 2020 17:19:38 +0000 (UTC)
Date:   Wed, 28 Oct 2020 11:19:38 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wilken Gottwalt <wilken.gottwalt@linux-addicted.net>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2] documentation: arm: sunxi: add Allwinner H6
 documents
Message-ID: <20201028111938.183451a1@lwn.net>
In-Reply-To: <20201027062408.GA6761@monster.powergraphx.local>
References: <20201027062408.GA6761@monster.powergraphx.local>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 07:24:08 +0100
Wilken Gottwalt <wilken.gottwalt@linux-addicted.net> wrote:

> Add the current Allwinner H6 datasheet and user manual.
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@linux-addicted.net>
> ---
> Changes in v2:
> 	- changed email because of serious problems between my old email
> 	  provider and the lkml
> ---
>  Documentation/arm/sunxi.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/arm/sunxi.rst b/Documentation/arm/sunxi.rst
> index 62b533d0ba94..0c536ae1d7c2 100644
> --- a/Documentation/arm/sunxi.rst
> +++ b/Documentation/arm/sunxi.rst
> @@ -148,3 +148,13 @@ SunXi family
>          * User Manual
>  
>            http://dl.linux-sunxi.org/A64/Allwinner%20A64%20User%20Manual%20v1.0.pdf
> +
> +      - Allwinner H6
> +
> +	* Datasheet
> +
> +	  https://linux-sunxi.org/images/5/5c/Allwinner_H6_V200_Datasheet_V1.1.pdf
> +
> +	* User Manual
> +
> +	  https://linux-sunxi.org/images/4/46/Allwinner_H6_V200_User_Manual_V1.1.pdf

Applied, thanks.

jon
