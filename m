Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F987269111
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgINQHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgINQEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:04:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D97920EDD;
        Mon, 14 Sep 2020 16:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600099400;
        bh=yI0s//6TJSSQUXdVVQjhJfjWuCd2EdWI8qBQV3YQ9ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mvDKO755QCkKry9ENHnmoI8y02lzf3KZzcp4AKASxezMRa7nTzHcSRTXfhUPHwa+R
         y6/hcVyRJQS8nujE1QM+0qNIN87zdInb49CWM+Rpek+Tmn1iJ9AfCB2uYmYicE0bkQ
         K6TmkcVKtYDC3XoxqpyvsFxxQvwoLBy1pcdTkOpU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7AB0840D3D; Mon, 14 Sep 2020 13:03:18 -0300 (-03)
Date:   Mon, 14 Sep 2020 13:03:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 05/26] perf tools: Add build_id__is_defined function
Message-ID: <20200914160318.GG160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-6-jolsa@kernel.org>
 <CAM9d7cjjGjTN8sDgLZ1PoQZ-sUXWjnVaNdyOVE1yHxq46PrPkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjjGjTN8sDgLZ1PoQZ-sUXWjnVaNdyOVE1yHxq46PrPkw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 14, 2020 at 02:44:35PM +0900, Namhyung Kim escreveu:
> On Mon, Sep 14, 2020 at 6:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding build_id__is_defined helper to check build id
> > is defined and is != zero build id.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/build-id.c | 11 +++++++++++
> >  tools/perf/util/build-id.h |  1 +
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > index 31207b6e2066..bdee4e08e60d 100644
> > --- a/tools/perf/util/build-id.c
> > +++ b/tools/perf/util/build-id.c
> > @@ -902,3 +902,14 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
> >
> >         return ret;
> >  }
> > +
> > +bool build_id__is_defined(const u8 *build_id)
> > +{
> > +       static u8 zero[BUILD_ID_SIZE];
> > +       int err = 0;
> > +
> > +       if (build_id)
> > +               err = memcmp(build_id, &zero, BUILD_ID_SIZE);
> > +
> > +       return err ? true : false;
> > +}
 
> I think this is a bit confusing.. How about this?
 
>   bool ret = false;
>   if (build_id)
>       ret = memcmp(...);
>   return ret;
 
> Or, it can be a oneliner..

Yeah.

I was curious about if the kernel lib has something to ask if a range of
memory is zeroed, and there is this:

static bool is_zeroed(void *from, size_t size)
{
        return memchr_inv(from, 0x0, size) == NULL;
}

commit 798248206b59acc6e1238c778281419c041891a7
Author: Akinobu Mita <akinobu.mita@gmail.com>
Date:   Mon Oct 31 17:08:07 2011 -0700

    lib/string.c: introduce memchr_inv()

    memchr_inv() is mainly used to check whether the whole buffer is filled
    with just a specified byte.

    The function name and prototype are stolen from logfs and the
    implementation is from SLUB.

---

Some usage in drivers/nvme/target/admin-cmd.c

+static void nvmet_execute_identify_desclist(struct nvmet_req *req)
+{
+       struct nvmet_ns *ns;
+       u16 status = 0;
+       off_t off = 0;
+
+       ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+       if (!ns) {
+               status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+               goto out;
+       }
+
+       if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
+               status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
+                                                 NVME_NIDT_UUID_LEN,
+                                                 &ns->uuid, &off);
+               if (status)
+                       goto out_put_ns;
+       }

More:

[acme@five perf]$ find arch/ -type f | xargs grep memchr_inv
arch/x86/kernel/fpu/xstate.c:	if (memchr_inv(hdr->reserved, 0, sizeof(hdr->reserved)))
arch/x86/mm/init_64.c:			if (!memchr_inv(page_addr, PAGE_INUSE, PAGE_SIZE)) {
arch/x86/mm/init_64.c:				if (!memchr_inv(page_addr, PAGE_INUSE,
arch/x86/mm/init_64.c:				if (!memchr_inv(page_addr, PAGE_INUSE,
arch/s390/mm/vmem.c:	return !memchr_inv(page, PAGE_UNUSED, PMD_SIZE);
arch/powerpc/platforms/powermac/nvram.c:	if (memchr_inv(base, 0xff, NVRAM_SIZE)) {
arch/powerpc/platforms/powermac/nvram.c:	if (memchr_inv(base, 0xff, NVRAM_SIZE)) {
[acme@five perf]$

- Arnaldo
