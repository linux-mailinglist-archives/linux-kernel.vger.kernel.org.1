Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7121E3045ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394009AbhAZSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:05:31 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:52332 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732054AbhAZJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:18:34 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 92E9ECAD1F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:17:40 +0000 (GMT)
Received: (qmail 31365 invoked from network); 26 Jan 2021 09:17:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Jan 2021 09:17:40 -0000
Date:   Tue, 26 Jan 2021 09:17:37 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Tibor Bana <bana.tibor@gmail.com>
Cc:     valdis.kletnieks@vt.edu, Jan Kara <jack@suse.cz>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org
Subject: Re: [regression -next0117] What is kcompactd and why is he eating
 100% of my cpu?
Message-ID: <20210126091737.GA3592@techsingularity.net>
References: <20190126200005.GB27513@amd>
 <12171.1548557813@turing-police.cc.vt.edu>
 <20190127141556.GB9565@techsingularity.net>
 <20190127160027.GA9340@amd>
 <13417.1548624994@turing-police.cc.vt.edu>
 <20190128091627.GA27972@quack2.suse.cz>
 <14875.1548810399@turing-police.cc.vt.edu>
 <9618.1548822577@turing-police.cc.vt.edu>
 <20190130104020.GE9565@techsingularity.net>
 <20210125195438.c8d0e7980da0c2931d4f3056@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210125195438.c8d0e7980da0c2931d4f3056@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 07:54:38PM +0100, Tibor Bana wrote:
> Greetings!
> 
> I don't know if it still actual, but I am strugling with this problem right now and searching the internet for solutions.
> I read the thread and saw that you are strugling to reproduce the problem, and I can reproduce it almost every day.
> 
> - Install vmware player, and a linux guest. 
> - Configure the virtual machine to have a good amount of memory and cpu
> - run resource intensive tasks on the guest
> - when the host used up almost it's all memory and start to reuse caches kcompactd will kick in.
> 
> As I know the problem is related to transparent huge pages, but I tried to disable it. 
> Today I saw the problem again and kcompactd shown an interesting status in top. It hasn't used any memory, all zeroes but it used up one core completely. 
> 
> My machine is a core-i7 with 4 physical cores and hyper threading and 24GB Memory
> 5.9.11-arch2-1 #1 SMP PREEMPT Sat, 28 Nov 2020 02:07:22 +0000 x86_64 GNU/Linux
> 
> Hope this can help, to point out the problem.
> 

Is 5.10.10 affected because it included two patches related to halting
compaction that are relevant.

d20bdd571ee5c9966191568527ecdb1bd4b52368 mm/compaction: stop isolation if too many pages are isolated and we have pages to migrate
38935861d85a4d9a353d1dd5a156c97700e2765d mm/compaction: count pages and stop correctly during page isolation

-- 
Mel Gorman
SUSE Labs
