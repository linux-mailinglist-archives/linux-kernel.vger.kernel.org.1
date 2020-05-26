Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 071F91A0685
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 07:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgDGF0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 01:26:05 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:41034 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgDGF0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:26:05 -0400
Received: by mail-io1-f69.google.com with SMTP id n15so2095806iog.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 22:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=10x2LPIf+i5tUN+93O3ai178FKi5dAQ4lSNsVheuvew=;
        b=fRFZPZQQQLEOqzFZ7NmxehpGLh8dtp22057kTLXhHto3W+bbBzW35q9yOyCdX1XP5q
         E3xtVxscwrb69fuCX43LQ3baIytupnA5yRpHH01pZwezRcaq8PTB22OWIsA46DlcBQak
         szz9cR8a1gSRmmJ/u0yVsvAsWzG9p2x0UULX7We/gUQ3gbXv7Vs8rJyCGRbFiyufLyNY
         u9FrM5y7kd4tEoy6KKZ2iVP2kC7Juv+BCi+pyxe5AjQdaqbZm9ZrKCWgzxBAjU15x354
         /HRDbjhZHUjjdBwRnJJOiKmJyGIuBfiOfmdSxAJp9SWVOq+IlnkICZUZTJkBg0Cqfhkt
         R7yQ==
X-Gm-Message-State: AGi0PuarxPiD3SI4BDPYDMU6bB46INtE/t1Kvq17i6alVy4yEVZgr82f
        sQElMc2XdngBEgXKBsqoroAHXnyqzbczb5m135EbnMMToTHr
X-Google-Smtp-Source: APiQypKcWa27HP4wPRzmWPB3oiil2kIAlXNSOGNxBQypvmGUF9eM7Tq+Oe1CyHXQ/3i0QL6uD0aTBxvWpLk1jm5HIlg7xzZgK0fo
MIME-Version: 1.0
X-Received: by 2002:a92:1fc5:: with SMTP id f66mr654757ilf.157.1586237163153;
 Mon, 06 Apr 2020 22:26:03 -0700 (PDT)
Date:   Mon, 06 Apr 2020 22:26:03 -0700
In-Reply-To: <20200407012702.GB48345@xz-x1>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3afc905a2ac9e77@google.com>
Subject: Re: BUG: unable to handle kernel paging request in kernel_get_mempolicy
From:   syzbot <syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bgeffon@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterx@redhat.com, rdunlap@infradead.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com

Tested on:

commit:         23800bff mm/mempolicy: Allow lookup_node() to handle fatal..
git tree:       https://github.com/xzpeter/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=288d637f7bebfd40
dashboard link: https://syzkaller.appspot.com/bug?extid=693dc11fcb53120b5559
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
