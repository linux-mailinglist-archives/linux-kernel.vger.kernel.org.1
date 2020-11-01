Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7442A1C22
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 06:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgKAFkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 01:40:13 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:39939 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgKAFkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 01:40:12 -0400
Received: by mail-il1-f199.google.com with SMTP id g14so7864229ilr.7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 22:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=23OyltOe5EBhl8ArboyuBXKjLdoO9g+XhjDrucC98XU=;
        b=ox6BbDJIZ7oL1O1/F9XKjjEAr/+yLBFLTEI65Fw6tMO4VZ4SQVp6/vqmFi9ZbiZK4W
         BfBBufkuZM3zGI2uibE4I8K2ert9Jpm8Gb+Nk4le/u9QJ4bZwpl6k3y4YcWTO1SQxPjf
         aHI6r7D08wbTvaPMB6vg0BCv+jqJJIFZ/TLzwLl0q1Z5vqhyS5lILEy6ydgdVvPcXXS/
         iFb+vhijDOUSqBAtezhQoDMnFaE5AQMX68YqKrQj6bbDJNDkYoNnR7ShsS61yZe5qgMc
         5E00anAzTwSByfGGALZcRlJNRZUFKS8xZcd2y2HDKMXy3DsIicLpBHAYx9cI/C5RMHVc
         fSZQ==
X-Gm-Message-State: AOAM531fOQpCg+79uqEMs4cqME759eB1Qt3Yp6EwTafzUEddRv2vi8dt
        R50P0wya3IlIdCSKt4aw5QGT4A/duWtvv/4aPaoaow/VRjFP
X-Google-Smtp-Source: ABdhPJzop3BnuUmDv/RjS8YKnkYc3J7Hlabiq8WoaIZLlZjQOVQar2LUCPdvTKih8EIFknDVrPx1Mz5a6Yinm5bdbKguNde8y9Ej
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24cc:: with SMTP id y12mr7386176jat.144.1604209211179;
 Sat, 31 Oct 2020 22:40:11 -0700 (PDT)
Date:   Sat, 31 Oct 2020 22:40:11 -0700
In-Reply-To: <00000000000013259505a931dd26@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d865a05b3051076@google.com>
Subject: Re: KASAN: use-after-free Read in decode_session6
From:   syzbot <syzbot+5be8aebb1b7dfa90ef31@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, lucien.xin@gmail.com,
        marcelo.leitner@gmail.com, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit bcd623d8e9fa5f82bbd8cd464dc418d24139157b
Author: Xin Long <lucien.xin@gmail.com>
Date:   Thu Oct 29 07:05:05 2020 +0000

    sctp: call sk_setup_caps in sctp_packet_transmit instead

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14df9cb8500000
start commit:   68bb4665 Merge branch 'l2-multicast-forwarding-for-ocelot-..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16df9cb8500000
console output: https://syzkaller.appspot.com/x/log.txt?x=12df9cb8500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eac680ae76558a0e
dashboard link: https://syzkaller.appspot.com/bug?extid=5be8aebb1b7dfa90ef31
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11286398500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bbf398500000

Reported-by: syzbot+5be8aebb1b7dfa90ef31@syzkaller.appspotmail.com
Fixes: bcd623d8e9fa ("sctp: call sk_setup_caps in sctp_packet_transmit instead")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
