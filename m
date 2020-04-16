Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E49D1AB8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 08:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437809AbgDPG6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 02:58:11 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45661 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437733AbgDPG6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:58:03 -0400
Received: by mail-io1-f72.google.com with SMTP id y4so18679228ioy.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+GQulpXu2Zt/P9Hq8wYFo5idVVKpKyslYLuc6L5PFmk=;
        b=mm9p+FMK13nuCdxJ1YUKqeRAKz2o7PdM+jWtdSwvzl4pDvqmkQfw70pNnQUkH68Vgp
         +3kNuIyp1rzay3Ogjk2ixoFYXWvctOwnOXtUpgguu+kNl9+jxDotUSCyc90qoPbSk2WU
         ZPbxXyIJeohMRxGXQbYokjvIUk1+UiA16u6HoO5GRr59rg4/3j9VJcGcDHFXVKGR8+ZB
         wV9L9o8dR90mzm3iosqEqUfMzJsKo7GZ1KYR9NFKbpxOs6Sjq9623F/3TaJ9u8ZFqMZC
         tZ+PhcyimovhewqwCUyT6j0/4gehdIANMLFi/Grf90ZXZFtCe8FWvOc8GTz61X9314Ie
         Iu/w==
X-Gm-Message-State: AGi0Pubn/zaTLWYGjPd2qRCItuSlYOty3ZB8XqbupUYNLRjX6TskdJnP
        wyoIqlVP2M1PKeXcH0zfqgJJUdhfvTJ67dVqHJdikKwfI9Hu
X-Google-Smtp-Source: APiQypLXL68tRkrOK+4lHNQRvcpYhVNSNYSIiu34JiJTrQQDojKK9Zbqotwo9YF4xSkTEnnlxk7Hc5LvjRkE0SYDyayPpqFTZQlC
MIME-Version: 1.0
X-Received: by 2002:a92:a103:: with SMTP id v3mr9309533ili.194.1587020282361;
 Wed, 15 Apr 2020 23:58:02 -0700 (PDT)
Date:   Wed, 15 Apr 2020 23:58:02 -0700
In-Reply-To: <CAHbLzkqeNLyzP21m3iL4KxE8O0MPZW_vkYozwdLCaVKNp_idnA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e7e1505a362f4c3@google.com>
Subject: Re: possible deadlock in shmem_mfill_atomic_pte
From:   syzbot <syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        shy828301@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com

Tested on:

commit:         8f9c86c9 mm: shmem: disable interrupt when acquiring info-..
git tree:       https://github.com/yang-shi/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=11f10cc27c63cade
dashboard link: https://syzkaller.appspot.com/bug?extid=e27980339d305f2dbfd9
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
