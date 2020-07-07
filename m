Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1BA216E48
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 16:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgGGOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 10:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgGGOBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:01:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18757C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:01:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f139so46660823wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jN1nbT1sxQbFlRXUCBfggkW/hnjjJGCQVCG/NPTfu6Y=;
        b=pjWCUJEZwyPxA5RaPU66fCI6rKNgDNOxWlKt8d8YsnOGnz9+M2K1koQ7iG9eKhjaFx
         g8YYXzC7TkDHe9hJ+8+ILM1uoCB/M+MHWG34tN2gn70O8IytBqRJWMHsFxODpQitWvEe
         sT1z3OQLglHZy7jLwHM8UGQsPz8CNy8aRD+rEndm5AA2TpFh6opalazJ6fET6JTQdH6o
         +tipp3x4BsKQaEnJZRxgT8WT7DN2KIDtAgsdP5DvogsK2YWShtueljfN3tKDaAN+lpu2
         YLnIN4NNKIPdCd2/DMVhL0hcCLI01P4Qqh9eyPNxWoFhcq6sDnQe2S9JbIZ4IQOte1b9
         to+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jN1nbT1sxQbFlRXUCBfggkW/hnjjJGCQVCG/NPTfu6Y=;
        b=Qpp3C+4iDbzwyIcrQCWk6CW0TQb2nqTdV0O8vUXNdKsOCIUlXLZkqKjfg2a5S2FxnO
         ZHconYZkfbA7kr7q2mxurCr8PJsTE0jDPG/4POSO0mH85kk2Zrr4B/74MLy2m9t2X/fw
         QOTA1tpwJBou+sJ7TLzNvAmMeL/44ct9tsH3TiqKWu1m11RLveBPxgXO+EYBkDT1nTjJ
         jsB3bcObPNmFDmzWnmVtuXBNJDpcTKRPYGa67kEkhBCvILcsyG8Orv6dU4dZs6XCrumR
         YkIYgLA+D8qSistzeBlPYkJuWbn7uDkFOFFhvmU8dcNZW8IyHG2S7l4jETXzPondczMJ
         1Wiw==
X-Gm-Message-State: AOAM530RyY3sit05pKWNRShKAzGnioifcfyQrJ6GJgpO81GHwhyNZ3gB
        Ztb67gvF58Xp2ofqazKsm3fBDQ==
X-Google-Smtp-Source: ABdhPJzUV97sKhk0cTprn9h4VIm8fJrhl/nqYSZ5hY14wPRhadSv020fwC6sc7z+gXrJDrbeBjfV5A==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr4547681wma.134.1594130461172;
        Tue, 07 Jul 2020 07:01:01 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z25sm1102823wmk.28.2020.07.07.07.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:01:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Atul Mukker <Atul.Mukker@lsi.com>,
        Sreenivas Bagalkote <Sreenivas.Bagalkote@lsi.com>,
        Manoj Jose <Manoj.Jose@lsi.com>, megaraidlinux@lsi.com,
        megaraidlinux.pdl@broadcom.com
Subject: [PATCH 02/10] scsi: megaraid: megaraid_mbox: Fix some kerneldoc bitrot
Date:   Tue,  7 Jul 2020 15:00:47 +0100
Message-Id: <20200707140055.2956235-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707140055.2956235-1-lee.jones@linaro.org>
References: <20200707140055.2956235-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some function parameters have changed without updating the documentation.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/megaraid/megaraid_mbox.c:3314: warning: Excess function parameter 'level' description in 'megaraid_mbox_display_scb'
 drivers/scsi/megaraid/megaraid_mbox.c:3985: warning: Function parameter or member 'dev' not described in 'megaraid_sysfs_show_app_hndl'
 drivers/scsi/megaraid/megaraid_mbox.c:3985: warning: Function parameter or member 'attr' not described in 'megaraid_sysfs_show_app_hndl'
 drivers/scsi/megaraid/megaraid_mbox.c:3985: warning: Excess function parameter 'cdev' description in 'megaraid_sysfs_show_app_hndl'

Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: Atul Mukker <Atul.Mukker@lsi.com>
Cc: Sreenivas Bagalkote <Sreenivas.Bagalkote@lsi.com>
Cc: Manoj Jose <Manoj.Jose@lsi.com>
Cc: megaraidlinux@lsi.com
Cc: megaraidlinux.pdl@broadcom.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/megaraid/megaraid_mbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index 8f918df631bfe..cace28dd81ad8 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -3304,7 +3304,6 @@ megaraid_mbox_fire_sync_cmd(adapter_t *adapter)
  * megaraid_mbox_display_scb - display SCB information, mostly debug purposes
  * @adapter		: controller's soft state
  * @scb			: SCB to be displayed
- * @level		: debug level for console print
  *
  * Diplay information about the given SCB iff the current debug level is
  * verbose.
@@ -3972,7 +3971,8 @@ megaraid_sysfs_get_ldmap(adapter_t *adapter)
 
 /**
  * megaraid_sysfs_show_app_hndl - display application handle for this adapter
- * @cdev	: class device object representation for the host
+ * @dev		: device object representation for the host
+ * @attr	: unused
  * @buf		: buffer to send data to
  *
  * Display the handle used by the applications while executing management
-- 
2.25.1

