Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D0D2D5FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391416AbgLJPgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391896AbgLJPgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:36:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC191C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 07:36:02 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id y17so5897531wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fpTNmQiIHEJLaTitKVv1oaaSRbT39VRnTw74fvsGI1c=;
        b=H3trLt4V1L33TGwM/yZD0JhEIXHblYks1nZFOtWoQlVLJbsN4Mz5l79tyImAywSIi/
         C8bIE40OmzGccXtTHB9uAPK+pfwT16fE4+WkMzVF9505mmbuAjrE2MTj80KZD/zCn8CT
         lHPuSJv9iYvdtlkhMD0Y1cF/n0mF1jce237ttDgDNPKFwvynr2QuVvCVr0P7Ep1bc2ni
         8L5A/xQr9LtZOrgHHwu1uHYsJDmsHA2nRpxaMyVej2blUUTv+IFGvVuFTjMj7zKMmjNa
         Qos2oXRMierk/L+O1eqGuYNoI7QNw4g2+7EQzyAspzxtKKxfJk9mG9V7gHqPDny5woOx
         G+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fpTNmQiIHEJLaTitKVv1oaaSRbT39VRnTw74fvsGI1c=;
        b=SlgQmB6d1qZ6B4CNt+wwOfraBBsg7abGW+7cRNnlmrrX2wtOcM1cLxONi8J7T3s314
         vb/3b2Mhq/vJ7KXsVB/I5IdRVumHpepmnWPgo4CVVxxLHxu2kv9jyC1HMfF6nWzM4Vra
         q7rZvk20zc486WdQMEt5J13tpuFzO5W7ACo78h5EiOoIRnsXWOUnRQdek3K5NjREqkuh
         Blvu9RnXxqqxUqQtj4wwu0SwT7l7wdkC9cLIB3Qj1dJSaSoisAC3chb6edZD+xMnc2QL
         dgpe8hClh/HX3VhJcK0pYir1jIDXq2/m2d2HmZU0+KfslEx0g2thsQpoTZ7JheRE0gEO
         KlYA==
X-Gm-Message-State: AOAM530b2IqbODVXOUW1nm/7ZEU8h9hpsSOBPdLjdn8vlaDitQOYQ+25
        CezRcH+9afL1Zz1uKfuOemumSA==
X-Google-Smtp-Source: ABdhPJzRsd4INrUHZ1w+FccKPJwW1ZyQU2s8jxT0sdxgFM9P2IbkcARs9CxNUGLQOzZ7aJF2x940Xw==
X-Received: by 2002:adf:fdcb:: with SMTP id i11mr8862811wrs.349.1607614561777;
        Thu, 10 Dec 2020 07:36:01 -0800 (PST)
Received: from localhost (p4fdabc80.dip0.t-ipconnect.de. [79.218.188.128])
        by smtp.gmail.com with ESMTPSA id z22sm9112468wml.1.2020.12.10.07.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 07:36:01 -0800 (PST)
Date:   Thu, 10 Dec 2020 16:33:56 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] mm: memcontrol: add per memcg shrinker nr_deferred
Message-ID: <20201210153356.GE264602@cmpxchg.org>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-6-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202182725.265020-6-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:27:21AM -0800, Yang Shi wrote:
> @@ -504,6 +577,34 @@ int memcg_expand_shrinker_maps(int new_id)
>  	return ret;
>  }
>  
> +int memcg_expand_shrinker_deferred(int new_id)
> +{
> +	int size, old_size, ret = 0;
> +	struct mem_cgroup *memcg;
> +
> +	size = (new_id + 1) * sizeof(atomic_long_t);
> +	old_size = memcg_shrinker_deferred_size;
> +	if (size <= old_size)
> +		return 0;
> +
> +	mutex_lock(&memcg_shrinker_mutex);

The locking is somewhat confusing. I was wondering why we first read
memcg_shrinker_deferred_size "locklessly", then change it while
holding the &memcg_shrinker_mutex.

memcg_shrinker_deferred_size only changes under shrinker_rwsem(write),
correct? This should be documented in a comment, IMO.

memcg_shrinker_mutex looks superfluous then. The memcg allocation path
is the read-side of memcg_shrinker_deferred_size, and so simply needs
to take shrinker_rwsem(read) to lock out shrinker (de)registration.

Also, isn't memcg_shrinker_deferred_size just shrinker_nr_max? And
memcg_expand_shrinker_deferred() is only called when size >= old_size
in the first place (because id >= shrinker_nr_max)?
