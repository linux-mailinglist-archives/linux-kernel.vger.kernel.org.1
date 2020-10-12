Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9526228BACB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389092AbgJLO0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388589AbgJLO0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:26:16 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B565A2076C;
        Mon, 12 Oct 2020 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602512775;
        bh=T18qq6n77M14K4aDgEWW3a4aROVcFCp95O5Tl5EbYQc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n4e71GzUhq2ZKR3S5av77GyaGXDfHFRFkw0jQkSk6tAb32pDCstgvo6DyxrCxiwct
         LqbP1Efhrb4dvE+e7Cutt+Ig6bQ/ngsm1LKZfOy+WvVO42BveT75+a4pX5EPBNJbvE
         E/KlVDyTCfc8L7rgbD9rZbCkUpb+dyLqM4ZaQ1bA=
Message-ID: <43b10ad23a80ee5ae9f10b6d47d7944b6b14a25d.camel@kernel.org>
Subject: Re: [PATCH v3 1/2] tracing: support "bool" type in synthetic trace
 events
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Mon, 12 Oct 2020 09:26:13 -0500
In-Reply-To: <20201012101527.6df53dda@gandalf.local.home>
References: <20201009220524.485102-1-axelrasmussen@google.com>
         <20201009220524.485102-2-axelrasmussen@google.com>
         <20201012101527.6df53dda@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Looks ok to me.

Acked-by: Tom Zanussi <zanussi@kernel.org>

Thanks,

Tom


On Mon, 2020-10-12 at 10:15 -0400, Steven Rostedt wrote:
> Tom,
> 
> Can you ack this patch for me?
> 
> -- Steve
> 
> 
> On Fri,  9 Oct 2020 15:05:23 -0700
> Axel Rasmussen <axelrasmussen@google.com> wrote:
> 
> > It's common [1] to define tracepoint fields as "bool" when they
> > contain
> > a true / false value. Currently, defining a synthetic event with a
> > "bool" field yields EINVAL. It's possible to work around this by
> > using
> > e.g. u8 (assuming sizeof(bool) is 1, and bool is unsigned; if
> > either of
> > these properties don't match, you get EINVAL [2]).
> > 
> > Supporting "bool" explicitly makes hooking this up easier and more
> > portable for userspace.
> > 
> > [1]: grep -r "bool" include/trace/events/
> > [2]: check_synth_field() in kernel/trace/trace_events_hist.c
> > 
> > Acked-by: Michel Lespinasse <walken@google.com>
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  kernel/trace/trace_events_synth.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_events_synth.c
> > b/kernel/trace/trace_events_synth.c
> > index 8e1974fbad0e..8f94c84349a6 100644
> > --- a/kernel/trace/trace_events_synth.c
> > +++ b/kernel/trace/trace_events_synth.c
> > @@ -234,6 +234,8 @@ static int synth_field_size(char *type)
> >  		size = sizeof(long);
> >  	else if (strcmp(type, "unsigned long") == 0)
> >  		size = sizeof(unsigned long);
> > +	else if (strcmp(type, "bool") == 0)
> > +		size = sizeof(bool);
> >  	else if (strcmp(type, "pid_t") == 0)
> >  		size = sizeof(pid_t);
> >  	else if (strcmp(type, "gfp_t") == 0)
> > @@ -276,6 +278,8 @@ static const char *synth_field_fmt(char *type)
> >  		fmt = "%ld";
> >  	else if (strcmp(type, "unsigned long") == 0)
> >  		fmt = "%lu";
> > +	else if (strcmp(type, "bool") == 0)
> > +		fmt = "%d";
> >  	else if (strcmp(type, "pid_t") == 0)
> >  		fmt = "%d";
> >  	else if (strcmp(type, "gfp_t") == 0)
> > --
> > 2.28.0.1011.ga647a8990f-goog
> 
> 

