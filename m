Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4831D66B3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEQJBK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 May 2020 05:01:10 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:61253 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727021AbgEQJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:01:10 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21218995-1500050 
        for multiple; Sun, 17 May 2020 10:01:02 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200517085049.278103-1-christophe.jaillet@wanadoo.fr>
References: <20200517085049.278103-1-christophe.jaillet@wanadoo.fr>
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        airlied@linux.ie, daniel@ffwll.ch, gregkh@linuxfoundation.org,
        joonas.lahtinen@linux.intel.com, tglx@linutronix.de,
        tvrtko.ursulin@intel.com
Subject: Re: [PATCH] drm/mm: Fix an error handling path in '__igt_once()'
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <158970606137.10809.7121434240962824777@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Sun, 17 May 2020 10:01:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2020-05-17 09:50:49)
> The label of the last gotos must be switched for the error handling code to
> work as expected.
> 
> Fixes: 83bc4ec37210 ("drm/mm: Add a search-by-address variant to only inspect a single hole")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/selftests/test-drm_mm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
> index 9aabe82dcd3a..af38c4fa4db5 100644
> --- a/drivers/gpu/drm/selftests/test-drm_mm.c
> +++ b/drivers/gpu/drm/selftests/test-drm_mm.c
> @@ -1864,14 +1864,14 @@ static int __igt_once(unsigned int mode)
>                 pr_err("Unexpectedly inserted the node into the wrong hole: node.start=%llx\n",
>                        node.start);
>                 err = -EINVAL;
> -               goto err_node;
> +               goto err_hi;

This needs to call drm_mm_remove_node() [err_node:] as it accidentally inserted the
node.

>         }
>  
>         err = drm_mm_insert_node_generic(&mm, &node, 2, 0, 0, mode);
>         if (err) {
>                 pr_err("Could not insert the node into the available hole!\n");
>                 err = -EINVAL;
> -               goto err_hi;
> +               goto err_node;

And this must *not* call drm_mm_remove_node.
-Chris
