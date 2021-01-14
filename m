Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294182F58A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbhANCqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726962AbhANCqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610592305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DPxb5ET8kJn+yePURBnBONcqbnXWa5runmC5LYkViy8=;
        b=ES2LdvSoLWcAjeRqGtUHyyO6/xRPiD0ETb175T86O1gkz+Edktg2xlnSAxGWGKNITTv8I3
        0hfOhWeXOgB2eq7H/JrcuO3tMQRTzRj967t7v31L0U/YY0fC9sx+iCXBnMPb5adDN6Ld2g
        rL9e+Oku98Iocxf+tUFZkAsRttHA1wA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-PKcHDEEBOaaJzgfQ8qBJ1g-1; Wed, 13 Jan 2021 21:45:03 -0500
X-MC-Unique: PKcHDEEBOaaJzgfQ8qBJ1g-1
Received: by mail-qk1-f200.google.com with SMTP id 189so3293764qko.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 18:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DPxb5ET8kJn+yePURBnBONcqbnXWa5runmC5LYkViy8=;
        b=LRDJYkM7X9eDbPm6vL0lsmjpMtXLMcRuEIDzcpfqadOL1S8APEe+6QiVtQVstTPmTG
         RNYG5TRG+FijUF2q0hIxoGok6m9eZrR8rlkVOQjIWVcfMFdd6W44g5SZzocociDIGJ3z
         ZP3uyrlmTRg39WazJfI6OVIJ2uMb68ThICPkQHz7KyOSkNsBSr8mbiS3dqt+FXzICJ/8
         1JXk5BCzFzp+eCuvT+nquw0FwuPOQuwALSYbCcVuEVbORHJmsI6xUcyRf7E2XCn+nxtS
         yJDbSKBbYfwdZdjo0TnuUgbh8/ezruxCM6MnqKID1GSSJnzvU/4QGIjUQptebSUmiUx+
         dNvA==
X-Gm-Message-State: AOAM532LK2gk7qld/xlYbP8YSwHqupGYRA3nk5vyfTsxBXE7A/bM3Sr4
        HYTndsbKuPD9qJqZMvzwdvU/tDp/3n1HdaJ4o74WIpvL5ROBzXTg7e64sZ7OvET4PT3g2AKZs0u
        bW4zvADTAccT/h8vAFQYNd/BX
X-Received: by 2002:ad4:4c50:: with SMTP id cs16mr5318529qvb.33.1610592302794;
        Wed, 13 Jan 2021 18:45:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+1amknm7XoeuDWHpBHl9NiMhA4zFWaDo79pFp8Tc44/hCK+5BEiyXCVvTtM3oh5/uYV8nIg==
X-Received: by 2002:ad4:4c50:: with SMTP id cs16mr5318522qvb.33.1610592302587;
        Wed, 13 Jan 2021 18:45:02 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z26sm2230591qki.40.2021.01.13.18.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 18:45:02 -0800 (PST)
From:   trix@redhat.com
To:     jdelvare@suse.com, wsa@kernel.org
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] i2c: stub: remove definition of DEBUG
Date:   Wed, 13 Jan 2021 18:44:56 -0800
Message-Id: <20210114024456.1752286-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Defining DEBUG should only be done in development.
So remove DEBUG.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/i2c/i2c-stub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
index 537a598e22db..d642cad219d9 100644
--- a/drivers/i2c/i2c-stub.c
+++ b/drivers/i2c/i2c-stub.c
@@ -7,7 +7,6 @@
 
 */
 
-#define DEBUG 1
 #define pr_fmt(fmt) "i2c-stub: " fmt
 
 #include <linux/errno.h>
-- 
2.27.0

