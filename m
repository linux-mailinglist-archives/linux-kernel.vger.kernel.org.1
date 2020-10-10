Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39E1289D41
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 03:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbgJJBvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 21:51:20 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:50372 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbgJJB1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 21:27:18 -0400
Received: by mail-il1-f197.google.com with SMTP id h16so7221531ilq.17
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 18:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8OsC1Z46bkpCXK7zlGKfNBeg/b4R5n/K4/+udpZ91nQ=;
        b=NX9DpUMlyuxzSLC0ob7UGCEW8h1epYskg3wqOv0Cncm+NWQ2oRh2//ldINvNBRRnXJ
         VbgRecAEE8LuAGusXNXOTxFYdsIG5C0dKisgL7+LbZ/55ZEYRyHHxhB2XmAf6+g1R4oS
         2zynVsJ5deURPMDXESV8lyGufvjelKi34mK7KlCs5RdolSheAYnxgpf+w79M4I8HPGXh
         Pqhtj6aq29hZUFSZwzHzxAfjdyoq51xOFK+9aQl0KlNEEuuos2N3WcL5yTTI9ApDwEk2
         R4i9gk6kRu6pJA3RyeqxgEopmnA49b1pdoDVaPdsnYIwS1Sb3WVYotFyj+VM2VQ4Rqvn
         X0/g==
X-Gm-Message-State: AOAM530jj2eIXr+xQUWvzi/FOVR4ClhCWI4sSGURc0rrySr5bSyeRttp
        yrnf0aBOU83U19B2ZfQsuBLEYl8NgdIB8matEtw9e8d9SITQ
X-Google-Smtp-Source: ABdhPJxj4LVaMnRw3LHLpSZCvAk/5cbtNzA0dxEA5sAb2ppy8Cj0rGxAn+NqXSqtHvfGxuic8f6cM1YKfMfdgw9yvLbHdmZ+w0sC
MIME-Version: 1.0
X-Received: by 2002:a92:4101:: with SMTP id o1mr12200876ila.296.1602293233687;
 Fri, 09 Oct 2020 18:27:13 -0700 (PDT)
Date:   Fri, 09 Oct 2020 18:27:13 -0700
In-Reply-To: <20201010010817.GA557391@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005234105b146f7bd@google.com>
Subject: Re: WARNING in hif_usb_send/usb_submit_urb
From:   syzbot <syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, ath9k-devel@qca.qualcomm.com,
        eli.billauer@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com

Tested on:

commit:         549738f1 Linux 5.9-rc8
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.9-rc8
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b79158db7761422
dashboard link: https://syzkaller.appspot.com/bug?extid=f5378bcf0f0cab45c1c6
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16da8ffb900000

Note: testing is done by a robot and is best-effort only.
