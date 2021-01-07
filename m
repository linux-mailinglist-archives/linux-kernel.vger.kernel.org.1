Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCCB2ED063
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 14:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbhAGNLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 08:11:54 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:36512 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbhAGNLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:11:54 -0500
Received: by mail-il1-f198.google.com with SMTP id z15so6428754ilb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 05:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oRgWg98/FIZVEp9r8aGEhshpBf9hX/r9V4Oyf+qndMQ=;
        b=HagAdp9yLKoOxgFX9Ef6qFTF373YH+QNvhbwBYpcL1f48CxW3pzQAlb3WdybfRv/4V
         xB1nM1khdx6KIOhXU61ZobSLcZDZg/8M2Djs/PotsG8TstxmcybzJpjLuSrKjSEbJh5D
         AIaqRNpU0t+jpZaLNDfYWn47ZrnKDTqS9I0Jgpzv5aPLKwvgwIV68Or9q30trfZhPeXQ
         lAZbLXvd4aMlefFYJ1HjCwDkzgUz1WhqFlhPs2/43tvcRDtGNgx1NZUYPHXdnAF7WmZ4
         EBymJ0x1I7+aK5Z7lLPtC9abjId37bLIIujXLUxQh4MfgFxxA697VfYaB4QrCSIKBul+
         LOXw==
X-Gm-Message-State: AOAM5310unQx7VArba3jDhb76v7ZxDtvjB3rpkrdktAerGHLlvJL5U7R
        79KkNp/zXIXzzhngdmXoVzwn430B9E5tBzWolUSS9DD/mCry
X-Google-Smtp-Source: ABdhPJzAnEVXSY+0SUdfW+TlfG3lxIrSn4jNeUtDM1iW6Sx0nFOKztdga01Tpd5QZdv7OejOUPG+X745sJHHIqpZqgHwQGz1OH2i
MIME-Version: 1.0
X-Received: by 2002:a92:ca46:: with SMTP id q6mr8928737ilo.278.1610025073072;
 Thu, 07 Jan 2021 05:11:13 -0800 (PST)
Date:   Thu, 07 Jan 2021 05:11:13 -0800
In-Reply-To: <00000000000053e36405b3c538fc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f60c505b84f2cd0@google.com>
Subject: Re: KASAN: null-ptr-deref Write in start_transaction
From:   syzbot <syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, fdmanana@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f30bed83426c5cb9fce6cabb3f7cc5a9d5428fcc
Author: Filipe Manana <fdmanana@suse.com>
Date:   Fri Nov 13 11:24:17 2020 +0000

    btrfs: remove unnecessary attempt to drop extent maps after adding inline extent

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ddc30b500000
start commit:   521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
dashboard link: https://syzkaller.appspot.com/bug?extid=6700bca07dff187809c4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a07ab2500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fe69c6500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove unnecessary attempt to drop extent maps after adding inline extent

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
