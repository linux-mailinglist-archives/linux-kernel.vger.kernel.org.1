Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B67C2975B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753329AbgJWRW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:22:29 -0400
Received: from ms.lwn.net ([45.79.88.28]:51556 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753320AbgJWRW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:22:28 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2AA317C0;
        Fri, 23 Oct 2020 17:22:28 +0000 (UTC)
Date:   Fri, 23 Oct 2020 11:22:26 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/56] scripts: kernel-doc: fix typedef parsing
Message-ID: <20201023112226.4035e3f7@lwn.net>
In-Reply-To: <d0b2146c4ced3121342583bb3d962628fc96759b.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
        <d0b2146c4ced3121342583bb3d962628fc96759b.1603469755.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 18:32:48 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The include/linux/genalloc.h file defined this typedef:
> 
> 	typedef unsigned long (*genpool_algo_t)(unsigned long *map,unsigned long size,unsigned long start,unsigned int nr,void *data, struct gen_pool *pool, unsigned long start_addr);
> 
> Because it has a type composite of two words (unsigned long),
> the parser gets the typedef name wrong:
> 
> .. c:macro:: long
> 
>    **Typedef**: Allocation callback function type definition
> 
> Fix the regex in order to accept composite types when
> defining a typedef for a function pointer.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/kernel-doc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 99cd8418ff8a..311d213ee74d 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1438,7 +1438,7 @@ sub dump_typedef($$) {
>      $x =~ s@/\*.*?\*/@@gos;	# strip comments.
>  
>      # Parse function prototypes
> -    if ($x =~ /typedef\s+(\w+)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
> +    if ($x =~ /typedef\s+(\w+\s*){1,}\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||

I sure wish we could find a way to make all these regexes more
understandable and maintainable.  Reviewing a change like this is ... fun.

Anyway, it seems to work, but it does now include trailing whitespace in
the type portion.  So, for example, from include/linux/xarray.h:

  typedef void (*xa_update_node_t)(struct xa_node *node);

The type is parsed as "void " where it was "void" before.  The only ill
effect I can see is that some non-breaking spaces get inserted into the
HTML output, but perhaps it's worth stripping off that trailing space
anyway?

Thanks,

jon
