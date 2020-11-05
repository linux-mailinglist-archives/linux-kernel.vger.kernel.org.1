Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE182A84B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbgKERRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:17:12 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:47625 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgKERRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:17:11 -0500
Received: by mail-io1-f72.google.com with SMTP id d19so1627322iod.14
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 09:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Rfdp0/IC9VqRIhN/SmK7/bJW5Cqy/A/9wt6SQdrC/so=;
        b=dWbHleiOXFsd0hp+63nUWenFVIHTXABDP0L/vY9cGPbp56E69QEuzLM0y/kdVdRUe2
         NmwSkXtWBFbrtLlyOtGrDOtK3L/mBnwFLcgm+DgSFZchi7/WeMgAnpSR7vmdFXE9ceY+
         4CLhMwT8ZDEFrBJHwKcGAy2jl72/lZ4wAH2pjw5BMmGo+MrDt3KaIKuvVxV8q4nanS2m
         XOkd2C+l3JVc4bB7pwmjVJPO0Ntd9loIkHQOgRLE/YXsCtg51Tv0Bi7ietvpOeWQlhgy
         v7jmXHOYIiLxYIS/qUpqTRtyPGPe+6ng3qqaw8FZGJuILv6ryWWc6A2AmTybSbRxTVIC
         MbCQ==
X-Gm-Message-State: AOAM532zcmX14eTTVKx/w9FvncHZ1M7sJz4mPCjunKRngdJ2pim4XnPl
        B55Km2vvXOszz0T/dYFaeRKmFHGJrBtjdrnAUue370Dvn9kE
X-Google-Smtp-Source: ABdhPJz6aE++DpR5GB57XSRgnn/AejK0OmDlD9JNlHk2Cn/tHZAQrZtFP17BXU3YjRc+tzy/tebsQtaCi4N/l2rop3tvXbzsLPOf
MIME-Version: 1.0
X-Received: by 2002:a92:7a0c:: with SMTP id v12mr2249529ilc.37.1604596628995;
 Thu, 05 Nov 2020 09:17:08 -0800 (PST)
Date:   Thu, 05 Nov 2020 09:17:08 -0800
In-Reply-To: <000000000000dd392b05b0a1b7ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014484705b35f4414@google.com>
Subject: Re: WARNING in handle_exception_nmi
From:   syzbot <syzbot+4e78ae6b12b00b9d1042@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f8e48a3dca060e80f672d398d181db1298fbc86c
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu Oct 22 10:23:02 2020 +0000

    lockdep: Fix preemption WARN for spurious IRQ-enable

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bbfa8a500000
start commit:   d3d45f82 Merge tag 'pinctrl-v5.9-2' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
dashboard link: https://syzkaller.appspot.com/bug?extid=4e78ae6b12b00b9d1042
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f24a0b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167b838f900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: lockdep: Fix preemption WARN for spurious IRQ-enable

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
