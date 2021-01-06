Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F4F2EBB73
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbhAFI6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbhAFI6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:58:47 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D25EC06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:58:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y23so1945993wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=t7SzucWW/7oyzTD4IWlg7LOeVx2wVOlCEClwE9Dp08M=;
        b=HttvI82OwlgE5zXupVNhzBU88c/MJUIKEpRMkaUslQc2vZhEyB6ugM6wCPIpgYU6en
         tJXAg/Uubl1OAfm4XXq+dtZEu+tq7v0uVuwOLlhHQD3JRVwt3fi+u1wOD849PU7oJ4kn
         xacrflG2SWcmV8ymu4Sc2hl80wxnd8kKthDCaLHGreV6y9NxuF+BkfWvKnvWjqKsz9C4
         fQtUNp0vpe3qCJz5i6pAcgkjdwZjsmyGJK3a52vfNwpnQgjMOMRbknVgv+T/7obP3kDi
         F4Fz0GQqJIC7joQg/QRQIeudoqorMdj/9xocOlMiHLNImlTdfPJejFE6Ug2jwgN7kquU
         7fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=t7SzucWW/7oyzTD4IWlg7LOeVx2wVOlCEClwE9Dp08M=;
        b=PPfv18pc0qQfCIXVIpyMTUh2+sDYBezop6LqrTq2fp5C/wccIdz1p1XBE3DjuTwQyT
         1p1nrtHccsvSXCwSWW5jAyOQOpuyJeRfGGvlOqEBT9+tHwQqUD4YkZtF5wUE3KTAdyQN
         viPa97Yi1OD9dgTOldIajktqTBjfSlsNhorKVFd7SfmrsQAR6uRVfTolYxOXctkmoex2
         4qLFFofdZ7uPUbe2tb48nGa/g8fAPssOhfby+ATGtUpGK9tyHwzj5uugvpdCfQMV71Yi
         eQF6WA30pg8kInlKdb8D70gaLcVmH6qVxytadMnr8SCYu5cYYTaPdTyz3FLC0lyrB+IO
         bjmQ==
X-Gm-Message-State: AOAM532FxLIujWADzndLXDrtNJrPYhGmdFMb8Aq68T3Qre90QmKOas8R
        SR+B1kX1LR+rpXaFBaW49K0jHE/CWCNwCmrFWqaZEqSNmVyxOg==
X-Google-Smtp-Source: ABdhPJwRPYBu19XyiMbDkEn+6U3v0A/B18JQofTB6G9Sheb5gTuTOo+VwZJfpOtNDJkzDsuQqV8NlN3pQTvOmOgeXz8=
X-Received: by 2002:a1c:7716:: with SMTP id t22mr2715851wmi.126.1609923485755;
 Wed, 06 Jan 2021 00:58:05 -0800 (PST)
MIME-Version: 1.0
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Wed, 6 Jan 2021 17:57:54 +0900
Message-ID: <CAM7-yPSa8kJkS2xm8w6hCgme7YmUOR8GBrx-kiQuUjGctF2QVw@mail.gmail.com>
Subject: [PATCH RESEND] irq: export irq_check_status_bit symbol
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the missing export symbol for irq_chekc_status_bit,
Building arm_spe_pmu.ko is a failure on the modpost step.

Below is an error message I saw:
ERROR:modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!
make[4]: *** [scripts/Makefile.modpost:111: Module.symvers] Error 1
make[4]: *** Deleting file 'Module.symvers'
make[3]: *** [Makefile:1396: modules] Error 2
make[2]: *** [debian/rules:7: build-arch] Error 2
dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
make[1]: *** [scripts/Makefile.package:83: bindeb-pkg] Error 2

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 kernel/irq/manage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ab8567f32501..dec3f73e8db9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2859,3 +2859,4 @@ bool irq_check_status_bit(unsigned int irq,
unsigned int bitmask)
        rcu_read_unlock();
        return res;
 }
+EXPORT_SYMBOL_GPL(irq_check_status_bit);
--
2.27.0
