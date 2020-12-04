Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3DF2CF78F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbgLDXbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:31:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbgLDXbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607124637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ms5V2uxyieO3HN+qSj95pXjFZDCxPFCV/aCXi/3gSe8=;
        b=F7KCqA32oJA0MomwUszo5Y3kzotkfAoIlkTNo/vRaWKaTv7gvWXtDmstCjllciYadhzwgJ
        oICZB3uzqeQWD3QCEWAk7PAQLqG8P+bQ629kyBFy0aiaolJpPleh9pDRB3LMZLUhhhVLOf
        HZyCerjSfQBUmTXUtEAwA9ty4yp4Cec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-BxPUYGuOO-uzpRX6vYwE3g-1; Fri, 04 Dec 2020 18:30:34 -0500
X-MC-Unique: BxPUYGuOO-uzpRX6vYwE3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECB9F803638;
        Fri,  4 Dec 2020 23:30:31 +0000 (UTC)
Received: from krava (unknown [10.40.192.39])
        by smtp.corp.redhat.com (Postfix) with SMTP id 948D817C58;
        Fri,  4 Dec 2020 23:30:28 +0000 (UTC)
Date:   Sat, 5 Dec 2020 00:30:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
Subject: Re: [PATCH 02/25] bpf: Add size arg to build_id_parse function
Message-ID: <20201204233027.GL3613628@krava>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-3-jolsa@kernel.org>
 <EFD4A5C8-19AB-460A-B784-001F3809F71A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EFD4A5C8-19AB-460A-B784-001F3809F71A@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 09:23:52PM +0000, Song Liu wrote:
> 
> 
> > On Nov 26, 2020, at 9:00 AM, Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> > It's possible to have other build id types (other than default SHA1).
> > Currently there's also ld support for MD5 build id.
> > 
> > Adding size argument to build_id_parse function, that returns (if defined)
> > size of the parsed build id, so we can recognize the build id type.
> > 
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Sorry for the late response. The patch looks good to me. 
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> 
> with one nitpick below. 
> 
> > ---
> > include/linux/buildid.h |  3 ++-
> > kernel/bpf/stackmap.c   |  2 +-
> > lib/buildid.c           | 29 +++++++++++++++++++++--------
> > 3 files changed, 24 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> > index 3be5b49719f1..72639d433873 100644
> > --- a/include/linux/buildid.h
> > +++ b/include/linux/buildid.h
> > @@ -6,6 +6,7 @@
> > 
> > #define BUILD_ID_SIZE 20
> 
> Since we are handling build-id with different sizes, how about we 
> rename this as BUILD_ID_SIZE_MAX or BUILD_ID_SIZE_DEFAULT? 

right, BUILD_ID_SIZE_MAX sounds good to me

thanks,
jirka

