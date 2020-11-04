Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D672A70FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbgKDXKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgKDXKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:10:23 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6251FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:10:22 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f38so151406pgm.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=K7h2qyay5RG41a6GRN62gnE+M5KIqcjPTA9MdefbS0Y=;
        b=pqMcDyUDtBnmJXrlXiUNPMw9P5JR9pdUaOuW4njMlXzGG2mrcyxj2fLU+WvXbXmoZj
         hgXqvVjMJb/+xiUq6QrODHQADb6zbjLGunpo7gLHhu0FEHHvHxnD/4FI0QD++zVSwf8O
         HZciPsgWudQqVgze49OLRfakcCa2MilcOGBioFrjydHFr+SU26fRfM9SECjFDfAwuKVJ
         XMN1jtXz3G0oy66/Ujw0mvC33ZwJn2+O82NOIzxEr7qu2Z0eDezu/Vx76xuPBRv7oBgC
         D3XMqH6XEufszYz8ea3dXjY5SB9DKrGk/3DWMlJ7AD4XU/HeWOAVLGiM96RiLrq8BjUg
         cwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=K7h2qyay5RG41a6GRN62gnE+M5KIqcjPTA9MdefbS0Y=;
        b=uOKnxwhwy7zeCjnkhvXoXKDXKVAEbt6B3p1HQOYfZP1WGu7AzRBC+p8Ul0xGUlr74X
         v5c0ylbgYevspFf8Mz06sdzpPpD39TWz8UoeHbP5HQg1NDPfk/DfJ7X5tbLeP6YTAik/
         EPW5JkKsaybZUmFhfAoJDC+tIiwoIbztCqFFdA+++bByLAQXd6Ml/KPLO/5VjqU9DUaF
         BD1LdaZ5QhcEEl40JyRbhY4dllLAiRtSjhkoujEys8jNAB7Y2C3vMJDyy+fVR/5Abari
         yI/yKJ7NPerbiJrGOtIW3lD0+kXurgW0WjNndqX3+W7HpENCEibmLoKAkFcHcSquLWIL
         p6EA==
X-Gm-Message-State: AOAM533xwFkSc738xI8sD9XOZv5JDuBTH5sg7ak9aE19jUozruj8eGCQ
        Bvh1CEchQqaNdmqERCWczwuuJw==
X-Google-Smtp-Source: ABdhPJz9JdrAa/HQl0jqsMpzO+T9YGt56jk9UMWZjkOWSZr4lbnmfRBveRyt31eo55kfoG1BM2rM/g==
X-Received: by 2002:a17:90b:3d5:: with SMTP id go21mr240724pjb.8.1604531421773;
        Wed, 04 Nov 2020 15:10:21 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id r8sm3111794pjz.51.2020.11.04.15.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:10:20 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:10:19 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Roman Gushchin <guro@fb.com>
cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH rfc 0/3] mm: memcg: deprecate cgroup v1 non-hierarchical
 mode
In-Reply-To: <20201103212725.3716088-1-guro@fb.com>
Message-ID: <alpine.DEB.2.23.453.2011041509290.447493@chino.kir.corp.google.com>
References: <20201103212725.3716088-1-guro@fb.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020, Roman Gushchin wrote:

> The non-hierarchical cgroup v1 mode is a legacy of early days
> of the memory controller and doesn't bring any value today.
> However, it complicates the code and creates many edge cases
> all over the memory controller code.
> 
> It's a good time to deprecate it completely. This patchset removes
> the internal logic, adjusts the user interface and updates
> the documentation. The alt patch removes some bits of the cgroup
> core code, which become obsolete.
> 
> 
> Roman Gushchin (3):
>   mm: memcg: deprecate the non-hierarchical mode
>   docs: cgroup-v1: reflect the deprecation of the non-hierarchical mode
>   cgroup: remove obsoleted broken_hierarchy and warned_broken_hierarchy
> 

For all three patches:

Acked-by: David Rientjes <rientjes@google.com>

Very welcome change to see, we've always prevented the non-hierarchical 
mode from being set in our kernel.
