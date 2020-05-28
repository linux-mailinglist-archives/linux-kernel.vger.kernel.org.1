Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442321E523D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 02:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgE1AbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 20:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE1AbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 20:31:24 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEED4207CB;
        Thu, 28 May 2020 00:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590625884;
        bh=chuSr3FoCBRQngQ6m8+G1nqucLsORSNtGxzZXnM/qHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k38BlaGnj/bNSVWELhnzWpEXGSXVkELh6GkXp/X8oFNGz9TmO5GfZiEGCYgIcQQ+T
         Jk+srUGzakC3OfUU6hj6zwVWYIO+Z+jUzCQ9kmo/0ClgaHAgl8IeFd3k7ZObx2/h6u
         +miY1tc01t7h51Pmn+eFKE7T+4MUqWAmQ6A811C0=
Date:   Thu, 28 May 2020 09:31:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 03/15] kprobes: Add symbols for kprobe insn pages
Message-Id: <20200528093117.181bf843a2f8f2c39fcf9860@kernel.org>
In-Reply-To: <20200527174345.GB706478@hirez.programming.kicks-ass.net>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
        <20200512121922.8997-4-adrian.hunter@intel.com>
        <20200527174345.GB706478@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 19:43:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, May 12, 2020 at 03:19:10PM +0300, Adrian Hunter wrote:
> > @@ -2179,6 +2181,49 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
> >  	return 0;
> >  }
> >  
> > +int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
> > +			     unsigned long *value, char *type, char *sym)
> > +{
> > +	struct kprobe_insn_page *kip;
> > +	int ret = -ERANGE;
> > +
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(kip, &c->pages, list) {
> > +		if ((*symnum)--)
> > +			continue;
> > +		strlcpy(sym, c->sym, KSYM_NAME_LEN);
> > +		*type = 't';
> > +		*value = (unsigned long)kip->insns;
> > +		ret = 0;
> > +		break;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return ret;
> > +}
> 
> This fails on sparc64-defconfig.
> 
> In file included from ../include/linux/kprobes.h:19:0,
>                  from ../kernel/kprobes.c:21:
> ../kernel/kprobes.c: In function 'kprobe_cache_get_kallsym':
> ../include/linux/rculist.h:382:49: error: dereferencing pointer to incomplete type 'struct kprobe_insn_page'
> 
> Please provide a new patch.

Ah, yes. Since some archs doesn't require special out-of-line
trampoline, we need to check __ARCH_WANT_KPROBES_INSN_SLOT,
and if not, kprobe_cache_get_kallsym() has do nothing and 
return -ERANGE.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
