Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275B62309C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 14:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgG1MPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 08:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgG1MPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:15:12 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01352065E;
        Tue, 28 Jul 2020 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595938511;
        bh=Rpq2jtTAEGKxvS9IkttiSEtUwi1P5Vuf47wcS3+ndws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1GTMsqCD4NQYAS6ghj/54ObEdKwy6UZtI8OhyXmu0zU9+wPz5IGkJhMNsn/7qyUs
         bVR4A7uoLcPKkOPol7vAgGw5aBjGMgmv1y1gd3WIdI7y5j2bDdl/z4Z358lcokhPIU
         wnTSr/E9ES5/jRFPhhmbuuFFiR3QDjsw6oCC6kLM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DD725404B1; Tue, 28 Jul 2020 09:15:08 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:15:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 1/2] perf tools: Allow r0x<HEX> event syntax
Message-ID: <20200728121508.GE40195@kernel.org>
References: <20200725121959.1181869-1-jolsa@kernel.org>
 <CAP-5=fU5HOmOR6XekgZsHG1a1wzh=1=kdFsddOYbGYK_U4fG7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU5HOmOR6XekgZsHG1a1wzh=1=kdFsddOYbGYK_U4fG7A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jul 25, 2020 at 09:40:55AM -0700, Ian Rogers escreveu:
> On Sat, Jul 25, 2020 at 5:20 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to specify raw event with 'r0<HEX>' syntax within
> > pmu term syntax like:
> >
> >   -e cpu/r0xdead/
> >
> > It will be used to specify raw events in cases where they conflict
> > with real pmu terms, like 'read', which is valid raw event syntax,
> > but also a possible pmu term name as reported by Jin Yao.
> >
> > Reported-by: Jin Yao <yao.jin@linux.intel.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
