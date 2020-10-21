Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE729487E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 08:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395161AbgJUGyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 02:54:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43812 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390644AbgJUGyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 02:54:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so1588581wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 23:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8by5sRUZeB9uCP5ORX+kwVQI8eEL0WmXBTs0Dd1dsw=;
        b=GcPuaCDRKW4KFTxgNvACa3K4KdG1ET73aYlW4ZEqbsnD+vV/QfCr2BBPDxNARNazun
         7kGZjd+FnClTLrtn4zGSfyDYJAcFqRN/fCNCQytLpvPoPEO2CaljHAUevpRfy3vHzbO4
         mlLoIItkzEN2Dz5E3DeKQCBjovwGbPbOdXDtAGmBK+cmfbpZGpIBx9sLNFTFpHKq7hMb
         1DxbH9px8t1SqRTeOK9eUTZAC/oMYSFnQybNiXZuYJhRLHombSAfs0pnxKVic2CqAlQT
         dSnxpArtXoiRf+aI5TgrZXngHBY9LW37Z01V5lf8pArdMORtlCE/fg+wt5z4C3j/tPjy
         ZYBw==
X-Gm-Message-State: AOAM530EHNaibV35j8UQadRwdKoTlAhtztrRw/eMowjrxeYT6OfY3bTc
        w0wQ6nLIoVMk+96xk66yyd9Sw2Hxdsf+r8GlP5A=
X-Google-Smtp-Source: ABdhPJxH2WJKqCsu/qm/UXrsRj+AMZLOlj0/PBt1DkGxxsgR8MTUboGzixFJSXeqOg4zcF2T2ysWtFm0MkOVP73LSpA=
X-Received: by 2002:adf:bb43:: with SMTP id x3mr2770588wrg.250.1603263280202;
 Tue, 20 Oct 2020 23:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <39cf6164-f3be-ae34-292a-94faef32fdb9@linux.intel.com> <20201012160921.GD466880@tassilo.jf.intel.com>
 <8f90c785-8bdc-e7cd-a6d9-7eed0fb2c6b3@linux.intel.com> <7216a411-a635-4fcc-b10d-afe1f75509d3@linux.intel.com>
In-Reply-To: <7216a411-a635-4fcc-b10d-afe1f75509d3@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Oct 2020 15:54:29 +0900
Message-ID: <CAM9d7cjJzHr7BZ2LVFuG4dnk=i+LmP_TCb9J8FTO0w1w=KG1WQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/15] perf session: load data directory into tool
 process memory
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 13, 2020 at 8:30 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
> On 12.10.2020 19:49, Alexey Budankov wrote:
> > On 12.10.2020 19:09, Andi Kleen wrote:
> >> On Mon, Oct 12, 2020 at 11:58:58AM +0300, Alexey Budankov wrote:
> >>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> >>> index 6afc670fdf0c..0752eec19813 100644
> >>> --- a/tools/perf/util/session.c
> >>> +++ b/tools/perf/util/session.c
> >>> @@ -2212,6 +2212,17 @@ reader__process_events(struct reader *rd, struct perf_session *session,
> >>>             goto more;
> >>>
> >>>  out:
> >>> +   if (rd->unmap_file) {
> >>> +           int i;
> >>> +
> >>> +           for (i = 0; i < NUM_MMAPS; i++) {
> >>> +                   if (mmaps[i]) {
> >>> +                           munmap(mmaps[i], mmap_size);
> >>> +                           mmaps[i] = NULL;
> >>
> >> Okay so where is the mmap? Would make more sense to put that
> >> into the same patch as who adds the mmap. Or is the mmap
> >> code already in the perf source? In that case it should
> >> probably be some common helper with the existing users.
> >
> > That mmap is already in the code. Agree, this part of the patch
> > can be applied prior the whole patch set.
>
> I take it back. Single trace file can't be unmapped yet since it also
> contains not only compressed records but also other records backing
> the data for aggregated analysis.

Are you talking about the auxtrace?

I thought everything will be compressed when it's enabled.
But if it's only for the auxtrace, maybe we can unmap them
with checking it as it's not the common case?

Thanks
Namhyung
