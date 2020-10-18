Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FAD2918D0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 20:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgJRSWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 14:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgJRSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 14:22:45 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3408AC061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 11:22:45 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 67so10340793iob.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Xw9Ow2yHmo2oNd+ZTIMD+CJynhqcGFKv1PZK7QCU8/s=;
        b=mSZ9ypGM9AM0d+JDU0ZbF5QWU4hhICdKaXiltH7yUfzyYa4ClDif1dQG78EFOlMh/z
         BCBR+wbA2jgVo2t3ERNsTzQOPywwW7LIeNvKziUZ+GSvVillyxhd6BeJu0vY30sHSQau
         qLWsjBmCC+wH42L1hXGk9pveNUlGZ4vNoJbGHWuvh1gYPtZdHdR35afgKu93daxu8C8R
         C5LNPshotnwrMSLvC5Cvxh6T+AHbifC1nNmP2vz9843RX/XqsB9GhZ9mHGU726JG0zwD
         1iUnkGaBZ9pkAOQLn46D9qk8CZTMVdsayUGbaRihEAv4wbYu57R9LcmZbpoLuRAZ0IQ8
         H9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Xw9Ow2yHmo2oNd+ZTIMD+CJynhqcGFKv1PZK7QCU8/s=;
        b=FfBqqb08gzEGQc5THuu8qlY93tkdH6FkmtcoqxU9v9Kohy9nkMPkdtcAgywHE3n4iG
         nGedBwstrIX8Rv/bkO9jAeC3YSfTGITorzYKhQ2fyWCvTJGrO67FyBGtt2a4cTuwr+pi
         IzUI9n0zwlC33QsJnydYQoByOlwD0zoQssGIiMhgDb1823M2f8JZv35Uo4NWLAl5Rn3H
         jxVUd9hkrDB9BUkdbJZM0W/ZzedHS6sUI6qm3dAVgRBI3PYmMkneWfOv58GscTO+Cnsa
         lVaiM5b+HPC6Q+fgdRFKh6WHbqTJVds6RW+Cbv5Ah62jNotA24hiKRb9ApGdZh4kRTjT
         c54Q==
X-Gm-Message-State: AOAM5321bF24Vvz0uU/7RQ6wSxeb3RoJjusQw4rr2A9Ed6ywxAQY9dAX
        UZa9uJpMsF3rlU1hHptjQYW++DhPxrwiHpZJ4Qg=
X-Google-Smtp-Source: ABdhPJw4ASglTZ96vzxCiJQex7RAFstged7NTgtIOURelA0UA7CnNQkxhdwqdo5nu4qiu+udXyrtfgxfmIxU5+9QgKo=
X-Received: by 2002:a5e:9618:: with SMTP id a24mr8685558ioq.27.1603045364440;
 Sun, 18 Oct 2020 11:22:44 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 18 Oct 2020 13:22:33 -0500
Message-ID: <CABb+yY2hRBr7Uz9qtF9SUGzcUW6NNak0988v=0m0316erAYBTQ@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 549738f15da0e5a00275977623be199fbbf7df50:

  Linux 5.9-rc8 (2020-10-04 16:04:34 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.10

for you to fetch changes up to c7dacf5b0f32957b24ef29df1207dc2cd8307743:

  mailbox: avoid timer start from callback (2020-10-16 19:09:17 -0500)

----------------------------------------------------------------
- arm: implementation of mhu as a doorbell driver
       conversion of dt-bindings to json-schema
- mediatek: fix platform_get_irq error handling
- bcm: convert tasklets to use new tasklet_setup api
- core: fix race cause by hrtimer starting inappropriately

----------------------------------------------------------------
Allen Pais (1):
      mailbox: bcm: convert tasklets to use new tasklet_setup() API

Jassi Brar (1):
      mailbox: avoid timer start from callback

Krzysztof Kozlowski (1):
      maiblox: mediatek: Fix handling of platform_get_irq() error

Sudeep Holla (3):
      dt-bindings: mailbox: add doorbell support to ARM MHU
      mailbox: arm_mhu: Match only if compatible is "arm,mhu"
      mailbox: arm_mhu: Add ARM MHU doorbell driver

Viresh Kumar (1):
      dt-bindings: mailbox : arm,mhu: Convert to Json-schema

 .../devicetree/bindings/mailbox/arm,mhu.yaml       | 135 ++++++++
 .../devicetree/bindings/mailbox/arm-mhu.txt        |  43 ---
 drivers/mailbox/Makefile                           |   2 +-
 drivers/mailbox/arm_mhu.c                          |   3 +
 drivers/mailbox/arm_mhu_db.c                       | 354 +++++++++++++++++++++
 drivers/mailbox/bcm-pdc-mailbox.c                  |   6 +-
 drivers/mailbox/mailbox.c                          |  12 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 |   8 +-
 8 files changed, 506 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
 create mode 100644 drivers/mailbox/arm_mhu_db.c
