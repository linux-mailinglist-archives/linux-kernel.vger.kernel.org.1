Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1628D7AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgJNApK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:45:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53776 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgJNApK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:45:10 -0400
Received: by mail-io1-f72.google.com with SMTP id m23so1246388ioj.20
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 17:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZlnVN06zvE5cF9KZreYd2wyFcOusb7soW5MmKwdjdcA=;
        b=Vx9d07TlAyx/XwQpaV3tqnmDCnd3+ljMJ2+hng036nbDhmtB0b2cA876z0MJ/TC0Pi
         odV1IgI2VjvMk+fB+IPHHvhRDkJc46UvGE5PHu6ProY3+lMrcDMjUIsJWwsgFQ602iaD
         XAFnZTCXEI7zspUPChlRl8wSi19Mhq8fftqafcOUKQnexhbi8OqAIEi0Kmz/bcTbbyVA
         jgdhRgEaFeHt1n7cr3HJtXiWTpYRtKGC/5xrPe/bBVyQIsKIcgilQi7LTzhOPoKeoX/K
         z6HX5foIByH51uABVJ76remfV/W2477c35PdAbFDmjNrgK30OQW5YdLbx0zaTgNMAo6+
         iXXw==
X-Gm-Message-State: AOAM533gtdM+r5Ih7h8DXmd+Nnz+FcUnLRkc4ICa/jco0fjnW+qgifei
        bGalbyy7GfWlOuGzwEznmEoo1u8Py9SfyGG6urfdwOy2UA+0
X-Google-Smtp-Source: ABdhPJw4swHS/dpCZd6s1X5CU9CnyB+o5kjhxjq8HfcnLo08QTJaf/V+oern5AJ6ynrqdkK+8s7xs48l3i8GD2dpaoOc0eDeWe6U
MIME-Version: 1.0
X-Received: by 2002:a92:c946:: with SMTP id i6mr1954470ilq.199.1602636309649;
 Tue, 13 Oct 2020 17:45:09 -0700 (PDT)
Date:   Tue, 13 Oct 2020 17:45:09 -0700
In-Reply-To: <95f493a39c2a6cc2f45da2f7fe73d7febee927df.camel@linux.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0df8b05b196d7d5@google.com>
Subject: Re: general protection fault in scsi_queue_rq
From:   syzbot <syzbot+0796b72dc61f223d8cc5@syzkaller.appspotmail.com>
To:     hare@suse.de, hch@lst.de, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0796b72dc61f223d8cc5@syzkaller.appspotmail.com

Tested on:

commit:         69f4ec1e scsi: hisi_sas: Recover PHY state according to th..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
kernel config:  https://syzkaller.appspot.com/x/.config?x=caba25cc405f3c66
dashboard link: https://syzkaller.appspot.com/bug?extid=0796b72dc61f223d8cc5
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
