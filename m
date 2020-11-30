Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176872C89E0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgK3Qr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgK3Qr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:47:57 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B32C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:47:11 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id z7so17074757wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxmBi2j3Zu/diNdwa9NP5Pzem+6qya5Hy2+e8magSPM=;
        b=ivWWB7L33Sv7AncDB32Vi6gvAlkNjnnIN86KjUbdC3b8MvOo1shukfaxQKM40lqZZY
         PCbUAZZMVU7GAlRLTgVguDGiGWfauolu0l5hfIFUXAi5KtOfSBVPFMG4MMrqx8t85Ssv
         IvcBn91erDzU2POwcYgheC1F7O96B5xQvW6Irta4efM+DoHIOnDYD0KsSpdWyO8EwVGr
         ak1mBbvkii7LQx6U1gZ6PD+LsjbLv3wuJCjXzp05wvq2DBFK3FTqbRcbO9CMyltMJHos
         IUhc0pQ7n7Ptn1cs6mx74XFcbvbrsbsnDAcmD/OeIoZaCDlgIXhvRKo5Oz+i9TFzNl6W
         wTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxmBi2j3Zu/diNdwa9NP5Pzem+6qya5Hy2+e8magSPM=;
        b=sCg+E0G+N3f90m6WQrP9N9EEZ40pZp+YcUltM9U0KMVlbQhSqQOBaDGsdWV8cOj+Yj
         T89k9fEfAXO7z7tTDxw+ejfc+pOOV7IRRL3/hrRn4QKvst4iFEgqJ5fNs4WFqcY0PmB5
         uSvDODCH4WJoI86CMDZVf7yrBOWERXjVVmotDxbhKe8pckM4ALJ7jGTwZso217ppRk6T
         xttqsbouqGn+lgsmXozNcFjyNFYhDIF/y+bV93GqgY+7U1WUV+Yt+bmoSFSUSuYdQOlZ
         /I+Gj1geM3pLowIcxoNSP67RB+JNUoYUWlkMAUof998otKcCXlYH4fN5A3kS6rbi8WIO
         DL6w==
X-Gm-Message-State: AOAM530Ru3BqHKq9zKqnkuEmxs8BEf0+0SPPE87zj+Mlkhbu6uJMkaFS
        W4qdZ40AmJQOatiW8ELmhpfuDA==
X-Google-Smtp-Source: ABdhPJzXdR0RmiNzosMsDwvDJRs/h650LcA8WFFqbcRTQ/E2ynYgo3kqGzMzanLq1DpQT6emPCCaQw==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr30586128wrr.1.1606754829840;
        Mon, 30 Nov 2020 08:47:09 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id b4sm8400805wrr.30.2020.11.30.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:47:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/4] configfs: implement committable items and add sample code
Date:   Mon, 30 Nov 2020 17:47:00 +0100
Message-Id: <20201130164704.22991-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Committable items in configfs are well defined and documented but unfortunately
so far never implemented.

The use-case we have over at the GPIO subsystem is using configfs in
conjunction with sysfs to replace our current gpio-mockup testing module
with one that will be much more flexible and will allow complete coverage
of the GPIO uAPI.

The current gpio-mockup module is controlled using module parameters which
forces the user to reload it everytime they need to change the chip
configuration or layout and makes it difficult to extend its functionality.

Testing module based on configfs would allow fine-grained control over dummy
GPIO chips but since GPIO devices must be configured before they are
instantiated, we need committable items.

This implements them and adds code examples to configfs_sample module. The
first two patches are just cosmetic.

v1 -> v2:
- fix a 'set but not used' build warning reported by kernel test robot

Bartosz Golaszewski (4):
  configfs: increase the item name length
  configfs: use BIT() for internal flags
  configfs: implement committable items
  samples: configfs: add a committable group

 Documentation/filesystems/configfs.rst |   6 +-
 fs/configfs/configfs_internal.h        |  22 +--
 fs/configfs/dir.c                      | 237 ++++++++++++++++++++++++-
 fs/configfs/file.c                     |   8 +
 include/linux/configfs.h               |   3 +-
 samples/configfs/configfs_sample.c     | 150 ++++++++++++++++
 6 files changed, 406 insertions(+), 20 deletions(-)

-- 
2.29.1

