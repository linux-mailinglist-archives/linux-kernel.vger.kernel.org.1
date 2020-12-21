Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA482DFDF9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgLUQXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:23:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725777AbgLUQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608567741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JsaAJBHqubdRAQb5CKtk/rEujCkt80qc4CgCqukMEgs=;
        b=TAHtnyVSODeSSMbHGDLGcpyMAx6KR4vvFz4wWIQmCSL4C9brYdybCZO5ejNhTMmsvw7NYA
        u+976eZzwQu76lrKd1M5CPu7LekLpSXJk+5Jv1LsmdbbeLinkmkrX/AkfeAWeHFwxfCiyA
        Ch+VAU8gpwtXhy2vT4pz8lOpDqO3htU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-7ZMoum2ROq-fuFlszDWDuA-1; Mon, 21 Dec 2020 11:22:19 -0500
X-MC-Unique: 7ZMoum2ROq-fuFlszDWDuA-1
Received: by mail-oo1-f70.google.com with SMTP id w3so4022392oov.16
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 08:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JsaAJBHqubdRAQb5CKtk/rEujCkt80qc4CgCqukMEgs=;
        b=fOaaDEXgMX+d9kDt0AbhQXpf+mDY02Fohplo6xrL4EnlpiRrmaCtdA6FTN7Y6Ff4U+
         Kx+At8o+0ZlvGU7iBRm1K1objeMUI3QCSwgluBljpKGxfQuM0Lpec2B0zoj/FPQb55GC
         6A3lrs91yLfNF9vd25ZzyGJINqbmAY7CvLFbs0xm6pwE2Cl2jPA6nJojXdXfNXUzpHei
         Aixwenmoqg7T4eLrL09d4pto49T28Lm1OkJtcbwg4rp54AExcs1XvyhkZhQF0m5VkTaF
         rm0SoWIzZ5QfORrCRD9b4CCJ4i131PyQMnd/p91pF2EkQQIYtIdZbyT7NVrm4o37Rc0g
         z37g==
X-Gm-Message-State: AOAM53053HWOkp/T1iQKrM52VQ0J5Iaae3GEWq2Eau+sDyCMzo+QmoTE
        0kUs65dSmqmXzZbb2ycE5WZZCPGMpIwcIs+bb2hl9vp1W9XfkInvgvu3tBXcDkWe1EK5swNipX7
        AVPl9m98mYt2uyX6KvzckCyw2
X-Received: by 2002:a05:6830:1bc6:: with SMTP id v6mr12472043ota.33.1608567738899;
        Mon, 21 Dec 2020 08:22:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwScQjxH+sKjnbs2a3cOOUeqJmfpCfnYSsPY+fJ/WnUiSpKosz8iLroTPNMtoECzxMSpw7s7A==
X-Received: by 2002:a05:6830:1bc6:: with SMTP id v6mr12472030ota.33.1608567738740;
        Mon, 21 Dec 2020 08:22:18 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 8sm4000851otq.18.2020.12.21.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:22:18 -0800 (PST)
From:   trix@redhat.com
To:     khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] [SCSI] BusLogic: add printf attribute to log function
Date:   Mon, 21 Dec 2020 08:22:12 -0800
Message-Id: <20201221162212.3755805-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Attributing the function allows the compiler to more thoroughly
check the use of the function with -Wformat and similar flags.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/BusLogic.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/BusLogic.h b/drivers/scsi/BusLogic.h
index 6182cc8a0344..b701fc8ba789 100644
--- a/drivers/scsi/BusLogic.h
+++ b/drivers/scsi/BusLogic.h
@@ -1289,6 +1289,7 @@ static int blogic_slaveconfig(struct scsi_device *);
 static void blogic_qcompleted_ccb(struct blogic_ccb *);
 static irqreturn_t blogic_inthandler(int, void *);
 static int blogic_resetadapter(struct blogic_adapter *, bool hard_reset);
+__printf(2, 4)
 static void blogic_msg(enum blogic_msglevel, char *, struct blogic_adapter *, ...);
 static int __init blogic_setup(char *);
 
-- 
2.27.0

