Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A642F29CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392272AbhALINf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392259AbhALINe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:13:34 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8110FC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:12:54 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n25so955357pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L2l6Rr1xN13fWChpqtRLf7qClNmYDaja3N/aO2Ct6fU=;
        b=J3ZLmDpu8FL3lT7WITcZlFarpkLVi/PFlw3OmqkZwP5yGPBiVyDF0xak8+32mvvcnq
         0/RWOC/JYi34v6SDdJLQhNbsdGO7X1u50r4UllA8tt9ztM5/Z1wYIbarLgIfRijuJCW9
         cDtqhJMuwcNGGCKMNek3vnF/yq+uuAosvYZG1dcmbGR8Hu++GOOfLlRHr+nOX7mqyFhh
         OS/62D1YvPcK+i80wG8Dt0HkeMzz2wimSexoKTr05O/+VipVqaDJFuNKDm1xSTj0B/PG
         9PkpTXeTDf6kZgA81wbxzauOoi8J6f19mkHyyzZaOS9a/8aWsXVshpeB1YruwCIW2VSr
         3Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2l6Rr1xN13fWChpqtRLf7qClNmYDaja3N/aO2Ct6fU=;
        b=FmrR7b31qYnNrHEFBVErJk4XfzQhVZ5zZq1R9XD/HfHF++kTnLybIPyUjQvY7EliS5
         NJIKNR8Ovc0K48xt4QuxKc6L3iGDjq8/S+RxctidNIKiwtTlJWq/uTwRW5IlAAo31aih
         YKbtKkibjOapljnmwiMmy4up33/TiKSUqC+RicCFiaLwDapDqA6yttJNaKdrR3aOVq3t
         T6NGqV0QPLHT/3/4Knh0g+XvTyU0Cwpr0o4B1gGl7cAmazfvQfvMrXEAkCcrrwgTGiGU
         KphgaIpMcNys6zsBtA3yDT+tK8xOt4Y9UOX1mu4zpB7pVi0QPzRw2UCCAPpF5dhq3f8z
         CfYQ==
X-Gm-Message-State: AOAM533yrYmZuLcyP2IU9fw/8odEKpE0fQD1ExIFzXbWP1GzvZhlw59A
        6JJ0bjRt1N4JKPrJZio55h0=
X-Google-Smtp-Source: ABdhPJz9J9f+9rKMUoT2drjKhr14BDBiNqjedY6nxz2BjkFex49ogtVZaUc6QVrN90NaBkCiaGxTkQ==
X-Received: by 2002:a63:3549:: with SMTP id c70mr3588502pga.361.1610439173993;
        Tue, 12 Jan 2021 00:12:53 -0800 (PST)
Received: from varodek.localdomain ([106.215.30.102])
        by smtp.gmail.com with ESMTPSA id l2sm2152381pjz.27.2021.01.12.00.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:12:53 -0800 (PST)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        David Airlie <airlied@linux.ie>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 0/3] char: use generic power management
Date:   Tue, 12 Jan 2021 13:39:21 +0530
Message-Id: <20210112080924.1038907-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20200717074937.296192-1-vaibhavgupta40@gmail.com>
References: <20200717074937.296192-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mentee: Remove Legacy Power Management.

The purpose of this patch series is to upgrade power management in char
drivers. This has been done by upgrading .suspend() and .resume() callbacks.

The upgrade makes sure that the involvement of PCI Core does not change the
order of operations executed in a driver. Thus, does not change its behavior.

In general, drivers with legacy PM, .suspend() and .resume() make use of PCI
helper functions like pci_enable/disable_device_mem(), pci_set_power_state(),
pci_save/restore_state(), pci_enable/disable_device(), etc. to complete
their job.

The conversion requires the removal of those function calls, change the
callbacks' definition accordingly and make use of dev_pm_ops structure.

All patches are compile-tested only.

Test tools:
    - Compiler: gcc (GCC) 10.2.0
    - allmodconfig build: make -j$(nproc) W=1 all

v2: patch-set rebased.

Vaibhav Gupta (3):
  amd64-agp: use generic power management
  sis-agp: use generic power management
  via-agp: use generic power management

 drivers/char/agp/amd64-agp.c | 24 ++++++------------------
 drivers/char/agp/sis-agp.c   | 25 ++++++-------------------
 drivers/char/agp/via-agp.c   | 25 +++++--------------------
 3 files changed, 17 insertions(+), 57 deletions(-)

-- 
2.30.0

