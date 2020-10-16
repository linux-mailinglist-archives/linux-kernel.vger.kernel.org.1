Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7428E2906BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408482AbgJPOCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:02:07 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:35968 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408470AbgJPOCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:02:06 -0400
Received: by mail-il1-f198.google.com with SMTP id j19so1653813ilq.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 07:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+8FRC9A/2r22wNctHEmIcxNIQfOiXTrDIO/Luy9E2As=;
        b=JOPs1nKyXPK1ZZ8xJOz5z6Wt9IxzkEXRo7prFEkp0E3hEPSSO++OwnGCUzF8HwpkRS
         1juRbojCUA9eUcqeYhLC1krz4hntwQPbiE9b6as05Ce55PK053Pr4Zn9czS4QILTyqXs
         AOJav3jPjPgt1phlnpN7bPlJ0mOBS0JU/mCxtViIqK6+g/rh+BhuwzHck/CbTYy+kSIc
         HMkbw9K6xQrpdYP3kddSjg47kQXg1tI4gk61NRDEh0tzj1yGXisawowym5QjAv0OmV1X
         9p0cz3khXJ3C6R5JIMrU2xniTPqGKhqlZyTaSdrIOVWmDA5aMSE3fLPrI5ac2cAFAa5G
         6Q9w==
X-Gm-Message-State: AOAM530SwM+IS0kaLP2/ecqDUHSe2c37Eg8o28xeCjFL4gjCBfKCv613
        z0X5MkXUxxS84HPBOTgpXzMm0pZ+YvPt77HjzsTMDdkGCMVU
X-Google-Smtp-Source: ABdhPJzXx/UVlTNoX1P8zLcBnPNnAJAFocb3mI1+eNW4a73QQ+iZimlYfwfH7BMbzj9L4ezavZmc8yaJI33lozl/F0xz+c0NWFsn
MIME-Version: 1.0
X-Received: by 2002:a92:98c5:: with SMTP id a66mr2916184ill.50.1602856925126;
 Fri, 16 Oct 2020 07:02:05 -0700 (PDT)
Date:   Fri, 16 Oct 2020 07:02:05 -0700
In-Reply-To: <1423871.1602855728@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5ea6905b1ca3572@google.com>
Subject: Re: WARNING: proc registration bug in afs_manage_cell
From:   syzbot <syzbot+b994ecf2b023f14832c1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        hchunhui@mail.ustc.edu.cn, ja@ssi.bg, jmorris@namei.org,
        kaber@trash.net, kuznet@ms2.inr.ac.ru,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b994ecf2b023f14832c1@syzkaller.appspotmail.com

Tested on:

commit:         7530d3eb afs: Don't assert on unpurgeable server records
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=302928762dfb5528
dashboard link: https://syzkaller.appspot.com/bug?extid=b994ecf2b023f14832c1
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
