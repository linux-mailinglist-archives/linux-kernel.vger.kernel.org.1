Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75A2FAA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437518AbhARTnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390365AbhARTm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:42:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098D3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=zEJ22T1F3C1ubeY5/smo9KBx7Q8j3vhMGHt2WDHCSaU=; b=cUK7zXfaMBn25pUSZdxNvgLj0O
        uBg6xKKhdWyrtkQsCeMm3Kn2EP3pjEcLEaJlRAIQGlRZqIMSlXBjMmiDq24QOgwRdcAixbOQIeRtB
        JtLV8PvHMSm/mPAOJXRVgeZX6U0Q6qbvFkONMl5WP2fuSOx/lWFaATpxT0mg0x72l5aED38rusqNm
        PC/v95/FvgmYcdZcV9FeBgB9fGW8ClMfBV3xeztFJtFb3VIaZhB78qb/W5j+cev6r61SnFFs2L8EU
        NYb/JsL9GsKhYVBmOpAziNtG+Gzi+wus9dZqfq3pWQ5I/RztgB1hrXnEqf13vDoRTdC6gkeIhTt4q
        Enu8wHBA==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1aPk-0007XE-C8; Mon, 18 Jan 2021 19:42:12 +0000
Subject: Re: [PATCH] drm/syncobj: make lockdep complain on WAIT_FOR_SUBMIT v2
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        daniel@ffwll.ch, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210118180334.43714-1-christian.koenig@amd.com>
 <20210118180334.43714-2-christian.koenig@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3ebc7345-1b3f-8e7f-dc12-eacfd3a993d9@infradead.org>
Date:   Mon, 18 Jan 2021 11:42:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210118180334.43714-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a comment about the comments:

On 1/18/21 10:03 AM, Christian König wrote:
> DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT can't be used when we hold locks
> since we are basically waiting for userspace to do something.
> 
> Holding a lock while doing so can trivial deadlock with page faults
> etc...
> 
> So make lockdep complain when a driver tries to do this.
> 
> v2: Add lockdep_assert_none_held() macro.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/drm_syncobj.c | 7 +++++++
>  include/linux/lockdep.h       | 5 +++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 6e74e6745eca..f51458615158 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -387,6 +387,13 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
>  	if (!syncobj)
>  		return -ENOENT;
>  
> +	/* Waiting for userspace with locks help is illegal cause that can

	                                    held            because

> +	 * trivial deadlock with page faults for example. Make lockdep complain

	   trivially

> +	 * about it early on.
> +	 */
> +	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
> +		lockdep_assert_none_held_once();
> +
>  	*fence = drm_syncobj_fence_get(syncobj);
>  	drm_syncobj_put(syncobj);
>  


thanks.
-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
