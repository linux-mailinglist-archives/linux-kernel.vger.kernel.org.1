Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB392D665C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 20:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393414AbgLJTZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 14:25:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:48393 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393327AbgLJTYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:24:44 -0500
Received: by mail-io1-f71.google.com with SMTP id 191so4684279iob.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Xa0iQU8Q/C+YSjMiw9XJ96Kz4N4tah7/BH4NCXeOx4M=;
        b=hj3eHOQPmndTeYSHqYXVP4zfCg4neWZKDzdtn/HWvMGKEEeWT/pRGcV9vjfeLr5LFN
         0UEtsfjkHPYytAsy2iR/X2QP5dqjkrQu0i3HoMqG1rGa10iVu+5n90xeXE5BaO2nGmS8
         xayLk1511JZY2GF9A1SOp+HAAGp23mzHh/zT7KUeJ0N12tFxZbBJ3MhDOIIabAtYg28w
         zbO+RuxxMYeTuH2M4zNYhlyLd40O1pVxHDMI6oBj7EV995wzN/4UCS3ZrRuTVbbHTD4/
         Z5qKP5KPkXn/fn/blPdqCkHR2ld1Qi8rgcfOLGCzQ45AlYoW50jyoYr/zMZuvIFnZ6Xg
         FG1g==
X-Gm-Message-State: AOAM531M52Wmu5KBblNSjD12pc0KElnpJuCe5rLdLOfnU5hUPn0HQVhj
        ieykQw0pAytZx9gVBkRoto3MK4OWxEsQrFe9A/OI0QmdO3Pk
X-Google-Smtp-Source: ABdhPJw89+a7UPMpCsZTfxcSNJBk4rtWLQnGEptKIq8hWLFCqIinN+sPXA8GzWSfq1CEL5GO5Krtdag6Leg0Ep3Ab4QTo1ofp8+a
MIME-Version: 1.0
X-Received: by 2002:a92:d0c8:: with SMTP id y8mr10133578ila.46.1607628243790;
 Thu, 10 Dec 2020 11:24:03 -0800 (PST)
Date:   Thu, 10 Dec 2020 11:24:03 -0800
In-Reply-To: <CACT4Y+a+ZwwEup7xgfsJth-=T-o-tYNHpVc0m4ePx0fj9LBHZw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066f16005b6211ed2@google.com>
Subject: Re: UBSAN: shift-out-of-bounds in ext4_fill_super
From:   syzbot <syzbot+345b75652b1d24227443@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        dvyukov@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+345b75652b1d24227443@syzkaller.appspotmail.com

Tested on:

commit:         e360ba58 ext4: fix a memory leak of ext4_free_data
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe9725f8845d9fe6
dashboard link: https://syzkaller.appspot.com/bug?extid=345b75652b1d24227443
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1166cf17500000

Note: testing is done by a robot and is best-effort only.
