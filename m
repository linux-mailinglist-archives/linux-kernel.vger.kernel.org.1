Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E78E2FDFA2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbhATXri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 18:47:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728464AbhATV1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611177960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6M0kiTHNLGAWYX3jX6GQ7MllBMP9eI8gpCnHl+Iru4E=;
        b=CxNRwCxzvTzkI4eo0Prs2pnCd2xEmm4GsrVIE91GLcJ7W2PEiFIKIGFjm831Z3gskfnUWD
        6kJHgxV/AQfmC4ZrvgmVuqs29jaqS5oYOAuCAN/g/lj7A6jVZdlKsHwAHLJyo09HX/Pswd
        MKpzdgVlcoYthUkOnFNpjgz2A8WN2fQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-PUdxj0ibMC6SgjhV1SGiLQ-1; Wed, 20 Jan 2021 16:25:57 -0500
X-MC-Unique: PUdxj0ibMC6SgjhV1SGiLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B3FE107ACE4;
        Wed, 20 Jan 2021 21:25:56 +0000 (UTC)
Received: from krava (unknown [10.40.194.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 024FF1992D;
        Wed, 20 Jan 2021 21:25:53 +0000 (UTC)
Date:   Wed, 20 Jan 2021 22:25:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Append to default list if use -e +event
Message-ID: <20210120212553.GA1798087@krava>
References: <20210104021837.30473-1-yao.jin@linux.intel.com>
 <20210112100807.GB1273297@krava>
 <64dba2a3-0bf2-3af3-6f54-6e200840017d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64dba2a3-0bf2-3af3-6f54-6e200840017d@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 12:54:37PM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 1/12/2021 6:08 PM, Jiri Olsa wrote:
> > On Mon, Jan 04, 2021 at 10:18:37AM +0800, Jin Yao wrote:
> > > The default event list includes the most common events which are widely
> > > used by users. But with -e option, the current perf only counts the events
> > > assigned by -e option. Users may want to collect some extra events with
> > > the default list. For this case, users have to manually add all the events
> > > from the default list. It's inconvenient. Also, users may don't know how to
> > > get the default list.
> > > 
> > > Now it supports a simple syntax: -e +event
> > > 
> > > The prefix '+' tells perf to append this event (or event list) to default
> > > event list.
> > > 
> > > Before:
> > > 
> > > root@kbl-ppc:~# ./perf stat -e power/energy-pkg/ -a -- sleep 1
> > > 
> > >   Performance counter stats for 'system wide':
> > > 
> > >                2.04 Joules power/energy-pkg/
> > > 
> > >         1.000863884 seconds time elapsed
> > > 
> > > After:
> > > 
> > > root@kbl-ppc:~# ./perf stat -e +power/energy-pkg/ -a -- sleep 1
> > > 
> > >   Performance counter stats for 'system wide':
> > > 
> > >                2.11 Joules +power/energy-pkg/        #    0.000 K/sec
> > 
> > I dont think we should print the extra '+' prefix
> > 
> > jirka
> > 
> > >            8,007.17 msec   cpu-clock                 #    7.993 CPUs utilized
> > >                 125        context-switches          #    0.016 K/sec
> > >                   8        cpu-migrations            #    0.001 K/sec
> > >                   2        page-faults               #    0.000 K/sec
> > >           8,520,084        cycles                    #    0.001 GHz
> > >           2,808,302        instructions              #    0.33  insn per cycle
> > >             555,427        branches                  #    0.069 M/sec
> > >              59,005        branch-misses             #   10.62% of all branches
> > > 
> > >         1.001832003 seconds time elapsed
> > > 
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > 
> 
> Printing '+' prefix is the original behavior.
> 
> Without this patch,
> 
> root@kbl-ppc:# ./perf stat -e +power/energy-pkg/ -a -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>               2.02 Joules +power/energy-pkg/
> 
>        1.000859434 seconds time elapsed
> 
> The '+' prefix is printed. So I finally decide not to remove the '+' prefix
> in order to keep original behavior.

hm, originaly there's no purpose for the '+', right?
it seems it's more like bug then anything else

you added function to the '+' to add default events to specified event,
which I think is good idea, but I don't think we should display the
extra '+' in output

thanks,
jirka

