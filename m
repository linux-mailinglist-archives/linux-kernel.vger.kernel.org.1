Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400442B4499
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgKPNUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728860AbgKPNUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:20:12 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2CF12223D;
        Mon, 16 Nov 2020 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605532812;
        bh=C+xAHN26kNAdTDGwwpTMO1dDTwp/qjDVOHXVeSI4rco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBwPjO3d5SBIpq9VxJXeZAX/YMuYQ8RcGuaV4HE5Xq75SkN0BwbjybznDdfxWWnif
         vGVuh16NEiwPzoE4VFh+7QWjgpQ2HqcIHDNdD1Wmj8G+BQaakvXz/dD0xFy9HzRvz9
         VoX2+5EPHSFW1AhBRvPanKq2MF9hrvJJL6bPKBSg=
Date:   Mon, 16 Nov 2020 13:20:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: Use arch_get_random_long_early() for
 init_std_data()
Message-ID: <20201116132007.GA30323@willie-the-truck>
References: <20201113161912.62068-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113161912.62068-1-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:19:12PM +0000, Andre Przywara wrote:
> In commit 253d3194c2b5 ("random: add arch_get_random_*long_early()") we
> introduced _early versions of arch_get_random_long(), that are used on
> arm64 to use the CPU RNDR instruction early in the boot process, before
> we have established system-wide availability.
> This covers the calls in crng_initialize_primary(), but missed the calls
> in init_std_data(), happening just before that.
> 
> Use the _early versions of the arch_get_random* calls also in
> init_std_data(), to help initialising the pool with proper seed values.
> 
> Fixes: 253d3194c2b5 ("random: add arch_get_random_*long_early()")
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/char/random.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 2a41b21623ae..43bb331a67bd 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1778,8 +1778,8 @@ static void __init init_std_data(struct entropy_store *r)
>  
>  	mix_pool_bytes(r, &now, sizeof(now));
>  	for (i = r->poolinfo->poolbytes; i > 0; i -= sizeof(rv)) {
> -		if (!arch_get_random_seed_long(&rv) &&
> -		    !arch_get_random_long(&rv))
> +		if (!arch_get_random_seed_long_early(&rv) &&
> +		    !arch_get_random_long_early(&rv))
>  			rv = random_get_entropy();
>  		mix_pool_bytes(r, &rv, sizeof(rv));

Acked-by: Will Deacon <will@kernel.org>

Will
