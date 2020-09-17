Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D6B26D059
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgIQBER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:04:17 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:65075 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgIQBEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:04:14 -0400
X-Greylist: delayed 648 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:04:11 EDT
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-09.nifty.com with ESMTP id 08H0nhFh024961
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:49:43 +0900
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 08H0n5uu014769
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:49:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 08H0n5uu014769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1600303746;
        bh=c8S4K7uDa/aR9LN8wCRZKo/j8yBtHuphCUXHfxgfWz4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0Oc21h9jkCccFJVG+VokzU4PO2aHxfxMVU+6HWgwvkr5Gsc0EID6exiOc04B2h653
         h/dFKyWNOnueyqS0vEqM0gDQGKXWqj9kGt2HA8mkYBlEdw1xB9pqyr4WGMZwzKMNk8
         8MFW+wdQ67N85UKxj2cx1b+suY99F3+yvMnu9FSOrumnzSKLc2o2beRu6UQk6ZX0RS
         EOfFLYFsF+v6uUwUbIT/d3f8ALv6CefvJM5KkvHRicANuJNPhdCTn18CHa2u0GKc/v
         jIMploesxyUo2pUvO/uUX+k3qRRqDw/ImpFtKviELQSQPfkHFLFdagkwPobMqCvtj1
         UdmAp45OZEfcQ==
X-Nifty-SrcIP: [209.85.215.177]
Received: by mail-pg1-f177.google.com with SMTP id j34so336372pgi.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 17:49:06 -0700 (PDT)
X-Gm-Message-State: AOAM5304sYciW9l4G15/w/jt/eF+vALq232tngL7GUpu5yHe2B/uNiYi
        dNT3gysu7rG8wkndbtD6ycDSa6YZp9SGOC/Gbx4=
X-Google-Smtp-Source: ABdhPJwHBdx6Ns9JCqmHIPCaljn8pzP/coRvZSCzQ1LGIcplYMRPT3vo2tAuJF09z3fTcidkdF53J2/04fM5u62tHEk=
X-Received: by 2002:a63:1b44:: with SMTP id b4mr18348864pgm.175.1600303745113;
 Wed, 16 Sep 2020 17:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
 <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
 <CA+ASDXOuK=iCdzWbtc+aRhBy=8xy860XqxwJg+wFuQaXKfg3UQ@mail.gmail.com>
 <f3ce9b3e-d3c1-a96b-e14b-a8d3c4600b09@rasmusvillemoes.dk> <CAK7LNATJ2seAuYpi-WPdLNFn2C9Vwm494nk-SWvgBJB3CmCJrw@mail.gmail.com>
 <fd1bb3d9-2b21-c330-7fa8-02ec76292d8b@rasmusvillemoes.dk> <CAK7LNASvh=pR=b0YtfzdKU1Y+M8kUiOKu887k05UH-xKs3b99g@mail.gmail.com>
 <0873059d-2912-3ef2-bab1-9db0cbe904a0@rasmusvillemoes.dk>
