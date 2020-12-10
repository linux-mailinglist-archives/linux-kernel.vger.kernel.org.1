Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3562D520C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgLJDuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:50:54 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:52384 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbgLJDuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:50:44 -0500
Received: by mail-io1-f72.google.com with SMTP id b136so2933364iof.19
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 19:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0cTgBqiGrBDRYHQY4vsFsGVcfdNZ3CTtIGa2AjXRHQM=;
        b=CHNCmDf5wS2SRIwWo4X+BSI3C3YDviBQRAwOTKnIY0UORoDifxnp0Ka0LSlx2Lzwfr
         +nMHC2TP32ecpc6oMzLulzMSgmGQPkez1gpYBOsMn2/wGgo0zlsh8O5GugIfOLAGO8Ps
         fDiqFE87A+57+M+H5mMYlPf7kKluk5bVK79JRzZU4vSiuXpyWDKQGyCLMJ1lUFMls4h7
         wkKbxC16vJLHKqZyU5GOTsbZ7tBKL9jCuVGjLvCV+PfnGSoCk0KIcH8KBWfT03KpKNWp
         tIHf5qtTWC5IRr0YX2H7Hf/zjAyLqiIgyVx0+owim72PdiNh+dBXfxmUhVG3WJWdFgjq
         ywxg==
X-Gm-Message-State: AOAM532PeGt6d4ov0Lak0I1/94rahqfsgJC+++miAF4ejLS5r762M++c
        w+nSzsLC/1XiosNSC7HxG4if30Y5pILHPk5SwmllFWGYHP2g
X-Google-Smtp-Source: ABdhPJyJBi3l4F5GkR7QE/LAQNz6qZ3uFv+qO5865YwPpiuNkNUCxXJdCxiFDp6XnB01MVcNXgIHtBtdJa2j8DlZclJ7cXZ20a6x
MIME-Version: 1.0
X-Received: by 2002:a05:6638:e8c:: with SMTP id p12mr7286833jas.112.1607572203501;
 Wed, 09 Dec 2020 19:50:03 -0800 (PST)
Date:   Wed, 09 Dec 2020 19:50:03 -0800
In-Reply-To: <20201210023638.GP52960@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024030c05b61412e6@google.com>
Subject: Re: UBSAN: shift-out-of-bounds in ext4_fill_super
From:   syzbot <syzbot+345b75652b1d24227443@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git on commit e360ba58d067a30a4e3e7d55ebdd919885a058d6: failed to run ["git" "fetch" "--tags" "d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8"]: exit status 1
From git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
 * [new branch]                bisect-test-ext4-035     -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/bisect-test-ext4-035
 * [new branch]                bisect-test-generic-307  -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/bisect-test-generic-307
 * [new branch]                dev                      -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/dev
 * [new branch]                ext4-3.18                -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-3.18
 * [new branch]                ext4-4.1                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.1
 * [new branch]                ext4-4.4                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.4
 * [new branch]                ext4-4.9                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.9
 * [new branch]                ext4-dax                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-dax
 * [new branch]                ext4-tools               -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-tools
 * [new branch]                fix-bz-206443            -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/fix-bz-206443
 * [new branch]                for-stable               -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/for-stable
 * [new branch]                fsverity                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/fsverity
 * [new branch]                lazy_journal             -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/lazy_journal
 * [new branch]                master                   -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/master
 * [new branch]                origin                   -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/origin
 * [new branch]                pu                       -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/pu
 * [new branch]                test                     -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/test
 * [new tag]                   ext4-for-linus-5.8-rc1-2 -> ext4-for-linus-5.8-rc1-2
 ! [rejected]                  ext4_for_linus           -> ext4_for_linus  (would clobber existing tag)
 * [new tag]                   ext4_for_linus_bugfixes  -> ext4_for_linus_bugfixes
 * [new tag]                   ext4_for_linus_cleanups  -> ext4_for_linus_cleanups
 * [new tag]                   ext4_for_linus_fixes     -> ext4_for_linus_fixes
 * [new tag]                   ext4_for_linus_fixes2    -> ext4_for_linus_fixes2



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git e360ba58d067a30a4e3e7d55ebdd919885a058d6
dashboard link: https://syzkaller.appspot.com/bug?extid=345b75652b1d24227443
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1499c287500000

