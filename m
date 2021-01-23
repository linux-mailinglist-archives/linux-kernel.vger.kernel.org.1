Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97833018DA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 00:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbhAWXQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 18:16:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbhAWXQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 18:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611443699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQZ5NGVNhPCOb9rh4yam9JxP0UIma3g63UEXLfk+y3Y=;
        b=ZFpAyrvvenkXpUgzH+u1mH3a0wFQaOTgj8xzF48P00JEkfTGH6s0YPSiZr9MIAdt7vtFZ7
        ucjAEJVIwqyf+a9hwUkP6EQqlFgt9iZFEl5iHh2zCh/FclBofn1M/D+KspPfoIMKH4kveV
        ZYMAsNYEFrrz2lDqisRpywabuYmolLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-OdlFlyh8PvyGYYCpkoNG6Q-1; Sat, 23 Jan 2021 18:14:57 -0500
X-MC-Unique: OdlFlyh8PvyGYYCpkoNG6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8983180A08A;
        Sat, 23 Jan 2021 23:14:55 +0000 (UTC)
Received: from krava (unknown [10.40.192.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8B5575D9CC;
        Sat, 23 Jan 2021 23:14:53 +0000 (UTC)
Date:   Sun, 24 Jan 2021 00:14:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Append to default list if use -e +event
Message-ID: <20210123231452.GD138414@krava>
References: <20210104021837.30473-1-yao.jin@linux.intel.com>
 <20210112100807.GB1273297@krava>
 <64dba2a3-0bf2-3af3-6f54-6e200840017d@linux.intel.com>
 <20210120212553.GA1798087@krava>
 <20210121000355.GB106434@kernel.org>
 <2d2c8e32-53f2-560d-3f69-a0ed7c3810e6@linux.intel.com>
 <20210121130225.GV12699@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121130225.GV12699@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 10:02:25AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 21, 2021 at 02:08:52PM +0800, Jin, Yao escreveu:
> > Hi Arnaldo,
> > 
> > On 1/21/2021 8:03 AM, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Jan 20, 2021 at 10:25:53PM +0100, Jiri Olsa escreveu:
> > > > On Mon, Jan 18, 2021 at 12:54:37PM +0800, Jin, Yao wrote:
> > > > > root@kbl-ppc:# ./perf stat -e +power/energy-pkg/ -a -- sleep 1
> > > 
> > > > >   Performance counter stats for 'system wide':
> > > 
> > > > >                2.02 Joules +power/energy-pkg/
> > > 
> > > > >         1.000859434 seconds time elapsed
> > > 
> > > > > The '+' prefix is printed. So I finally decide not to remove the '+' prefix
> > > > > in order to keep original behavior.
> > > > hm, originaly there's no purpose for the '+', right?
> > > > it seems it's more like bug then anything else
> > > > you added function to the '+' to add default events to specified event,
> > > > which I think is good idea, but I don't think we should display the
> > > > extra '+' in output
> > > 
> > > The value would be to stress that that is an event added to the ones
> > > without the + prefix, i.e. the default ones.
> > > 
> > > But by having the command line copied over and the added events at the
> > > first lines we should have that abundantly clear.
> > > 
> > > Also we won't print removed events (using -), is that available already?
> > > 
> > 
> > Sorry, the '-' support is not available in this patch. Can I do the patch
> > for '+' first and then do a follow up patch for '-' at next step?
> 
> Yeah, it can be done afterwards, to be symmetric.
>  
> > > Nope:
> > > 
> > > [root@quaco ~]# perf stat -e -cycles sleep
> > > event syntax error: '-cycles'
> > >                       \___ parser error
> > > Run 'perf list' for a list of valid events
> > > 
> > >   Usage: perf stat [<options>] [<command>]
> > > 
> > >      -e, --event <event>   event selector. use 'perf list' to list available events
>  
> > So if we just want to append the default list, we only need to set
> > detailed_run=1, then ideally perf-stat will print the default list.
>  
> > But for now, there are no task-clock, context-switches, cpu-migrations,
> > page-faults, instructions, branches and branch-misses displayed.
>  
> > root@kbl-ppc:~# ./perf stat -e cycles -d -a -- sleep 1
> > 
> >  Performance counter stats for 'system wide':
> > 
> >        124,178,207      cycles                                                        (80.02%)
> >          6,444,490      L1-dcache-loads                                               (80.01%)
> >          1,043,169      L1-dcache-load-misses     #   16.19% of all L1-dcache accesses  (80.02%)
> >            564,474      LLC-loads                                                     (80.02%)
> >             49,262      LLC-load-misses           #    8.73% of all LL-cache accesses  (79.92%)
> > 
> >        1.001614947 seconds time elapsed
> > 
> > Do we still need the '+' prefix to add the specified event on top of default
> > list? It looks current syntax should already support that feature, but just
> > need to fix some issues.
> 
> I think we can do away with that '+' when showing the added events and
> its counts.

I was thinking of people parsing the stat output (this is probably also
in CSV output, right?) having the extra '+' prrefix could cause issues

jirka

