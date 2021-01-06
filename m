Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D6F2EC487
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 21:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbhAFUL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbhAFUL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:11:26 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7FDC061359
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 12:10:46 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 9so4803840oiq.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 12:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sckuBFKDP/tBwUgNZbg7jLIawlE/HReY1fWcTvNn+Ik=;
        b=FqMt0IyR2Gr6pgNEehhrW0GUBda+3DiL1blCiFaqlcFWCHRwxQRp34T/GG5+OBM+zD
         RcNlYhaaMHPkb9NxPGJMO3oO82xw82mTugaMEWf6zQ5Z3SOIHFHfZncjzThUUl3uK+sP
         X6K/N2BLAcXBTDIKcWfWZoT7C65ZguG2kUmWn3m+7argOLDFMw1MeSfoIwIYMdqWc1PO
         7tYQNZmtNJJOb9zxI2NeLXcaCcc5MawFFra84U2GNUUY5xA1TSNSHtk7ptOUhRfmZj7l
         /Tvf1xKB3NNj+/d+IixsIARQUvAfwBCKrmuruCUZ7GEx6Qne500hD5tkN1+NOPChaLg9
         Z/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sckuBFKDP/tBwUgNZbg7jLIawlE/HReY1fWcTvNn+Ik=;
        b=XGaPOlpfwg/l6R0Rb6guGQkJwqMpg86OBNw4rnCB3SeMX2nlbuiaSKqbKX/mJgD4hl
         WW65xz4zLjyzr1rDBvz2IK+3/mEdFIEyAWoITym3xlDb4P87c91Hh8oLw4Y3W5e1tuSa
         ZWc049rwd8dM43HOgIRKJdg3Hw60DEQrFweyNwhjhLlBE5MzfBCJRerH/pz0lZvLmGZT
         FVeU7qCa/LXEf0ejkfWm6+Sw+QNA1MlWLrHOo1z8wn5w2UldmPL2FcVeJ3WBshWuRBa5
         RfoU0/KuOMCNMt85V3gYACQvpLl3lyhVRPsmd3Al7OUoa/ggs29Zfp+i2A0XNjpF7FdD
         ct+A==
X-Gm-Message-State: AOAM533iM4Bb7P+uZV/5XyVLywleItTZ1YWqMkbMC5m5EHXlcIT+gX4G
        yQ5HY3yFR/gaLYtJwdz1CnX0UdOVQGbJnQ==
X-Google-Smtp-Source: ABdhPJzr/Lph7HH4uDU/k4Bu9lyenK39zcnUlm8v++01PvcJSgzXwNU5CF3ETlZDAA98y26LwAL6lg==
X-Received: by 2002:a05:6808:b18:: with SMTP id s24mr4373888oij.72.1609963845708;
        Wed, 06 Jan 2021 12:10:45 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m15sm692345otl.11.2021.01.06.12.10.44
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 06 Jan 2021 12:10:45 -0800 (PST)
Date:   Wed, 6 Jan 2021 12:10:30 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()
In-Reply-To: <20210106114620.5c221690f3a9cad7afcc3077@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2101061150180.2400@eggly.anvils>
References: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com> <1607743586-80303-2-git-send-email-alex.shi@linux.alibaba.com> <e50574aa-87b8-8ddf-2235-ef98e22bcb7d@linux.alibaba.com> <alpine.LSU.2.11.2101051919130.1361@eggly.anvils>
 <20210106114620.5c221690f3a9cad7afcc3077@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021, Andrew Morton wrote:
> On Tue, 5 Jan 2021 20:28:27 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:
> 
> > Alex, please consider why the authors of these lines (whom you
> > did not Cc) chose to write them without BUG_ON(): it has always
> > been preferred practice to use BUG_ON() on predicates, but not on
> > functionally effective statements (sorry, I've forgotten the proper
> > term: I'd say statements with side-effects, but here they are not
> > just side-effects: they are their main purpose).
> > 
> > We prefer not to hide those away inside BUG macros
> 
> Should we change that?  I find BUG_ON(something_which_shouldnt_fail())
> to be quite natural and readable.

Fair enough.  Whereas my mind tends to filter out the BUG lines when
skimming code, knowing they can be skipped, not needing that effort
to pull out what's inside them.

Perhaps I'm a relic and everyone else is with you: I can only offer
my own preference, which until now was supported by kernel practice.

> 
> As are things like the existing
> 
> BUG_ON(mmap_read_trylock(mm));
> BUG_ON(wb_domain_init(&global_wb_domain, GFP_KERNEL));
> 
> etc.

People say "the exception proves the rule".  Perhaps we should invite a
shower of patches to change those?  (I'd prefer not, I'm no fan of churn.)

> 
> No strong opinion here, but is current mostly-practice really
> useful?

You've seen my vote.  Now let the games begin!

Hugh
