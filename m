Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F490281DFE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgJBWEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBWEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:04:49 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C11320719;
        Fri,  2 Oct 2020 22:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601676288;
        bh=EDDwAOV0ZwyLNQlXhxnuTN6DGHN2lm7tbc8rdKw8T34=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=1lN6jaNHJds8vh4DCPahKoVdOq3+GNhZJXt0rtwWahwlFu1KrLOHAZzN56NMQQpXg
         s2QjsspYb37CWL4Y59B4kyEWePh4Iw6NGeSjOhtHrXOE7bIkmcXmxZ4tqpSbR2B+pb
         FWMBq5HvcWfUXK8b77INoTtGVDMf6bBklnAShm+w=
Message-ID: <75577192da2769b982b748305ad5609d94bd9bcf.camel@kernel.org>
Subject: Re: [PATCH v3 1/3] tracing: Change STR_VAR_MAX_LEN
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 02 Oct 2020 17:04:46 -0500
In-Reply-To: <20201002154417.320ad78b@gandalf.local.home>
References: <cover.1601588066.git.zanussi@kernel.org>
         <34a494e502fe1364b07896ef4d76f1fbbb8d1d1a.1601588066.git.zanussi@kernel.org>
         <20201002154417.320ad78b@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, 2020-10-02 at 15:44 -0400, Steven Rostedt wrote:
> On Thu,  1 Oct 2020 16:46:44 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > 32 is too small for this value, and anyway it makes more sense to
> > use
> > MAX_FILTER_STR_VAL, as this is also the value used for variable-
> > length
> > __strings.
> > 
> > Tested-by: Axel Rasmussen <axelrasmussen@google.com>
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  kernel/trace/trace_synth.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_synth.h
> > b/kernel/trace/trace_synth.h
> > index ac35c45207c4..5166705d1556 100644
> > --- a/kernel/trace/trace_synth.h
> > +++ b/kernel/trace/trace_synth.h
> > @@ -7,7 +7,7 @@
> >  #define SYNTH_SYSTEM		"synthetic"
> >  #define SYNTH_FIELDS_MAX	32
> >  
> > -#define STR_VAR_LEN_MAX		32 /* must be multiple of
> > sizeof(u64) */
> > +#define STR_VAR_LEN_MAX		MAX_FILTER_STR_VAL /* must be
> > multiple of sizeof(u64) */
> 
> Hmm, this requirement is now passed to MAX_FILTER_STR_VAL, but
> there's no
> mention of it there. I guess we should have a
> 
> 	BUILD_BUG_ON(STR_VAR_LEN_MAX & (sizeof(u64) - 1));
> 
> in C code somewhere.

Good point.  I'll add that in the next version.

Thanks,

Tom


