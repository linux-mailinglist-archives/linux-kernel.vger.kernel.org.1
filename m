Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C10E26FAF5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgIRKvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgIRKvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600426275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f8L73omdRwt2XW22haAod4n/ftl4SghA4bgj9gc9Se8=;
        b=cS/XfZkeDXB22dYUeJI14NUxViz4Sh32fR5H+nP/el7k0HqnKHn5hhC2ZfuxrK+yZpS6hW
        heFtgQlNQy+mylmSQ/ClWZm+QXiwrq/nm4OW31e0FvhpISPRMCEsjQ875+Gxkpi/5CvRuz
        VjXa/QFlNEOOfpTe3aeIRgQtxRo3lMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-il1hGKEBPVuSl8kR_Ae4WA-1; Fri, 18 Sep 2020 06:51:13 -0400
X-MC-Unique: il1hGKEBPVuSl8kR_Ae4WA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 596911084C94;
        Fri, 18 Sep 2020 10:51:11 +0000 (UTC)
Received: from krava (ovpn-114-24.ams2.redhat.com [10.36.114.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id 069B519D6C;
        Fri, 18 Sep 2020 10:51:06 +0000 (UTC)
Date:   Fri, 18 Sep 2020 12:51:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 04/26] perf tools: Add filename__decompress function
Message-ID: <20200918105105.GA2614866@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-5-jolsa@kernel.org>
 <20200914153554.GF160517@kernel.org>
 <20200914204326.GY1714160@krava>
 <20200917185455.GA1426933@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917185455.GA1426933@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:54:55PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Sep 14, 2020 at 10:43:26PM +0200, Jiri Olsa escreveu:
> > On Mon, Sep 14, 2020 at 12:35:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Sun, Sep 13, 2020 at 11:02:51PM +0200, Jiri Olsa escreveu:
> > > > Factor filename__decompress from decompress_kmodule function.
> > > > It can decompress files with compressions supported in perf -
> > > > xz and gz, the support needs to be compiled in.
> > > > 
> > > > It will to be used in following changes to get build id out of
> > > > compressed elf objects.
> > > 
> > > This is prep work, can be applied now, done.
> > 
> > thanks,
> > jirka
> 
> So, I take that back, one of these decompress patches is causing this:
> 
> [root@five ~]# perf list syscalls:sys_enter_open |& tail
> lzma: fopen failed on /usr/lib/modules/5.6.19-200.fc31.x86_64/kernel/drivers/acpi/video.ko.xz: 'No such file or directory'
> lzma: fopen failed on /usr/lib/modules/5.5.8-200.fc31.x86_64/kernel/net/ipv4/netfilter/nf_reject_ipv4.ko.xz: 'No such file or directory'
> lzma: fopen failed on /usr/lib/modules/5.5.9-200.fc31.x86_64/kernel/net/ipv6/netfilter/ip6_tables.ko.xz: 'No such file or directory'
> lzma: fopen failed on /usr/lib/modules/5.5.5-200.fc31.x86_64/kernel/drivers/crypto/ccp/ccp.ko.xz: 'No such file or directory'
> lzma: fopen failed on /usr/lib/modules/5.4.20-200.fc31.x86_64/kernel/sound/pci/hda/snd-hda-codec.ko.xz: 'No such file or directory'
> lzma: fopen failed on /usr/lib/modules/5.5.15-200.fc31.x86_64/kernel/drivers/target/target_core_mod.ko.xz: 'No such file or directory'
> lzma: fopen failed on /usr/lib/modules/5.3.7-301.fc31.x86_64/kernel/drivers/iommu/amd_iommu_v2.ko.xz: 'No such file or directory'
> lzma: fopen failed on /usr/lib/modules/5.3.7-301.fc31.x86_64/kernel/drivers/media/v4l2-core/videodev.ko.xz: 'No such file or directory'
> lzma: fopen failed on /usr/lib/modules/5.6.19-200.fc31.x86_64/kernel/net/ipv4/netfilter/iptable_filter.ko.xz: 'No such file or directory'
>   syscalls:sys_enter_open                            [Tracepoint event]
> [root@five ~]# perf test 78
> 78: Check open filename arg using perf trace + vfs_getname          : FAILED!
> [root@five ~]#
> [root@five ~]# uname -a
> Linux five 5.9.0-rc3 #1 SMP Mon Aug 31 08:38:27 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
> [root@five ~]#
> 
> So I removed them from my local branch, I'll rerun the build tests and
> then push perf/core when all tests pass.
> 
> The test uses 'perf probe' and I noticed it when processing Masami's
> debuginfod patches to make 'perf probe' use it, I thought it was his
> patches, looking only at the 'perf test 78' output, but ended up being
> the decompress ones.

ok, will check on that

thanks,
jirka

