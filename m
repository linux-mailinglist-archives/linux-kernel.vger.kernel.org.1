Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB972FEB04
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbhAUNDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:03:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731075AbhAUNDJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:03:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F3D523A00;
        Thu, 21 Jan 2021 13:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611234148;
        bh=zX97QFz98GSlO9uDxJjp3v1pZ+rFCAVbXIs+lebua4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKtEigbWsw+Kv30BP7IHX/W1KNgnALbBqj9JIWUE02ZlemxWhCMUP4k+C0dEbaeVe
         PLltac1lae7ydgVg69hhbZyB+7W6xXjqF2sTwtnMPfW9YLSrUBF8XkhiBdQsL0vBv3
         Un4AWrTnRl+mx77CAy8vBHeHai1+gqbbiSaIQcsxU/CCA87Oyykp/97qi+K/2CxMt+
         kOcqd5tBlRANpGK4kyGUSF55aeMomfm/p3udpSzqdjxCMziPyv8323Mu01CbVsnPXj
         azwVZUJQLiVtpsq7j0w7cX3rAYtImvvwN3lLG7WV766lWL16JhYd7K/eQ6ole8gKWb
         Xa2zLvkV60oZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF1EB40513; Thu, 21 Jan 2021 10:02:25 -0300 (-03)
Date:   Thu, 21 Jan 2021 10:02:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Append to default list if use -e +event
Message-ID: <20210121130225.GV12699@kernel.org>
References: <20210104021837.30473-1-yao.jin@linux.intel.com>
 <20210112100807.GB1273297@krava>
 <64dba2a3-0bf2-3af3-6f54-6e200840017d@linux.intel.com>
 <20210120212553.GA1798087@krava>
 <20210121000355.GB106434@kernel.org>
 <2d2c8e32-53f2-560d-3f69-a0ed7c3810e6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d2c8e32-53f2-560d-3f69-a0ed7c3810e6@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 21, 2021 at 02:08:52PM +0800, Jin, Yao escreveu:
> Hi Arnaldo,
> 
> On 1/21/2021 8:03 AM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jan 20, 2021 at 10:25:53PM +0100, Jiri Olsa escreveu:
> > > On Mon, Jan 18, 2021 at 12:54:37PM +0800, Jin, Yao wrote:
> > > > root@kbl-ppc:# ./perf stat -e +power/energy-pkg/ -a -- sleep 1
> > 
> > > >   Performance counter stats for 'system wide':
> > 
> > > >                2.02 Joules +power/energy-pkg/
> > 
> > > >         1.000859434 seconds time elapsed
> > 
> > > > The '+' prefix is printed. So I finally decide not to remove the '+' prefix
> > > > in order to keep original behavior.
> > > hm, originaly there's no purpose for the '+', right?
> > > it seems it's more like bug then anything else
> > > you added function to the '+' to add default events to specified event,
> > > which I think is good idea, but I don't think we should display the
> > > extra '+' in output
> > 
> > The value would be to stress that that is an event added to the ones
> > without the + prefix, i.e. the default ones.
> > 
> > But by having the command line copied over and the added events at the
> > first lines we should have that abundantly clear.
> > 
> > Also we won't print removed events (using -), is that available already?
> > 
> 
> Sorry, the '-' support is not available in this patch. Can I do the patch
> for '+' first and then do a follow up patch for '-' at next step?

Yeah, it can be done afterwards, to be symmetric.
 
> > Nope:
> > 
> > [root@quaco ~]# perf stat -e -cycles sleep
> > event syntax error: '-cycles'
> >                       \___ parser error
> > Run 'perf list' for a list of valid events
> > 
> >   Usage: perf stat [<options>] [<command>]
> > 
> >      -e, --event <event>   event selector. use 'perf list' to list available events
 
> So if we just want to append the default list, we only need to set
> detailed_run=1, then ideally perf-stat will print the default list.
 
> But for now, there are no task-clock, context-switches, cpu-migrations,
> page-faults, instructions, branches and branch-misses displayed.
 
> root@kbl-ppc:~# ./perf stat -e cycles -d -a -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>        124,178,207      cycles                                                        (80.02%)
>          6,444,490      L1-dcache-loads                                               (80.01%)
>          1,043,169      L1-dcache-load-misses     #   16.19% of all L1-dcache accesses  (80.02%)
>            564,474      LLC-loads                                                     (80.02%)
>             49,262      LLC-load-misses           #    8.73% of all LL-cache accesses  (79.92%)
> 
>        1.001614947 seconds time elapsed
> 
> Do we still need the '+' prefix to add the specified event on top of default
> list? It looks current syntax should already support that feature, but just
> need to fix some issues.

I think we can do away with that '+' when showing the added events and
its counts.

- Arnaldo
