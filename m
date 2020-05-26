Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02F71CD6CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 12:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgEKKpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 06:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgEKKpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:45:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200D520720;
        Mon, 11 May 2020 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589193952;
        bh=YKQf+yut5PyTaJyO4G7QVdbZDAhqYM8hMpLBt+mLfWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ycstioGxXdrQGSjd1FbMW5NialkNNzH7qxmD3nZgQaJepgaHbkX1XZrSmoVkgHDB5
         6Tsu5bdNmeCcCWb8d5XliJVau7vx57UvdbM8XF+aPkrmKCoSAI3WKjxFmnZa3NMQn1
         FZhDYtUQZBR1s4qXma1yfnMnruFrhG3bUUl7jPak=
Date:   Mon, 11 May 2020 11:45:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: remove the specific name of arm64
Message-ID: <20200511104548.GB18310@willie-the-truck>
References: <cover.1589178399.git.zong.li@sifive.com>
 <3a6a92ecedc54e1d0fc941398e63d504c2cd5611.1589178399.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6a92ecedc54e1d0fc941398e63d504c2cd5611.1589178399.git.zong.li@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 02:28:19PM +0800, Zong Li wrote:
> UXN is the name of arm64 page-table descriptors.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> CC: Will Deacon <will@kernel.org>
> ---
>  mm/Kconfig.debug | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index e19f94c6df90..b8cbe035247f 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -130,8 +130,6 @@ config DEBUG_WX
>  
>  	  This is useful for discovering cases where the kernel is leaving W+X
>  	  mappings after applying NX, as such mappings are a security risk.
> -	  This check also includes UXN, which should be set on all kernel
> -	  mappings.
>  
>  	  Look for a message in dmesg output like this:

Acked-by: Will Deacon <will@kernel.org>

The commit message needs help, but I'm assuming Andrew will just fold this
into the other patch so it doesn't matter.

Will
