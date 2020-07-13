Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB25D21D122
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgGMIA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbgGMIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:00:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB8AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:30 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so12341768wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XHlEfo3tdu7fpK4dx4b1MtHnaLwguM9Twh58pG6oyd8=;
        b=CeT9LqTKAntJxO532RBKZSD2MmXajdTP2Z6TZsjFUos2Dy3AqQiKeqmzOQXLOdup5K
         oR9Jfvpc/IaLI5DHKjLZ3nTEB8sF7UYyDL/vrYeDWJPRBIq19lwaOe71zTjcxb8EEYZJ
         IHb63tKO7l/kaliVaH9+00BPFG2fPoqIMa4p7jFFQ+VJjSMs6z1wx8Q2skmsuMUqQQBo
         QEqn0NETKhS4uJDnyliVRpRQEe348zA7tfix6tX0dSpRIadSxns7p8COhLJLS9QdLhFt
         J2M/PHpxAxBC76pHYM3RFjlQi3JH+L/QEkYTospzXYKTUlDLQ2OBFM9bLkvfhMhrp4Ky
         sygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHlEfo3tdu7fpK4dx4b1MtHnaLwguM9Twh58pG6oyd8=;
        b=ABXq9NgFad0annppQtpgDaQmRgX/JkMGKmqiIDM05VN4JVTJi43ZcizNdwhsa+Uz8A
         B9+llPpdVtRjbU9orNvrynWp9VySa9zdChaasz3nblr7lXm3nBL8GI2ZJWVcW45k7TDV
         H3j/Kd8L1GVy+XN+VJSJAO5KyMPamhA4P+yocmI9A9WDJabCVz5Fg2ElS6C80eq7wwLC
         eRwAdG4vUpbaMfDQywT5RAA7zjpveDhsPRq9bx8Qp8D6TOQsHDusPnYqS0t1cnJvHxgb
         2V8AkNjKq97IwnZXGDhdEIU4kEiOpxy2oe8APhZ3OE3GhjRm+r5McB8rasLJ+hNa5T7f
         2NPA==
X-Gm-Message-State: AOAM5315DaCaD5A0UiHW0ubgYaGZUFswbWKNrGohtMFChiNLQMJbPYWa
        0Ka6ETuLniZ9Tn7aNIewwtEBdg==
X-Google-Smtp-Source: ABdhPJx88Pdx/IGjrSfBIXgCCFIBL5KfuufE/J4dRq+ZR/F1RbBZER6j/AS7USDE5pUVx4WBY8NA3w==
X-Received: by 2002:a1c:408b:: with SMTP id n133mr17672302wma.88.1594627228848;
        Mon, 13 Jul 2020 01:00:28 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id 33sm24383549wri.16.2020.07.13.01.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:00:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        linux-drivers@broadcom.com
Subject: [PATCH v2 19/24] scsi: be2iscsi: be_mgmt: Add missing function parameter description
Date:   Mon, 13 Jul 2020 08:59:56 +0100
Message-Id: <20200713080001.128044-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713080001.128044-1-lee.jones@linaro.org>
References: <20200713080001.128044-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also promote fully documented function header to kerneldoc.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/be2iscsi/be_mgmt.c:112: warning: Function parameter or member 'phba' not described in 'mgmt_open_connection'

Cc: Subbu Seetharaman <subbu.seetharaman@broadcom.com>
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc: linux-drivers@broadcom.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/be2iscsi/be_mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/be2iscsi/be_mgmt.c b/drivers/scsi/be2iscsi/be_mgmt.c
index a2d69b287c7bb..96d6e384b2b25 100644
--- a/drivers/scsi/be2iscsi/be_mgmt.c
+++ b/drivers/scsi/be2iscsi/be_mgmt.c
@@ -97,6 +97,7 @@ unsigned int mgmt_vendor_specific_fw_cmd(struct be_ctrl_info *ctrl,
 
 /**
  * mgmt_open_connection()- Establish a TCP CXN
+ * @phba: driver priv structure
  * @dst_addr: Destination Address
  * @beiscsi_ep: ptr to device endpoint struct
  * @nonemb_cmd: ptr to memory allocated for command
@@ -209,7 +210,7 @@ int mgmt_open_connection(struct beiscsi_hba *phba,
 	return tag;
 }
 
-/*
+/**
  * beiscsi_exec_nemb_cmd()- execute non-embedded MBX cmd
  * @phba: driver priv structure
  * @nonemb_cmd: DMA address of the MBX command to be issued
-- 
2.25.1

