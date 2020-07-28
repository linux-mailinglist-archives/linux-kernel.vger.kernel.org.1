Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7BF2309F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgG1M1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 08:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgG1M1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:27:01 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39C43206D4;
        Tue, 28 Jul 2020 12:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939221;
        bh=N4SOQRKaRTIyJZBjBFixSfY3mkt05IKtAPjTslO6urY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pduy+mKNwv04ARmILR0f7B+iaiH+Cq9UdVAP9MmfnNV5iaclkUrnVVeGG78bR2c93
         gzNDqIQ72bCdIKXPisvjzpkKLfJ/ztFCBZHglkxFSxaY3cYlFTsihWlfqwYuoOG0Lo
         mtEH35O2CZHi2uPbmsW13gTGtbQinVfwqDvLYMFo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 54747404B1; Tue, 28 Jul 2020 09:26:58 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:26:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 01/19] perf metric: Fix memory leak in expr__add_id
 function
Message-ID: <20200728122658.GH40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-2-jolsa@kernel.org>
 <CAP-5=fWdgFCBj0r4nVgEXnwOpckCXOb-FSTqexuDw=YiNnH+9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWdgFCBj0r4nVgEXnwOpckCXOb-FSTqexuDw=YiNnH+9Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 19, 2020 at 02:41:46PM -0700, Ian Rogers escreveu:
> On Sun, Jul 19, 2020 at 11:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Arnaldo found that we don't release value data in case the
> > hashmap__set fails. Releasing it in case of an error.
> >
> > Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
