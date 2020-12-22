Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E9B2DBBDE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 08:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgLPHPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 02:15:44 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:43302 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgLPHPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 02:15:44 -0500
Received: by mail-il1-f200.google.com with SMTP id p6so18640785ils.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 23:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=36zW/PbpiTCKuG8Esvh3+4Beyh5+p/0KAx49415NdvY=;
        b=iBjZG9XlzqdsCA0oOrNjy3j2EQipGYnxqo3XoL6O0nYDiVFIWRTboHHbbNYtNHzGjM
         R/5lQw44LnR8uesXDTNU2ZgImGgSAYkKbnPutC9Z8sJbgJmoJ+U+2Y+2Uodm07ND32q9
         R7r+af0iyuxY6U+CRSPQWW50IpXz+sNFF9W0qxKGil1KBZkRXfELdKeCYrEei9Jjwv3p
         VRsZNmhKKn5981c6rN+D/5ESFb8rQmKEeySDDG2t+Ubm9BQHXf/hT5kg3QpSDH9rq4Mh
         GZ9QbMfEJrrHz4deED/y8PCbDf1wpZYC8YMaXrceBsi4LTh+22GEL3lK41i1Fow755HC
         aYYA==
X-Gm-Message-State: AOAM532MV7lBNPwbMJ4bv02XEwIWFrNxeMMRDx7MS0dExDR6FZP+D1me
        yK4k17fhvVqKgApAgarQ+ci7+zJeASppuJyvo5UslytfnGmk
X-Google-Smtp-Source: ABdhPJyE+w4DQGI1MtjxdqzF3IywhKSts84lZVnS0w5MQcPUmCQp7IMO10IRfWgV2p9/kkfUbcykf9u+Dd+WT8lfjHM/CdRp4VIy
MIME-Version: 1.0
X-Received: by 2002:a6b:c9cb:: with SMTP id z194mr40484133iof.110.1608102903193;
 Tue, 15 Dec 2020 23:15:03 -0800 (PST)
Date:   Tue, 15 Dec 2020 23:15:03 -0800
In-Reply-To: <000000000000ab11c505abeb19f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ea4fe05b68fa299@google.com>
Subject: Re: KASAN: use-after-free Write in __sco_sock_close
From:   syzbot <syzbot+077eca30d3cb7c02b273@syzkaller.appspotmail.com>
To:     anmol.karan123@gmail.com, coreteam@netfilter.org,
        davem@davemloft.net, devel@driverdev.osuosl.org,
        foxhlchen@gmail.com, gregkh@linuxfoundation.org,
        johan.hedberg@gmail.com, kaber@trash.net, kadlec@blackhole.kfki.hu,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        marcel@holtmann.org, mchehab@kernel.org, mchehab@s-opensource.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 6dfccd13db2ff2b709ef60a50163925d477549aa
Author: Anmol Karn <anmol.karan123@gmail.com>
Date:   Wed Sep 30 14:18:13 2020 +0000

    Bluetooth: Fix null pointer dereference in hci_event_packet()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cb845b500000
start commit:   47ec5303 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c783f658542f35
dashboard link: https://syzkaller.appspot.com/bug?extid=077eca30d3cb7c02b273
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165a89dc900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130a8c62900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Fix null pointer dereference in hci_event_packet()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
