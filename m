Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BABC28441A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 04:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgJFCjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 22:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgJFCjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 22:39:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE63C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 19:39:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m15so485527pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c3o9BUJSdFDURbaPvsof0q2JaknWm3G4aaqwgKCf2g8=;
        b=DG4XoTuh3p+Gu9D+F4OrW8MmuZMiwdugoe8gCTuSW2EAHLAYjp0QzV6qSHIwnv+Bw/
         j9/ziaaxnpTalar8341DTcd1+dDFVaRgZeJJswl5+AEBFrn/XrWOWsVsX5/+3iDHcNeN
         fC6PwWhCffpOlFJ1H2C78yhYpehXu2QIcvRBm+j0HkfD8yc2IpGHH3bbuox4PZB0efST
         He7Rm0rUuci63zVs/aW8XWaw3VHehiCEA/bpNxreh//S9imo1/td8bSW+7tKMfBQYjpX
         MewXO43m5sxkcDNL2KE0HBdzGFbF6M+IaNReOcG6TwD5/oUU5p8ZKCPaARtX0FE2OoCB
         dxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=c3o9BUJSdFDURbaPvsof0q2JaknWm3G4aaqwgKCf2g8=;
        b=FLdS9j5tpX1/MYhlqiiPMXr9wKaICOnex58MMxv9BNCJL6GuYO3GXAeLjBFY8oDio9
         moOGTAlC30ziVve92HtodjmVoKuQ1yUc0sWQ4BGD3q4QV0NBGJkgg5cpDWtTBWwiYs71
         6Y4fWT636q8JS2rCbJMA9olDpSBrlSCsGohwNAd/ds8JUeJ4qFx2nyi6obSUKVrUfmLo
         dJElueQXFin4QpbD5/DG5A9jxxvhaHXMAi1s4CPVVJNPvjjqB/FIEDeMHk9fHnn/cfpr
         /cLOk2qEcrO8LGlXENo+A1WLw5yh5wakX7sK3xxh3EiKbRVeJcmZzPimj5DeWYju+t7A
         riUA==
X-Gm-Message-State: AOAM5306gfgXMiYh2e9wy0CGZJaJ+6azhvdtP2O8X0qWabmWv+8JSilE
        Opi2i+8NLTDlbYXZ+dqzWuVYNpzZ3hg=
X-Google-Smtp-Source: ABdhPJyoA2rNfNgXfiEakT8m5+n/maXmEGc7hzE9htqNhwDYNo7a+jKttNing57tGgEtttaqdCKGyw==
X-Received: by 2002:a17:902:14f:b029:d2:562d:e84 with SMTP id 73-20020a170902014fb02900d2562d0e84mr1270355plb.64.1601951994603;
        Mon, 05 Oct 2020 19:39:54 -0700 (PDT)
Received: from google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id x4sm1372073pfm.86.2020.10.05.19.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 19:39:53 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 6 Oct 2020 11:39:49 +0900
From:   namhyung@kernel.org
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Al Grant <al.grant@foss.arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf inject: Flush ordered events on FINISHED_ROUND
Message-ID: <20201006023949.GA1682192@google.com>
References: <20201002130317.1356440-1-namhyung@kernel.org>
 <20201004195239.GA217601@krava>
 <CAM9d7cgsxkefHAgyMf-GoP4-OdSsaRmhSGLwPMoYn=-c9YXxDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM9d7cgsxkefHAgyMf-GoP4-OdSsaRmhSGLwPMoYn=-c9YXxDw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Fri, Oct 02, 2020 at 10:03:17PM +0900, Namhyung Kim wrote:
> > > Below measures time and memory usage during the perf inject and
> > > report using ~190MB data file.
> > >
> > > Before:
> > >   perf inject:  11.09 s,  382148 KB
> > >   perf report:   8.05 s,  397440 KB
> > >
> > > After:
> > >   perf inject:  16.24 s,   83376 KB
> > >   perf report:   7.96 s,  216184 KB
> > >
> > > As you can see, it used 2x memory of the input size.  I guess it's
> > > because it needs to keep the copy for the whole input.  But I don't
> > > understand why processing time of perf inject increased..

Measuring it with time shows:

           before       after
  real    11.309s     17.040s
  user     8.084s     13.940s
  sys      6.535s      6.732s

So it's user space to make the difference.  I've run perf record on
both (with cycles:U) and the dominant function is same: queue_event.
(46.98% vs 65.87%)

It seems the flushing the queue makes more overhead on sorting.

Thanks
Namhyung
