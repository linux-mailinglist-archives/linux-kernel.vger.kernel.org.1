Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA982830C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJEHUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:20:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:53384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgJEHUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:20:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601882412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vApl6nXikrRUzYKlMP3kusxzGltUkIK633aGyjdosYg=;
        b=tvmDLQLfHw/qpS+VI+hrrbB0pRaF4IL1Rud2cY6czfRucQjMhyGZZVv/byN4tYQXpkMP0n
        jLcUnv0uSpmStgmWK+cLFmrRiGnPsCLbMjs4D7ISEp1PX7gnYblN+52VVsJqJFKwBVf87O
        gwsAal6wk7N7rTP0eB3rPlg/8KHqhDg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65092AF37;
        Mon,  5 Oct 2020 07:20:12 +0000 (UTC)
Date:   Mon, 5 Oct 2020 09:20:11 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     pintu@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, pintu.ping@gmail.com
Subject: Re: [PATCH] mm/util.c: Add error logs for commitment overflow
Message-ID: <20201005072011.GP4555@dhcp22.suse.cz>
References: <1601639861-32171-1-git-send-email-pintu@codeaurora.org>
 <20201002121726.GF4555@dhcp22.suse.cz>
 <adaf346febe6bb6fbdcedb8709e35bcb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaf346febe6bb6fbdcedb8709e35bcb@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-10-20 21:53:37, pintu@codeaurora.org wrote:
> On 2020-10-02 17:47, Michal Hocko wrote:
> 
> > > __vm_enough_memory: commitment overflow: ppid:150, pid:164,
> > > pages:62451
> > > fork failed[count:0]: Cannot allocate memory
> > 
> > While I understand that fork failing due to overrcomit heuristic is non
> > intuitive and I have seen people scratching heads due to this in the
> > past I am not convinced this is a right approach to tackle the problem.
> 
> Dear Michal,
> First, thank you so much for your review and comments.
> I totally agree with you.
> 
> > First off, referencing pids is not really going to help much if process
> > is short lived.
> 
> Yes, I agree with you.
> But I think this is most important mainly for short lived processes itself.
> Because, when this situation occurs, no one knows who could be the culprit.

Pid will not tell you much for those processes, right?

> However, user keeps dumping "ps" or "top" in background to reproduce once
> again.

I do not think this would be an effective way to catch the problem.
Especially with _once reporting. My experience with these reports is
that a reporter notices a malfunctioning (usually more complex)
workload. In some cases ENOMEM from fork is reported into the log by the
userspace.

For others it is strace -f that tells us that fork is failing and a
test with OVERCOMMIT_ALWAYS usually confirms the theory that this is
the culprit. But a rule of thumb is that it is almost always overcommit
to blame. Why? An undocumented secret is that ENOMEM resulting from an
actual memory allocation in the fork/clone path is close to impossible
because kernel does all it can to satisfy them (an even invokes OOM
killer). There are exceptions (e.g. like high order allocation) but
those should be very rare in that path.

> At this time, we can easily match the pid, process-name (at least in most
> cases).

Maybe our definitions of short lived processes differ but in my book
those are pretty hard to catch in flight.

> > Secondly, __vm_enough_memory is about any address space
> > allocation. Why would you be interested in parent when doing mmap?
> > 
> 
> Yes agree, we can remove ppid from here.
> I thought it might be useful at least in case of fork (or short lived
> process).

I suspect you have missed my point here. Let me clarify a bit more.
__vm_enough_memory is called from much more places than fork.
Essentially any mmap, brk etc are going though this. This is where
parent pid certainly doesn't make any sense. In fork this is a different
case because your forked process pid on its own doesn't make much sense
as it is going to die very quickly anyway. This is when parent is likely
a more important information.

That being said the content really depends on the specific path and that
suggestes that you are trying to log at a wrong layer.

Another question is whether we really need a logging done by the kernel.
Ratelimiting would be tricky to get right and we do not want to allow an
easy way to swamp logs either.
As already mentioned ENOMEM usually means overcommit failure. Maybe we
want to be more explicit this in the man page?
-- 
Michal Hocko
SUSE Labs
