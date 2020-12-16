Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376B22DC16F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgLPNko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:40:44 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:44943 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgLPNko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:40:44 -0500
Received: by mail-io1-f71.google.com with SMTP id a1so22022738ioa.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 05:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=H23gK52sCILiq088lhUQFDzvFZHl87rDPzyeRO8RNd4=;
        b=GZcbyLSIY34Mq7Nc0U5jhE5ueJ/yrq6jsqgNu2W8xiUuhJLSL035C7ao5N226LWYzt
         ljzxeVkooqQFbSbjIjXDvvdywA5Trb8swM/n/Zl6+jGMv1gQFyLduZ1jEVEaSZlCDiKs
         qUf/bsqoYLAVK/m4j7qFqtaDG+ElLI8YxBXPS/SSPMA5nj2R3HjsJiDBI0dCQPdNHIRq
         xH5a9RvaKwqGG92IQfGGF1mtxXrAKjxo610yoI/AlZ5MXDIYZ74x2cls4WncZUjgA55s
         QaJ3A9WUc3CEkRP38uwAaEhacQgUzB2Hmb/bnBu4V9y9D0Z5HAiNSFSu3FKE4XiZBsRP
         vQ+Q==
X-Gm-Message-State: AOAM5339eKG/MQkCrC3za72zSTPXTPIKUcPBbR19LKD7gOs8wbeXCeTU
        yr2cz6DPIZ7ymsZdG9gTVoTf7fOW2rpn5W0GwimPZe3Nd/gz
X-Google-Smtp-Source: ABdhPJycCbsLgF11aJGiLLu+8JEFqwjFZFOTcyTLJfHZRSLSOi8ZBEoTLEWIX6TXadn0g2BSEryafSecxWImCEYJifPSP/NC/og0
MIME-Version: 1.0
X-Received: by 2002:a92:bb84:: with SMTP id x4mr3410125ilk.298.1608126003067;
 Wed, 16 Dec 2020 05:40:03 -0800 (PST)
Date:   Wed, 16 Dec 2020 05:40:03 -0800
In-Reply-To: <000000000000f683660598300559@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002aca3d05b69503ac@google.com>
Subject: Re: INFO: rcu detected stall in sys_open (2)
From:   syzbot <syzbot+7ee926c5e237e614ccb1@syzkaller.appspotmail.com>
To:     bp@alien8.de, davem@davemloft.net, dhowells@redhat.com,
        fweisbec@gmail.com, herbert@gondor.apana.org.au, hpa@zytor.com,
        linux-afs@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1d0e850a49a5b56f8f3cb51e74a11e2fedb96be6
Author: David Howells <dhowells@redhat.com>
Date:   Fri Oct 16 12:21:14 2020 +0000

    afs: Fix cell removal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128ceadf500000
start commit:   c85fb28b Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
dashboard link: https://syzkaller.appspot.com/bug?extid=7ee926c5e237e614ccb1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1227c177900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13553f60500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: afs: Fix cell removal

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
