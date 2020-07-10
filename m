Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D7821B4CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 14:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGJMO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 08:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgGJMO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:14:27 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0815F20748;
        Fri, 10 Jul 2020 12:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594383267;
        bh=+JcSCW1Yk7MXsggHid4vcPDCUM9s1PaRKkB2XXsOmuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vp9AR8EaV4pHPfWwjgF2Jxv2Opp253jtwUddnQ3Sp9ZaoGsM72b9ooo+7vlc6EQS9
         33KlKxi1/v4JpMGqeu7BE9bQff5RO4OP3r+fgLHeu2wjsPzqa9ukbT2q0tqHWtV5en
         w9CUnLk59+enz+894X+2X3QgCbv2zFgMuPm0UalI=
Date:   Fri, 10 Jul 2020 21:14:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4/4] perf-probe: Warn if the target function is GNU
 Indirect function
Message-Id: <20200710211422.9464c12f2e6ec02ef5dec1a6@kernel.org>
In-Reply-To: <20200710111512.GK874@linux.vnet.ibm.com>
References: <159428201109.56570.3802208017109058146.stgit@devnote2>
        <159428205174.56570.17588311835868886287.stgit@devnote2>
        <20200710111512.GK874@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 16:45:12 +0530
Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> * Masami Hiramatsu <mhiramat@kernel.org> [2020-07-09 17:07:31]:
> 
> > Reported-by: Andi Kleen <andi@firstfloor.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-event.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 1e95a336862c..671176d39569 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -379,6 +379,11 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
> >  			address = sym->start;
> >  		else
> >  			address = map->unmap_ip(map, sym->start) - map->reloc;
> > +		if (sym->type == STT_GNU_IFUNC) {
> > +			pr_warning("Warning: The probe address (0x%lx) is in a GNU indirect function.\n"
> > +				"This may not work as you expected unless you intend to probe the indirect function.\n",
> > +				(unsigned long)address);
> > +		}
> 
> Are these GNU indirect functions possible in kernel? If not we could move
> this warning under if (uprobes)

OK, I'll move it under if (uprobes).

> 
> Also instead of printing the address, can we print the pp->function?

Hmm, OK. But it may not help user because the pp->function will the name
specified by user...

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
