Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651322BC5C0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 14:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgKVNNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 08:13:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgKVNNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 08:13:10 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE5A20724;
        Sun, 22 Nov 2020 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606050790;
        bh=TjQ8YDqQM6PWcMTGEeeBPCud8rCB1HrhNYqg0vnG+qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tS642YVi4bL5YLam4oXfNr2AXnFJqWbXaNv+E1cyO3Bchqe0R6lYTpj8GZViEK5eN
         gHj74pvPqj/YVHgEPtFxhJL2vP1KB0xoaX0xVA79MarKDR3SbePLncvwsXffd/NoJU
         oux/NAKCQv1QssX5Ng+F5vtlhUPGC0BgRzla0oZA=
Date:   Sun, 22 Nov 2020 15:13:03 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] Documentation/admin-guide: mark memmap parameter is
 supported by a few architectures
Message-ID: <20201122131303.GF8537@kernel.org>
References: <20201118014145.29596-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201118014145.29596-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 02:41:45PM +1300, Barry Song wrote:
> early_param memmap is only implemented on X86, MIPS and XTENSA. To avoid
> wasting users’ time on trying this on platform like ARM, mark it clearly.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  * the background was that I spent one hour on using memmap on arm64, only
>    to find memmap= is not implemented on most architectures;
> 
>  Documentation/admin-guide/kernel-parameters.rst | 1 +
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> index 6d421694d98e..06fb1b4aa849 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -172,6 +172,7 @@ parameter is applicable::
>  	X86	Either 32-bit or 64-bit x86 (same as X86-32+X86-64)
>  	X86_UV	SGI UV support is enabled.
>  	XEN	Xen support is enabled
> +	XTENSA	xtensa architecture is enabled.
>  
>  In addition, the following text indicates that the option::
>  
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 526d65d8573a..8bdbc555f221 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2709,7 +2709,7 @@
>  			option description.
>  
>  	memmap=nn[KMG]@ss[KMG]
> -			[KNL] Force usage of a specific region of memory.
> +			[KNL, X86, MIPS, XTENSA] Force usage of a specific region of memory.
>  			Region of memory to be used is from ss to ss+nn.
>  			If @ss[KMG] is omitted, it is equivalent to mem=nn[KMG],
>  			which limits max address to nn[KMG].
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
