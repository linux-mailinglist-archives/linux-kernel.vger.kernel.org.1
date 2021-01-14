Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845612F5969
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbhANDer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:34:47 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:56646 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbhANDer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:34:47 -0500
Received: by mail-io1-f71.google.com with SMTP id m2so6270345iow.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=f22n4Aak+hB+/IuxcnatE3srzcBWoURgUFOb64w1dNE=;
        b=GH7UgPpypuYPYOJkbx79zX5nj0HwgTbCDOPgiH5JVP6kshBAMNyNW5gSGwc+RMGhyQ
         w5kFgKMrhetl8Qm0uk2PIXJCPF/lY+82lTQKfh+ZYHFhkrjxKkuCvdKUr5nuqtF0if7g
         rJHRaaX4BAaRHJ4yM5qMg9BEjms2RU5nGne2WRan0VrbtUJRWdW8FdwAzYwug6l40CdH
         yEbWcILSJlUlApkpIB6hmec0N1qovbP55Y+yFOTYDhFrK6g+03vRIrGHv/6711ZyOGwW
         a6yIohU88ox34nLXDkn3snM8etKtdPmoKarzkiNHgNcCfICAARcWCE2ZO79Shj2YYj1E
         q9Rg==
X-Gm-Message-State: AOAM5339b54uh1yPi9cfQoMXlJaMf41/gGDGX2hI1BLmFaG8rKu04D5K
        AwxLLamTa/oP16N0Utel1lWc+PIAjkQzLPUUY0+kroQUagfn
X-Google-Smtp-Source: ABdhPJzVfIo14TqfHwIBnkwUXlFkwsfabGz8IMixGLGwcg0hqqrLwUBpRANSVcJW4gHGkgBcAvUDMpUgixw3kbXug/YrfOIQujBq
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2243:: with SMTP id m3mr4942918jas.115.1610595246502;
 Wed, 13 Jan 2021 19:34:06 -0800 (PST)
Date:   Wed, 13 Jan 2021 19:34:06 -0800
In-Reply-To: <000000000000484e4b05b3bbdcf4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b7b2405b8d3ed48@google.com>
Subject: Re: WARNING in put_i2c_dev
From:   syzbot <syzbot+0a05df8ed151f2ed3a05@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit c318840fb2a42ce25febc95c4c19357acf1ae5ca
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Wed Dec 30 16:20:44 2020 +0000

    USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cddcaf500000
start commit:   2c85ebc5 Linux 5.10
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aff533d6c635e6
dashboard link: https://syzkaller.appspot.com/bug?extid=0a05df8ed151f2ed3a05
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a47b7f500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166f12cb500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
