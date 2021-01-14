Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF19D2F565F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbhANBqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:46:53 -0500
Received: from mail-pf1-f200.google.com ([209.85.210.200]:47397 "EHLO
        mail-pf1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbhANA4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:56:33 -0500
Received: by mail-pf1-f200.google.com with SMTP id x21so2304164pff.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jlFSyFsy03pYVrVR3CcVIDgLJx11fHk/YYGYXYtjZt0=;
        b=HzIut8zBtPMmewYpB1K2CxerFM6pcdlcmIqCSlpP5iZqQdBpNwDT77NlIJQGYqXrpu
         cflH5JS2cja+leLL+AKN9tiFADJm9atqLiiU9BFrEbqhT1XawaThN75j4ivfKTsiD76a
         aLCKPQsbNKP9HN/qt1BkwDVBBevxv17QjS9XorOMB1qIXb/jKrKocnPf6t7FImNmZ/Po
         IbjsayfBPJWSyX/MA89U8MIH22n54RZq1aWb8H+VFFzOdngThefEJFMTpxKAdGTk6ymO
         hoPqnuVUqqJleHahuj4bjaORVGxuji2+D9lAj2zHTO1OkSTCsynDQXEGaB91KYcfGR2T
         ZbLw==
X-Gm-Message-State: AOAM532LRNeorFm5nj/CgwQu9qq38lQa8foXEnnwJCvOphNadlLmqAmj
        xsy5Ab8jwG5urucWRaQ0Wrppc1SXDi5ts93uCll0uDMdlK/v
X-Google-Smtp-Source: ABdhPJy1vepLrK0QdOGj3+JxVkfzwde1SE5dgoHnfXS4WCuUzSYJSlWakQM+9vHXU3TywlsRkPAATkcWJ2PnQeeUhpeBjEvjEIeS
MIME-Version: 1.0
X-Received: by 2002:a6b:784d:: with SMTP id h13mr3621423iop.26.1610585226627;
 Wed, 13 Jan 2021 16:47:06 -0800 (PST)
Date:   Wed, 13 Jan 2021 16:47:06 -0800
In-Reply-To: <20210113114136.4b23f753@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000504e4005b8d198c1@google.com>
Subject: Re: kernel BUG at net/core/dev.c:NUM!
From:   syzbot <syzbot+2393580080a2da190f04@syzkaller.appspotmail.com>
To:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, f.fainelli@gmail.com, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2393580080a2da190f04@syzkaller.appspotmail.com

Tested on:

commit:         3a30363e net: sit: unregister_netdevice on newlink's error..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git sit-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=bacfc914704718d3
dashboard link: https://syzkaller.appspot.com/bug?extid=2393580080a2da190f04
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
