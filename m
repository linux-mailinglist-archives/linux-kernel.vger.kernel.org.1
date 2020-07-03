Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D19213609
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 10:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgGCIQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 04:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCIQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ABFC08C5C1;
        Fri,  3 Jul 2020 01:16:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bj10so7149990plb.11;
        Fri, 03 Jul 2020 01:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dX1y3EZXLwuCJAuG+s638H9srGw+Bv0i5V3KBJVUxbU=;
        b=HY9dYLnm3ErI+evPVxOOELTSXIrSfRXLyBecauxWz+4akfnnMTqeBHYlJ451fUPJJN
         nWCJDx0OyqnWliWCFUyRi2agBVfLxFPIJyaD57p1oPUynCuMYU/01uIWxkyPhwPhnYL3
         Oy0kE9SGnQEl4LcpTR4JIpYR/QncK76BYew3gOH2XMWDwOssy1obyTQqdoFiuQuD0q9Z
         qDK91+lQS5p8fTYJBsShymdiKb4+L/Fpyzi7Sipw+4WMVGLSOVyxCKgNMblxZ4BiR7YO
         2ty+ZbQ19OCGlOIB7idbdZS6JjgLj/ydJZ8dCvRP6JVnaphdtqIn+13rO8+zvJHuEuC/
         9W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dX1y3EZXLwuCJAuG+s638H9srGw+Bv0i5V3KBJVUxbU=;
        b=kSLtJJ6rhTgwdKxiYP1t2xU1QPJSWZMmUCJvifDZKFRZ/XJN5+lZ98spHVG/DuPKCs
         441FT1Y+Ns69tS9y9P+IzlfxUN/mFxy19APe2PjWx7oPR5wwIDMsr5byVa6lZeZ6nHHt
         sGBvKI3bltDp1quPpB29qeAqLHfChOGFwrMKJk/uSsul2Tf4XP75gGtgZB0eo71fhDes
         ioyK0T52wDj0ujLzyheMhwH7IAyqoar0hpcjUWde/WHri1cfNBzEK8LQLVqSvSEu0rJN
         aIlRVKnekwjw50HEtjmVGZ1xuoB/QxpRcVqSkolAlauVoUxyp7AOwqbkqsplD6OlhFSg
         MHYg==
X-Gm-Message-State: AOAM533D+EJIruRhe5UGaavjcV9VxaGxsgDSU5m5BZYOcLr4K/BYzeRt
        SH6WgI8EVi2VBtMpLc9r8GA=
X-Google-Smtp-Source: ABdhPJyu7elHooqc3ZPVMwTGcHHv784cEG5qJZel5gkB1yqKLwT51/PoIU1mh380wOPhTtCkGk/CIQ==
X-Received: by 2002:a17:90a:728d:: with SMTP id e13mr22595947pjg.51.1593764173155;
        Fri, 03 Jul 2020 01:16:13 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id y198sm8437085pfg.116.2020.07.03.01.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:16:12 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: [PATCH v2 0/4] drivers: ide: use generic power management
Date:   Fri,  3 Jul 2020 13:44:24 +0530
Message-Id: <20200703081428.1011527-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mentee: Remove Legacy Power Management.

The purpose of this patch series is to remove legacy power management callbacks
from ide drivers.

The suspend() and resume() callbacks operations are still invoking
pci_save/restore_state(), pci_set_power_state(), pci_enable/disable_state(),
etc. and handling the power management themselves, which is not recommended.

The conversion requires the removal of the those function calls and change the
callback definition accordingly and make use of dev_pm_ops structure.

All patches are compile-tested only.

V2: Kbuild had modpost error for undefined reference in v1.

Testing by:
  Compiler: gcc (GCC) 10.1.0
  Build: make -j$(nproc) W=1 all

Vaibhav Gupta (4):
  ide: use generic power management
  ide: triflex: use generic power management
  ide: sc1200: use generic power management
  ide: delkin_cb: use generic power management

 drivers/ide/aec62xx.c         |  3 +--
 drivers/ide/alim15x3.c        |  3 +--
 drivers/ide/amd74xx.c         |  3 +--
 drivers/ide/atiixp.c          |  3 +--
 drivers/ide/cmd64x.c          |  3 +--
 drivers/ide/cs5520.c          |  3 +--
 drivers/ide/cs5530.c          |  3 +--
 drivers/ide/cs5535.c          |  3 +--
 drivers/ide/cs5536.c          |  3 +--
 drivers/ide/cy82c693.c        |  3 +--
 drivers/ide/delkin_cb.c       | 30 +++++-------------------
 drivers/ide/hpt366.c          |  3 +--
 drivers/ide/ide-pci-generic.c |  3 +--
 drivers/ide/it8172.c          |  3 +--
 drivers/ide/it8213.c          |  3 +--
 drivers/ide/it821x.c          |  3 +--
 drivers/ide/jmicron.c         |  3 +--
 drivers/ide/ns87415.c         |  3 +--
 drivers/ide/opti621.c         |  3 +--
 drivers/ide/pdc202xx_new.c    |  3 +--
 drivers/ide/pdc202xx_old.c    |  3 +--
 drivers/ide/piix.c            |  3 +--
 drivers/ide/sc1200.c          | 43 ++++++++++++-----------------------
 drivers/ide/serverworks.c     |  3 +--
 drivers/ide/setup-pci.c       | 29 +++++------------------
 drivers/ide/siimage.c         |  3 +--
 drivers/ide/sis5513.c         |  3 +--
 drivers/ide/sl82c105.c        |  3 +--
 drivers/ide/slc90e66.c        |  3 +--
 drivers/ide/triflex.c         | 24 +++++++++----------
 drivers/ide/via82cxxx.c       |  3 +--
 include/linux/ide.h           |  8 +------
 32 files changed, 65 insertions(+), 150 deletions(-)

-- 
2.27.0

