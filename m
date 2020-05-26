Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714C619D973
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 16:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403981AbgDCOs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 10:48:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:46582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgDCOs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:48:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D4ADDACE3;
        Fri,  3 Apr 2020 14:48:57 +0000 (UTC)
Received: from localhost (webern.olymp [local])
        by webern.olymp (OpenSMTPD) with ESMTPA id 9113dd72;
        Fri, 3 Apr 2020 15:48:57 +0100 (WEST)
Date:   Fri, 3 Apr 2020 15:48:57 +0100
From:   Luis Henriques <lhenriques@suse.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fscache: drop fscache_cookie_put on duplicated cookies
 in the hash
Message-ID: <20200403144857.GA22068@suse.com>
References: <20200309161643.GA92486@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309161643.GA92486@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

Cheers,
--
Luis

On Mon, Mar 09, 2020 at 04:16:43PM +0000, Luis Henriques wrote:
> When there's a collision due to a duplicate cookie, __fscache_register_netfs
> will do an fscache_cookie_put.  This, however, isn't required as
> fscache_cookie_get hasn't been executed, and will lead to a NULL pointer as
> fscache_unhash_cookie will be called.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/fscache/netfs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/fscache/netfs.c b/fs/fscache/netfs.c
> index cce92216fa28..07a55371f0a4 100644
> --- a/fs/fscache/netfs.c
> +++ b/fs/fscache/netfs.c
> @@ -52,7 +52,6 @@ int __fscache_register_netfs(struct fscache_netfs *netfs)
>  	return 0;
>  
>  already_registered:
> -	fscache_cookie_put(candidate, fscache_cookie_put_dup_netfs);
>  	_leave(" = -EEXIST");
>  	return -EEXIST;
>  }

