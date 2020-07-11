Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F52E21C574
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 19:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgGKRMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 13:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgGKRMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 13:12:33 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B7ED207F9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594487551;
        bh=s9mrx7k59hwzdLeWPJcQcmvwf6/b9gcu+Ak1sy2igxM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IeaXB6GSRhioFWU0UTvh1ZtPOgVSI6WZtlrygLedn7tb5e3XWxUN+18LvhwZp+mBa
         ZJZr1gZLDcpoT6EvncyhJvyf4NftCj7iUO+7kZ/Ap2mdB8UNpw+jXaSdW9dYzXGM7C
         5OCe9PJGfLeJjHqXC2c6lePSLeSpGEbB4ZhXcIsg=
Received: by mail-wr1-f41.google.com with SMTP id z13so8988247wrw.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 10:12:31 -0700 (PDT)
X-Gm-Message-State: AOAM533dkRel8J8ofkHB4AHXRx4wDVa5NwJ4wkchgYY4TNxoRRpcccn3
        lZlbRab7dtuj7dBef0ZaBT7MGxtyaYfXhHvQ4rc7CA==
X-Google-Smtp-Source: ABdhPJxNtxNv97vVac68ETfyivGxBZOuJIp3HUrjq3Qf1jDPvSqczIR/Ifqp2jy/OgdOrzmC+NqwE8cc5w8QhdQwvnk=
X-Received: by 2002:adf:f707:: with SMTP id r7mr71676977wrp.70.1594487550009;
 Sat, 11 Jul 2020 10:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a4fd8105aa252630@google.com>
In-Reply-To: <000000000000a4fd8105aa252630@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 11 Jul 2020 10:12:18 -0700
X-Gmail-Original-Message-ID: <CALCETrVM13_htxyALSTjZT-m2=qBfBh_Z8AaGFD=BLdSgX-jzA@mail.gmail.com>
Message-ID: <CALCETrVM13_htxyALSTjZT-m2=qBfBh_Z8AaGFD=BLdSgX-jzA@mail.gmail.com>
Subject: Re: BUG: stack guard page was hit in fixup_exception
To:     syzbot <syzbot+3370f8260246b965fefd@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 12:10 AM syzbot
<syzbot+3370f8260246b965fefd@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    42f82040 Merge tag 'drm-fixes-2020-07-10' of git://anongit..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d80333100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3370f8260246b965fefd
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3370f8260246b965fefd@syzkaller.appspotmail.com
>

> Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

I bet this is the same fbcon bug.
