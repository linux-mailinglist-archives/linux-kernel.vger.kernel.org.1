Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA02AE686
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 03:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgKKCrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 21:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKCrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 21:47:21 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBDAC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:47:19 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q3so646148edr.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nu9R3ini0DJUYFxlXcOZoD/UHlTCD3Gyc9oHDqhMzM=;
        b=HE2hXmQSP3OtTDZmEe1Q+ersOVtGf9XzkUDLhem3hpfF/SFDfFYD8RqTLFqOtSTb7+
         YDXX1jQr5OEviE8Jz+KlTr47YYCSPbTMgZm5RGChS55hWmgKOqzlPwOUOuKsoMkrQbAZ
         v6E7aYnw2ZUsYL4nZiiAsN/Zg2c8oyc/wXeZirApRQDNV4dVJe2SMaDVVuVKNIRsmxfg
         AfkYfkeY2DsNkyoEjBbF1yWivmWben+6/y+WeJqjK4S6VKHnAp6cpR87bj7ODkFu2Lad
         x0ezt3wyOxefxrbusBOZ9omSpAn/gF3BJHX+0TN+YZt5E0inBwUJ5Tv8sTF68Mbw+nee
         ZsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nu9R3ini0DJUYFxlXcOZoD/UHlTCD3Gyc9oHDqhMzM=;
        b=adKhN2yx6w6q6nohPvIef9Gbe3BQQr482low2mSl4ZCP0/xGSrrOumM1wbl+MUBw+I
         lyyfjQExdZC3HiqQq2tryDRf0NBtkNjlPLh3S97Md7032gC1xE2zWvNFN/416b8yOyPb
         osy+9ox+N+52Ktv5VesTv+/g1qhcIABHuTBgA5K641Wv7tG81j60r3pj6tawlHIezSBF
         ITeWXjAlpd5nOB1jSaAfq55zSQ4feZJIuOCSvDVWmCYytX5SYOr67Xdp2IwIEKcKwJdV
         NowiYJIlX65tCc16K1K85Slb6q0q8vNoxtki//Kln55PWNtPah/nftNs7k+yGG8k34iS
         9lDw==
X-Gm-Message-State: AOAM532eAgDC4WSm19kv+4W1eHBX4SrH3vA2U1g6YuU5nV3F+cR3hrVq
        2lN+JFNrJFZ5QJ/fg7kEIyw1CvWpIWFau8mSVYgH
X-Google-Smtp-Source: ABdhPJw2IcHVJZiQH2el4IvKVSLlQj8IHMx0QGFJtccL5YLRLYPAJvia6xIq6JSSJ+LuVap1HHeOlNjVOaS2BkwvsNs=
X-Received: by 2002:a50:d587:: with SMTP id v7mr23364994edi.38.1605062838314;
 Tue, 10 Nov 2020 18:47:18 -0800 (PST)
MIME-Version: 1.0
References: <1604651482-9780-1-git-send-email-alex.shi@linux.alibaba.com> <20201110152310.GB55411@madcap2.tricolour.ca>
In-Reply-To: <20201110152310.GB55411@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Nov 2020 21:47:07 -0500
Message-ID: <CAHC9VhQiQoZh8in+zoYa5hbTN_yL-=mt7nTQFN9GAyQZ+tz-Ww@mail.gmail.com>
Subject: Re: [PATCH] audit: remove unused macros
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:23 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-11-06 16:31, Alex Shi wrote:
> > Some unused macros could cause gcc warning:
> > kernel/audit.c:68:0: warning: macro "AUDIT_UNINITIALIZED" is not used
> > [-Wunused-macros]
> > kernel/auditsc.c:104:0: warning: macro "AUDIT_AUX_IPCPERM" is not used
> > [-Wunused-macros]
> > kernel/auditsc.c:82:0: warning: macro "AUDITSC_INVALID" is not used
> > [-Wunused-macros]
> >
> > remove them to tame gcc.
> >
> > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Eric Paris <eparis@redhat.com>
> > Cc: linux-audit@redhat.com
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/audit.c   | 1 -
> >  kernel/auditsc.c | 3 ---
> >  2 files changed, 4 deletions(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index ac0aeaa99937..dfac1e0ca887 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -65,7 +65,6 @@
> >  /* No auditing will take place until audit_initialized == AUDIT_INITIALIZED.
> >   * (Initialization happens after skb_init is called.) */
> >  #define AUDIT_DISABLED               -1
> > -#define AUDIT_UNINITIALIZED  0
> >  #define AUDIT_INITIALIZED    1
> >  static int   audit_initialized;
>
> This one is part of a set, so it feels like it should stay, but the code
> is structured in such a way that it is not necessary.

Yes, I'd like for us to find a way to keep this if possible.  Let's
simply initialize "audit_initialized" to AUDIT_UNINITIALIZED in this
file.  At some point someone will surely complain about not needing to
initialize to zero, but we can deal with that later.

> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 183d79cc2e12..eeb4930d499f 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -80,7 +80,6 @@
> >  #include "audit.h"
> >
> >  /* flags stating the success for a syscall */
> > -#define AUDITSC_INVALID 0
> >  #define AUDITSC_SUCCESS 1
> >  #define AUDITSC_FAILURE 2
>
> Same here, but this one should really be fixed by using
> AUDITSC_INVALID as the value assigned to context->return_valid in
> __audit_free() to avoid using magic numbers.

Agreed.

We could probably explicitly set it in audit_alloc_context() as well
if we wanted to be complete.

> Similarly, the compared
> values in audit_filter_rules() under the AUDIT_EXIT and AUDIT_SUCCESS
> cases should be "ctx->return_valid != AUDITSC_INVALID" rather than just
> "ctx->return_valid".  Same in audit_log_exit().

Agreed.

> > @@ -102,8 +101,6 @@ struct audit_aux_data {
> >       int                     type;
> >  };
> >
> > -#define AUDIT_AUX_IPCPERM    0
> > -
>
> Hmmm, this one looks like it was orphaned 15 years ago a couple of
> months after it was introduced due to this commit:
> c04049939f88 Steve Grubb <sgrubb@redhat.com> 2005-05-13
>     ("AUDIT: Add message types to audit records")
>
> Introduced here:
> 8e633c3fb2a2 David Woodhouse <dwmw2@shinybook.infradead.org> 2005-03-01
>     ("Audit IPC object owner/permission changes.")
>
> I agree, remove it.

No arguments from me.

--
paul moore
www.paul-moore.com
