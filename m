Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572E52D5527
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbgLJIKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387710AbgLJIKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:10:48 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B69BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 00:10:04 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id z11so4004530qkj.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 00:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYDAWamrgtXENPLy0KNGY/iAQYLlOTlQsd1JUCvYlbQ=;
        b=X340a6vYLIu9nk5jTRrIBU/GTygftmL4lzB0insa31P5NBCcQ9mew06GhG9yH7/x5A
         huwQ9lMfEF1FN2qaEb5mpVXhIOJO+zql+pjTcYnrrvot2PDIByuOqkpnWzwFSgLecdsn
         X4X+aMHpPT9deedqHAd0AgI4ce7aPCDdi9CTUBhpUW2MXfEEUgyzoYbNssEe9ZJflXWp
         fWejdmw6qGhIt0/y5L5FqpCWc1OMXRxs8s8KWUsVs5cA1K5Yj2IWxH7F4D4PBxhbGzC2
         2uh2vqnWRZN/hNhJSpT47aEtaYBdXTkLTPm8tBSn9aEDpRD7/ffttwSxnpFbRF1lcV93
         J6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYDAWamrgtXENPLy0KNGY/iAQYLlOTlQsd1JUCvYlbQ=;
        b=MIxg3l4Eq3ft2x1/J4jybZP6zPgEv6cj7qgCsNyINjwKvO8NvyRuwAm69hHHSKu7nU
         QWDzg3BzquHzoN919Am5VKcHuSNACy1IqU8IIUUonZeD7soaKGCe3r24e7FocEbEcTse
         IhXCjNh8lTbGad4f5ZeOdPVRtIfQUZ7gjYthCdGcpONatf5k7/V1pfFqm8yyjiS73bdt
         oznlgm+CoN3u2gSeZOeqXSMHSfvTsqO+cn4ovD9sFSC0BHFGOVSRXEQ//KZlHHDpQCND
         Pju9Zs90t2F897xbcwuMlOHgBUouukRM+r6Xu1HpaJtJl+GRSBaogJ071v3MbzwPTPoh
         zraQ==
X-Gm-Message-State: AOAM531C/y4fEKnomEKyR8qPsU6Ji/GXpUQ3Zy4mMtJD8rvdZ7a39/7c
        SwLL9Ku16C4/uo0ZD3l6bRGkPpvfLYVkSIN+d0eR6g==
X-Google-Smtp-Source: ABdhPJy7H6zGDswBAbu4+krX/7B3/ty90plQHmoQqsVqam3x/bggZ04bAtBdiovS1q67/5ehktng/KUBnnTiKYZcPm8=
X-Received: by 2002:a37:56c6:: with SMTP id k189mr7380186qkb.501.1607587803237;
 Thu, 10 Dec 2020 00:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20201210023638.GP52960@mit.edu> <00000000000024030c05b61412e6@google.com>
In-Reply-To: <00000000000024030c05b61412e6@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Dec 2020 09:09:51 +0100
Message-ID: <CACT4Y+bkaVq1RzONGuPJxu-pSyCSRrEs7xV0sa2n0oLNkicHQQ@mail.gmail.com>
Subject: Re: UBSAN: shift-out-of-bounds in ext4_fill_super
To:     syzbot <syzbot+345b75652b1d24227443@syzkaller.appspotmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 4:50 AM syzbot
<syzbot+345b75652b1d24227443@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git on commit e360ba58d067a30a4e3e7d55ebdd919885a058d6: failed to run ["git" "fetch" "--tags" "d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8"]: exit status 1
> From git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
>  * [new branch]                bisect-test-ext4-035     -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/bisect-test-ext4-035
>  * [new branch]                bisect-test-generic-307  -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/bisect-test-generic-307
>  * [new branch]                dev                      -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/dev
>  * [new branch]                ext4-3.18                -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-3.18
>  * [new branch]                ext4-4.1                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.1
>  * [new branch]                ext4-4.4                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.4
>  * [new branch]                ext4-4.9                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.9
>  * [new branch]                ext4-dax                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-dax
>  * [new branch]                ext4-tools               -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-tools
>  * [new branch]                fix-bz-206443            -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/fix-bz-206443
>  * [new branch]                for-stable               -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/for-stable
>  * [new branch]                fsverity                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/fsverity
>  * [new branch]                lazy_journal             -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/lazy_journal
>  * [new branch]                master                   -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/master
>  * [new branch]                origin                   -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/origin
>  * [new branch]                pu                       -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/pu
>  * [new branch]                test                     -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/test
>  * [new tag]                   ext4-for-linus-5.8-rc1-2 -> ext4-for-linus-5.8-rc1-2
>  ! [rejected]                  ext4_for_linus           -> ext4_for_linus  (would clobber existing tag)

Interesting. First time I see this. Should syzkaller use 'git fetch
--tags --force"?...
StackOverflow suggests it should help:
https://stackoverflow.com/questions/58031165/how-to-get-rid-of-would-clobber-existing-tag


>  * [new tag]                   ext4_for_linus_bugfixes  -> ext4_for_linus_bugfixes
>  * [new tag]                   ext4_for_linus_cleanups  -> ext4_for_linus_cleanups
>  * [new tag]                   ext4_for_linus_fixes     -> ext4_for_linus_fixes
>  * [new tag]                   ext4_for_linus_fixes2    -> ext4_for_linus_fixes2
>
>
>
> Tested on:
>
> commit:         [unknown
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git e360ba58d067a30a4e3e7d55ebdd919885a058d6
> dashboard link: https://syzkaller.appspot.com/bug?extid=345b75652b1d24227443
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1499c287500000
