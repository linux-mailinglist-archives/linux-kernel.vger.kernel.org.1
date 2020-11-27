Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BC22C6926
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbgK0QJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:09:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731163AbgK0QJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606493391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=+OBqy0pHArArhpX+VbrsT96w7Ubj+UYCCndi+URT9+c=;
        b=GoH1uXWa1JDmdUZSwsCgwUGaJjqf8O7h3lTv50U7m8BPpzJaNdpsT40wMET6IKLqlMmXUY
        XxME2yVgK6yKHdKMXewG8qW6B514E9J9SsPf7e1BkxS0oMl1iW0Mq2IwpUMjZ24s1fRkHP
        ST7rslVmpRp+WXI4YY1Obe4K3VOuYc8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-fhvlXVYZNxCeltOC_B82YA-1; Fri, 27 Nov 2020 11:09:50 -0500
X-MC-Unique: fhvlXVYZNxCeltOC_B82YA-1
Received: by mail-qk1-f198.google.com with SMTP id q21so3963949qkq.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+OBqy0pHArArhpX+VbrsT96w7Ubj+UYCCndi+URT9+c=;
        b=Q5m06VcViSE/w0ZhI6k5giPTqsd7kB//H4dGTvjcXzg5/BCZd58O78GszDuJCxBi/b
         s6qpRPGnNKJW95SMNmRE6de7q+WYfUSpAThjWhOfc2+IxGsetbqn6wNxhPh049no7PBc
         +IF4B+JFZH78twelMPGsnPw3vEFCWRyBZrWzFjtNhtQZvulZ+uB4FW2lpgXN1DrsQRob
         XAvRw5jqaxGuUDQxtGShL5dEYLdEZ2JJ5w7K4fynBbiuhc4GOv56dXX/nspYeVyI93bM
         90lu4S1Vdf8AEAWX6gsUZdjVLtE3MBfkVU+W9z/lmVEjIlZiaY1Qwm4bHqdsQFepHNrL
         MOFA==
X-Gm-Message-State: AOAM5301AZ3cLKp/SRv7mfkxETWzu7bkznQDBD5JBvwwbC5Zqpwa51jQ
        hEHoDLlnJRoXiAL81svc3h4wlsYI1w+QKR0XTROvGfbE9+Q0YVdgbQxLdWLJwXcaQv1WBqV4/F9
        1pJmEX/imYWOLfe7l5O0qTwEE
X-Received: by 2002:a05:620a:94d:: with SMTP id w13mr9472122qkw.194.1606493389625;
        Fri, 27 Nov 2020 08:09:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYjKpN0SVw8PixncmDIqWvih71/xv1YTT2BdIvxQrqVDxwpg2W+A2tlaOOQbNynMy0p13bBA==
X-Received: by 2002:a05:620a:94d:: with SMTP id w13mr9472103qkw.194.1606493389457;
        Fri, 27 Nov 2020 08:09:49 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f189sm6122046qkb.84.2020.11.27.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:09:48 -0800 (PST)
From:   trix@redhat.com
To:     ning.sun@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, tboot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] x86/tboot: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 08:09:43 -0800
Message-Id: <20201127160943.2627134-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/kernel/tboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 7b1425dc2549..fdbb2f9ac61d 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -257,7 +257,7 @@ static void tboot_copy_fadt(const struct acpi_table_fadt *fadt)
 	tbg.bit_width    = g.bit_width;		\
 	tbg.bit_offset   = g.bit_offset;	\
 	tbg.access_width = g.access_width;	\
-	tbg.address      = g.address;
+	tbg.address      = g.address
 
 	TB_COPY_GAS(tboot->acpi_sinfo.pm1a_cnt_blk, fadt->xpm1a_control_block);
 	TB_COPY_GAS(tboot->acpi_sinfo.pm1b_cnt_blk, fadt->xpm1b_control_block);
-- 
2.18.4

