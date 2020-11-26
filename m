Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678EC2C5DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 23:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391847AbgKZW1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 17:27:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58275 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732463AbgKZW1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 17:27:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B1D2105211;
        Thu, 26 Nov 2020 17:27:37 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=e6D8JtrZh+gyuLF4VkESI6EIFAQ=; b=ntv0/U
        BaVqtZ3Oc7rguk9iohCqODrlsAZ1Ie77r7fX08AiUY3rqOPeQfAF8EW77UG5sRqj
        uH8dcorO14s/zk7P2xaBi4o+3+mrWR2QdpnjVmx4I/nTkoLlvtrufqhg7kgS15Uh
        3FZQ75XNx+iLsB9Ds1sRhy+Fg+67WoY9PzG38=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23C18105210;
        Thu, 26 Nov 2020 17:27:37 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=4l+cSIPmi8hYrYSvBRQOMiOM05217aFM+h4f2fNLbs4=; b=QD2Vs/Z/DuvOz64mqNVjRl9kiQA7l/6LmRnkONse6tFSQSDlh8/489Qyd0njqEvNmcI0+7lRSpte9tTZ1hZkAMTrcJRRLk6sVspG4/XsGJjD1hEPaSi3oj918hiBZ0GUbz6w35tXJPa0+nKPqi9g8IbrLUWqCJsaCzXFklu01bQ=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 18F5910520E;
        Thu, 26 Nov 2020 17:27:34 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 4C5702DA0AC8;
        Thu, 26 Nov 2020 17:27:32 -0500 (EST)
Date:   Thu, 26 Nov 2020 17:27:32 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Colin King <colin.king@canonical.com>
cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs: Kconfig: Fix spelling mistake "adresssed" ->
 "addressed"
In-Reply-To: <20201126222405.12772-1-colin.king@canonical.com>
Message-ID: <64s43648-2182-3n94-5ssr-9943o794r97q@syhkavp.arg>
References: <20201126222405.12772-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 946849C0-3036-11EB-BCA2-E43E2BB96649-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the Kconfig help text. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> ---
>  fs/cramfs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cramfs/Kconfig b/fs/cramfs/Kconfig
> index d98cef0dbb6b..a8af8c6ac15d 100644
> --- a/fs/cramfs/Kconfig
> +++ b/fs/cramfs/Kconfig
> @@ -38,7 +38,7 @@ config CRAMFS_MTD
>  	default y if !CRAMFS_BLOCKDEV
>  	help
>  	  This option allows the CramFs driver to load data directly from
> -	  a linear adressed memory range (usually non volatile memory
> +	  a linear addressed memory range (usually non volatile memory
>  	  like flash) instead of going through the block device layer.
>  	  This saves some memory since no intermediate buffering is
>  	  necessary.
> -- 
> 2.29.2
> 
> 
