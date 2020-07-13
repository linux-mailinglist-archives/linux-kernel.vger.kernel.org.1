Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E3A21D0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 09:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgGMHrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 03:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgGMHrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:47:20 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E7CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:47:20 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so12322271wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQHRlmYiMy5z0WnxtNKRalmwQyJTVSmo3hN7/2Qvzas=;
        b=KHL9TfqHuic2Hz/gCGjHqEV4aXb+rqiIxhW2H0SIf95PQRa4bMGKzxcKNY/V0HaQCh
         FV3WMI7KMqZvdJMZLQIqhkncE2ybjODT8FbtRsxDnKV+4nRN9UaArVXi4PibDxnCCBgh
         Ga86GDhHwA3vJDwJOPNCgFmgF2wgxvnOjM7T1IXrGAtLr5AN6fKxkJGta0KvX7tr0g/v
         08KZHR0URgb652sx8tDibXdv/bjWR5rZvhMtIpKtL+K9M+MoW+jJe8/n9qMF8rmDJq6A
         bDBxqpp+t/g4wU79ff6v94+pBQFa0Pz5/QlwG64QEbTWP7WxFnU32Eiml8L1gkX7+TQF
         NRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQHRlmYiMy5z0WnxtNKRalmwQyJTVSmo3hN7/2Qvzas=;
        b=p+mJ6h4K/n2ABCphjbyslocouitsFVqd1fnXX8tkcIpGl1tbG/9xw8rx84lfWy0gcn
         NnDBpSkI2pNWr0rdou133LavaHvd++jvdT31fbQ0KAQ+8NbES3xRPwnTfDqh50NafOFy
         6cwH9wQ0HlV02sMzVQRdFhbx85/+IElgRATokEb7h3Xm9sO988u7R2ArEqXyaPcTTyHt
         lno7q5w8yZJKzLke+QveyoVaHgbZmOTj2C5POCwL8HIVvDhvMcluz4mUFMYslFjbpRMl
         OIcAekZmIAOTZhsbnWcmBy37LotwzIDsQXt6KUIBukPv6/UAO5Zx5viRLlkSdTDXWF9t
         3NsA==
X-Gm-Message-State: AOAM5310/gS0wfLkOlwrMuOxT7VqNCIzIrvSWZp2dq3waeSvbNbb7cGE
        fyvRsPkm+UfdMkkGE+1NiH/IqA==
X-Google-Smtp-Source: ABdhPJzgwrMYUQqLwI6VoW0qfTZcKcx1xciX4lkFCkQBG7dWKtjqLa9Y5l1ZR3O6y0+SbRr5gKv1Lg==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr17319246wmh.134.1594626438923;
        Mon, 13 Jul 2020 00:47:18 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id k11sm25142488wrd.23.2020.07.13.00.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:47:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        QLogic-Storage-Upstream@qlogic.com
Subject: [PATCH v2 29/29] scsi: qla4xxx: ql4_init: Provide a missing function param description and fix formatting
Date:   Mon, 13 Jul 2020 08:46:45 +0100
Message-Id: <20200713074645.126138-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713074645.126138-1-lee.jones@linaro.org>
References: <20200713074645.126138-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc function parameter references need to be in the format '@.*: ',
else the kerneldoc checker gets confused.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/qla4xxx/ql4_init.c: In function ‘ql4xxx_set_mac_number’:
 drivers/scsi/qla4xxx/ql4_init.c:17:10: warning: variable ‘func_number’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/qla4xxx/ql4_init.c: In function ‘qla4xxx_pci_config’:
 drivers/scsi/qla4xxx/ql4_init.c:664:6: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]
from  drivers/scsi/qla4xxx/ql4_init.c:9:
from  drivers/scsi/qla4xxx/ql4_init.c:9:
 drivers/scsi/qla4xxx/ql4_init.c:953: warning: Function parameter or member 'is_reset' not described in 'qla4xxx_initialize_adapter'
 drivers/scsi/qla4xxx/ql4_init.c:1168: warning: Function parameter or member 'ha' not described in 'qla4xxx_process_ddb_changed'
 drivers/scsi/qla4xxx/ql4_init.c:1168: warning: Function parameter or member 'fw_ddb_index' not described in 'qla4xxx_process_ddb_changed'
 drivers/scsi/qla4xxx/ql4_init.c:1168: warning: Function parameter or member 'state' not described in 'qla4xxx_process_ddb_changed'
 drivers/scsi/qla4xxx/ql4_init.c:1168: warning: Function parameter or member 'conn_err' not described in 'qla4xxx_process_ddb_changed'

Cc: QLogic-Storage-Upstream@qlogic.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qla4xxx/ql4_init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_init.c b/drivers/scsi/qla4xxx/ql4_init.c
index 2bf5e3e639e1a..5963127f7d2ef 100644
--- a/drivers/scsi/qla4xxx/ql4_init.c
+++ b/drivers/scsi/qla4xxx/ql4_init.c
@@ -945,6 +945,7 @@ void qla4xxx_free_ddb_index(struct scsi_qla_host *ha)
 /**
  * qla4xxx_initialize_adapter - initiailizes hba
  * @ha: Pointer to host adapter structure.
+ * @is_reset: Is this init path or reset path
  *
  * This routine parforms all of the steps necessary to initialize the adapter.
  *
@@ -1156,9 +1157,9 @@ int qla4xxx_flash_ddb_change(struct scsi_qla_host *ha, uint32_t fw_ddb_index,
 
 /**
  * qla4xxx_process_ddb_changed - process ddb state change
- * @ha - Pointer to host adapter structure.
- * @fw_ddb_index - Firmware's device database index
- * @state - Device state
+ * @ha: Pointer to host adapter structure.
+ * @fw_ddb_index: Firmware's device database index
+ * @state: Device state
  *
  * This routine processes a Decive Database Changed AEN Event.
  **/
-- 
2.25.1

