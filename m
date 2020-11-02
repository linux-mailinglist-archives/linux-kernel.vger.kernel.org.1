Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC5A2A227F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 01:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgKBAC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 19:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgKBAC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 19:02:27 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E86C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 16:02:27 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r9so13225730ioo.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 16:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vot87oQGFGr7SPekNg6EcPihYhCC6/PN3yRfHubevVQ=;
        b=vVCtV57d8VRqmqGxM0oOpB89061SwN1ZvrG4m38uVNh/doTR5a03tDmbVItxn2PTIK
         WcjiYYdCj4999CinJmYIWUH+qC5XL+RpOdZVk9TavDNccRPBwx0t2o5cMePA5gS9ftCb
         i8Wo5pyV9+nmJzBhVrNHUPP3+SXAa5H796kII0Pdg/Gb+CN814m0EkzTWrJvmEfXpdqR
         nZNMgJJJJjEV+GXfBYbZIFJmbzYmc0BRehtlb5RpkFDf8tI3xFuHS+8jzEn8QmsAXxZl
         yoaP8kG/d9DdgPJuNeCYR9g5nJq5GJpumCliG9PAdg/xGF9jmRHLIAOC7wNy3vxGDP8v
         /AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vot87oQGFGr7SPekNg6EcPihYhCC6/PN3yRfHubevVQ=;
        b=T1qwqqPN1Zbz4I6/BrF8c0gj/VAuYhtVDNpW61629GuUpBvyqgjBhSTSWr8uIuGLvj
         7e1t4uJycV+yDmjLNjqNiYUhbW192w2uFInljyioSXodlQZhOHAgVXQuQvVTt+3JyRi3
         O6Eo/Ddzj0GFr3YoW/b4APgOc7PnC8MMCS+sPK4F01ArCx4Ims3tkuZ4utuHvZbt+N0j
         VcwWz6KxLGiMHfldBxguKi0gZ0XXg4kwvANv0T3Bb/7gwTZIzbMnzpJGmj7aZBeXMjH8
         QKmHuB38uL3aiuVXLgYhhJ20qa9ljE3ryBnajAhN9sOCBsH5ozo/T1gjU7cB6uJfd73C
         tyPA==
X-Gm-Message-State: AOAM530SHAVR4IAnVreouWZukTPuN4TIJVoKxyirdSDyZF+Ko4J6+tWW
        EqTWNS6nAHiXBN4QDl3uB4Aibc7YmqoZ5te5TH6Q+w==
X-Google-Smtp-Source: ABdhPJwY9ZYUrHZu1RFOw1vbxRAM8T+/tsiWOxmkcPholPLxQVGY8Vg2G5x21Y5UI35QWbckD9pWSuLFb1d6kzglmWw=
X-Received: by 2002:a02:c80a:: with SMTP id p10mr9265753jao.114.1604275346738;
 Sun, 01 Nov 2020 16:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20201029065133.3027749-1-amistry@google.com> <20201029175120.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
 <839fad53-4377-592a-a0da-2cf18b5c6027@amd.com>
In-Reply-To: <839fad53-4377-592a-a0da-2cf18b5c6027@amd.com>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Mon, 2 Nov 2020 11:02:10 +1100
Message-ID: <CAATStaOTMrdserLepxkSdFErrjhMKyvd_g_GNBqOo_4p932ikw@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/speculation: Allow IBPB to be conditionally
 enabled on CPUs with always-on STIBP
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     x86@kernel.org, Joel Fernandes <joelaf@google.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        tglx@linutronix.de, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Nov 2020 at 02:05, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 10/29/20 1:51 AM, Anand K Mistry wrote:
> > On AMD CPUs which have the feature X86_FEATURE_AMD_STIBP_ALWAYS_ON,
> > STIBP is set to on and 'spectre_v2_user_stibp ==
> > SPECTRE_V2_USER_STRICT_PREFERRED'. At the same time, IBPB can be set to
> > conditional. However, this leads to the case where it's impossible to
> > turn on IBPB for a process because in the PR_SPEC_DISABLE case in
> > ib_prctl_set, the (spectre_v2_user_stibp ==
> > SPECTRE_V2_USER_STRICT_PREFERRED) condition leads to a return before the
> > task flag is set. Similarly, ib_prctl_get will return PR_SPEC_DISABLE
> > even though IBPB is set to conditional.
> >
> > More generally, the following cases are possible:
> > 1. STIBP = conditional && IBPB = on for spectre_v2_user=seccomp,ibpb
> > 2. STIBP = on && IBPB = conditional for AMD CPUs with
> >     X86_FEATURE_AMD_STIBP_ALWAYS_ON
> >
> > The first case functions correctly today, but only because
> > spectre_v2_user_ibpb isn't updated to reflect the IBPB mode.
> >
> > At a high level, this change does one thing. If either STIBP is IBPB is
>
> s/STIBP is IBPB/STIBP or IBPB/

