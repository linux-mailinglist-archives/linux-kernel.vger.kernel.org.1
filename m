Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579ED2AE290
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbgKJWIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729862AbgKJWIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:08:38 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4B7220781;
        Tue, 10 Nov 2020 22:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605046118;
        bh=wzueAwNKUFgTyXUWlQJsepkAlXdOG+naI+ANaxmxCRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M568qlMyReOV/5qEhQduZfhKUTIxTHpSPfVsvUQnpH+NDPeRbQNMPYwH65vJvkFBn
         vSvi8gg8KELpYBhjtrZ7EPqhNyuIvYqvG+yFvFFNUNianeXLacoojlHkxjHBHV9xQZ
         dzNrg2CPyGeDqxL7n9lmfn1eV1ObUZyM1Igm0YLI=
Date:   Tue, 10 Nov 2020 14:08:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, sjenning@linux.vnet.ibm.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Stefan Agner <stefan@agner.ch>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm: fix build failure with xtensa
Message-Id: <20201110140837.99b1feabec8754ce5247e2a0@linux-foundation.org>
In-Reply-To: <20201110220151.20911-1-sudipm.mukherjee@gmail.com>
References: <20201110220151.20911-1-sudipm.mukherjee@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 22:01:51 +0000 Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:

> If CONFIG_ZSMALLOC is enabled with xtensa then the build fails with:
> mm/zsmalloc.c:43:10: fatal error: asm/sparsemem.h: No such file or directory
> 
> Disable CONFIG_ZSMALLOC for xtensa as xtensa arch has not defined
> sparsemem.h.
> 
> ...
>
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -698,7 +698,7 @@ config Z3FOLD
>  
>  config ZSMALLOC
>  	tristate "Memory allocator for compressed pages"
> -	depends on MMU
> +	depends on (MMU && !XTENSA)
>  	help
>  	  zsmalloc is a slab-based memory allocator designed to store
>  	  compressed RAM pages.  zsmalloc uses virtual memory mapping

Thanks.  I believe that Stefan is working on a more general solution
over in
https://lkml.kernel.org/r/bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch

