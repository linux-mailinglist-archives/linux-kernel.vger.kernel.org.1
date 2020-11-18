Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792882B8520
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgKRTxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRTxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:53:48 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD463C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:53:48 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id m9so1953398pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Nv1lrpdhsNV5qrzQebFMOG5OIfE6xbhYHuZs96YR+FM=;
        b=bDEBYC40hgqvmqxbaEKtvckc6NvT/RbCEYuDgJ9aEWvhiRs16BNuSs693ZPg40EwrV
         LQrgGY/iJ6tdNiWJzQX+8n0UwclQRCqEU61x/024gocsOTLyKjh8jgufMVVUXlMSbUqy
         WO6kLbO8YYHN50EbiLUp71HaGHDhswJr8zf+cYE5iGpeWs/4AKwFkRQ0iibEJub9u08P
         RfUL4XUhKL9dIWlcnQ4uU40oPJRE4109tDViD/K/mZuYoCq0vNlFhmgr2QUHQ6X9CNXA
         B6rw7Leec6zoAx3qh7jeY+C82oynkZGJXo36kyH+x1KzsKcR3mg9zr34CznnQm+ClFYr
         lStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Nv1lrpdhsNV5qrzQebFMOG5OIfE6xbhYHuZs96YR+FM=;
        b=k0tapSvSrKg3i9Gc7muVuGEL+KaC44dxut4wOEs1oaAE0Ta0NFb8T9GCY26ws5DRE7
         0sc9IWNMQkSIH1x7xQ1Q8yREzrZlnjyc7h5fEbIe83K6WYk2sWMGDW8aw6Uycom9GPRm
         hcFNtC1kZ2gVB+WjbgsiMj+7PRkmH+XW3dlzGiw7+hTSP0TLmBS+Pzu9fnY2JzZukDnx
         XTIfImJxqBvZ1qC64hsjJbyyJIvXtldqtMwd4ec/qdCkPnY0b0S/CUFSP/7ELcPN1Wcv
         kqq6eXT7m7UyYJFERHUUy9QvEWvWxQfP3BINXZ8gJSNXYZ8vDAVizKqgC5gyevA754Pb
         /pLw==
X-Gm-Message-State: AOAM532pZDWyfDHLjBSFbryRtL4iYvXCSZnJ71+CQpG9CmdTtxHmEEpo
        iYjhwUeSKbKzeImLBZb2N4a7xQ==
X-Google-Smtp-Source: ABdhPJy1Lr/VhmQiOIIOOdBdn0L5HHiRUxFJwMAPMpCWzaYxHigh46zSKk3LLQ5VrRtLGn0HNnpyYg==
X-Received: by 2002:a62:52d7:0:b029:18b:7093:fb88 with SMTP id g206-20020a6252d70000b029018b7093fb88mr6145068pfb.76.1605729228003;
        Wed, 18 Nov 2020 11:53:48 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id a12sm3264030pjh.48.2020.11.18.11.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:53:47 -0800 (PST)
Date:   Wed, 18 Nov 2020 11:53:46 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Roman Gushchin <guro@fb.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Bharata B Rao <bharata@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, cl@linux.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        shakeelb@google.com, hannes@cmpxchg.org, aneesh.kumar@linux.ibm.com
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
In-Reply-To: <20201118193446.GC186396@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.DEB.2.23.453.2011181153390.1618743@chino.kir.corp.google.com>
References: <20201118082759.1413056-1-bharata@linux.ibm.com> <9e1a2e2b-1b3c-9587-9b74-8ed8300fcb98@suse.cz> <20201118193446.GC186396@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020, Roman Gushchin wrote:

> On Wed, Nov 18, 2020 at 12:25:38PM +0100, Vlastimil Babka wrote:
> > On 11/18/20 9:27 AM, Bharata B Rao wrote:
> > > The page order of the slab that gets chosen for a given slab
> > > cache depends on the number of objects that can be fit in the
> > > slab while meeting other requirements. We start with a value
> > > of minimum objects based on nr_cpu_ids that is driven by
> > > possible number of CPUs and hence could be higher than the
> > > actual number of CPUs present in the system. This leads to
> > > calculate_order() chosing a page order that is on the higher
> > > side leading to increased slab memory consumption on systems
> > > that have bigger page sizes.
> > > 
> > > Hence rely on the number of online CPUs when determining the
> > > mininum objects, thereby increasing the chances of chosing
> > > a lower conservative page order for the slab.
> > > 
> > > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > 
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> > Ideally, we would react to hotplug events and update existing caches
> > accordingly. But for that, recalculation of order for existing caches would
> > have to be made safe, while not affecting hot paths. We have removed the
> > sysfs interface with 32a6f409b693 ("mm, slub: remove runtime allocation
> > order changes") as it didn't seem easy and worth the trouble.
> > 
> > In case somebody wants to start with a large order right from the boot
> > because they know they will hotplug lots of cpus later, they can use
> > slub_min_objects= boot param to override this heuristic. So in case this
> > change regresses somebody's performance, there's a way around it and thus
> > the risk is low IMHO.
> 
> I agree. For the absolute majority of users there will be no difference.
> And there is a good workaround for the rest.
> 
> Acked-by: Roman Gushchin <guro@fb.com>
> 

Acked-by: David Rientjes <rientjes@google.com>
