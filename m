Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5297D2FE397
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbhAUHQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:16:14 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:43576 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbhAUHOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:14:52 -0500
Received: by mail-io1-f70.google.com with SMTP id n18so1846367ioo.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xo9ghie0HmQTCVFE6esqYP8OmOHWlrtIq/GxNkUwj5U=;
        b=H4O2tPDwjzhYor7ZX4sKkjdf7BxsLoLzSA1CwxXJqz59qKBAzM+NUJdKi9/VQL773s
         WpdPF9cpSAN66Q2gFjPzA5C2SFLw/b+FKsh03kRay3OS8ereNrz7VKMIoKBxy2QeVFT+
         Vrte0FQKcaVbzB3aepak3Y+gLlLGmCC2twA1DpaDIow3bMCU0iZum9dgsBETnXuSMjN3
         jgnQShKanAV1mPaCKyDMf6/yNlwVIW/T4Dk38Fdp1UbTWMqyckz8z381Gbv5gL2SS2wL
         MuDPQUjG66CN06TQaMEdl4TAj6RQeKU4XVyIUnLbchNSFo29UgiF9mjcqTSCAyc0LFiq
         /NEQ==
X-Gm-Message-State: AOAM530+XxsJZ//rT9cmyf62MNSYEiz73b0ROeXZ9VCsqTewWWTZ5Pmq
        MC1TaUUTMETB37kfqURa6uvf8C+zok5eIVuImJqH1d4Q6eZC
X-Google-Smtp-Source: ABdhPJzDLnqdQook2ZXZb3CUnas5dN6lgKAj1/BZrrphe7tOta2u+ZsyZ5hzlDABjpjcMMegIBs85pqV27tUbqqi6hEb5rGPe9sv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:: with SMTP id g5mr10839151ilf.257.1611213251877;
 Wed, 20 Jan 2021 23:14:11 -0800 (PST)
Date:   Wed, 20 Jan 2021 23:14:11 -0800
In-Reply-To: <000000000000c8dd4a05b828d04c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000891f4605b963d113@google.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Read in bpf_trace_run7
From:   syzbot <syzbot+fad5d91c7158ce568634@syzkaller.appspotmail.com>
To:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, rostedt@goodmis.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, xdp-newbies@vger.kernel.org,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 8b401f9ed2441ad9e219953927a842d24ed051fc
Author: Yonghong Song <yhs@fb.com>
Date:   Thu May 23 21:47:45 2019 +0000

    bpf: implement bpf_send_signal() helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123408e7500000
start commit:   7d68e382 bpf: Permit size-0 datasec
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=113408e7500000
console output: https://syzkaller.appspot.com/x/log.txt?x=163408e7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7843b8af99dff
dashboard link: https://syzkaller.appspot.com/bug?extid=fad5d91c7158ce568634
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1224daa4d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13dfabd0d00000

Reported-by: syzbot+fad5d91c7158ce568634@syzkaller.appspotmail.com
Fixes: 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
