Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406272809AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbgJAVuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733191AbgJAVuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:50:51 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7702F206A2;
        Thu,  1 Oct 2020 21:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601589050;
        bh=vvAEf2Gi2d43VX0OLIxuwTV1L6w4EYfWAmQbzKPRMN4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZPW18z6jIBI4V2WKcUXKGGKZ3S+8gj+30rHpH1XgJ97db3vaMUMrfFL58RNvZnqKI
         GUi6Ti48cLeFR22/VSSHbKmrJRg5kQI9Nhx7WN+ccQ3rxo3TpOeA7uNK3omWzExsQn
         Cz8FI/zCiA4oI7kCSNiu+t25VSY2DATNJhENeVfA=
Message-ID: <928fc2ba78e1319704c4ecdbf20d87c9f221ac6c.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] tracing: Change STR_VAR_MAX_LEN
From:   Tom Zanussi <zanussi@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Oct 2020 16:50:49 -0500
In-Reply-To: <CAJHvVchLJ4_Oha6bXa2k26JAy6hMVmOZpxfZRGvRPEUZahd5dw@mail.gmail.com>
References: <cover.1601490263.git.zanussi@kernel.org>
         <8616d1a2485fee1ae71d27d7c598acf1c9e32abe.1601490263.git.zanussi@kernel.org>
         <CAJHvVchLJ4_Oha6bXa2k26JAy6hMVmOZpxfZRGvRPEUZahd5dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On Wed, 2020-09-30 at 15:45 -0700, Axel Rasmussen wrote:
> I still get the same WARN_ON behavior when trying to use bpftrace.
> But, I spent some time today reading through that call path, and at
> this point I'm convinced that it's the version of bpftrace I'm using
> which is slightly broken, not the kernel in this case. (To be fair,
> I'm trying to use some unreleased tip-of-tree version of it, with
> some
> not-yet-merged patches, and some extra hacks on top of all that, so
> it's not particularly surprising...)
> 
> In my experiments with just the synthetic event + histogram triggers,
> this patchset works as expected for my use case.
> 
> So (for the whole series, not just this one patch):
> 
> Tested-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks!

Tom

> 
> On Wed, Sep 30, 2020 at 11:41 AM Tom Zanussi <zanussi@kernel.org>
> wrote:
> > 
> > 32 is too small for this value, and anyway it makes more sense to
> > use
> > MAX_FILTER_STR_VAL, as this is also the value used for variable-
> > length
> > __strings.
> > 
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
> >  #define SYNTH_SYSTEM           "synthetic"
> >  #define SYNTH_FIELDS_MAX       32
> > 
> > -#define STR_VAR_LEN_MAX                32 /* must be multiple of
> > sizeof(u64) */
> > +#define STR_VAR_LEN_MAX                MAX_FILTER_STR_VAL /* must
> > be multiple of sizeof(u64) */
> > 
> >  struct synth_field {
> >         char *type;
> > --
> > 2.17.1
> > 

