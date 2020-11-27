Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2862C6B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbgK0SIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732855AbgK0SIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606500524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=/DgUT5SNxJZkOmupt2XLqi4YOdrVCYEQCxi35Ihq2HE=;
        b=CuUGinUeCOFPAhGEzVWELMLy7w9WiVClpndu+ydm8O+paS8uXdqQzLqTjPUXGQxF/F8uAz
        VYOjzroM4UJg0n29Dg0Tod7fz2AcKURIWPXIHcm+enTUQRRfNWlW0fTBbBjZ2PuBOnVBM4
        NS+5xTQnAFJ+7fpiq6pCqiYKjlvhCFw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-EqU8CpZaMuGoakgs2N49nA-1; Fri, 27 Nov 2020 13:08:41 -0500
X-MC-Unique: EqU8CpZaMuGoakgs2N49nA-1
Received: by mail-qv1-f70.google.com with SMTP id m45so3460419qvg.16
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:08:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/DgUT5SNxJZkOmupt2XLqi4YOdrVCYEQCxi35Ihq2HE=;
        b=tbjgexyzmE53mjJUiKnOMLHATvKCkUT0zB/0jGcSETv331tVMVaqhPTZgR26ULqFOH
         ICLnj2E6Ui/Kfj0KmEKM9vduBNI895AhGE3IQJZAf3NuBegiAz9ILIecxaQwsfYbAVU0
         iT5Z8dt+qAn0o47YwHfWBanw9hmyYblBnt0i2+Xxc1hpoez5LSsyIXBpFD5JXTUvEzJR
         Y9ayfwKghhO9wrcqpWp67RbAR/QfvHBCLSSe0dCPrnbbHcovZr6wGmwTg92D5u6eoypt
         D1T0N08UkjKV/eBRAP2/88BvrIQfj7mBwrTcZYzP/7bm6CtsFbEYl8l/4NCDnEt8wRXC
         +x1Q==
X-Gm-Message-State: AOAM530thXb5HbF/vJsFcYE/qrUwD5x34fQuiu11KPudnflVe2E7fXoT
        7PPNfGQOtHJj3nrOksFMjrZg9fzDzokgH1AAwym9K5q/o24LP5WE/VMP4N7UpW03ysSoy27ZgAa
        lxvhp7/6KETCaKtIfT4CP4+J9
X-Received: by 2002:a05:620a:790:: with SMTP id 16mr9817592qka.169.1606500521548;
        Fri, 27 Nov 2020 10:08:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTJQc/pmRL8xFzMk/FHDQG/ksd1sqzwIdRRI35jLBYQnKKpX3IG3hKq5RW1K8Qd/3Nnae4aw==
X-Received: by 2002:a05:620a:790:: with SMTP id 16mr9817579qka.169.1606500521380;
        Fri, 27 Nov 2020 10:08:41 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c128sm6276198qkg.66.2020.11.27.10.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 10:08:40 -0800 (PST)
From:   trix@redhat.com
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: wl1251: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 10:08:35 -0800
Message-Id: <20201127180835.2769297-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/ti/wl1251/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wl1251/debugfs.c b/drivers/net/wireless/ti/wl1251/debugfs.c
index d48746e640cc..a1b778a0fda0 100644
--- a/drivers/net/wireless/ti/wl1251/debugfs.c
+++ b/drivers/net/wireless/ti/wl1251/debugfs.c
@@ -39,7 +39,7 @@ static const struct file_operations name## _ops = {			\
 
 #define DEBUGFS_ADD(name, parent)					\
 	wl->debugfs.name = debugfs_create_file(#name, 0400, parent,	\
-					       wl, &name## _ops);	\
+					       wl, &name## _ops)	\
 
 #define DEBUGFS_DEL(name)						\
 	do {								\
-- 
2.18.4

