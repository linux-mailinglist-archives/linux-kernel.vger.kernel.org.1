Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1BB2E2C81
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 23:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgLYWgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 17:36:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726737AbgLYWgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 17:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608935721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xmLuwFglEXzlvsfgmPEIOiXlu1HJHtLhbVA56knSTc8=;
        b=aroKMdKQHbkVnmJTsyhotEZgbneGaed7TF8iO1rKBFTiFibifLb7ixe2q6KHxnCsozvQXF
        U1ccJ29tvg7bOEMU/GuHh0ZkmVuhnQ81GqT3cxq7LySp7n3TO3+mW5nitXwRc6VbrGpaci
        unoerG555iGpWVd4p0hQiojsB/O4/8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-AL75_iGDNyeiKNZhfHKmSw-1; Fri, 25 Dec 2020 17:35:16 -0500
X-MC-Unique: AL75_iGDNyeiKNZhfHKmSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 324EA800D53;
        Fri, 25 Dec 2020 22:35:14 +0000 (UTC)
Received: from krava (unknown [10.40.192.19])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2A2A3E140;
        Fri, 25 Dec 2020 22:35:07 +0000 (UTC)
Date:   Fri, 25 Dec 2020 23:35:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 03/15] perf: Add build id data in mmap2 event
Message-ID: <20201225223507.GA364667@krava>
References: <20201214105457.543111-1-jolsa@kernel.org>
 <20201214105457.543111-4-jolsa@kernel.org>
 <20201215155226.GK258566@kernel.org>
 <30ef464f-fc0b-bf5b-33e0-e207b754199d@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ef464f-fc0b-bf5b-33e0-e207b754199d@iogearbox.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 11:01:51PM +0100, Daniel Borkmann wrote:
> Hey Arnaldo,
> 
> On 12/15/20 4:52 PM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Dec 14, 2020 at 11:54:45AM +0100, Jiri Olsa escreveu:
> > > Adding support to carry build id data in mmap2 event.
> > > 
> > > The build id data replaces maj/min/ino/ino_generation
> > > fields, which are also used to identify map's binary,
> > > so it's ok to replace them with build id data:
> > > 
> > >    union {
> > >            struct {
> > >                    u32       maj;
> > >                    u32       min;
> > >                    u64       ino;
> > >                    u64       ino_generation;
> > >            };
> > >            struct {
> > >                    u8        build_id_size;
> > >                    u8        __reserved_1;
> > >                    u16       __reserved_2;
> > >                    u8        build_id[20];
> > >            };
> > >    };
> > 
> > Alexei/Daniel, this one depends on BPFs build id routines to be exported
> > for use by the perf kernel subsys, PeterZ already acked this, so can you
> > guys consider getting the first three patches in this series via the bpf
> > tree?
> > 
> > The BPF bits were acked by Song.
> 
> All the net-next and therefore also bpf-next bits for 5.11 were just merged
> by Linus into his tree. If you need the first 3 from [0] to land for this merge
> window, it's probably easiest if you take them in and send them via perf tree
> directly in case you didn't send out a pull-req yet.. (alternatively I'll ping
> David/Jakub if they plan to make a 2nd net-next pull-req end of this week).
> 
> Thanks,
> Daniel
> 
>  [0] https://lore.kernel.org/lkml/20201214105457.543111-1-jolsa@kernel.org/
> 

hi,
I don't see them (first 3 from [0]) in any tree so far ;-) please let
me know if there's anything I can do from my side to get this merged

thanks,
jirka


[0] https://lore.kernel.org/lkml/20201214105457.543111-1-jolsa@kernel.org/

