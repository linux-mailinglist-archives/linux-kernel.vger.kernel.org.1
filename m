Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9412AD301
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgKJKCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:02:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbgKJKCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605002526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q1ZG2YVszGjoyBGFui4k875AVjUELR1/C4e620On31o=;
        b=bEhso7BcRcX7wcm4D2uDxqKdJpODTWcxES+SRdkl6frMoFHHvgieI3PX8/MqcLaZ6F2z5C
        jXFdd6ajD+SCsIIcl9G04MRwifuXptuT/ClqXu1s/BgycP2rrTjxZdCwF/HAJa71fpsNeq
        ESZPZY0Bltmb5Q7kn2LgBeX3K1JmyhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-XJIZoZnlNA6vSmmpUjarAQ-1; Tue, 10 Nov 2020 05:02:04 -0500
X-MC-Unique: XJIZoZnlNA6vSmmpUjarAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3674C5F9E2;
        Tue, 10 Nov 2020 10:02:02 +0000 (UTC)
Received: from krava (unknown [10.40.195.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 62C23389;
        Tue, 10 Nov 2020 10:01:58 +0000 (UTC)
Date:   Tue, 10 Nov 2020 11:01:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 02/24] bpf: Add build_id_parse_size function
Message-ID: <20201110100157.GA387652@krava>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-3-jolsa@kernel.org>
 <CAADnVQLdXRFv1MYQu8k9QrECQxe3LFAfuyU244-9LfRT5snoqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLdXRFv1MYQu8k9QrECQxe3LFAfuyU244-9LfRT5snoqA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 04:15:42PM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 9, 2020 at 1:54 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > It's possible to have other build id types (other than default
> > SHA1). Currently there's also ld support for MD5 build id.
> >
> > Adding build_id_parse_size function, that returns also size of
> > the parsed build id, so we can recognize the build id type.
> >
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/buildid.h |  2 ++
> >  lib/buildid.c           | 31 ++++++++++++++++++++++++-------
> >  2 files changed, 26 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> > index 3be5b49719f1..edba89834b4c 100644
> > --- a/include/linux/buildid.h
> > +++ b/include/linux/buildid.h
> > @@ -7,5 +7,7 @@
> >  #define BUILD_ID_SIZE 20
> >
> >  int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id);
> > +int build_id_parse_size(struct vm_area_struct *vma, unsigned char *build_id,
> > +                       __u32 *size);
> 
> I think it's too many choices for such trivial api.
> Just keep one build_id_parse() with two outputs
> and fix the callers.
> 

ok, will do

jirka

