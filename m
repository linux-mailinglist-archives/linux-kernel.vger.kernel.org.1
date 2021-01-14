Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32472F6A66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbhANTCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727799AbhANTCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610650872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+5RIDcrsbrw4UUhjO07auVuEd2BGO1y+nf7kAPT4Gc=;
        b=C/7GW8mkZb4dzNqEK0amJUgRf05vzlILqgkJ1kb7LOmvm2qAi/5M+waP0JWcTPS3bA3O7d
        G/mURBJ50iDQLZmKH8Pkvx5dxQeOUdqxbbpUOF86KBOMCKw/zsk4Ir9wCsREtaMS8KRM+0
        S+3dzexyZGwnuXckEXyO37fxJTivt0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-jggtxtacOzyoPOltwvkwFA-1; Thu, 14 Jan 2021 14:01:08 -0500
X-MC-Unique: jggtxtacOzyoPOltwvkwFA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94AC187950D;
        Thu, 14 Jan 2021 19:01:01 +0000 (UTC)
Received: from krava (unknown [10.40.195.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7DD8B19C48;
        Thu, 14 Jan 2021 19:00:59 +0000 (UTC)
Date:   Thu, 14 Jan 2021 20:00:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5] perf stat: Fix wrong skipping for per-die aggregation
Message-ID: <20210114190058.GD1416940@krava>
References: <20210113015631.8748-1-yao.jin@linux.intel.com>
 <20210113110701.GC1331835@krava>
 <20210114183047.GB307547@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114183047.GB307547@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 03:30:47PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jan 13, 2021 at 12:07:01PM +0100, Jiri Olsa escreveu:
> > On Wed, Jan 13, 2021 at 09:56:31AM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > 
> > > root@lkp-csl-2ap4 ~# ./perf stat -a -I 1000 -e llc_misses.mem_read --per-die -- sleep 5
> > >      1.001586691 S0-D0           1            1229440 Bytes llc_misses.mem_read
> > >      1.001586691 S0-D1           1             976832 Bytes llc_misses.mem_read
> > >      1.001586691 S1-D0           1             938304 Bytes llc_misses.mem_read
> > >      1.001586691 S1-D1           1            1227328 Bytes llc_misses.mem_read
> > >      2.003776312 S0-D0           1            1586752 Bytes llc_misses.mem_read
> > >      2.003776312 S0-D1           1             875392 Bytes llc_misses.mem_read
> > >      2.003776312 S1-D0           1             855616 Bytes llc_misses.mem_read
> > >      2.003776312 S1-D1           1             949376 Bytes llc_misses.mem_read
> > >      3.006512788 S0-D0           1            1338880 Bytes llc_misses.mem_read
> > >      3.006512788 S0-D1           1             920064 Bytes llc_misses.mem_read
> > >      3.006512788 S1-D0           1             877184 Bytes llc_misses.mem_read
> > >      3.006512788 S1-D1           1            1020736 Bytes llc_misses.mem_read
> > >      4.008895291 S0-D0           1             926592 Bytes llc_misses.mem_read
> > >      4.008895291 S0-D1           1             906368 Bytes llc_misses.mem_read
> > >      4.008895291 S1-D0           1             892224 Bytes llc_misses.mem_read
> > >      4.008895291 S1-D1           1             987712 Bytes llc_misses.mem_read
> > >      5.001590993 S0-D0           1             962624 Bytes llc_misses.mem_read
> > >      5.001590993 S0-D1           1             912512 Bytes llc_misses.mem_read
> > >      5.001590993 S1-D0           1             891200 Bytes llc_misses.mem_read
> > >      5.001590993 S1-D1           1             978432 Bytes llc_misses.mem_read
> > > 
> > > On no-die system, die_id is 0, actually it's hashmap(socket,0), original behavior
> > > is not changed.
> > > 
> > > Reported-by: Huang Ying <ying.huang@intel.com>
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > > v5:
> > >  Hash key is changed to die_id << 32 | socket.
> > >  In pkg_id_hash, return (int64_t)key & 0xffffffff; actually it's socket.
> > 
> > seems ok, but I'm getting python test fail:
> 
> He addressed that in v6, so I've sticked an Acked-by: jolsa, ok?

yep, I just acked it

jirka

> 
> - Arnaldo
>  
> > 	$ sudo ./perf test python -v
> > 	19: 'import perf' in python                                         :
> > 	--- start ---
> > 	test child forked, pid 1352066
> > 	python usage test: "echo "import sys ; sys.path.append('python'); import perf" | '/usr/bin/python2' "
> > 	Traceback (most recent call last):
> > 	  File "<stdin>", line 1, in <module>
> > 	ImportError: python/perf.so: undefined symbol: hashmap__free
> > 	test child finished with -1
> > 	---- end ----
> > 	'import perf' in python: FAILED!
> > 
> > jirka
> > 
> 
> -- 
> 
> - Arnaldo
> 

