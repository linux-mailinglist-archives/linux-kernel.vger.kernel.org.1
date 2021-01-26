Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E230D303DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403749AbhAZMzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731344AbhAZMt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1F9C0611BD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:36 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f16so2328623wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X8BAzJFz4ZIrpg/Z+DKR2RrLgnadQAJiV/btseJ+HGo=;
        b=Mhc1dP5lYtWDjM7iP3QCf7se8IPXO5Zpw+dLL5XJ5foEKLkrFsse1ajEsjhcEnlufj
         K+THdxTRx2NC1k6nHlUU9gJTHgaPOOw+RbLYOlo7U20HVu3rdIzsI1AvQ3P8hFj4T4Uz
         x6Ruab8R7JXJv66upE2kqHcUlBrzag2mqp+qHZl13tSIoU6fRo0iSrjcpIqmOV71q12V
         YqO3rCKOoG4LOKOLRax2GuPWaHwl81QxMcX6J1CH8tK637ZoqXSLbhSbdPpevAxoWdud
         wvQnXQCTT5ZkEyXhOsFrRWHTqdOxgEoH7RTuI2BqrVJJV79CB8oQO3BtL3NK3ckS6EAJ
         CgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X8BAzJFz4ZIrpg/Z+DKR2RrLgnadQAJiV/btseJ+HGo=;
        b=em9N73KNdS4YdNOv5bwjAd2rmYDRXW2LFpJsV+4ojKYtZALV6XA52CI7XYK5rgjqIw
         ZZihnC4f8wnbuGRqtpctrjRlZaFGrTZEQPfBWQHeMXwkhttt+fsGAlqXOO4QT7cM3g3x
         VdQPlduNfGS1dBCITvsTdycKjpMMrIVKu8KdcaaHiJJrQAEinA2XqBJMuQbLj7hPqP0X
         5K+uQG03a+AEbtW0cZTGCA4jDw13NlTEmON1K8kG4vlQV5YVFSzCVay9612OxDCGm/ZY
         Vt8YDSimQOgBb32fPfc1S/5a5G4tQrF/jUiYfTrN+O1XQhFAgqM+QoMqlHXCNad5blXk
         3vkQ==
X-Gm-Message-State: AOAM530tZi8uL53/K004CChAxlxeg9/nKj0Qy3YK1D5dtvkoBQHd1qJl
        9GNppCGrpXIRsYpJuIsM6jvmYQ==
X-Google-Smtp-Source: ABdhPJxnIr7hKqNIROJ6CQJNvglpa/yGCZFNQOCByUbAhAXURtdmxS5i7pvkN0tgzQ4jq/v90uZ99A==
X-Received: by 2002:a1c:457:: with SMTP id 84mr4603536wme.148.1611665255554;
        Tue, 26 Jan 2021 04:47:35 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:34 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: [PATCH 00/20] [Set 3] Rid W=1 warnings from Infiniband
Date:   Tue, 26 Jan 2021 12:47:12 +0000
Message-Id: <20210126124732.3320971-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

This is set 3 of 3 sets required to fully clean-up.  All done!

Lee Jones (20):
  RDMA/hw/hfi1/intr: Fix some kernel-doc formatting issues
  RDMA/sw/rdmavt/srq: Fix a couple of kernel-doc issues
  RDMA/hw/hfi1/iowait: Demote half-completed kernel-doc and fix
    formatting issue in another
  RDMA/hw/hfi1/mad: Demote half-completed kernel-doc header fix another
  RDMA/hw/hfi1/msix: Add description for 'name' and remove superfluous
    param 'idx'
  RDMA/sw/rdmavt/mad: Fix misspelling of 'rvt_process_mad()'s
    'in_mad_size' param
  RDMA/sw/rdmavt/qp: Fix kernel-doc formatting problem
  RDMA/hw/hfi1/netdev_rx: Fix misdocumentation of the 'start_id' param
  RDMA/hw/hfi1/pcie: Demote kernel-doc abuses
  RDMA/hw/hfi1/pio_copy: Provide entry for 'pio_copy()'s 'dd' param
  RDMA/hw/hfi1/rc: Fix a few function documentation issues
  RDMA/hw/hfi1/qp: Fix some formatting issues and demote kernel-doc
    abuse
  RDMA/hw/hfi1/ruc: Fix a small formatting and description issues
  RDMA/hw/hfi1/sdma: Fix misnaming of 'sdma_send_txlist()'s 'count_out'
    param
  RDMA/hw/hfi1/tid_rdma: Fix a plethora of kernel-doc issues
  RDMA/hw/hfi1/uc: Fix a little doc-rot
  RDMA/hw/hfi1/ud: Fix a little more doc-rot
  RDMA/hw/hfi1/user_exp_rcv: Demote half-documented and kernel-doc
    abuses
  RDMA/hw/hfi1/verbs: Demote non-conforming doc header and fix a
    misspelling
  RDMA/hw/hfi1/rc: Demote incorrectly populated kernel-doc header

 drivers/infiniband/hw/hfi1/intr.c         | 16 ++++----
 drivers/infiniband/hw/hfi1/iowait.c       |  4 +-
 drivers/infiniband/hw/hfi1/mad.c          |  4 +-
 drivers/infiniband/hw/hfi1/msix.c         |  2 +-
 drivers/infiniband/hw/hfi1/netdev_rx.c    |  2 +-
 drivers/infiniband/hw/hfi1/pcie.c         |  4 +-
 drivers/infiniband/hw/hfi1/pio_copy.c     |  1 +
 drivers/infiniband/hw/hfi1/qp.c           | 14 +++----
 drivers/infiniband/hw/hfi1/rc.c           |  7 ++--
 drivers/infiniband/hw/hfi1/ruc.c          |  5 ++-
 drivers/infiniband/hw/hfi1/sdma.c         | 10 ++---
 drivers/infiniband/hw/hfi1/tid_rdma.c     | 47 +++++++++++++----------
 drivers/infiniband/hw/hfi1/uc.c           |  8 +---
 drivers/infiniband/hw/hfi1/ud.c           |  8 +---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 10 ++---
 drivers/infiniband/hw/hfi1/verbs.c        |  6 +--
 drivers/infiniband/sw/rdmavt/mad.c        |  2 +-
 drivers/infiniband/sw/rdmavt/qp.c         |  2 +-
 drivers/infiniband/sw/rdmavt/srq.c        |  7 ++--
 19 files changed, 82 insertions(+), 77 deletions(-)

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
-- 
2.25.1

