Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE752F85AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbhAOTly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbhAOTlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:41:49 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CC8C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:41:09 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x20so405051pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 11:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=7ZOtZQqScRqmXMQNflY5TUjZiKxgB7JP2I29GHn6hvY=;
        b=YgpstNfRToKUFQ+HxwP36JaYtWCOaIC2/E9Vdj5j1m/0/2hTgi4gtd+HXq0caIy01f
         6yxPek2LC/lMjkcpWw++X9dSl2I9AEVz5IUiNNgIdR9TAUpm+Qx8LTZ/ByIqenssqMVX
         +n7uSwcHxj0fMdXA3E/RleTh3M5UJOEsiaQKCDSBRmbAWpzCkI3p+YHXS/DSWRtwxyfE
         BJ9zrb4cSCFzSuCKalzh0Ls1mnVssXSBwD/7eGju1PMv7XhYVLSRR6TA4IgBT9BQU6cK
         qcuRoxGvTHFWybw/iepe4eMjnVwiNRkA+lqMtu6KDE/bQH0LWs2Vf0oej3Koibjw81oc
         K40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=7ZOtZQqScRqmXMQNflY5TUjZiKxgB7JP2I29GHn6hvY=;
        b=TcBNLlTJylXptIDtdOEuXF8JamS+pR0i0bb2zIXQZbCm/GLJG2nVlDBYQ2LK9CTqBk
         Z1exDNH4Wxe8sN2HxP+vHA8EWmMxsf+0va7JS5vE3y+xVYvxQU+OI3mkl7lRlJKs9Xmy
         CNN9RvzFl4EKAimYk6nZdJqs1rRSQRgEaQ8XPT9q+FXSjkZwFfO+ox4qRu2Ebqn9S8Xn
         Xi6cELrG+EM3gmJRiJEZlHJ253YTZOOO48TZY1RoiSu1aY1w4ODv6/P+RsGWwtIIwkVy
         vbI97DDgX4c6oIQoc7WDz8gQleEu+DWEH9odOPXeQEyx2nvA0KXw85n9BDgizCcjnqaK
         0vBQ==
X-Gm-Message-State: AOAM532H+GUY9wYGw/RV5nULWZ/GwIKXQOLpoq67z9MTG/Uny0vP7o2m
        PlCa2tg98vNkvoACyVqkrcnBRA==
X-Google-Smtp-Source: ABdhPJzZVx5Siw11mjH+EklG37Sitjunb0l3FvKRsfGi8zrpm7clOU0c1B39FZpYgCE4et60mHfk6g==
X-Received: by 2002:a17:90a:4096:: with SMTP id l22mr12009324pjg.114.1610739669019;
        Fri, 15 Jan 2021 11:41:09 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id q23sm9103137pgm.89.2021.01.15.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 11:41:08 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:41:07 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Johannes Berg <johannes@sipsolutions.net>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] mm/slub: disable user tracing for kmemleak caches by
 default
In-Reply-To: <20210113215114.d94efa13ba30.I117b6764e725b3192318bbcf4269b13b709539ae@changeid>
Message-ID: <ef5c2539-735-42ef-89e0-ef142da415cd@google.com>
References: <20210113215114.d94efa13ba30.I117b6764e725b3192318bbcf4269b13b709539ae@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021, Johannes Berg wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> If kmemleak is enabled, it uses a kmem cache for its own objects.
> These objects are used to hold information kmemleak uses, including
> a stack trace. If slub_debug is also turned on, each of them has
> *another* stack trace, so the overhead adds up, and on my tests (on
> ARCH=um, admittedly) 2/3rds of the allocations end up being doing
> the stack tracing.
> 
> Turn off SLAB_STORE_USER if SLAB_NOLEAKTRACE was given, to avoid
> storing the essentially same data twice.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: David Rientjes <rientjes@google.com>

> ---
> Perhaps instead it should go the other way around, and kmemleak
> could even use/access the stack trace that's already in there ...
> But I don't really care too much, I can just turn off slub debug
> for the kmemleak caches via the command line anyway :-)
> 

I think making the change to kmem_cache_flags() is likely the simplest.
