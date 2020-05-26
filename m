Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D91DB513
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 15:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgETNch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 09:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgETNch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:32:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD72720748;
        Wed, 20 May 2020 13:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589981557;
        bh=zz40LEwDhy/bBwHQxPzcfAFOOwMH3tx/OLlUA8WvHJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mE8ciLVA7eX43/9pkSddLPTGsdw3V9YdKJxG3i71IlEA8ehlkaeDYF4+bkwNqgqkP
         gcXA8ByKYyydYXeKVuTAvphtf11QoBUyXZt3QP8LfCflNAAA5iV3/tHxpReSojfHh0
         zGDPj7N2N+VItrm7AKDtfh8p/2hwYYlWwtzqyQcg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 787CF40AFD; Wed, 20 May 2020 10:32:34 -0300 (-03)
Date:   Wed, 20 May 2020 10:32:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf stat: Fail on extra comma while parsing events
Message-ID: <20200520133234.GF32678@kernel.org>
References: <20200520074050.156988-1-jolsa@kernel.org>
 <CAP-5=fWaqofns-K1_q=0iAZOF1D0CVDEyE6v6r+3L=Sd9Mto6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWaqofns-K1_q=0iAZOF1D0CVDEyE6v6r+3L=Sd9Mto6w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 20, 2020 at 12:51:24AM -0700, Ian Rogers escreveu:
> On Wed, May 20, 2020 at 12:41 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Ian reported that we allow to parse following:
> >
> >   $ perf stat -e ,cycles true
> >
> > which is wrong and we should fail, like we do with this fix:
> >
> >   $ perf stat -e ,cycles true
> >   event syntax error: ',cycles'
> >                         \___ parser error
> >
> > The reason is that we don't have rule for ',' in 'event'
> > start condition and it's matched and accepted by default
> > rule.
> >
> > Adding scanner debug support (that Ian already added for
> > expr code), which was really useful for finding this. It's
> > enabled together with bison debug via 'make PARSER_DEBUG=1'.
> >
> > Reported-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
