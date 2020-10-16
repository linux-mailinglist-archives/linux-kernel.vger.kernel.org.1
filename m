Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CAF2907CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409442AbgJPOyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407149AbgJPOyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:54:45 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CAAC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 07:54:45 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b8so4094687ioh.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 07:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P+wWygljj49b/Jwoyua6AHD+Ku/LFmb5gdhqTAfvLEg=;
        b=LfWcB5jJyrh0MulkzzuGDm88OUPUpKQE8o53FteBypfuv4DTJIqcilO5fbMfXFgYXI
         lNzpYppun7sYKDcWP9drg2dRRpqy3ivRLLdyLTh5O5yrcim1D+Rl1p43Fc8Ww1Dlnq75
         UduIWxVs7cKdmtuQ99t4hyO12AovSFAZgo1uUGJ5obm0Il7FaQHkzj9QMdXK9zopXcSF
         PLwlynbaqdXAtnJzQ89MJ+Lzr1Vb/40fbGXEsslJk7dWbQwUd777LR4USiIBmWG9Zm6f
         7A4U32UBKsGWK71FaDROAEtzkzsNLPZWM6FOj2Bt9j8CrzMDRFddJUzI7S5C99xjuZd5
         KqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P+wWygljj49b/Jwoyua6AHD+Ku/LFmb5gdhqTAfvLEg=;
        b=ltD+Ud4lBx96atxO13ucRWLU90tsOxCFzTpms3oPAenNb8AJXidq9dU6Sm40sjDDh0
         bsxBg+aFdexsDOP4iFzkrs6m3pgMEbAD1er2N6M52d5jcBMobL2KwUJKVxCIFBbGormz
         NvBTua2SF5vRw9rzyXwklIcJiLfYSCppcCnrowphOkA3WNksofhbDyoGAckWpFsKO15R
         vgUWW1EyjZyieTmOS6z7jctl1RqGCiAVZB1+U138I2r19RvGATC8wANZ6TWO5G4Oz3K7
         iWoZgl/BmmYp6L0qANG1UOGZAbZAeEijCSIGqRVozGCIu80IXppXZ2G13biZt5YhEofQ
         vThw==
X-Gm-Message-State: AOAM530j0HeyBuPY/a68Ej1cozauOMdoTE5Z9TsfzkkKtZbj61qwx76m
        S3a5Z35Zijd1Pc7wHwIgEZ5/Uw==
X-Google-Smtp-Source: ABdhPJzFogEG6IQkoTlKAgWk1KT+gJK3ZP6L/JPWVdkauPYFnSZXzWhrRw9D+btj4vw97vn8oJI+tQ==
X-Received: by 2002:a02:9441:: with SMTP id a59mr2934832jai.122.1602860084430;
        Fri, 16 Oct 2020 07:54:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b51d])
        by smtp.gmail.com with ESMTPSA id b14sm2815853ilg.63.2020.10.16.07.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 07:54:43 -0700 (PDT)
Date:   Fri, 16 Oct 2020 10:53:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Richard Palethorpe <rpalethorpe@suse.com>,
        Roman Gushchin <guro@fb.com>, ltp@lists.linux.it,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201016145308.GA312010@cmpxchg.org>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201016094702.GA95052@blackbook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 11:47:02AM +0200, Michal Koutný wrote:
> Hello.
> 
> On Wed, Oct 14, 2020 at 08:07:49PM +0100, Richard Palethorpe <rpalethorpe@suse.com> wrote:
> > SLAB objects which outlive their memcg are moved to their parent
> > memcg where they may be uncharged. However if they are moved to the
> > root memcg, uncharging will result in negative page counter values as
> > root has no page counters.
> Why do you think those are reparented objects? If those are originally
> charged in a non-root cgroup, then the charge value should be propagated up the
> hierarchy, including root memcg, so if they're later uncharged in root
> after reparenting, it should still break even. (Or did I miss some stock
> imbalance?)

Looking a bit closer at this code, it's kind of a mess right now.

The central try_charge() function charges recursively all the way up
to and including the root. But not if it's called directly on the
root, in which case it bails and does nothing.

kmem and objcg use try_charge(), so they have the same
behavior. get_obj_cgroup_from_current() does it's own redundant
filtering for root_mem_cgroup, whereas get_mem_cgroup_from_current()
does not, but its callsite __memcg_kmem_charge_page() does.

We should clean this up one way or another: either charge the root or
don't, but do it consistently.

Since we export memory.stat at the root now, we should probably just
always charge the root instead of special-casing it all over the place
and risking bugs.

Indeed, it looks like there is at least one bug where the root-level
memory.stat shows non-root slab objects, but not root ones, whereas it
shows all anon and cache pages, root or no root.
