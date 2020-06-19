Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3F32003FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 10:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbgFSIdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 04:33:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43334 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731168AbgFSIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592555621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqPwLxwAHLc+aX/wY9Dbq0INdSgTTSTh9i8amqqb0b8=;
        b=KWNxAIo87El2A+fYhLe/ZIwQ9ZNcF4hO56ooBqP4DVIcEbemyOZQzUcvgSAhe/eLCCKkM7
        DNHQ8vVQxL3zcraeOX1kNQgFmecOVJHivFYf8Jg7ZRC6htM/E3yy//+j+0GMnzH55MMcEt
        z5ejPygEOnjQwn/L1w1yBjKafu4Mq/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-Sr7_nXn_N_GqSAHVJqvgEA-1; Fri, 19 Jun 2020 04:32:57 -0400
X-MC-Unique: Sr7_nXn_N_GqSAHVJqvgEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DCCF8015CB;
        Fri, 19 Jun 2020 08:32:55 +0000 (UTC)
Received: from carbon (unknown [10.40.208.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 009BC60BE1;
        Fri, 19 Jun 2020 08:32:48 +0000 (UTC)
Date:   Fri, 19 Jun 2020 10:32:47 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, brouer@redhat.com
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200619103247.7b8bc9ad@carbon>
In-Reply-To: <20200619013013.GE135965@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
        <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
        <20200617024147.GA10812@carbon.lan>
        <CALvZod4vLQb4kns=ao8btL_g--9axZfcaxhMnj+CoTrCkyWoWQ@mail.gmail.com>
        <20200617033217.GE10812@carbon.lan>
        <e510e964-2703-d123-120c-816bbdd35743@suse.cz>
        <20200618012928.GD24694@carbon.DHCP.thefacebook.com>
        <20200618104344.6a96ac04@carbon>
        <20200618113121.78a6a2ca@carbon>
        <20200619013013.GE135965@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 18:30:13 -0700
Roman Gushchin <guro@fb.com> wrote:

> On Thu, Jun 18, 2020 at 11:31:21AM +0200, Jesper Dangaard Brouer wrote:
> > On Thu, 18 Jun 2020 10:43:44 +0200
> > Jesper Dangaard Brouer <brouer@redhat.com> wrote:
> >   
> > > On Wed, 17 Jun 2020 18:29:28 -0700
> > > Roman Gushchin <guro@fb.com> wrote:
> > >   
> > > > On Wed, Jun 17, 2020 at 01:24:21PM +0200, Vlastimil Babka wrote:    
> > > > > On 6/17/20 5:32 AM, Roman Gushchin wrote:      
> > > > > > On Tue, Jun 16, 2020 at 08:05:39PM -0700, Shakeel Butt wrote:      
> > > > > >> On Tue, Jun 16, 2020 at 7:41 PM Roman Gushchin <guro@fb.com> wrote:      
> > > > > >> >
> > > > > >> > On Tue, Jun 16, 2020 at 06:46:56PM -0700, Shakeel Butt wrote:      
> > > > > >> > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:      
> > > > > >> > > >      
> > > > > >> [...]      
> > > > > >> > >
> > > > > >> > > Have you performed any [perf] testing on SLAB with this patchset?      
> > > > > >> >
> > > > > >> > The accounting part is the same for SLAB and SLUB, so there should be no
> > > > > >> > significant difference. I've checked that it compiles, boots and passes
> > > > > >> > kselftests. And that memory savings are there.
> > > > > >> >      
> > > > > >> 
> > > > > >> What about performance? Also you mentioned that sharing kmem-cache
> > > > > >> between accounted and non-accounted can have additional overhead. Any
> > > > > >> difference between SLAB and SLUB for such a case?      
> > > > > > 
> > > > > > Not really.
> > > > > > 
> > > > > > Sharing a single set of caches adds some overhead to root- and non-accounted
> > > > > > allocations, which is something I've tried hard to avoid in my original version.
> > > > > > But I have to admit, it allows to simplify and remove a lot of code, and here
> > > > > > it's hard to argue with Johanness, who pushed on this design.
> > > > > > 
> > > > > > With performance testing it's not that easy, because it's not obvious what
> > > > > > we wanna test. Obviously, per-object accounting is more expensive, and
> > > > > > measuring something like 1000000 allocations and deallocations in a line from
> > > > > > a single kmem_cache will show a regression. But in the real world the relative
> > > > > > cost of allocations is usually low, and we can get some benefits from a smaller
> > > > > > working set and from having shared kmem_cache objects cache hot.
> > > > > > Not speaking about some extra memory and the fragmentation reduction.
> > > > > > 
> > > > > > We've done an extensive testing of the original version in Facebook production,
> > > > > > and we haven't noticed any regressions so far. But I have to admit, we were
> > > > > > using an original version with two sets of kmem_caches.
> > > > > > 
> > > > > > If you have any specific tests in mind, I can definitely run them. Or if you
> > > > > > can help with the performance evaluation, I'll appreciate it a lot.      
> > > > > 
> > > > > Jesper provided some pointers here [1], it would be really great if you could
> > > > > run at least those microbenchmarks. With mmtests it's the major question of
> > > > > which subset/profiles to run, maybe the referenced commits provide some hints,
> > > > > or maybe Mel could suggest what he used to evaluate SLAB vs SLUB not so long ago.
> > > > > 
> > > > > [1] https://lore.kernel.org/linux-mm/20200527103545.4348ac10@carbon/      
> > > > 
> > > > Oh, Jesper, I'm really sorry, somehow I missed your mail.
> > > > Thank you, Vlastimil, for pointing at it.
> > > > 
> > > > I've got some results (slab_bulk_test01), but honestly I fail to interpret them.
> > > > 
> > > > I ran original vs patched with SLUB and SLAB, each test several times and picked
> > > > 3 which looked most consistently. But it still looks very noisy.
> > > > 
> > > > I ran them on my desktop (8-core Ryzen 1700, 16 GB RAM, Fedora 32),
> > > > it's 5.8-rc1 + slab controller v6 vs 5.8-rc1 (default config from Fedora 32).    
> > > 
> > > What about running these tests on the server level hardware, that you
> > > intent to run this on?    
> > 
> > To give you an idea of the performance difference I ran the same test
> > on a Broadwell Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz.
> > 
> > The SLUB fastpath:
> >  Type:kmem fastpath reuse Per elem: 60 cycles(tsc) 16.822 ns
> > 
> >   
> > > > 
> > > > How should I interpret this data?    
> > > 
> > > First of all these SLUB+SLAB microbenchmarks use object size 256 bytes,
> > > because network stack alloc object of this size for SKBs/sk_buff (due
> > > to cache-align as used size is 224 bytes). Checked SLUB: Each slab use
> > > 2 pages (8192 bytes) and contain 32 object of size 256 (256*32=8192).
> > > 
> > >   The SLUB allocator have a per-CPU slab which speedup fast-reuse, in this
> > > case up-to 32 objects. For SLUB the "fastpath reuse" test this behaviour,
> > > and it serves as a baseline for optimal 1-object performance (where my bulk
> > > API tries to beat that, which is possible even for 1-object due to knowing
> > > bulk API cannot be used from IRQ context).
> > > 
> > > SLUB fastpath: 3 measurements reporting cycles(tsc)
> > >  - SLUB-patched : fastpath reuse: 184 - 177 - 176  cycles(tsc)
> > >  - SLUB-original: fastpath reuse: 178 - 153 - 156  cycles(tsc)
> > >   
> > 
> > For your SLAB results:
> > 
> >  SLAB fastpath: 3 measurements reporting cycles(tsc)
> >   - SLAB-patched : 161 - 160 - 163  cycles(tsc)
> >   - SLAB-original: 174 - 170 - 159  cycles(tsc)
> > 
> > I find it strange that SLAB is slightly better than SLUB (in many
> > measurements), because SLUB should have an advantage on this fast-path
> > quick reuse due to the per-CPU slabs.  Maybe this is also related to
> > the CPU arch you are using?
> > 
> >   
> > > There are some stability concerns as you mention, but it seems pretty
> > > consistently that patched version is slower. If you compile with
> > > no-PREEMPT you can likely get more stable results (and remove a slight
> > > overhead for SLUB fastpath).
> > > 
> > > The microbenchmark also measures the bulk-API, which is AFAIK only used
> > > by network stack (and io_uring). I guess you shouldn't focus too much
> > > on these bulk measurements. When bulk-API cross this objects per slab
> > > threshold, or is unlucky is it use two per-CPU slab, then the
> > > measurements can fluctuate a bit.
> > > 
> > > Your numbers for SLUB bulk-API:
> > > 
> > > SLUB-patched - bulk-API
> > >  - SLUB-patched : bulk_quick_reuse objects=1 : 187 -  90 - 224  cycles(tsc)
> > >  - SLUB-patched : bulk_quick_reuse objects=2 : 110 -  53 - 133  cycles(tsc)
> > >  - SLUB-patched : bulk_quick_reuse objects=3 :  88 -  95 -  42  cycles(tsc)
> > >  - SLUB-patched : bulk_quick_reuse objects=4 :  91 -  85 -  36  cycles(tsc)
> > >  - SLUB-patched : bulk_quick_reuse objects=8 :  32 -  66 -  32  cycles(tsc)
> > > 
> > > SLUB-original -  bulk-API
> > >  - SLUB-original: bulk_quick_reuse objects=1 :  87 -  87 - 142  cycles(tsc)
> > >  - SLUB-original: bulk_quick_reuse objects=2 :  52 -  53 -  53  cycles(tsc)
> > >  - SLUB-original: bulk_quick_reuse objects=3 :  42 -  42 -  91  cycles(tsc)
> > >  - SLUB-original: bulk_quick_reuse objects=4 :  91 -  37 -  37  cycles(tsc)
> > >  - SLUB-original: bulk_quick_reuse objects=8 :  31 -  79 -  76  cycles(tsc)  
> > 
> > Your numbers for SLAB bulk-API:
> > 
> > SLAB-patched -  bulk-API
> >  - SLAB-patched : bulk_quick_reuse objects=1 :  67 -  67 - 140  cycles(tsc)
> >  - SLAB-patched : bulk_quick_reuse objects=2 :  55 -  46 -  46  cycles(tsc)
> >  - SLAB-patched : bulk_quick_reuse objects=3 :  93 -  94 -  39  cycles(tsc)
> >  - SLAB-patched : bulk_quick_reuse objects=4 :  35 -  88 -  85  cycles(tsc)
> >  - SLAB-patched : bulk_quick_reuse objects=8 :  30 -  30 -  30  cycles(tsc)
> > 
> > SLAB-original-  bulk-API
> >  - SLAB-original: bulk_quick_reuse objects=1 : 143 - 136 -  67  cycles(tsc)
> >  - SLAB-original: bulk_quick_reuse objects=2 :  45 -  46 -  46  cycles(tsc)
> >  - SLAB-original: bulk_quick_reuse objects=3 :  38 -  39 -  39  cycles(tsc)
> >  - SLAB-original: bulk_quick_reuse objects=4 :  35 -  87 -  87  cycles(tsc)
> >  - SLAB-original: bulk_quick_reuse objects=8 :  29 -  66 -  30  cycles(tsc)
> > 
> > In case of SLAB I expect the bulk-API to be slightly faster than SLUB,
> > as the SLUB bulk code is much more advanced.  
> 
> So again it looks like a patched version is only slightly worse if we're taking
> the smallest number in each series. Is it a correct assumption?

Yes, I guess that is a good way to look at these somewhat fluctuating numbers.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

