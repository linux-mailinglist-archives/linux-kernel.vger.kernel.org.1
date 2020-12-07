Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B03A2D16BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgLGQp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgLGQp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:45:59 -0500
Date:   Mon, 7 Dec 2020 13:45:26 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607359518;
        bh=jBiVQIaWWzg/nGbyXXx18bCxNLJXMIp2AwZ7+5Oa+hE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnKunEAiIyyd9wVCwgXOWX4CjlHxVWjsbqTtvF+VRbHBpNKBk5Ip5P383kRx5WXpF
         tclyrk+5fm8Y2eu1y+BjTMC8emg88XjThtr7Jr6EI2oPjfQq2/cUGlOhvE4CvvORjV
         j+B6vz4Q3Zkn3jbUFGgtErcDnxmIxLg04kVt1fFOJtOYcwG1v8+Kcs4GdTaC97iPfu
         eopMLHZIRKlA6SLrsmJRciGs/kH+6vPIUaeftF92UnHjO5k54oCwza+aCibzwS7SUH
         jF2V5denM3TFr6WunAzvxV1WLIw7H6OjzzfE0iukBAVmQGMZz+aXaIFWAOWiLlQCUh
         krsRf+TS7NSLw==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH -next] perf util: Fix memory leak in __parse_regs()
Message-ID: <20201207164526.GH125383@kernel.org>
References: <20200703093344.189450-1-zhengzengkai@huawei.com>
 <20200703103106.GA3261456@krava>
 <0e52c7be-ca81-2f4d-ee2f-8f9ced382f60@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e52c7be-ca81-2f4d-ee2f-8f9ced382f60@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 27, 2020 at 03:45:40PM +0800, Zheng Zengkai escreveu:
> Ping...

Thanks, applied.

- Arnaldo
 
> > On Fri, Jul 03, 2020 at 05:33:44PM +0800, Zheng Zengkai wrote:
> > > when using perf record option '-I' or '--user-regs='
> > > along with argument '?' to list available register names,
> > > memory of variable 'os' allocated by strdup() needs to be released
> > > before __parse_regs() returns, otherwise memory leak will occur.
> > > 
> > > Fixes: bcc84ec65ad1 ("perf record: Add ability to name registers to record")
> > > Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > thanks,
> > jirka
> > 
> > > ---
> > >   tools/perf/util/parse-regs-options.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
> > > index e687497b3aac..a4a100425b3a 100644
> > > --- a/tools/perf/util/parse-regs-options.c
> > > +++ b/tools/perf/util/parse-regs-options.c
> > > @@ -54,7 +54,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
> > >   #endif
> > >   				fputc('\n', stderr);
> > >   				/* just printing available regs */
> > > -				return -1;
> > > +				goto error;
> > >   			}
> > >   #ifdef HAVE_PERF_REGS_SUPPORT
> > >   			for (r = sample_reg_masks; r->name; r++) {
> > > -- 
> > > 2.20.1
> > > 
> > .
> > 

-- 

- Arnaldo
