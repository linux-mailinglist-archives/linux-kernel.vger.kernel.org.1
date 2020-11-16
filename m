Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C53A2B4C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbgKPRKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729841AbgKPRKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:10:18 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDCDB207BC;
        Mon, 16 Nov 2020 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605546618;
        bh=uyxtp8pl/baUuN3tyAuMlU0OeRREEZTtqZFl5mU/Tqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqNcOXG2ffBgaW3j+M6c4iPLi9iYNm7J1zru0mqpOTo0UJvpRmQ5BsGuyHEN6PB5E
         nRX67SjZIsluA+X9kcZ/BbUrhHPt4U4xGqYUnsE1KlVaNIyFZ90O07N6I5k2i8d7p7
         pnWMI7c36YPStJNjhdmJ90IHI220zvoX802+Fb88=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E5D62411D1; Mon, 16 Nov 2020 14:10:15 -0300 (-03)
Date:   Mon, 16 Nov 2020 14:10:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf expr: Force encapsulation on expr_id_data
Message-ID: <20201116171015.GH509215@kernel.org>
References: <20200826153055.2067780-1-irogers@google.com>
 <20200826155733.GB783610@krava>
 <4b6bc995-d468-3137-f00f-3867233740a3@linux.ibm.com>
 <CAP-5=fUdK2Zuv9BMpkRw669n_SvQ3kDa0s0RA=Hj1GUtqqw0YQ@mail.gmail.com>
 <20200904162920.GV3495158@kernel.org>
 <CAP-5=fW7bF4PJpNQnDnf--RVtmYQ+nKC-OoU_wYjaR4cuAXZfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW7bF4PJpNQnDnf--RVtmYQ+nKC-OoU_wYjaR4cuAXZfg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 13, 2020 at 10:38:28AM -0800, Ian Rogers escreveu:
> On Fri, Sep 4, 2020 at 9:29 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> wrote:
> 
> > Em Thu, Sep 03, 2020 at 10:53:16PM -0700, Ian Rogers escreveu:
> > > On Thu, Aug 27, 2020 at 12:00 AM kajoljain <kjain@linux.ibm.com> wrote:
> > > >
> > > >
> > > >
> > > > On 8/26/20 9:27 PM, Jiri Olsa wrote:
> > > > > On Wed, Aug 26, 2020 at 08:30:55AM -0700, Ian Rogers wrote:
> > > > >> This patch resolves some undefined behavior where variables in
> > > > >> expr_id_data were accessed (for debugging) without being defined. To
> > > > >> better enforce the tagged union behavior, the struct is moved into
> > > > >> expr.c and accessors provided. Tag values (kinds) are explicitly
> > > > >> identified.
> > > >
> > > > Reviewed-By: Kajol Jain<kjain@linux.ibm.com>
> > > >
> > > > Thanks,
> > > > Kajol Jain
> > > > >>
> > > > >> Signed-off-by: Ian Rogers <irogers@google.com>
> > > > >
> > > > > great, thanks for doing this
> > > > >
> > > > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > > > >
> > > > > jirka
> > > > >
> > >
> > > Thanks for the reviews! Arnaldo could this get merged? Thanks!
> >
> > I'll get this and the other outstanding patches into perf/core soon as I
> > got urgent stuff already merged by Linus,
> >
> > Thanks!
> >
> > - Arnaldo
> >
> 
> I just spotted this wasn't merged and will conflict with:
> https://lore.kernel.org/lkml/20201113001651.544348-1-irogers@google.com/
> I can fix that patch when this lands.

Thanks, applied, will test build and push publicly today.

- Arnaldo
