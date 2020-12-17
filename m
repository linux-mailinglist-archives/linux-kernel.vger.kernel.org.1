Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85922DCAF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 03:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgLQCSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 21:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgLQCSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 21:18:13 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279BAC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 18:17:33 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id be12so1215977plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 18:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CINNwNMj6sXXA523Nvf46evyRHb0T5u+eLeN61gnr1o=;
        b=QmaJicxPMVcBstcSnuGZDWUScFyu4ScV1SnYs1wYrb+o/xM9p7E6lN2X/E5ksTJU/Z
         Vbl6PDDUBGZvuYN++ozUN3B3mG0QynuSS0rPXdIFJXgizXA/rYnqD2VuMVwBkwUQRYab
         l/U+F8WIJpDqp+KA4GKVMCUt031FhGd4x6gRNK5lXB8NmGq9e1UOZWB3Mg8VKnuiys2J
         NeqEbEbtH/DH/+tns8yCPA4JfyMYh08ZVMNFSKt7T8LmiqSyR3HSda5AVxxsCNC865cn
         BlLfNEjsrPl42VRlrwlTg9g0QWLLyL/q2lw3AE+Sh/ZW4pXGwpFq72FKfQK0YPDk2Y5c
         kTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CINNwNMj6sXXA523Nvf46evyRHb0T5u+eLeN61gnr1o=;
        b=DitalJLWmPNMRXlDxFTl1FqsyD+72VOrV+6puSakb5asIEh/HP+E97+qpGP7Zo2im6
         jsSKq/MQCqmJ9vNxEWM3nEzEvYdbYDVxb6I78HU4SR0HAUsDMcWS7ZlMbNZYMD4q/9xq
         3i/PAQFVtBlKmnEQDqqKD9bso8gyv6ilg+mIY5ruQsl2RA5NsM4k0tzd3UVKdGW5UVLk
         2w3My7um7j8UmL5hwmERdMyhktDz1BdjsogyxEUr6mG4LcAeNLi9Yp98Zuw1ixjzZUlU
         DjpiC/J1H1RHhfVMJPQSxB+SF7FgPGq5rKldN/5I5nvc+cfUR3h5Eph/hVoRHHYTklz2
         Cz6w==
X-Gm-Message-State: AOAM532lRcD2M3cq1cJEndUKLYSYpJPDHwTYV/biDen2qR0Mn0cfedNz
        Dk2b1s61I6EnvxLvkseGpPK+3KB2UBuB7iCwSUQ=
X-Google-Smtp-Source: ABdhPJwqr1mvO9dbo5PqiMldA3xijX7g6V5dfz+YwMtWPGag570MHgYcc1Ls8OGH2QK9UjadBEPdLicCZ5PqILTBloU=
X-Received: by 2002:a17:90b:100e:: with SMTP id gm14mr5676468pjb.179.1608171452638;
 Wed, 16 Dec 2020 18:17:32 -0800 (PST)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 16 Dec 2020 20:17:21 -0600
Message-ID: <CABb+yY29c=nw5Nm4J3Aq4mFtzFPTvS51sVmA9zM+KxHgDaHN=A@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.11]
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
The following changes since commit 509a15421674b9e1a3e1916939d0d0efd3e578da:

  Merge tag '5.10-rc6-smb3-fixes' of
git://git.samba.org/sfrench/cifs-2.6 (2020-12-01 15:43:53 -0800)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.11

for you to fetch changes up to 5a6338cce9f4133c478d3b10b300f96dd644379a:

  mailbox: arm_mhuv2: Add driver (2020-12-09 19:26:02 -0600)

----------------------------------------------------------------
- arm: added mhu-v2 controller driver
       mhu_db fix kfree by using devm_ variant
- stm32-ipcc: misc cleanup

----------------------------------------------------------------
Martin Kaiser (3):
      mailbox: stm32-ipcc: add COMPILE_TEST dependency
      mailbox: stm32-ipcc: remove duplicate error message
      mailbox: stm32-ipcc: cast void pointers to unsigned long

Sudeep Holla (1):
      mailbox: arm_mhu_db: Fix mhu_db_shutdown by replacing kfree with
devm_kfree

Viresh Kumar (2):
      dt-bindings: mailbox : arm,mhuv2: Add bindings
      mailbox: arm_mhuv2: Add driver

 .../devicetree/bindings/mailbox/arm,mhuv2.yaml     |  209 ++++
 MAINTAINERS                                        |    9 +
 drivers/mailbox/Kconfig                            |    9 +-
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/arm_mhu_db.c                       |    2 +-
 drivers/mailbox/arm_mhuv2.c                        | 1136 ++++++++++++++++++++
 drivers/mailbox/stm32-ipcc.c                       |   15 +-
 include/linux/mailbox/arm_mhuv2_message.h          |   20 +
 8 files changed, 1391 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
 create mode 100644 drivers/mailbox/arm_mhuv2.c
 create mode 100644 include/linux/mailbox/arm_mhuv2_message.h
