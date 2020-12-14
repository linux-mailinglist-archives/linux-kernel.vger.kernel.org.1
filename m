Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CDE2D9A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408233AbgLNOii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408226AbgLNOie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:38:34 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357BCC061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:37:50 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id b9so11932839qtr.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HunglVjcvBMAm8Vnq5RKFceAB0LUszPBed8/+5881NA=;
        b=HEpN52kifpE64ZoqKFvmqtw415H2UUKpykICzQf/95P3n6NYbr1D2wfMBFeISonvqU
         63uoTYYyM21eSDzjLmhM0x8S5ec62HgO1f88RYej0gmrzjcV1RLJ55G/cLQn3SN6Vb99
         FB8Po6DREKkbhRBbSlLrHoi+3ZHl/UgT3roQ9XZQMXLqpZW69ecabKdSc17ByZFnP2zL
         boR44VyI7yXpOfVb6Cbh/dfMgPJZPkL1x3Nevu4uoXFeutq4PITVrA8p8xEEgiuU2nJZ
         mMpdcnXApLbUS7R/VvOlwCl8nJuFcOK5LEX1KhzR+Ea4Xb9GB9mze27wFJlSMFLhiIm1
         kz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HunglVjcvBMAm8Vnq5RKFceAB0LUszPBed8/+5881NA=;
        b=j0KN6kUBbx65hvePpBpVHHDSbA9qFtOO4XLqFG+KanpgCMu0G2v5Xl7DCR6X/a75oc
         6tws51odHGRnir/mn8f5OQnA0l03OoXruij/FadvFg82EpKdrl9WCHFMahQXYijvFkgE
         PbjvDpNMx0lsmin9Pxt8lpjIOsiUDHRyIQirWM8xN8Fx5mnazJl2k74jvXeUAgw/i+YO
         +8RgPMafvkgnxbGEjP2RZ1bsMO/tDvWRPfp+MKDYTdSzjJydmqgb3dwSmxK+sIQ6SB2C
         V1kPDjpDVPePFvT/RJmzETqOR/Qd1Uv752fi1FHX6euV+jCyyJJA4Lq5YW9xS2VZOBeb
         2ACQ==
X-Gm-Message-State: AOAM533h6IizJlATIHaALQ7C4OrSiQt+u4xLKdt2Wbefo3/XVHfIbZdT
        W7SOXggblkMMRyUxxA3Tsu7Rf3D9RnhB4OS2FSQtlw==
X-Google-Smtp-Source: ABdhPJzeIiPc1hYkr4hJt6QGcMzIk0jnXi6Gwhu4Wyy5i30MHSACUVb6cee6+HGIOL8wK9K+sgrxIe5id4ligrAa/pw=
X-Received: by 2002:ac8:4e1c:: with SMTP id c28mr31562407qtw.67.1607956669043;
 Mon, 14 Dec 2020 06:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20201210023638.GP52960@mit.edu> <00000000000024030c05b61412e6@google.com>
 <CACT4Y+bkaVq1RzONGuPJxu-pSyCSRrEs7xV0sa2n0oLNkicHQQ@mail.gmail.com> <20201210182821.GS52960@mit.edu>
In-Reply-To: <20201210182821.GS52960@mit.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Dec 2020 15:37:37 +0100
Message-ID: <CACT4Y+bqDdidJpYimvzY5UkrXzw7JuefHndOM0+c6Y8e56vBjQ@mail.gmail.com>
Subject: Re: UBSAN: shift-out-of-bounds in ext4_fill_super
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     syzbot <syzbot+345b75652b1d24227443@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 7:28 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Dec 10, 2020 at 09:09:51AM +0100, Dmitry Vyukov wrote:
> > >  * [new tag]                   ext4-for-linus-5.8-rc1-2 -> ext4-for-linus-5.8-rc1-2
> > >  ! [rejected]                  ext4_for_linus           -> ext4_for_linus  (would clobber existing tag)
> >
> > Interesting. First time I see this. Should syzkaller use 'git fetch
> > --tags --force"?...
> > StackOverflow suggests it should help:
> > https://stackoverflow.com/questions/58031165/how-to-get-rid-of-would-clobber-existing-tag
>
> Yeah, sorry, ext4_for_linus is a signed tag which is only used to
> authenticate my pull request to Linus.  After Linus accepts the pull,
> the digital signature is going to be upstream, and so I end up
> deleting and the reusing that tag for the next merge window.
>
> I guess I could just start always using ext4_for_linus-<VERSION> and
> just delete the tags once they have been accepted, to keep my list of
> tags clean.
>
> It's going to make everyone else's tags who pull from ext4.git messy,
> though, with gobs of tags that probably won't be of use to them.  It
> does avoid the need to use git fetch --tags --force, and I guess
> people are used to the need to GC tags with the linux-repo.  So maybe
> that's the right thing to do going forward.

Hi Ted,

syzbot is now prepared and won't fail next time, nor on other similar
trees. Which is good.
So it's really up to you.

Thanks
