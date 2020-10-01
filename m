Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F0227FF17
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbgJAMah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:30:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:34150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731987AbgJAMaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:30:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601555434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uCm4uXOnrpWMmMZOVA7wh6ICDudob2h+p29v5JSL4lU=;
        b=GnrnpGVOycrS6i3U5eUDgMPqc4ZSmxHImP6IM3Q9oRdFfgGHwzWCI5H+2lZar3wd+EJgGv
        QEiFqFCDYgSp1OTN9AbCtO5mEALDiuKWhR/Pqkq7y6hzSbhehovg/ZXqPG6QVOD7X2crvB
        fZtYaxIuElKuddlIJBEQ3JPWMaSRAqU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D2BAAFD7;
        Thu,  1 Oct 2020 12:30:34 +0000 (UTC)
Date:   Thu, 1 Oct 2020 14:30:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastiaan Meijer <meijersebastiaan@gmail.com>
Cc:     akpm@linux-foundation.org, buddy.lumpkin@oracle.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, riel@surriel.com,
        willy@infradead.org
Subject: Re: [RFC PATCH 1/1] vmscan: Support multiple kswapd threads per node
Message-ID: <20201001123032.GC22560@dhcp22.suse.cz>
References: <CANuy=C+JH7sZbMToWNNyWcKANbwSx5KLaiRBLHXBz6EU=JCABA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANuy=C+JH7sZbMToWNNyWcKANbwSx5KLaiRBLHXBz6EU=JCABA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-09-20 21:27:12, Sebastiaan Meijer wrote:
> > yes it shows the bottleneck but it is quite artificial. Read data is
> > usually processed and/or written back and that changes the picture a
> > lot.
> Apologies for reviving an ancient thread (and apologies in advance for my lack
> of knowledge on how mailing lists work), but I'd like to offer up another
> reason why merging this might be a good idea.
> 
> From what I understand, zswap runs its compression on the same kswapd thread,
> limiting it to a single thread for compression. Given enough processing power,
> zswap can get great throughput using heavier compression algorithms like zstd,
> but this is currently greatly limited by the lack of threading.

Isn't this a problem of the zswap implementation rather than general
kswapd reclaim? Why zswap doesn't do the same as normal swap out in a
context outside of the reclaim?

My recollection of the particular patch is dimm but I do remember it
tried to add more kswapd threads which would just paper over the problem
you are seein rather than solve it.

-- 
Michal Hocko
SUSE Labs