In-Reply-To: <0873059d-2912-3ef2-bab1-9db0cbe904a0@rasmusvillemoes.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 17 Sep 2020 09:48:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNATtOKXpZpikQsnPqEdCdyPPH+dyUXsNrmkQDHGBtpg9Jg@mail.gmail.com>
Message-ID: <CAK7LNATtOKXpZpikQsnPqEdCdyPPH+dyUXsNrmkQDHGBtpg9Jg@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: make git describe output more reliable
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Brian Norris <briannorris@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 4:31 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 16/09/2020 20.01, Masahiro Yamada wrote:
> > On Thu, Sep 17, 2020 at 12:23 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> On 16/09/2020 16.28, Masahiro Yamada wrote:
> >>> On Fri, Sep 11, 2020 at 5:28 PM Rasmus Villemoes
> >>> <linux@rasmusvillemoes.dk> wrote:
> >>>>
>
> >>> Why do we care about the uniqueness of the abbreviated
> >>> hash in the whole git history?
> >>
> >> Because when I ask a customer "what kernel are you running", and they
> >> tell me "4.19.45-rt67-00567-123abc8", I prefer that 123abc8 uniquely
> >> identifies the right commit, instead of me having to dig around each of
> >> the commits starting with that prefix and see which one of them matches
> >> "is exactly 567 commits from 4.19.45-rt67". 7 hexchars is nowhere near
> >> enough for that today, which is why Linus himself did that "auto-tune
> >> abbrev based on repo size" patch for git.git.
> >
> > I like:
> >
> >    git rev-parse --verify HEAD 2>/dev/null | cut -c1-15
> >
> > better than:
> >
> >    git rev-parse --verify --short=15 HEAD 2>/dev/null
> >
> > The former produces the deterministic kernelrelease string.
> >
> >
> > But, let's reconsider if we need as long as 15-digits.
> >
> > There are a couple of kinds of objects in git: commit, tree, blob.
> >
> > I think you came up with 15-digits to ensure the uniqueness
> > in _all_ kinds of objects.
> >
> > But, when your customer says "4.19.45-rt67-00567-123abc8",
> > 123abc8 is apparently a commit instead of a tree or a blob.
> >
> >
> >
> > In the context of the kernel version, we can exclude
> > tree and blob objects.
> >
> > In other words, I think "grows ~60000 objects per release"
> > is somewhat over-estimating.
> >
> > We have ~15000 commits per release. So, the difference
> > is just 4x factor, though...
> >
> >
> >
> > BTW, I did some experiments, and I noticed
> > "git log" accepts a shorter hash
> > than "git show" does presumably because
> > "git log" only takes a commit.
> >
> >
> >
> > For example, "git show 06a0d" fails, but
> > "git log 06a0d" works.
> >
> >
> > masahiro@oscar:~/ref/linux$ git  show   06a0d
> > error: short SHA1 06a0d is ambiguous
> > hint: The candidates are:
> > hint:   06a0df4d1b8b commit 2020-09-08 - fbcon: remove now unusued
> > 'softback_lines' cursor() argument
> > hint:   06a0d81911b3 tree
> > hint:   06a0dc5a84d2 tree
> > hint:   06a0d1947c77 blob
> > hint:   06a0df434249 blob
> > fatal: ambiguous argument '06a0d': unknown revision or path not in the
> > working tree.
> > Use '--' to separate paths from revisions, like this:
> > 'git <command> [<revision>...] -- [<file>...]'
> > masahiro@oscar:~/ref/linux$ git  log --oneline  -1   06a0d
> > 06a0df4d1b8b fbcon: remove now unusued 'softback_lines' cursor() argument
> >
> >
> >
> >
> > What is interesting is, if you prepend <tag>-<number-of-commits>-
> > to the abbreviated hash, "git show" accepts as short as a commit
> > "git log" does.
> >
> > masahiro@oscar:~/ref/linux$ git  show   v5.9-rc5-00002-g06a0d  | head -1
> > commit 06a0df4d1b8b13b551668e47b11fd7629033b7df
> >
> >
> > I guess git cleverly understands it refers to a commit object
> > since "v5.9-rc5-00002-" prefix only makes sense
> > in the commit context.
> >
>
> Well, yes, but unfortunately only so far as applying the same "the user
> means a commit object" logic; git doesn't do anything to actually use
> the prefix to disambiguate. In fact, looking at a semi-random commit in
> 4.19-stable v4.19.114-7-g236c445eb352:
>
> $ git show 236c44
> error: short SHA1 236c44 is ambiguous
> hint: The candidates are:
> hint:   236c445eb352 commit 2020-03-13 - drm/bochs: downgrade
> pci_request_region failure from error to warning
> hint:   236c448cb6e7 commit 2011-09-08 - usbmon vs. tcpdump: fix dropped
> packet count
> hint:   236c445b1930 blob
>
> Now you're right that we get
>
> $ git show v4.19.114-7-g236c445 | head -n1
> commit 236c445eb3529aa7c976f8812513c3cb26d77e27
>
> so it knows we're not looking at that blob. But "git show
> v4.19.114-7-g236c44" still fails because there are two commits. Adding
> to the fun is that "git show v4.19.114-7-g236c448" actually shows the
> usbmon commit, which is old v3.2 stuff and certainly not a descendant of
> v4.19.114.


Oh, I did not notice that.
Maybe git can be improved to check the validity of
the 'git describe' form, but that is another story.



