Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576782F2B29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390658AbhALJVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:21:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390337AbhALJVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610443188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YQ3Mf9K3OSq1tFMsqSNt3O1g/fXryt3OcbUzn0sGHAQ=;
        b=hcV1VOFmYNcwr9p+qAvvwfV1sekAApmbWyjF562yHFrXbVgrgo2/e/hcqUk1X1XJvjgqQc
        d2M1c2SdsqT5Jw9igNTC4uCx5Hw3nur37NjKdhfknHMDytP4PNeWJbU5ikV3dVWnTGLV0t
        ERSEvcRN4Mg7R1UOZnYD1P2RywpO+ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-4Wb95AP9OUmKJVujVKyyGQ-1; Tue, 12 Jan 2021 04:19:46 -0500
X-MC-Unique: 4Wb95AP9OUmKJVujVKyyGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B5811926DA4;
        Tue, 12 Jan 2021 09:19:43 +0000 (UTC)
Received: from krava (unknown [10.40.195.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0EA7F74440;
        Tue, 12 Jan 2021 09:19:38 +0000 (UTC)
Date:   Tue, 12 Jan 2021 10:19:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [PATCHv6 0/4] perf: Add mmap2 build id support
Message-ID: <20210112091937.GA1252618@krava>
References: <20210111213823.1249420-1-jolsa@kernel.org>
 <20210112024958.4utm7ijkpluu3g36@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112024958.4utm7ijkpluu3g36@ast-mbp>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 06:49:58PM -0800, Alexei Starovoitov wrote:
> On Mon, Jan 11, 2021 at 10:38:19PM +0100, Jiri Olsa wrote:
> > hi,
> > adding the support to have buildid stored in mmap2 event,
> > so we can bypass the final perf record hunt on build ids.
> > 
> > This patchset allows perf to record build ID in mmap2 event,
> > and adds perf tooling to store/download binaries to .debug
> > cache based on these build IDs.
> > 
> > Note that the build id retrieval code is stolen from bpf
> > code, where it's been used (together with file offsets)
> > to replace IPs in user space stack traces. It's now added
> > under lib directory.
> > 
> > v6 changes:
> >   - last 4 patches rebased Arnaldo's perf/core
> 
> There were no issues with v5 as far as I can remember.
> This is just a resubmit to get it landed ?

yes, exactly

> Last time we couldn't quite figure out which tree to go through.
> I think the recommend path was to go via bpf-next.
> Is it still the case?

bpf-next would be best for kernel changes,
  perf: Add build id data in mmap2 event
  bpf: Add size arg to build_id_parse function
  bpf: Move stack_map_get_build_id into lib

the 'perf buildid-cache' change needs to go through Arnaldo's tree,
because it depends on changes he already pulled in

thanks,
jirka

