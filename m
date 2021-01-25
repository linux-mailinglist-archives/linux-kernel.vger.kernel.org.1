Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F5030222D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 07:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbhAYGjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 01:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbhAYGg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 01:36:26 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA8C061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 22:35:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o10so16041137lfl.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 22:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1FaOCMVhBrKvV/kr2ZvUjYEuk47vbJOU/enSL7Dyws=;
        b=vYow9yz+IIBcGRtOdnaNWdXFbeTQAPkd2e+luHTzVDeJGr3mLeTwC1HcrM+nxFw/+N
         j4C24OZq8UCqdi/4q59X6yC/pSoN0y6pVcbifAULmLsFi/3VE+3xghCcdFmzFiaglS0k
         1rM/n7knpwlQL1lpyDYokhC6hfSqI3zUKY/gaMEfVXB+qh47W8uLY952+JoIM5A5El9T
         0tEJZ/Cb1LK64G32jSA1gQLcWUxlsnQz5snhW17iMbq2N4DUWyl6ff6tMxXQCk9m8Vr4
         GUEvjBosqtGbzo+sarQ5vGhZC55fXgkWuuupPdOc+EGxK6SxOQTJQjmiO3808Qar7OkY
         5qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1FaOCMVhBrKvV/kr2ZvUjYEuk47vbJOU/enSL7Dyws=;
        b=GXGwanEXFHOzw3CLApi9vIW8j6RRKXkYkgueA5a7IKN7WCD2na1mk+pC36GztCqUlf
         tFM6GjJduQTL5rYBKEAFJSrp1UsoMz8bdnIBsYO44gVL+UgdaQk5LNC5v+w2jiLfl6Cx
         KDZJzTT4CPCv2Dgx0ogenrBrrGnEs3DQHaSa83RveboivRbcjjK0OKM/N7txiY0kHmUF
         DWRIdRdnn+gTuRPkM0DLZo5r2YxlAIY5tAucGM+G033PiWkpmoTAXrVUpqEJrQOOMb41
         A9HS2nEGcCCthHl77+UU3WLentjxYEWbobHX6yj04TQhs10ONj7PfnTni68AtZNfeNZL
         Oujw==
X-Gm-Message-State: AOAM530h7VCK0BOwAWuqRSJ/VuGelcwBZrCIzkQXvW37uF2qj4KwvBD1
        w4XfQ90Rer22nkfImql9hvRVrdYfm/6GjL1K4ZGcTA==
X-Google-Smtp-Source: ABdhPJwaxZsdvdQUqIxLDi2kIO1WJvt9f/SRH5B6Y43PN/8hFKkKd7Znzw+GntDYRRMFc2DBNnPxjnWCM8qdFlRrNqs=
X-Received: by 2002:a19:691b:: with SMTP id e27mr1137208lfc.84.1611556543833;
 Sun, 24 Jan 2021 22:35:43 -0800 (PST)
MIME-Version: 1.0
References: <1611053418-29283-1-git-send-email-sumit.garg@linaro.org> <CAD=FV=Vrf4v0DKfZ7BAjW3ODoYeuwDu8L0S1kOMbbG+=WiVOnQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Vrf4v0DKfZ7BAjW3ODoYeuwDu8L0S1kOMbbG+=WiVOnQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 25 Jan 2021 12:05:32 +0530
Message-ID: <CAFA6WYNarMQN1coeWBjduDePg_veNdxkN+A7E0unfSdSFCfgfw@mail.gmail.com>
Subject: Re: [PATCH] kdb: Simplify kdb commands registration
To:     Doug Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Doug for your review.

On Sat, 23 Jan 2021 at 00:12, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Jan 19, 2021 at 2:50 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Simplify kdb commands registration via using linked list instead of
> > static array for commands storage.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_main.c    | 78 ++++++++++--------------------------------
> >  kernel/debug/kdb/kdb_private.h |  1 +
> >  2 files changed, 20 insertions(+), 59 deletions(-)
>
> Wow, nice.  It should have been done this way from the start!  ;-)
>
>
> > @@ -1011,7 +1005,7 @@ int kdb_parse(const char *cmdstr)
> >                 ++argv[0];
> >         }
> >
> > -       for_each_kdbcmd(tp, i) {
> > +       list_for_each_entry(tp, &kdb_cmds_head, list_node) {
> >                 if (tp->cmd_name) {
>
> So I think here (and elsewhere in this file) you can remove this "if
> (...->cmd_name)" stuff now, right?  That was all there because the old
> "remove" used to just NULL out the name to handle gaps and that's no
> longer possible.  If you are really paranoid you could error-check
> kdb_register_flags()
>

Agree, will get rid of this check.

>
> > --- a/kernel/debug/kdb/kdb_private.h
> > +++ b/kernel/debug/kdb/kdb_private.h
> > @@ -174,6 +174,7 @@ typedef struct _kdbtab {
> >         short    cmd_minlen;            /* Minimum legal # command
> >                                          * chars required */
> >         kdb_cmdflags_t cmd_flags;       /* Command behaviour flags */
> > +       struct list_head list_node;
>
> nit: every other entry in this struct has a comment but not yours..
>

Will add a comment here.

>
> Other than those small nits I think this is a great improvement, thanks!
>

Thanks,
Sumit

> -Doug
