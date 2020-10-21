Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF5C2954E0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 00:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506901AbgJUWpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 18:45:09 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:51720 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506696AbgJUWpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 18:45:09 -0400
Received: by mail-il1-f197.google.com with SMTP id e3so2752553ilq.18
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 15:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7JOVTJJfIbS3N5OEHaDdyiuANlR9ab6tKBOsWZoF0WU=;
        b=IbnfxfSDDrFvY85fL4WxJuz1S6Hls1Kw7rLQ42Uh3lnDYsr8TGbBBPFv2hhzROpfR0
         r6SYTuk78FJKT06goXO3m0KrCubbM1MpOeAAyI7RCWbkXnfDZP39WEMN3+oQJzYexP6v
         /mB+vrXHPpdc8q/A7bzk5PuOsJXk8GvgWCcE/VVHryRkj+mRfbqvVIqv6OVr5dQz+9oN
         NvkENuUX/7tYjvlzIPKJGt6+uOgBNwWA1ymfr9rVHcvTh9lNiZqf6h665HrronD/PXIG
         kEd3782DjWUK9O8Eo1iR5kO91HCmlx+kXF3DWm4U+WRQg61OqFgWhRQlTR4Bo5lDeYzd
         G9bA==
X-Gm-Message-State: AOAM530L/ChE5ogKw1g39dx472sk21DJdO/y81btafrI83ulm+EcX7eY
        9wiptGzJzWQF01wBGeDHWPuJJDNVCthPqURon63m/98lRg4G
X-Google-Smtp-Source: ABdhPJwN64BJqaeYhdPFxyZgp216gXtiWrfyXedsv28m6nR0w3XVay2RZzjVFcyl7xUj2MEtlepDUzCq6jwfiyEJdFioX6l3HEc7
MIME-Version: 1.0
X-Received: by 2002:a05:6638:20a:: with SMTP id e10mr4774996jaq.20.1603320306871;
 Wed, 21 Oct 2020 15:45:06 -0700 (PDT)
Date:   Wed, 21 Oct 2020 15:45:06 -0700
In-Reply-To: <089e0825cec8180a2b0568c4ee1d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a390a05b2361916@google.com>
Subject: Re: WARNING in ext4_set_page_dirty
From:   syzbot <syzbot+9a44753ac327c557796a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, chris@chris-wilson.co.uk,
        dvyukov@google.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.kuoppala@linux.intel.com,
        rodrigo.vivi@intel.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 7dfbf8a07cf8c936b0d6cc810df6ae7923954d5b
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Tue Jun 30 15:27:24 2020 +0000

    drm/i915: Skip stale object handle for debugfs per-file-stats

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=153d895f900000
start commit:   46cf053e Linux 5.5-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=9a44753ac327c557796a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10055799e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b852c6e00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: drm/i915: Skip stale object handle for debugfs per-file-stats

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
