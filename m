Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6664528A1F6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbgJJWwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbgJJTFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:05:20 -0400
Received: from mail-pl1-x64f.google.com (mail-pl1-x64f.google.com [IPv6:2607:f8b0:4864:20::64f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174F2C05BD3A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 09:38:12 -0700 (PDT)
Received: by mail-pl1-x64f.google.com with SMTP id h20so8483086plr.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 09:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=j31NhuPOHM2geZWaaQJv3ikYyVsGXqVbWelRycz+tD0=;
        b=XN5sxKHVYxhjwnTvEvhl4CNobtqSLXE0Z9xY+r4U5NRBesrhOF9B88Tak2ApjTWTxr
         a78rN3/Hltrh+uL9O9dcVas2BEhm7OnR7KNf6uuEiTq2M6BeEAY/wDE629AWhvD8Xwmt
         oKEt3jshtcEwzT68TsXAP/mg9tXPLkTfDjlrmMJuqr1V6DU3xOvtDhB/OE5WoSnt8n5l
         /J6ncCjriEWqPObhm+FdsQDIWlMH2uSSknXeOyNSeLywzsPV15kIWvhByzQelmyXSwas
         jsN+U+pGrxQP098JwF40ia6B8CurfnbkUTGWoJMAA5yo8kNU5fv8lx6d6Loj/KA0epML
         vQpw==
X-Gm-Message-State: AOAM531HENS2B9jnbupLoAy0D8daAo3nMTjByy1aK8dDeF6H7CyGE1mH
        VAjboTv0DfG1ec3WaVC+nDaZbsjxiK3o1VPXWTEhl4aStyEi
X-Google-Smtp-Source: ABdhPJx0qf2gnVvR85VmXRDohn+cNhIC1jhkMLDhwNno11joOtr/W5u8fdFcI6aYLOLSV77D+vz4P6E2n6OED0dp3fa5TZJ1Lnm4
MIME-Version: 1.0
X-Received: by 2002:a92:874a:: with SMTP id d10mr13835218ilm.163.1602345365166;
 Sat, 10 Oct 2020 08:56:05 -0700 (PDT)
Date:   Sat, 10 Oct 2020 08:56:05 -0700
In-Reply-To: <0000000000004a624a05b05a756d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c5e7e05b1531ab0@google.com>
Subject: Re: INFO: task hung in nbd_ioctl (3)
From:   syzbot <syzbot+fe03c50d25c0188f7487@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchristi@redhat.com,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e9e006f5fcf2bab59149cb38a48a4817c1b538b4
Author: Mike Christie <mchristi@redhat.com>
Date:   Sun Aug 4 19:10:06 2019 +0000

    nbd: fix max number of supported devs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=171556f0500000
start commit:   fb0155a0 Merge tag 'nfs-for-5.9-3' of git://git.linux-nfs...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=149556f0500000
console output: https://syzkaller.appspot.com/x/log.txt?x=109556f0500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41b736b7ce1b3ea4
dashboard link: https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173d9b17900000

Reported-by: syzbot+fe03c50d25c0188f7487@syzkaller.appspotmail.com
Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
