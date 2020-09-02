Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41A325A5CD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 08:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIBGv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 02:51:57 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:58630
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgIBGvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:51:55 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="357858231"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 08:51:47 +0200
Date:   Wed, 2 Sep 2020 08:51:42 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: ifnullfree: add vfree(), kvfree*()
 functions
In-Reply-To: <20200902044059.7133-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2009020851310.2528@hadrien>
References: <20200902044059.7133-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Sep 2020, Denis Efremov wrote:

> Extend the list of free functions with kvfree(), kvfree_sensitive(),
> vfree().
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, thanks.

julia

> ---
>  scripts/coccinelle/free/ifnullfree.cocci | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/free/ifnullfree.cocci b/scripts/coccinelle/free/ifnullfree.cocci
> index 2045391e36a0..285b92d5c665 100644
> --- a/scripts/coccinelle/free/ifnullfree.cocci
> +++ b/scripts/coccinelle/free/ifnullfree.cocci
> @@ -20,8 +20,14 @@ expression E;
>  - if (E != NULL)
>  (
>    kfree(E);
> +|
> +  kvfree(E);
>  |
>    kfree_sensitive(E);
> +|
> +  kvfree_sensitive(E, ...);
> +|
> +  vfree(E);
>  |
>    debugfs_remove(E);
>  |
> @@ -42,9 +48,10 @@ position p;
>  @@
>
>  * if (E != NULL)
> -*	\(kfree@p\|kfree_sensitive@p\|debugfs_remove@p\|debugfs_remove_recursive@p\|
> +*	\(kfree@p\|kvfree@p\|kfree_sensitive@p\|kvfree_sensitive@p\|vfree@p\|
> +*         debugfs_remove@p\|debugfs_remove_recursive@p\|
>  *         usb_free_urb@p\|kmem_cache_destroy@p\|mempool_destroy@p\|
> -*         dma_pool_destroy@p\)(E);
> +*         dma_pool_destroy@p\)(E, ...);
>
>  @script:python depends on org@
>  p << r.p;
> --
> 2.26.2
>
>
