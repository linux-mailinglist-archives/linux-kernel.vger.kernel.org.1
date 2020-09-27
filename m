Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AD427A165
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 16:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgI0O3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 10:29:11 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:54406 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0O3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 10:29:10 -0400
Received: by mail-il1-f205.google.com with SMTP id f4so6636933ilk.21
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 07:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iCeP7IjOo2Hlq0UPmdkKG9qIQjxyS5bd1Y3NOX50t+0=;
        b=rwGLYaQ0JQtvNDgpXxkST9fw79mwyz1Rq/noDQCHrcfpAa8EJ83/AKuyfgxSrFaCw+
         1PpgNgnlsVve463EYjzrUTmGvYcDr119X4Pqtq4dJUdFwWnnupgZ+p1mU2cCeOhOJbYI
         pZW29VFFyPEJX6WsIiUtrq3i4PABpXvBjkje8w+H6jm+XlK7hrJBifwmA20Cd+OgBAXu
         ot74L6/V7oFRqp1DzuH0tFFPPlL0c1BbfK3cjlY5FVT85K6RTjSMDRfXgeq+qianpIno
         fmRD6fb5gBK0dtgsGGhxf1c/PW8R3r9lUHyelNF0JlUNjz4CnSm36NrjqtyDbdMbxDhH
         opUQ==
X-Gm-Message-State: AOAM532nBMdiH7wwMKpQg1Iz2Er4Gs4UDSA0Oo4r52JAcC/4lEdp9zoJ
        Q3wuALBDHhX1avy/fsOcLMQKjDY1p88VuJfhOFXYGUjVy977
X-Google-Smtp-Source: ABdhPJzSnnM2y4SNlhtJwTtaS8AAXKQiaBSWsw5kGRsxEpDRyxijBbiKIWYkwjEk/3KFDNFGigpdVrGvz9UsIxoMAcRuYP0BiQTV
MIME-Version: 1.0
X-Received: by 2002:a02:a30b:: with SMTP id q11mr5628610jai.77.1601216949607;
 Sun, 27 Sep 2020 07:29:09 -0700 (PDT)
Date:   Sun, 27 Sep 2020 07:29:09 -0700
In-Reply-To: <000000000000bd9ee505b01f60e2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d5ec805b04c5fc8@google.com>
Subject: Re: WARNING in hrtimer_forward
From:   syzbot <syzbot+ca740b95a16399ceb9a5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hchunhui@mail.ustc.edu.cn, hdanton@sina.com,
        ja@ssi.bg, jmorris@namei.org, kaber@trash.net,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 0e7bbcc104baaade4f64205e9706b7d43c46db7d
Author: Julian Anastasov <ja@ssi.bg>
Date:   Wed Jul 27 06:56:50 2016 +0000

    neigh: allow admin to set NUD_STALE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1661d187900000
start commit:   ba5f4cfe bpf: Add comment to document BTF type PTR_TO_BTF_..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1561d187900000
console output: https://syzkaller.appspot.com/x/log.txt?x=1161d187900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d44e1360b76d34dc
dashboard link: https://syzkaller.appspot.com/bug?extid=ca740b95a16399ceb9a5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1148fe4b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f5218d900000

Reported-by: syzbot+ca740b95a16399ceb9a5@syzkaller.appspotmail.com
Fixes: 0e7bbcc104ba ("neigh: allow admin to set NUD_STALE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
