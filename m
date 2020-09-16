Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13D326BB53
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 06:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIPEYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 00:24:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:33504 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgIPEYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 00:24:05 -0400
Received: by mail-io1-f70.google.com with SMTP id l22so4152889iol.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 21:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FsJrosBct6HeioQ4vw4Oed6LnUjZATq80ngatZYph80=;
        b=YyPeHfkiMZ3lLs/dzSU7BQtOwkkzYoXlo87oKlZdh5+Jyd9fmj/syNJ54HnPii+z7d
         GVzRPw/dFwU5d1o1yH0AYH4s7rKIFROseMuIJFS/j/kgcXAXOyB+6haHExzrh7R5fZs9
         SeXAhUZQ2ueVmkBO3yHqwLJOjtq40bsGPXQGNyqYD5JFUl8YeIK12rhdpQblrUFNdrCK
         FrcNIgvgQI0cwl6xiGZUU6SAVtjl1b5alzZSrnAUp9XcYMVsz/+lLWgLtyGnvjD29vmg
         0k9Z4w57FMHfDiRubdViFushadd92xS1jLIFoPTxFV/oZLJf5bofwUSOttCxj/uyUJs5
         XYVg==
X-Gm-Message-State: AOAM530iEbyLjwxiBJ2QbpSX+PBBXKcp1CZNDNxf4Dad3VcaZYwsDnPe
        K0LJqpc0LOQEB9CZ85T+adNIcjJ0CKDi0flrmiZy79G6m1O9
X-Google-Smtp-Source: ABdhPJyxgDO3mPSpRdj5PWJk7ZMhK47LdqSQD3jL4Pz3xEHr/Rn8rGqvBi1/Xxn1kJa9LMQ3bYnN/Cc641Hk5M0N8rf3t7Gsn/ui
MIME-Version: 1.0
X-Received: by 2002:a6b:6e0b:: with SMTP id d11mr17800564ioh.155.1600230244424;
 Tue, 15 Sep 2020 21:24:04 -0700 (PDT)
Date:   Tue, 15 Sep 2020 21:24:04 -0700
In-Reply-To: <b542932c58eb464992529069cf58beaf@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047239b05af66a31c@google.com>
Subject: Re: general protection fault in unlink_file_vma
From:   syzbot <syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hdanton@sina.com, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel panic: Fatal exception

RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffd30630720 R11: 0000000000000000 R12: 000000000118d940
R13: 000000000118d940 R14: ffffffffffffffff R15: 000000000118cfec
FS:  0000000001b47940(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0033 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001590004 CR3: 0000000021097000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled


Tested on:

commit:         8f79400b fix vma_merge gpf
git tree:       https://github.com/Linmiaohe/linux vma_merge_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=153b1d43900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=c5d5a51dcbb558ca0cb5
compiler:       gcc (GCC) 10.1.0-syz 20200507

