Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82ED2EAB1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbhAEMoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbhAEMoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:44:20 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BB3C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:43:40 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z9so20675117qtn.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Ss0QCF7Y8CyjkIJ80E3ToE95jVj97tBQfOx1Qgnaa7U=;
        b=I30M791tveabVZ9iq/bJrQxBXUvm/1hVFe24L7Lwy74dr08bI/Fa3oxWsdEN7aml1o
         3Vow8F6QbRjAAl9h/XlG6Oyp5wY2CG84AGNPiqraViGB6ulFzeZxcJdDILXdkesqaOvx
         qq07/VTnFsZZCTe5h9q5LcOXNx4d/dTOsbiNsTMu0RWzWS3BOKGIfkJ6hN7M/SqsF/nf
         OFMFzEWcqQdHjGlpfo92svqWhUHdKvKblfB0pDI9GcVVFOCuZ5Jtx/q/Jx5mubEiHdt4
         XYP/FqfHwMqEw8hOA768QQCfynbv2YMENT6HhglKpw2yDcaxzm0ZerA2RwqPG6tgJw7C
         3TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Ss0QCF7Y8CyjkIJ80E3ToE95jVj97tBQfOx1Qgnaa7U=;
        b=mgr/hzRqFgTyWOTFIHFf13VDfQTrS1npAZycTljI1YuODf1TaVqVhQJnaNuBV7WS1D
         B4NMKgsaws8MiT90WJl1BVuFGIsVnFWbV0k7nkyQgdt6ESyc2+U8iEXTqL1TiHcC6vHd
         Bt7RysaGxLRFYrqjTElHf0FrWuI/SIKhht77npirb2AAC8+kz6eLBhRbctI6D/mg86Ow
         FO2wfeWi6sWnIN5LjG3zZRVDDk7lCUUkgKAQMdMYCPIXTSfrJOEoWChdWQTbObARtPG4
         HTmsKCpAMfIgo9+bEO7Kf5i90Xr7cCXXppZZNxyqfmTtfVZJIlNXBRdHAyBdl8yWm0N2
         JZOQ==
X-Gm-Message-State: AOAM5321AuhpHhuf9IAsaGGF3kE+sFAHUNdcJ8eZcgxFQKLPM8B90TGD
        pWSifaYcNbwXWAFkBVUYq1F4SaR2xyH05pY1ZuUmoiRYTkEHwA==
X-Google-Smtp-Source: ABdhPJyjwG1U03oRe5eHZ5SEwKBd9rKNCnPcesIkLV/MZGkGZcW6920phbPNDiANTE+bu8dIJP6nrWlgKi+jGyjcQ9g=
X-Received: by 2002:aed:208f:: with SMTP id 15mr73851418qtb.290.1609850619344;
 Tue, 05 Jan 2021 04:43:39 -0800 (PST)
MIME-Version: 1.0
References: <000000000000880dcc0598bcfac9@google.com> <0000000000000b157705b7f2eefd@google.com>
In-Reply-To: <0000000000000b157705b7f2eefd@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 5 Jan 2021 13:43:28 +0100
Message-ID: <CACT4Y+aq1-9hHzFJZedN3R-ahuxQSus5pXYxhaZbzWa-uWrFrQ@mail.gmail.com>
Subject: Re: possible deadlock in process_measurement (2)
To:     syzbot <syzbot+18a1619cceea30ed45af@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 12:08 AM syzbot
<syzbot+18a1619cceea30ed45af@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 15a8d68e9dc23dc9def4bd7e9563db60f4f86580
> Author: Wei Yang <richard.weiyang@linux.alibaba.com>
> Date:   Tue Oct 13 23:56:33 2020 +0000
>
>     mm/hugetlb: a page from buddy is not on any list
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13612350d00000
> start commit:   1590a2e1 Merge tag 'acpi-5.8-rc3' of git://git.kernel.org/..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bf3aec367b9ab569
> dashboard link: https://syzkaller.appspot.com/bug?extid=18a1619cceea30ed45af
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c79dbb100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169bba3d100000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: mm/hugetlb: a page from buddy is not on any list
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: mm/hugetlb: a page from buddy is not on any list
