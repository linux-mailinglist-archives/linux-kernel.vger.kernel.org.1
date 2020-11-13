Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA3A2B172C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgKMI1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:27:09 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:35302 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMI1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:27:08 -0500
Received: by mail-io1-f70.google.com with SMTP id u8so1834720ior.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aodAqy64F6XTaLuDziEH7zjvDDBZw6JGTnABsNn/TvA=;
        b=YhWfWCGAh7lyobQaAWnvATtAGiUZa0STM8+Y7JAPdzM5tGRmLyQZ9wUTJmto3RbFld
         pJy2pVyfw6GBwENxKVBP0Kv8De43ybItQN3l6cVISuSeH+8ZkS+kSWQPp0nwwAInLmkD
         qTcg+fDp/hacdraumaOxOBcUnpZbk4B+ICO5P9vgxrBaD0CU3x9aCk9r8awea3dojrN/
         R188xSNDx2WGwxVOxIn3MFtmTLA/2R8EHlsL11YMvhhT7zj3ik3SdKvosS/cpd52gJxs
         s/1mEzh3CAVpyH/PRkhdQH2lt/xhnjxAktmoZQFjav3gsGSuznvMNECIjxxrMphOGI6l
         cbIg==
X-Gm-Message-State: AOAM532kZ0SUmaWO2qLNSfEpyh56dP6qHg88dztVPE+m8BRjJqfr7kem
        rH9ONPPG8Inw41WZu8xEWjYeYn65oEdOYXyOAAgujwudwBeG
X-Google-Smtp-Source: ABdhPJxWG1D/1TdRIPE77iS79tX50Lk/pBj7OeAvfo760sgMZV71tViJj+mPhQ1xA9IkXqvruQWHzT14CG/WNCXKk72WTY/CL/T+
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:931:: with SMTP id o17mr1041906ilt.273.1605256027576;
 Fri, 13 Nov 2020 00:27:07 -0800 (PST)
Date:   Fri, 13 Nov 2020 00:27:07 -0800
In-Reply-To: <000000000000bb202905af132b8f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c208d05b3f8cbb6@google.com>
Subject: Re: kernel panic: stack is corrupted in get_kernel_gp_address
From:   syzbot <syzbot+d6459d8f8984c0929e54@syzkaller.appspotmail.com>
To:     alexandre.chartre@oracle.com, b.zolnierkie@samsung.com,
        bp@alien8.de, dan.carpenter@oracle.com, george.kennedy@oracle.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a49145acfb975d921464b84fe00279f99827d816
Author: George Kennedy <george.kennedy@oracle.com>
Date:   Tue Jul 7 19:26:03 2020 +0000

    fbmem: add margin check to fb_check_caps()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10ff7572500000
start commit:   f4d51dff Linux 5.9-rc4
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
dashboard link: https://syzkaller.appspot.com/bug?extid=d6459d8f8984c0929e54
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164270dd900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fbmem: add margin check to fb_check_caps()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
