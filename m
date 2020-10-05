Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A37A2836ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgJENvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:51:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39994 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJENvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:51:35 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kPQtp-0000xT-1K
        for linux-kernel@vger.kernel.org; Mon, 05 Oct 2020 13:51:33 +0000
Received: by mail-wr1-f69.google.com with SMTP id d13so4010422wrr.23
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 06:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bQQp2PNEq0FY7Hqco5htUGBXM0/SRgDQIUWJr9BdqaM=;
        b=S/9LQI0CKGb4YhzEQWSptDFgKwlaMW1o3IhkMRfYA42DeZkJx8lS8k628t/yuqzCAs
         pXPQGqb5DZwGYlDE34c4w6OoCg4Veky/vR5p9VkXowdwt8IeO5UXav7hXMguHZrIbRTQ
         BdC2BhcgfMZyJdd15TLIP6svHOg+9Xx4+tlZqHkSuc/g14OZOq6EGNYYFhzT5LCEhDbY
         rzUZOJqynaAlW4i2Drjq5+2AVE2CYYlqjZqmyuHQBQNTJ9jC/IKv3v64DzKWDs+9f1Md
         H1hj+7hIfK5zrGfsfXKB883tG2XNLlkbguqi90ysK5a1VCRGGJlgmSNurzVDDeG97Isc
         0vFw==
X-Gm-Message-State: AOAM530J5CuUjLcwIn1BgR3vLDKWeb1I+2P8+F0XhFkKvKIKcKJlkzVr
        aYgYQQtN+gtM/1glLBv8d/XqinCTI4u6wxVWIQgf2fIZCGcvrm54XL7BBgWDOW3N0lVIsPGJBiB
        1oIVO37fxCHKx76dbAWGZqNLP0THnoybSMb9Biww3NA==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr17121822wmc.9.1601905892392;
        Mon, 05 Oct 2020 06:51:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwofc6USifXN7h+C0hcGmEQa4n+RfAxxI8ZWg7rnK634gMSN9Wa915TnRbfzQlf/I65n7VhQw==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr17121788wmc.9.1601905892065;
        Mon, 05 Oct 2020 06:51:32 -0700 (PDT)
Received: from localhost (host-79-36-133-218.retail.telecomitalia.it. [79.36.133.218])
        by smtp.gmail.com with ESMTPSA id t202sm13779805wmt.14.2020.10.05.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 06:51:31 -0700 (PDT)
Date:   Mon, 5 Oct 2020 15:51:30 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luigi Semenzato <semenzato@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2] Opportunistic memory reclaim
Message-ID: <20201005135130.GA850459@xps-13-7390>
References: <20201005081313.732745-1-andrea.righi@canonical.com>
 <20201005112555.GA108347@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005112555.GA108347@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 12:25:55PM +0100, Chris Down wrote:
> Andrea Righi writes:
> > This feature has been successfully used to improve hibernation time of
> > cloud computing instances.
> > 
> > Certain cloud providers allow to run "spot instances": low-priority
> > instances that run when there are spare resources available and can be
> > stopped at any time to prioritize other more privileged instances [2].
> > 
> > Hibernation can be used to stop these low-priority instances nicely,
> > rather than losing state when the instance is shut down. Being able to
> > quickly stop low-priority instances can be critical to provide a better
> > quality of service in the overall cloud infrastructure [1].
> > 
> > The main bottleneck of hibernation is represented by the I/O generated
> > to write all the main memory (hibernation image) to a persistent
> > storage.
> > 
> > Opportunistic memory reclaimed can be used to reduce the size of the
> > hibernation image in advance, for example if the system is idle for a
> > certain amount of time, so if an hibernation request happens, the kernel
> > has already saved most of the memory to the swap device (caches have
> > been dropped, etc.) and hibernation can complete quickly.
> 
> Hmm, why does this need to be implemented in kernelspace? We already have
> userspace shrinkers using memory pressure information as part of PID control
> already (eg. senpai). Using memory.high and pressure information looks a lot
> easier to reason about than having to choose an absolute number ahead of
> time and hoping it works.

senpai is focused at estimating the ideal memory requirements without
affecting performance. And this covers the use case about reducing
memory footprint.

In my specific use-case (hibernation) I would let the system use as much
memory as possible if it's doing any activity (reclaiming memory only
when the kernel decides that it needs to reclaim memory) and apply a
more aggressive memory reclaiming policy when the system is mostly idle.

I could probably implement this behavior adjusting memory.high
dynamically, like senpai, but I'm worried about potential sudden large
allocations that may require to respond faster at increasing
memory.high. I think the user-space triggered memory reclaim approach is
a safer solution from this perspective.

-Andrea
