Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFFF1A255B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgDHPhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:37:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34406 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgDHPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:37:05 -0400
Received: by mail-io1-f69.google.com with SMTP id n26so321875iop.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 08:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Sk/yJxNuEWZ2R900yOk1engj26s2zBpDSaCTxgbd3iw=;
        b=N86ySn+PVwJnR870GQf+akWFXPJYjn1A9yOOZNpb2a6SMQVM5Xu6UIFfKHGO8smNky
         AL5bd5+E2i/ptLYKb9eR/KlxpD1+UcuF2AH36FHySgNN8rDMn4JC9QT6i4goRi22m7e3
         GHy6vNWCK3Sz915CvqXOqpuvvpNzIK5l8iJB3GI9MX42nY0OXvXTlS5XXUHqW2wt/wMF
         HH8MV/hYkQwO2TAmDjbm/sfimBgTiq+1mghSuX6SLb+kIHzA8AL20i3iuz+MmXy+aIO1
         5XCdXWUEwq9r+/55JJwX/WjmRrFji+7nO2AGZMK7s17IzrjJprtkbE4gc+twEws/6XBe
         oO/A==
X-Gm-Message-State: AGi0PuZNptE0I0WDqSINh8Qnm1SMYc0Z1z2Sz5M/JWd8lwJdX7IOmB3X
        XK1pUqIFVLUH7Fb/LNA99ShKPLNUPvPPsyeMoXtWB1/pz1ZC
X-Google-Smtp-Source: APiQypJdvcrg+aR58S2FEowGROs10MppJcSNDVTGB35UmZY5ZA1bV17WnWZlHjZMwBB+AaHxZWu05S2h25UB/7vDqvwQJi6PzhCP
MIME-Version: 1.0
X-Received: by 2002:a92:dcd1:: with SMTP id b17mr8371614ilr.80.1586360224353;
 Wed, 08 Apr 2020 08:37:04 -0700 (PDT)
Date:   Wed, 08 Apr 2020 08:37:04 -0700
In-Reply-To: <20200408151815.GG66033@xz-x1>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a89b5805a2c9450d@google.com>
Subject: Re: WARNING in af_alg_make_sg
From:   syzbot <syzbot+3be1a33f04dc782e9fd5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bgeffon@google.com, davem@davemloft.net,
        hdanton@sina.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+3be1a33f04dc782e9fd5@syzkaller.appspotmail.com

Tested on:

commit:         f5e94d10 Merge tag 'drm-next-2020-04-08' of git://anongit...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca75979eeebf06c2
dashboard link: https://syzkaller.appspot.com/bug?extid=3be1a33f04dc782e9fd5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1672dcede00000

Note: testing is done by a robot and is best-effort only.