Oops. Will be fixed in v2.

>
> > set to conditional, allow the prctl to change the task flag. Also,
> > reflect that capability when querying the state. This isn't perfect
> > since it doesn't take into account if only STIBP or IBPB is
> > unconditionally on. But it allows the conditional feature to work as
> > expected, without affecting the unconditional one.
> >
> > Signed-off-by: Anand K Mistry <amistry@google.com>
> >
> > ---
> >
> >   arch/x86/kernel/cpu/bugs.c | 41 +++++++++++++++++++++-----------------
> >   1 file changed, 23 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index d3f0db463f96..fb64e02eed6f 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -1254,6 +1254,11 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
> >       return 0;
> >   }
> >
> > +static bool is_spec_ib_user(enum spectre_v2_user_mitigation mode)
>
> Maybe something like is_spec_ib_user_controlled() would be a better name.

Changed in v2.

>
> > +{
> > +     return mode == SPECTRE_V2_USER_PRCTL || mode == SPECTRE_V2_USER_SECCOMP;
> > +}
> > +
>
> I like the idea of passing in the mode you want to check, but it appears
> they are never used independently. The ibpb and stibp modes are always
> checked together in one of the if statements below, so you could make this
> a function that checks both modes and just have a single call. I'll leave
> that up to the maintainers to see what is preferred.

I can see both sides to this. Personally, I think I prefer it as-is
since I think it improves readability a bit by making the conditions
less complicated whilst not hiding too many details. I'll wait to see
what others say before changing this one.

>
> >   static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
> >   {
> >       switch (ctrl) {
> > @@ -1262,13 +1267,16 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
> >                   spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
> >                       return 0;
> >               /*
> > -              * Indirect branch speculation is always disabled in strict
> > -              * mode. It can neither be enabled if it was force-disabled
> > -              * by a  previous prctl call.
> > +              * With strict mode for both IBPB and STIBP, the instruction
> > +              * code paths avoid checking this task flag and instead,
> > +              * unconditionally run the instruction. However, STIBP and IBPB
> > +              * are independent and either can be set to conditionally
> > +              * enabled regardless of the mode of the other. If either is set
> > +              * to conditional, allow the task flag to be updated, unless it
> > +              * was force-disabled by a previous prctl call.
>
> You probably want to reference the STIBP always on mode that allows this
> situation.

Updated comment in v2 to mention the X86_FEATURE_AMD_STIBP_ALWAYS_ON case.

>
> >                */
> > -             if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
> > -                 spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
> > -                 spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ||
> > +             if ((!is_spec_ib_user(spectre_v2_user_ibpb) &&
> > +                  !is_spec_ib_user(spectre_v2_user_stibp)) ||
> >                   task_spec_ib_force_disable(task))
> >                       return -EPERM;
> >               task_clear_spec_ib_disable(task);
> > @@ -1283,9 +1291,8 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
> >               if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
> >                   spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
> >                       return -EPERM;
> > -             if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
> > -                 spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
> > -                 spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
> > +             if (!is_spec_ib_user(spectre_v2_user_ibpb) &&
> > +                 !is_spec_ib_user(spectre_v2_user_stibp))
>
> The set function seems reasonable to me.
>
> >                       return 0;
> >               task_set_spec_ib_disable(task);
> >               if (ctrl == PR_SPEC_FORCE_DISABLE)
> > @@ -1351,20 +1358,18 @@ static int ib_prctl_get(struct task_struct *task)
> >       if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
> >           spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
> >               return PR_SPEC_ENABLE;
> > -     else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
> > -         spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
> > -         spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
> > -             return PR_SPEC_DISABLE;
> > -     else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_PRCTL ||
> > -         spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP ||
> > -         spectre_v2_user_stibp == SPECTRE_V2_USER_PRCTL ||
> > -         spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP) {
> > +     else if (is_spec_ib_user(spectre_v2_user_ibpb) ||
> > +              is_spec_ib_user(spectre_v2_user_stibp)) {
> >               if (task_spec_ib_force_disable(task))
> >                       return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
> >               if (task_spec_ib_disable(task))
> >                       return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
> >               return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
> > -     } else
> > +     } else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
> > +         spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
> > +         spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
> > +             return PR_SPEC_DISABLE;
> > +     else
>
> The get function also seems reasonable.
>
> Lets hear what some of the other folks that are familiar with this area
> have to say.
>
> Thanks,
> Tom
>
> >               return PR_SPEC_NOT_AFFECTED;
> >   }
> >
> >



-- 
Anand K. Mistry
Software Engineer
Google Australia
