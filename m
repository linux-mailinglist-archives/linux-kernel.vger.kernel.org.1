Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B7722F59D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgG0QpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 12:45:09 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:46192 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgG0QpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:45:09 -0400
Received: by mail-il1-f198.google.com with SMTP id o4so11888137ilo.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 09:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YHOnlUDfMk9Oce0Ou/WEOEHZ7nLvW59TMeR/2OpcF3Q=;
        b=ZJvCT2XTcZKKSzpIua3gCguPhfFeKLh/yjuQ1aiWDHPreIZDEr9GfWao8WPwMmXu4k
         eOLaot1yQwq9I2Udj40icqEN4K3zHG6/PcyylrQ07kglPHEjJhnFUAAMuBodYun0B542
         3cBmB4zrlG+3m7J+J0SrVPMhX8msrZh9SSinf3GC3ZrK+FF1zoNSqmmZYcdwOFR8DYLR
         gfEZfdN7obZxUs2vJTQs46JdT+EWsRszTlcUgcXEgPIP4j93/ePKlUCDIVtXd7/TDI/X
         tByolVjRSyVhKueSWd/YSthWUhkwaDgsMyF/Ti7wBidPk3aiOSNumQu2rCJo7h7rQ9Zr
         Arag==
X-Gm-Message-State: AOAM532jiE81WTC5kNShqAGi9rdeCRs0gKT6ux3m5DvyjwrngCi208h+
        N1F2Yah9eSPLrE+61FjgYdWpFoOy3Wa6ADFPw5m+W+TyahB1
X-Google-Smtp-Source: ABdhPJyWPqw6wdnxG6yEAcA0v1YAdXbJ62nm7W119h3e4RaBn+6wSQs6av1fBXa58L3cKtV8U9o26rlCi8xL4nuWsto7OXO4uR+Z
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1649:: with SMTP id a9mr18800320jat.115.1595868308050;
 Mon, 27 Jul 2020 09:45:08 -0700 (PDT)
Date:   Mon, 27 Jul 2020 09:45:08 -0700
In-Reply-To: <00000000000072cb4c0598d25a69@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c18f005ab6f0bc0@google.com>
Subject: Re: divide error in fbcon_switch
From:   syzbot <syzbot+13013adc4a234406c29e@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.thompson@linaro.org,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        ghalat@redhat.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit ce684552a266cb1c7cc2f7e623f38567adec6653
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Sun Jul 12 11:10:12 2020 +0000

    vt: Reject zero-sized screen buffer size.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155549c4900000
start commit:   76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
dashboard link: https://syzkaller.appspot.com/bug?extid=13013adc4a234406c29e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d69aeae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fdcc2ae00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: vt: Reject zero-sized screen buffer size.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
