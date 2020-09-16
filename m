Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D399B26C6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgIPSCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:02:30 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:39009 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbgIPSCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:02:13 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 08GI1gwX021826
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:01:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 08GI1gwX021826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1600279303;
        bh=vrkojej14gOuPDDTpBXZE88oQaVyq9TsyyMQly7A7JE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gMLh9EbcGJnlXtAf3LW6sT24yVVcDxutdoY22GcGvJXkIbpYM5dopZaYUp1NZepXo
         EZ+fM+jMyenYA1bJGELVsQOS7RhGPl8dQPp404YEMJLsKzoLkkWn1iBKv1vxExbwwN
         brr8yNysqu2MZNe0Ds8trJwVBwGaY40v7JbGw+jfgM7eQ8TObUlB4FgcBm5C7vKw4l
         48Su+v8DFImcSMdvUVRE6WPd/ApP5n8PVTTmUzaAdA6Tqx6XKxk856HhuMysMdz5PG
         bhrCAddUMyuTYUUXrkGcf2MoXmGmDFtEswhlUn/24qojDaJirfOn0CutGb/iSBWMOr
         jd82VcrEUeSwQ==
X-Nifty-SrcIP: [209.85.215.178]
Received: by mail-pg1-f178.google.com with SMTP id l191so4351249pgd.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:01:42 -0700 (PDT)
X-Gm-Message-State: AOAM530lsd1ysDt1ecWzdFfKAyS1druYrUd1direq522nAteGnaUur/P
        Lt+uvOu/K8oyOBp521AhMbal4yhtpMVjgxf+Bq8=
X-Google-Smtp-Source: ABdhPJyaL1rzeK33tiXruJkKngE86A6QMh7Z0QSYBXitiXDCSkAzd+IFjZ0Rtz32sZtJwU4wpDKUa1s/F4D6M0zeooU=
X-Received: by 2002:a63:d242:: with SMTP id t2mr19934901pgi.47.1600279301800;
 Wed, 16 Sep 2020 11:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
 <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
 <CA+ASDXOuK=iCdzWbtc+aRhBy=8xy860XqxwJg+wFuQaXKfg3UQ@mail.gmail.com>
 <f3ce9b3e-d3c1-a96b-e14b-a8d3c4600b09@rasmusvillemoes.dk> <CAK7LNATJ2seAuYpi-WPdLNFn2C9Vwm494nk-SWvgBJB3CmCJrw@mail.gmail.com>
 <fd1bb3d9-2b21-c330-7fa8-02ec76292d8b@rasmusvillemoes.dk>
In-Reply-To: <fd1bb3d9-2b21-c330-7fa8-02ec76292d8b@rasmusvillemoes.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 17 Sep 2020 03:01:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNASvh=pR=b0YtfzdKU1Y+M8kUiOKu887k05UH-xKs3b99g@mail.gmail.com>
Message-ID: <CAK7LNASvh=pR=b0YtfzdKU1Y+M8kUiOKu887k05UH-xKs3b99g@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: make git describe output more reliable
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Brian Norris <briannorris@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:23 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 16/09/2020 16.28, Masahiro Yamada wrote:
> > On Fri, Sep 11, 2020 at 5:28 PM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> On 10/09/2020 21.05, Brian Norris wrote:
> >>> On Thu, Sep 10, 2020 at 7:35 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >>>> On Thu, Sep 10, 2020 at 8:57 PM Rasmus Villemoes
> >>>> <linux@rasmusvillemoes.dk> wrote:
> >>>>> So in order to avoid `uname -a` output relying on such random details
> >>>>> of the build environment which are rather hard to ensure are
> >>>>> consistent between developers and buildbots, use an explicit
> >>>>> --abbrev=15 option (and for consistency, also use rev-parse --short=15
> >>>>> for the unlikely case of no signed tags being usable).
> >>>
> >>> For the patch:
> >>>
> >>> Reviewed-by: Brian Norris <briannorris@chromium.org>
> >>>
> >>>> I agree that any randomness should be avoided.
> >>>>
> >>>> My question is, do we need 15-digits?
> >>> ...
> >>>> So, I think the conflict happens
> >>>> only when we have two commits that start with the same 7-digits
> >>>> in the _same_ release. Is this correct?
> >>
> >> No.
> >>
> >>> For git-describe (the case where we have a tag to base off):
> >>> "use <n> digits, or as many digits as needed to form a unique object name"
> >>
> >> Yes, the abbreviated hash that `git describe` produces is unique among
> >> all objects (and objects are more than just commits) in the current
> >> repo, so what matters for probability-of-collision is the total number
> >> of objects - linus.git itself probably grows ~60000 objects per release.
> >>
> >> As for "do we need 15 digits", well, in theory the next time I merge the
> >> next rt-stable tag into our kernel I could end up with a commit that
> >> matches some existing object in the first 33 hex chars at which point I
> >> should have chosen 34 - but of course that's so unlikely that it's
> >> irrelevant.
> >>
> >> But the upshot of that is that there really is no objective answer to
> >> "how many digits do we need", so it becomes a tradeoff between "low
> >> enough probability that anyone anywhere in the next few years would have
> >> needed more than X when building their own kernel" and readability of
> >> `uname -r` etc. So I decided somewhat arbitrarily that each time one
> >> rolls a new release, there should be less than 1e-9 probability that
> >> HEAD collides with some other object when abbreviated to X hexchars.
> >> X=12 doesn't pass that criteria even when the repo has only 10M objects
> >> (and, current linus.git already has objects that need 12 to be unique,
> >> so such collisions do happen in practice, though of course very rarely).
> >> 13 and 14 are just weird numbers, so I ended with 15, which also allows
> >> many many more objects in the repo before the probability crosses that
> >> 1e-9 threshold.
> >>
> >
> >
> > This is because you use the output from git as-is.
> >
> > Why are you still trying to rely on such obscure behavior of git?
> >
> >
> > It is pretty easy to get the fixed number of digits reliably.
> >
> > For example,
> > git rev-parse --verify HEAD 2>/dev/null | cut -c1-7
> >
> >
> > It always returns a 7-digits hash,
> > and two different people will get the same result for sure.
> >
> > Your solution, --short=15, means "at least 15",
> > which still contains ambiguity.
> >
> >
> >
> > As I already noted, the kernelrelease string is
> > constructed in this format:
> >
> > <kernel-version>-<number-of-commits-on-top>-<abbreviated-commit-hash>
> >
> >
> > For example, if I enable CONFIG_LOCALVERSION_AUTO=y
> > in today's Linus tree, I got this:
> >
> > 5.9.0-rc5-00005-gfc4f28bb3daf
> >
> >
> > What if the number of digits were 7?
> >
> > 5.9.0-rc5-00005-gfc4f28b
> >
> > I see no problem here.
>
> The problem is that currently, the build relies on things which cannot
> easily be controlled or reproduced between different developers: Apart
> from git version (which is reasonable to mandate is the same, just like
> one must use same compiler, binutils etc. to get binary reproducible
> output), it depends on whether ~/.gitconfig has a core.abbrev setting -
> and even worse, it depends on the _total number of objects in the source
> git repo_, i.e. something that has nothing to do with what is currently
> in the work tree at all.
>
> And that leads to real bugs when one builds external modules that end up
> in one directory in the rootfs, while `uname -r` tells modprobe to look
> in some other directory (differing in the length of the abbreviated hash).
>
> > Even if we have another object that starts with "fc4f28b",
> > the kernelrelease string is still unique thanks to the
> > <kernel-version>-<number-of-commits-on-top> prefix.
> >
> > Why do we care about the uniqueness of the abbreviated
> > hash in the whole git history?
>
> Because when I ask a customer "what kernel are you running", and they
> tell me "4.19.45-rt67-00567-123abc8", I prefer that 123abc8 uniquely
> identifies the right commit, instead of me having to dig around each of
> the commits starting with that prefix and see which one of them matches
> "is exactly 567 commits from 4.19.45-rt67". 7 hexchars is nowhere near
> enough for that today, which is why Linus himself did that "auto-tune
> abbrev based on repo size" patch for git.git.



