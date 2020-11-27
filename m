Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF452C6986
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbgK0Qi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:38:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730324AbgK0Qi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606495135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=6soT6kNKicKwHaQhV8mD54KLa9zz/Qcn5Otsr8QXwTM=;
        b=KIYuVBxguejkRTh2+oIWW8eEPK+nIiXicl0Z30i6YSWoJzC9YMdLXgMIV2EK5NHF8BoyLa
        wum+jlOvnNmBOLUJIkyOpH+VGHIk03fyfMXQOLQC3qiBe07tugXAIWw7xgJGiPeHSh5kL5
        OTzz0gIlYK5EaZ+NuapAEzWAfWsXzGY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-5oDUgrzNOPiHAZaY9HjkbA-1; Fri, 27 Nov 2020 11:38:51 -0500
X-MC-Unique: 5oDUgrzNOPiHAZaY9HjkbA-1
Received: by mail-qk1-f199.google.com with SMTP id t141so3994324qke.22
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6soT6kNKicKwHaQhV8mD54KLa9zz/Qcn5Otsr8QXwTM=;
        b=fbvvSN5C5zv8qTd7AMhxLFvsgd6tQvXWJOejcfN+e6spT38b0GSKTuNJ6jITELJq/K
         YgOHttx1ybgS2xFnUGV+PjFRTfUjh0YTRICzxYn/BfZGgPi8nC/2HDUvEhhkc+bzi2FB
         DPJpIoBrwdOT0MG8RtqGlGePj4+14ysvmkXbWcNh/oJZm9zP0w9kwUf+UCdw9Upqa0Vh
         dhw047C+iTe5VguvIAUcrpjcPsE2Gbk6xaUPQht8/iagi+ljjw6Z40yzQX3AR5M9l0/Q
         XRG7h5B8N2o7hnO7wQQjJkNNrOljXWVOpS4GF3SeJ+XTpwpAju5f/GcYLhm4yAI/sqqg
         QVhg==
X-Gm-Message-State: AOAM532ag2iJYJr//AKhPRSHYOgUytF02f1jcl0lSZTmH1HfhE0KJUvb
        ZybmcJE/c/9nrw/Y0/jn4wKc0OODRcXC5FfjTcKT+Oa6XIIfu2PtvJwO5rKawTeYLNkOJzPCoV+
        mgSnY+qRMW2Cte8X5G4Xmmzbc
X-Received: by 2002:a05:620a:88e:: with SMTP id b14mr9390522qka.434.1606495125524;
        Fri, 27 Nov 2020 08:38:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEax7A2+M8txf8NSzvaWLDdcvfzjlcpauJT2nU/N8D/Jln7Bke0Usecu86i7miEwyXlfxTxA==
X-Received: by 2002:a05:620a:88e:: with SMTP id b14mr9390508qka.434.1606495125347;
        Fri, 27 Nov 2020 08:38:45 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c128sm6013643qkg.66.2020.11.27.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:38:44 -0800 (PST)
From:   trix@redhat.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] [media] b2c2: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 08:38:36 -0800
Message-Id: <20201127163836.2675604-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/common/b2c2/flexcop-hw-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/b2c2/flexcop-hw-filter.c b/drivers/media/common/b2c2/flexcop-hw-filter.c
index 335f30a54ba8..c5a3345c99e9 100644
--- a/drivers/media/common/b2c2/flexcop-hw-filter.c
+++ b/drivers/media/common/b2c2/flexcop-hw-filter.c
@@ -69,7 +69,7 @@ vpid.vregname.field = onoff ? pid : 0x1fff; \
 vpid.vregname.trans_field = transval; \
 v208.ctrl_208.enablefield = onoff; \
 fc->write_ibi_reg(fc, vregname, vpid); \
-fc->write_ibi_reg(fc, ctrl_208, v208);
+fc->write_ibi_reg(fc, ctrl_208, v208)
 
 static void flexcop_pid_Stream1_PID_ctrl(struct flexcop_device *fc,
 		u16 pid, int onoff)
-- 
2.18.4

