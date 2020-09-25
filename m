Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF7279104
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgIYSpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:45:40 -0400
Received: from one.firstfloor.org ([193.170.194.197]:41384 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYSpk (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:45:40 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 14:45:39 EDT
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 5723A867DA; Fri, 25 Sep 2020 20:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1601058975;
        bh=uy3Spl8pHcJe91IvAvg/89FyMbUxeI3OW+LkxFGW5TQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EiNiWhnoVSyE96tuthQ4FHdc3+ba22T1PlRB5dKkczDA/snzhzwMTRpkiOpgIOhoU
         W/bS+EnZRO/36unJwgHcXutp5wCwC9F9VX3HZp48+nwaazh6uy+l1A/78ecMGJLl6/
         3myblR0G9+vigzzllKXkdsgn08XtT+JhSZgJrbKs=
Date:   Fri, 25 Sep 2020 11:36:15 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Kan Liang <kan.liang@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 1/2] perf vendor events: Update CascadelakeX events to
 v1.08
Message-ID: <20200925183614.czoqgq2kcttzfm2g@two.firstfloor.org>
References: <20200922031918.3723-1-yao.jin@linux.intel.com>
 <20200922031918.3723-2-yao.jin@linux.intel.com>
 <20200922194232.GA2505291@kernel.org>
 <4db737f2-0705-5183-6971-9031acfd123b@linux.intel.com>
 <20200925180527.GA2883319@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925180527.GA2883319@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks, it now works, but then... You forgot to add the Cc: entries for
> all the people in your actual e-mail Cc: list, and also the
> Reviewed-by: from Andy, I had to do it all manually, so when I applied
> your attachments with 'git am' I needed to go on and manually collect
> all the Cc, Reviewed-by and Acked-by tags.

For the event updates we should just use git pulls in my opinion.

They are just too large for the normal review procedures, and usually
don't really benefit much from community review anyways because they
are essentially hardware documentation.

Should just name intel / amd / etc. event list maintainers and you
could accept pulls from them.

-Andi