I like:

   git rev-parse --verify HEAD 2>/dev/null | cut -c1-15

better than:

   git rev-parse --verify --short=15 HEAD 2>/dev/null



The former produces the deterministic kernelrelease string.


But, let's reconsider if we need as long as 15-digits.

There are a couple of kinds of objects in git: commit, tree, blob.

I think you came up with 15-digits to ensure the uniqueness
in _all_ kinds of objects.

But, when your customer says "4.19.45-rt67-00567-123abc8",
123abc8 is apparently a commit instead of a tree or a blob.



In the context of the kernel version, we can exclude
tree and blob objects.

In other words, I think "grows ~60000 objects per release"
is somewhat over-estimating.

We have ~15000 commits per release. So, the difference
is just 4x factor, though...



BTW, I did some experiments, and I noticed
"git log" accepts a shorter hash
than "git show" does presumably because
"git log" only takes a commit.



For example, "git show 06a0d" fails, but
"git log 06a0d" works.


masahiro@oscar:~/ref/linux$ git  show   06a0d
error: short SHA1 06a0d is ambiguous
hint: The candidates are:
hint:   06a0df4d1b8b commit 2020-09-08 - fbcon: remove now unusued
'softback_lines' cursor() argument
hint:   06a0d81911b3 tree
hint:   06a0dc5a84d2 tree
hint:   06a0d1947c77 blob
hint:   06a0df434249 blob
fatal: ambiguous argument '06a0d': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
masahiro@oscar:~/ref/linux$ git  log --oneline  -1   06a0d
06a0df4d1b8b fbcon: remove now unusued 'softback_lines' cursor() argument




What is interesting is, if you prepend <tag>-<number-of-commits>-
to the abbreviated hash, "git show" accepts as short as a commit
"git log" does.

masahiro@oscar:~/ref/linux$ git  show   v5.9-rc5-00002-g06a0d  | head -1
commit 06a0df4d1b8b13b551668e47b11fd7629033b7df


I guess git cleverly understands it refers to a commit object
since "v5.9-rc5-00002-" prefix only makes sense
in the commit context.



Keeping those above in mind, I believe 15-digits is too long.


So, I propose two options.


[1] 7 digits

The abbreviated hash part may not uniquely identify
the commit. In that case, you need some extra git
operations to find out which one is it.

As for the kernel build,
<kernel-version>-<number-of-commits>-<7-digits> is enough
to provide the unique kernelrelease string.



[2] 12 digits

This matches to the Fixes: tag policy specified in
Documentation/process/submitting-patches.rst

The abbreviated hash part is very likely unique
in the commit object space.
(Of course, it is impossible to guarantee the uniqueness)



I wait for some comments.






> But what I mostly care about is getting a consistent result. And yes,
> you're right that the porcelain command 'git describe' could end up
> using something more than 15 digits (though that's extremely unlikely).
> So if you prefer, I can try to rewrite the logic purely in terms of
> plumbing commands. But that's a much more invasive patch, and one would
> obviously lose the guarantee of the abbreviation being unique among
> current git objects.
>
> Alternatively, would you consider a Kconfig knob, LOCALVERSION_ABBREV?


No, I do not think LOCALVERSION_ABBREV is a good idea.

We should eliminate this problem
irrespective of the kernel configuration.


--
Best Regards
Masahiro Yamada
