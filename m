Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324972B0A06
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgKLQdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:33:09 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E472C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:33:09 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so5774198qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WFwVbiWdrg8oJ19mjUEtG44KctcAB071Kx6FOG4kRls=;
        b=ioQQCFc92AOKq8ku9H7tDHa5YhM0n8KmogoyRJZ1izXrF2YSEm1jz4/ZZbjTla3pbU
         fclII6E/2sTEzMOG+SIiftXnNzLwy7R96k1GECnLJ8oTqjpGzwHw1i9T88ZAD1eKjbRQ
         DeKX77e9EPadN5w8gLhyj2V5R+XL5S6nVx3rNKcwhwQ4eMmVHwgwE6B6kxEwKuy6yAF2
         mYpCA9rA/uMYFE0OLBh9yfZbLBKvJochpE4Y0v3CJNBbN8oRYW9zNShsjitkkqiUQI2l
         WMANBp+9ijGOneGubckyGfTQsVKw4/DJBUSHLQcOwtxZURZO8KoEm8CPSd/KDtSFXbOX
         RJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WFwVbiWdrg8oJ19mjUEtG44KctcAB071Kx6FOG4kRls=;
        b=LyCcd3mnDm3QW7hYzDCZVME1Oxh8BxpJuVi2kYpU5uyyeL9p8jTvsiS0BVMvwRjZx5
         TiZMoCi/+R9JHSRRpH1Yt5jjXHDCk/lxyeD5JHnWWoKx1haiRuswgPvjW/z+zv6RfNhn
         6I2oz3Zpb/Cpl8lRY+O/BLdiMGpn2Zv+fT9yIcGNMw+PpaCoNuQVpu68Wxzncz5UsJB3
         hvIFhuh+a0xVa/u2LQjs/bdPfIPFp3Ck3URc0AxXwaMTI/ZPhplW+fuQ9Pj1FyTZzc6I
         nTPPybVDU/Wa10jpeCZHLDfNo9jFKD1NsIvFdXppKJ2Zzj+oHloIqF3g5Y9D67ENrou8
         O4yg==
X-Gm-Message-State: AOAM532PzUNrYcuL2iQ9ZAl4B22WRD61t5uio8WsvxXyI2a7JkRIb8Zf
        Qw9FiWVMm/Dtbc9bpf8qRRh6vg==
X-Google-Smtp-Source: ABdhPJwkebS91lJYfKfzVNtiKd3voal+JqAUKS095h4Vo1nRD1nHpekjx4njJxR+llR+jKCPDcSf0Q==
X-Received: by 2002:a37:f513:: with SMTP id l19mr627725qkk.36.1605198788795;
        Thu, 12 Nov 2020 08:33:08 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:7257])
        by smtp.gmail.com with ESMTPSA id v15sm4852426qto.74.2020.11.12.08.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 08:33:08 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:31:19 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>, kernel-team@fb.com,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v1 1/3] mm: memcg: deprecate the non-hierarchical mode
Message-ID: <20201112163119.GC873621@cmpxchg.org>
References: <20201110220800.929549-1-guro@fb.com>
 <20201110220800.929549-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110220800.929549-2-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 02:07:58PM -0800, Roman Gushchin wrote:
> The non-hierarchical cgroup v1 mode is a legacy of early days
> of the memory controller and doesn't bring any value today.
> However, it complicates the code and creates many edge cases
> all over the memory controller code.
> 
> It's a good time to deprecate it completely.
> 
> Functionally this patch enabled is by default for all cgroups
> and forbids switching it off. Nothing changes if cgroup v2 is used:
> hierarchical mode was enforced from scratch.
> 
> To protect the ABI memory.use_hierarchy interface is preserved
> with a limited functionality: reading always returns "1", writing
> of "1" passes silently, writing of any other value fails with
> -EINVAL and a warning to dmesg (on the first occasion).
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: David Rientjes <rientjes@google.com>

...and don't let the door hit you on the way out ;-)

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
