Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B56279259
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIYUkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgIYUka (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:40:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32EB221E5;
        Fri, 25 Sep 2020 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601061665;
        bh=lPTczZAIg0pHtupCGmDV69Ki+l2+WiaRhBxnok1U9hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x5oXhFyVZDamgIVthuUoQkxJFKW9k709+7oIBy4Fwn7sJT9A6RxBbtktV+RyEm9GP
         V4gJiUwI+WOzdFyRilu7OxcSoHyEiqY66AZj5ot5pXcsyPBMnVcOad6zkprMt/jD1A
         NkhoH/jW6Phe2EboKn0hwjkml4Tfsxb3LNXBOtNo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E1AD400E9; Fri, 25 Sep 2020 16:21:03 -0300 (-03)
Date:   Fri, 25 Sep 2020 16:21:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux-kernel@vger.kernel.org, Kan Liang <kan.liang@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 1/2] perf vendor events: Update CascadelakeX events to
 v1.08
Message-ID: <20200925192103.GC2883319@kernel.org>
References: <20200922031918.3723-1-yao.jin@linux.intel.com>
 <20200922031918.3723-2-yao.jin@linux.intel.com>
 <20200922194232.GA2505291@kernel.org>
 <4db737f2-0705-5183-6971-9031acfd123b@linux.intel.com>
 <20200925180527.GA2883319@kernel.org>
 <20200925183614.czoqgq2kcttzfm2g@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925183614.czoqgq2kcttzfm2g@two.firstfloor.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 25, 2020 at 11:36:15AM -0700, Andi Kleen escreveu:
> > Thanks, it now works, but then... You forgot to add the Cc: entries for
> > all the people in your actual e-mail Cc: list, and also the
> > Reviewed-by: from Andy, I had to do it all manually, so when I applied
> > your attachments with 'git am' I needed to go on and manually collect
> > all the Cc, Reviewed-by and Acked-by tags.
> 
> For the event updates we should just use git pulls in my opinion.
> 
> They are just too large for the normal review procedures, and usually
> don't really benefit much from community review anyways because they
> are essentially hardware documentation.
> 
> Should just name intel / amd / etc. event list maintainers and you
> could accept pulls from them.

That isn't that important, i.e. if I do it from e-mail manually or doing
a git pull.

What is important is that one person submits, another provides some
stamp, the stamp is collected, patch is applied and build tested, life
goes on.

b4 should fix this all up, but attachments, in this case, seems to be
needed due to the content having such long lines, right?

- Arnaldo
