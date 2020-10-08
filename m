Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56BC287D15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgJHU2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 16:28:12 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:39005 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730312AbgJHU2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:28:11 -0400
Received: by mail-io1-f78.google.com with SMTP id s135so4632098ios.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 13:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7y3B3XsOiPTLYLIDns6NguVsL9ucnpw4TXcZn72tI0c=;
        b=UygwF6DWIk2VhJRxUu6cJwV/zXPTJLav7yLMs9vuCTlniBMHVbK40VDZ34ITa9cGmz
         oNrTSLHxvoNLtZGsokAm6PrzxiGGqnbF6RnI/HLQRhkit1OHRsdtnntKI7wRgdAKDQHS
         GdSTkGZGKmQUODkkZSdXlwyNU9A4BIndMT20J4csFFy+hUUtkS3tB9Yl2Ibuyn4m8WXC
         H3UPucyhGPYRD6o8cSCZsPu+mhFjukSbuxmHUVQNzhilQoELycUJw9tXrOcwQV0f693G
         pOw0Cp48N4xDja4FwQY2jrqKxl/Zy1hnbw9DXZTnoLXbuQDLbGPiIImmD4mQSeHsrrd+
         khCg==
X-Gm-Message-State: AOAM533egAGwMKazIZUA/sQMymESh/q1Y4q5/VxsnStTQ6b2CRowCtM0
        2rLtfDkhHClS3cWWi8urIH/LQ2J2BDyMyxgHrPCDFv5TmMSX
X-Google-Smtp-Source: ABdhPJxQG7zkhxy1g7ndmakw3pFTvWpidkFGm3ConSOutpg5F4NLy+BDbf/l7aHvxuH3DwXEGuIgtAHY6s+z1objQuaP9/PVvEnF
MIME-Version: 1.0
X-Received: by 2002:a92:1f44:: with SMTP id i65mr7622723ile.280.1602188890683;
 Thu, 08 Oct 2020 13:28:10 -0700 (PDT)
Date:   Thu, 08 Oct 2020 13:28:10 -0700
In-Reply-To: <00000000000084dcbd05b12a3736@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1412b05b12eab0a@google.com>
Subject: Re: general protection fault in percpu_ref_exit
From:   syzbot <syzbot+fd15ff734dace9e16437@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bcrl@kvack.org, hch@lst.de, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, viro@zeniv.linux.org.uk, vkabatov@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e
Author: Ming Lei <ming.lei@redhat.com>
Date:   Thu Oct 1 15:48:41 2020 +0000

    percpu_ref: reduce memory footprint of percpu_ref in fast path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126930d0500000
start commit:   8b787da7 Add linux-next specific files for 20201007
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=116930d0500000
console output: https://syzkaller.appspot.com/x/log.txt?x=166930d0500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aac055e9c8fbd2b8
dashboard link: https://syzkaller.appspot.com/bug?extid=fd15ff734dace9e16437
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119a0568500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106c0a8b900000

Reported-by: syzbot+fd15ff734dace9e16437@syzkaller.appspotmail.com
Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