> I didn't actually know that git would even accept those prefixed strings
> as possible refspecs, and for a moment you had me hoping that git would
> actually do the disambiguation using that prefix, which would certainly
> make 7 hex chars enough; unfortunately that's not the case.
>
> > Keeping those above in mind, I believe 15-digits is too long.
>
> Well, as you indicated, commits are probably ~1/4 of all objects, i.e.
> half a hexchar worth of bits. So the commit/object distinction shouldn't
> matter very much for the choice of suitable fixed length.
>
> > So, I propose two options.
> >
> >
> > [1] 7 digits
> >
> > The abbreviated hash part may not uniquely identify
> > the commit. In that case, you need some extra git
> > operations to find out which one is it.
> >
> > As for the kernel build,
> > <kernel-version>-<number-of-commits>-<7-digits> is enough
> > to provide the unique kernelrelease string.
> >
> >
> >
> > [2] 12 digits
> >
> > This matches to the Fixes: tag policy specified in
> > Documentation/process/submitting-patches.rst
> >
> > The abbreviated hash part is very likely unique
> > in the commit object space.
> > (Of course, it is impossible to guarantee the uniqueness)
>
> I can live with 12. It would be extremely rare that I would have to do
> some extra git yoga to figure out which commit they actually mean. I
> think we can still use git describe to do the bulk of the work (the 'git
> rev-parse | cut ... is easy, but it's somewhat tedious to find the
> closest tag, then compute the #commits-on-top part), then just have the
> awk script used for pretty-printing (the %05d of the #commits-on-top)
> can probably also be used to chop the abbreviated sha1 at 12 chars,
> should git have needed to make it longer. Please see below for an
> updated patch+commit log.


LGTM.

Could you send it to ML as a patch?



> >> Alternatively, would you consider a Kconfig knob, LOCALVERSION_ABBREV?
> >
> >
> > No, I do not think LOCALVERSION_ABBREV is a good idea.
>
> Neither do I; I considered it before sending the patch but decided that yes:
>
> > We should eliminate this problem
> > irrespective of the kernel configuration.
>
> Rasmus
>
> ====
>
> something like this, then?
>
>
>     scripts/setlocalversion: make git describe output more reliable
>
>     When building for an embedded target using Yocto, we're sometimes
>     observing that the version string that gets built into vmlinux (and
>     thus what uname -a reports) differs from the path under /lib/modules/
>     where modules get installed in the rootfs, but only in the length of
>     the -gabc123def suffix. Hence modprobe always fails.
>
>     The problem is that Yocto has the concept of "sstate" (shared state),
>     which allows different developers/buildbots/etc. to share build
>     artifacts, based on a hash of all the metadata that went into building
>     that artifact - and that metadata includes all dependencies (e.g. the
>     compiler used etc.). That normally works quite well; usually a clean
>     build (without using any sstate cache) done by one developer ends up
>     being binary identical to a build done on another host. However, one
>     thing that can cause two developers to end up with different builds
>     [and thus make one's vmlinux package incompatible with the other's
>     kernel-dev package], which is not captured by the metadata hashing, is
>     this `git describe`: The output of that can be affected by
>
>     (1) git version: before 2.11 git defaulted to a minimum of 7, since
>     2.11 (git.git commit e6c587) the default is dynamic based on the
>     number of objects in the repo
>     (2) hence even if both run the same git version, the output can differ
>     based on how many remotes are being tracked (or just lots of local
>     development branches or plain old garbage)
>     (3) and of course somebody could have a core.abbrev config setting in
>     ~/.gitconfig
>
>     So in order to avoid `uname -a` output relying on such random details
>     of the build environment which are rather hard to ensure are
>     consistent between developers and buildbots, make sure the abbreviated
>     sha1 always consists of exactly 12 hex characters. That is consistent
>     with the current rule for -stable patches, and is almost always enough
>     to identify the head commit unambigously - in the few cases where it
>     does not, the v5.4.3-00021- prefix would certainly nail it down.
>
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 20f2efd57b11..b51072167df1 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -45,7 +45,7 @@ scm_version()
>
>         # Check for git and a git repo.
>         if test -z "$(git rev-parse --show-cdup 2>/dev/null)" &&
> -          head=$(git rev-parse --verify --short HEAD 2>/dev/null); then
> +          head=$(git rev-parse --verify HEAD 2>/dev/null); then
>
>                 # If we are at a tagged commit (like "v2.6.30-rc6"), we ignore
>                 # it, because this version is defined in the top level Makefile.
> @@ -59,11 +59,22 @@ scm_version()
>                         fi
>                         # If we are past a tagged commit (like
>                         # "v2.6.30-rc5-302-g72357d5"), we pretty print it.
> -                       if atag="$(git describe 2>/dev/null)"; then
> -                               echo "$atag" | awk -F- '{printf("-%05d-%s", $(NF-1),$(NF))}'
> -
> -                       # If we don't have a tag at all we print -g{commitish}.
> +                        #
> +                        # Ensure the abbreviated sha1 has exactly 12
> +                        # hex characters, to make the output
> +                        # independent of git version, local
> +                        # core.abbrev settings and/or total number of
> +                        # objects in the current repository - passing
> +                        # --abbrev=12 ensures a minimum of 12, and the
> +                        # awk substr() then picks the 'g' and first 12
> +                        # hex chars.
> +                       if atag="$(git describe --abbrev=12 2>/dev/null)"; then
> +                               echo "$atag" | awk -F- '{printf("-%05d-%s",
> $(NF-1),substr($(NF),0,13))}'
> +
> +                       # If we don't have a tag at all we print -g{commitish},
> +                       # again using exactly 12 hex chars.
>                         else
> +                               head="$(echo $head | cut -c1-12)"
>                                 printf '%s%s' -g $head
>                         fi
>                 fi



-- 
Best Regards
Masahiro Yamada
