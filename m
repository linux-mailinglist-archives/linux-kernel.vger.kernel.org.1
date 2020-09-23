Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A855276019
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 20:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIWSju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 14:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWSju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:39:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04A4C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 11:39:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j2so787690eds.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 11:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FAP0TU2uPf481PQbEvwy2npjBiSvL3xKk9qiULyhTDI=;
        b=pS7LoSUFRBmfs4TqhR2/ItAtlPedY0WQT06Q3FkbUgVQKaRdFZgXcMtAk+teTn0ha2
         UU8bIjgOI1fGpj1oThc5J+bFJR06Iv5DHQ3vcLWeB290ObzCWu8VrMGI9BWr5iER9qQ3
         yQ6hlxfwrjyNZBC1R0tXV8XeF2k7PImSSqfXXYJdXaudpucKkdXVQdySH4TKNZKST80j
         lstaz6r5eoqvrVYPhDyVuZFwsqi3gnG6yQKHJX8DOVBOLnMqO5KPJ5mXn8/TIQeGiu6e
         Tx4FeIm2ZD3DUETNnH/hBuJZs+iJijiC6otSn+n+BGYV0qJRwCcEkz66DjijtDWnX79P
         76Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FAP0TU2uPf481PQbEvwy2npjBiSvL3xKk9qiULyhTDI=;
        b=oIhMozLHN+2zw8N3OAFRur+z/+8V195xtXgX5MY7xjjhPEmJvbD76Y+l0pci6ZE8PZ
         8TXC/H1BgJlWGweqdVCsn5Jn5FJP9ZUiH//1QUSp2c8gpNwVA/oon6g8VFx2HAp/nq/j
         ztKOFmcq1fFx0FYsoauBfqk1FI25qJ+ygxDEHWFpI0k9f4WSVBuIAlteA+SULsTI1hgU
         83ets58PSZUls4/uKB50Nqj4gPavX5VhNChZ0BUfGeRUvJFSfbOWff3gVTBaeeIn4CZL
         3HKYsuf9kyURCnMteemasb8eeXnC3ba+DBds4Mm2x5Aq+gOWqoAOmOZb3Ewf0SAEVCKK
         CeEQ==
X-Gm-Message-State: AOAM533xAsyDncwAY2FXCYUVpwnGmd7+GhLEFMqO8U2H79cepVfoH8pA
        2yY4brJ8ZaaEfA+h1pYSJMlx+CqEcuX93YQpbYau+fu5b/n8ITCY
X-Google-Smtp-Source: ABdhPJzyqiH3xwvh1apv/qXY4Ok5RjjteXpNPjw/EAy7up4BAsmksbGNf3vBvP0025Lq65pDhyaaV6U545ICPNrMv48=
X-Received: by 2002:a50:d4d8:: with SMTP id e24mr731780edj.1.1600886386948;
 Wed, 23 Sep 2020 11:39:46 -0700 (PDT)
MIME-Version: 1.0
From:   Ronny Meeus <ronny.meeus@gmail.com>
Date:   Wed, 23 Sep 2020 20:39:35 +0200
Message-ID: <CAMJ=MEc=bzSroEnEyWnVGz9-XkQAs1Wa5pdBNDSE-=PknEw8Aw@mail.gmail.com>
Subject: Kernel work in user context
To:     linux-kernel@vger.kernel.org
Cc:     Ronny Meeus <ronny.meeus@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have a system, running on a 2 core device, doing packet processing.
The kernel version is 4.9.
2 applications communicate with each other via IPC. One application is
receiving packets from an ethernet interface and after doing some
preprocessing it forwards the packets to the other application. Next
to these 2 applications a lot of other applications are running, so
the system is under high load.

Depending on the IPC mechanism I use between the 2 apps, I see a
completely different CPU load pattern.

The total load consumed by the 2 applications when using stream based
Unix Domain sockets (UDS) is 130% (200% =3D full load on the 2 cores).
The load consumed when using posix message queues is only 90%.
Apart from some IPC implementation details, the logic is identical in
the 2 tests so I cannot explain the 40% difference on the total load.

I was doing some monitoring with top and in the /proc/<pid>/stat files
of the 2 applications and I have the feeling that in the case of UDS,
a lot more system processing is done in the application threads. I'm
talking about the "stime" info the stat file.

When I read "kernel-hacking/hacking.html" in the linux documentation I see:
"Whenever a system call is about to return to userspace, or a hardware
interrupt handler exits, any =E2=80=98software interrupts=E2=80=99 which ar=
e marked
pending (usually by hardware interrupts) are run (kernel/softirq.c)."

Can it be that this is the case for the read/write system calls used
by UDS while this is not the case for the mqueue system calls
(mq_timedsend/mq_timedreceive)?

BTW the system is running with "threadirqs" enabled so that the irq
work is done in dedicated kernel threads.

Thanks

Best regards,
Ronny
