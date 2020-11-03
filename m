Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF702A44E2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgKCMPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728966AbgKCMPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:15:38 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74DDB21D40;
        Tue,  3 Nov 2020 12:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604405737;
        bh=RqOUqhub1p7UVpsEDddWrEzjzkacwuz/1Ck8fq4kG8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vicuSlojI8Bg8z2I5HttNlQi1rIWPPC7m3lxy75QLX6rbZlMLuszZJoyX8Z3HYJdI
         lN5n+8c9Jw7XveHgBjMJ2ohSwExEBibLH85wj5/sMRnkkiOqToV8FquxbkuL14FOa9
         JrllGZ/EsDaCz4dLkKGCbbsoW9MZyhq4W36eSw8Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F98E40452; Tue,  3 Nov 2020 09:15:35 -0300 (-03)
Date:   Tue, 3 Nov 2020 09:15:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/2] perf tools: Initialize output buffer in
 build_id__sprintf
Message-ID: <20201103121535.GD151027@kernel.org>
References: <20201101233103.3537427-1-jolsa@kernel.org>
 <CAM9d7cj6mfLuZYsXzAP+JBTuRC9F74AxmGbCL2_wyxRWoau-tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj6mfLuZYsXzAP+JBTuRC9F74AxmGbCL2_wyxRWoau-tA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 02, 2020 at 10:50:00PM +0900, Namhyung Kim escreveu:
> Hi Jiri,
> 
> On Mon, Nov 2, 2020 at 8:31 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We display garbage for undefined build_id objects,
> > because we don't initialize the output buffer.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks
> Namhyung
> 
> 
> > ---
> >  tools/perf/util/build-id.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > index 8763772f1095..6b410c3d52dc 100644
> > --- a/tools/perf/util/build-id.c
> > +++ b/tools/perf/util/build-id.c
> > @@ -102,6 +102,8 @@ int build_id__sprintf(const struct build_id *build_id, char *bf)
> >         const u8 *raw = build_id->data;
> >         size_t i;
> >
> > +       bf[0] = 0x0;
> > +
> >         for (i = 0; i < build_id->size; ++i) {
> >                 sprintf(bid, "%02x", *raw);
> >                 ++raw;
> > --
> > 2.26.2
> >

-- 

- Arnaldo
