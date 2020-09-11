Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956ED2669C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 22:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgIKUxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 16:53:12 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:44145 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgIKUxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 16:53:06 -0400
Received: by mail-il1-f198.google.com with SMTP id j11so8068934ilr.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YVXF1g4+lOmnjRf2AcTsASLYPgunWmQEGdeWgbAB0oo=;
        b=OjnF9Aeenf/IJ9yHXMwmHKcBrnnQ63A8HgEKb65xqlCELSAWN6q5jzsXthVc6HHj/i
         /haSLg6x/+bCAkwIJ/MEd8J9Yw0oHBGsFQP5hwuiQrjSXlwoJ4mS5nO+dcUQ3gCGSnmR
         ihayYq2UeoEE7/p+xIbqI92R8IUe+ddpNoTuar+j2AHWdiu8qhWH4zuUVf+D/A8fj85t
         jnTocU2T3pVQx35vqll0W/LK/e8dF2d8C5kwt7t75Zid/q1gd64Flf3y/WTgbTnD1/hP
         2/HQglEQ4WWhuoE48ON6uy8vVTX9zIv1MSzm130jqW+umS44TwMWtbr2SCtI3EKU/vQJ
         x5YA==
X-Gm-Message-State: AOAM533J43DO7D+LYdBplynFaeI7Xb30QD7qYNUnzH+ZRsLqpNJ74O+0
        ZyXYZXOGsoJ2/VPEjBK3nWtzQcGt/qLDIBq354KqLMratoo/
X-Google-Smtp-Source: ABdhPJxvuILFl1zVwslz3rOXPBUJrgVwPlDzIfXnq3TUXyLZVXcmchDm7ZTsSvK4buPOgx+5ucO7SLVwjQCZGdi+a624IWfjO167
MIME-Version: 1.0
X-Received: by 2002:a92:8709:: with SMTP id m9mr3488137ild.242.1599857585493;
 Fri, 11 Sep 2020 13:53:05 -0700 (PDT)
Date:   Fri, 11 Sep 2020 13:53:05 -0700
In-Reply-To: <20200911181939.GA1221970@ziepe.ca>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000131cf405af0fdfd0@google.com>
Subject: Re: KASAN: use-after-free Read in ucma_close (2)
From:   syzbot <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com

Tested on:

commit:         7c003f9a RDMA/ucma: Rework ucma_migrate_id() to avoid race..
git tree:       https://github.com/jgunthorpe/linux ucma_migrate_fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=cc6fc752b3819e082d0c
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
