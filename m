Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0302F01F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 18:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAIRBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 12:01:46 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:36810 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbhAIRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 12:01:45 -0500
Received: by mail-il1-f200.google.com with SMTP id z15so13298771ilb.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 09:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TKUoXu927qEWQVV5Epbyzc7Ss7cy0HmJolu4+tIMmUI=;
        b=SHX68mmRWjoQfFpCy2/XkB8y8RIA6DiYAVByWY7iwMgR9n9D9WL1MdsBUz636nPh5Z
         vyj5SebxANFaH4DjsMxljKyZ+2agUG7kvYtaNDZdf/vnRt4yZri/E/6Mk1fcTZ+0ZPtE
         we+LH+T+sZVD401JTZPjniohCLC5GB/IpKV1kPPpnfgG6dZDHzK3xQHl6jXYqwNBOByq
         HuNiqU0K0fhklU7ZzfKiGgupL/bbWYmz0Bwi1ck0bZrt1CyzF2QBi0R33I7GF8cCk5jC
         GLad8lsU+gPECm1KsGKJHl02oR8nwCFaxs7NpImX11jxn05Pw2D4oBSJQUUUUPOLgcV6
         ccIQ==
X-Gm-Message-State: AOAM5322wfIcOLk9Km9GBImpfEMHACtE2LQ3SLednqosezI9UWG285uJ
        m6x60eH2oum0bdEclxgXUoCbxGsXzoepbhPBNmn11noP14bA
X-Google-Smtp-Source: ABdhPJwpCDQCauEE8T5RinO+sglwtX2Wf03+cIUORnl4QvxsgoLfN20TgVTsEVpOZ5X7+qwp6ZSWudIC7bxQVULggumWU5sdTQq8
MIME-Version: 1.0
X-Received: by 2002:a02:63cd:: with SMTP id j196mr8221257jac.61.1610211664742;
 Sat, 09 Jan 2021 09:01:04 -0800 (PST)
Date:   Sat, 09 Jan 2021 09:01:04 -0800
In-Reply-To: <06c3d80d-eb09-5cda-e0bf-862400d02433@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a4ef105b87a9e10@google.com>
Subject: Re: BUG: unable to handle kernel paging request in percpu_ref_exit
From:   syzbot <syzbot+99ed55100402022a6276@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+99ed55100402022a6276@syzkaller.appspotmail.com

Tested on:

commit:         d9d05217 io_uring: stop SQPOLL submit on creator's death
git tree:       git://git.kernel.dk/linux-block
kernel config:  https://syzkaller.appspot.com/x/.config?x=2455d075a1c4afa8
dashboard link: https://syzkaller.appspot.com/bug?extid=99ed55100402022a6276
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
