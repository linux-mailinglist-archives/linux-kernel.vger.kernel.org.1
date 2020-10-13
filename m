Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61BA28D201
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389352AbgJMQQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389220AbgJMQQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:16:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E52925275;
        Tue, 13 Oct 2020 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602605771;
        bh=SQEwaPmyt7NIXIl/JqjLyiYJmyTqtk504hHzkeawI7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kWzX0J8hxUKs4ZQSiYdns6oNcPvhOhN6r7FQ4SFaAzEVVGdi/syK2yMEk8pjWjW5b
         KE6nxxo+JmFVNk9t4BDOHVK2UNFl6Y42m6DZ25pKVHmURzSkUfH0cmAIJe6SMDmeMF
         98ZhDUMNIjvmaLys6PJGCCmjvShUUs2JBYksdU4Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 665B44047F; Tue, 13 Oct 2020 13:16:09 -0300 (-03)
Date:   Tue, 13 Oct 2020 13:16:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf c2c: Update usage for showing memory events
Message-ID: <20201013161609.GI1063281@kernel.org>
References: <20201011121022.22409-1-leo.yan@linaro.org>
 <20201012091348.GC1099489@krava>
 <CAP-5=fWDwtL39EY0ucxeWk4kAuJYe=ZMCU9Z9Y-bVws+uBZ62g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWDwtL39EY0ucxeWk4kAuJYe=ZMCU9Z9Y-bVws+uBZ62g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 12, 2020 at 08:25:42AM -0700, Ian Rogers escreveu:
> On Mon, Oct 12, 2020 at 2:13 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Sun, Oct 11, 2020 at 08:10:22PM +0800, Leo Yan wrote:
> > > Since commit b027cc6fdf1b ("perf c2c: Fix 'perf c2c record -e list' to
> > > show the default events used"), "perf c2c" tool can show the memory
> > > events properly, it's no reason to still suggest user to use the
> > > command "perf mem record -e list" for showing events.
> > >
> > > This patch updates the usage for showing memory events with command
> > > "perf c2c record -e list".
> > >
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> >
> > thanks,
> > jirka
> 
> Acked-by: Ian Rogers <irogers@google.com>


Thanks, applied.

- Arnaldo

