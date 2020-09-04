Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAD925DFC9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 18:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIDQ2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 12:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgIDQ2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:28:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25252206A5;
        Fri,  4 Sep 2020 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599236913;
        bh=PoXlxmUYtEW48Hs13X+oAR508DfbOG7gjAVNJtRf/Sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2sdj1N8AGfaOTxGBg3yHvSY8xJMZi4nOsJprutMjAFsc/wIf0D26e0UHuCskLGdZ
         EhOl1qON5Xnd2cGXal7g5dSeaXJXuZPsFF5lUmsHN/XZroEpZW9c/SFvsvcEf/T5sr
         DDL1Kt17S1x4b39Rg19YTma1TaJGxyEs5p8UKYMI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3A67A40D3D; Fri,  4 Sep 2020 13:28:31 -0300 (-03)
Date:   Fri, 4 Sep 2020 13:28:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] perf metric: Fix some memory leaks
Message-ID: <20200904162831.GU3495158@kernel.org>
References: <20200904032142.516333-1-namhyung@kernel.org>
 <CAP-5=fXjeCBemNivMb6+9AH-PETTqTghaZHniOohd_1ms1rU2A@mail.gmail.com>
 <CAM9d7cgQAj-md=ZPKGD7iHEBYDnFqCfB1CO8moRih52MFoP6XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgQAj-md=ZPKGD7iHEBYDnFqCfB1CO8moRih52MFoP6XQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 04, 2020 at 10:39:50PM +0900, Namhyung Kim escreveu:
> On Fri, Sep 4, 2020 at 1:02 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Sep 3, 2020 at 8:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > I found some memory leaks while reading the metric code.  Some are
> > > real and others only occur in the error path.
> >
> > Thanks Namhyung! Is it possible to get test coverage?
> > Ian
> 
> Not sure what you want..
> 
> As I found it from code inspection I don't know if there's a test covering this.
> 
> But as far as I can see, 2 of them are on the error path so maybe not easy
> to add a test, other one is called from perf list code, and the last one is on
> the normal code path so any test should cover it.

Humm, I assume all those fixes were for csets in a single Linux version,
right? Otherwise I think it'd be better to have a fix per Fixes tag, so
that they would go to the kernel sources where those bugs were fixed.

Thanks!

- Arnaldo
