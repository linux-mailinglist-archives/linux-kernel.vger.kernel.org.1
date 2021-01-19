Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34122FB709
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbhASJu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbhASJgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:36:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF362C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 01:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hvDZ+fxryuq539HgDjOUrQrHbe7h9X7Wa0ctGASWN10=; b=OgKqJ+MG9z0OBm+QeKncoVH6nk
        XENt9FT49QZ7pXyt0d/n9FCFplAji+NLya51furZxTzehV6KnCjtX9ae0RtvONsRPkKSt+o9omq+U
        FqAOa+4lAGL1GK7J5qRWeOv0HSEmmQhb3jSClOJas3LIDEHty4ow3qb7IiLIhAf7oOx6jOc8Uk42y
        I3J7opZCXmmgirRPi/bx4/lj0qCTKK5BzVCI49Lves81lga7JsIGfXw8D/nw+cSK1pvJrh4vNGpau
        26o//HwgrWsjnJfpFQtBxmJY1RfIYA16Ra9tyMh35SuIy3WC6pxRLpjfebbYXgt3c5D6sYUQdzmUf
        gPDlYEsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l1nQN-00E7lm-FO; Tue, 19 Jan 2021 09:35:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84BB7304D28;
        Tue, 19 Jan 2021 10:35:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 392A12023AA22; Tue, 19 Jan 2021 10:35:38 +0100 (CET)
Date:   Tue, 19 Jan 2021 10:35:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     daniel@ffwll.ch, mingo@redhat.com, will@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/syncobj: make lockdep complain on WAIT_FOR_SUBMIT v2
Message-ID: <YAan6haGjnIlNIoJ@hirez.programming.kicks-ass.net>
References: <20210118180334.43714-1-christian.koenig@amd.com>
 <20210118180334.43714-2-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210118180334.43714-2-christian.koenig@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 07:03:34PM +0100, Christian König wrote:

> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 6e74e6745eca..f51458615158 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -387,6 +387,13 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
>  	if (!syncobj)
>  		return -ENOENT;
>  
> +	/* Waiting for userspace with locks help is illegal cause that can
> +	 * trivial deadlock with page faults for example. Make lockdep complain
> +	 * about it early on.
> +	 */

Egads, the cursed comment style is spreading :/

> +	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
> +		lockdep_assert_none_held_once();
> +

Should this not be part of drm_syncobj_fence_add_wait() instead? Also,
do you want to sprinkle might_sleep() around ?

>  	*fence = drm_syncobj_fence_get(syncobj);
>  	drm_syncobj_put(syncobj);
>  
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
