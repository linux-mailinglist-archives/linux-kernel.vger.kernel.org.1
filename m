Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1D62DAFA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgLOPBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:01:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34048 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727833AbgLOPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608044377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IKljx6FgCzdtloc3mc18Xk4cKwYG6+/P+prc9Q1mYZI=;
        b=fk905x4PbiPLjLr8SvgfvTXnKLoX6pjp8/VaYp2oTJH2vPD8GtEzEOiJQ4bsm7rerrsVKy
        atjfEbhCOe45IMedoUbKhe8oTR++C0aIJzrRG/s29zFzzGbKH6mFfmcaab6DiItnjSsw2u
        92tSPc0YpksQuUD/t+GWvRiR39Pw0tI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-UHQ3wQPpMo6m7eKFMQ00xw-1; Tue, 15 Dec 2020 09:59:35 -0500
X-MC-Unique: UHQ3wQPpMo6m7eKFMQ00xw-1
Received: by mail-qt1-f199.google.com with SMTP id c14so14506352qtn.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKljx6FgCzdtloc3mc18Xk4cKwYG6+/P+prc9Q1mYZI=;
        b=RiRqpVNOwSqlbQHs8CE7HAIfy6EC5pNjvnXXDgrWJxy6SRris7cLmKHUhGdl2Khf18
         eUw+YQD8G+VwZaXhw5mriEclZAAQ9bn2DWsu+NuVMBndzEV9jnGxNQsK5CzqY23F1mt/
         VpPvtGTrd4CSX/kv6r74ENMBM5nbMbB9LEipoHjE6rfdXfcO4URg6GtYPFshqgNb3PSM
         r2MAhGJhGQDqBWhhNON5p4TBQ4gmUM6cALk8pgJK/O/r6t7zMM8zGvNCWUlX/j9DTGVA
         H8BEwau1Gl73yuAQoKjwRUhc0nrYVbVDoc1t2LmIrkKM+FUG+Ri9f+uJiXr6Csd0tB1D
         QbPg==
X-Gm-Message-State: AOAM533A8n0OgiTHbooP7VKpPchqP7gJG+/exgRb0qbbIIMtT3HMmquK
        ICB45yUd0b1xOOBsTIkA2bMLuyKkUt8rbGK9HvId/Hbhdh+g9nQtMRLoY/mYovuzWdFlt401vwD
        LrRikDoY5A52nc9ewPp9Aj5gG
X-Received: by 2002:a37:9e43:: with SMTP id h64mr39977603qke.380.1608044375467;
        Tue, 15 Dec 2020 06:59:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycu6otuC4YO/BGyPd5ppmhTVfTafNZG9cE1BgzxMsc8XHugDuz4vdzli+bb/JCxJcj4P/10A==
X-Received: by 2002:a37:9e43:: with SMTP id h64mr39977581qke.380.1608044375283;
        Tue, 15 Dec 2020 06:59:35 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l1sm17648469qkj.101.2020.12.15.06.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 06:59:34 -0800 (PST)
From:   trix@redhat.com
To:     david.rheinsberg@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] HID: wiimote: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 06:59:28 -0800
Message-Id: <20201215145928.1912641-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.
h should no longer be used in the format specifier for printk.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/hid/hid-wiimote-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 41012681cafd..4399d6c6afef 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1482,7 +1482,7 @@ static void handler_return(struct wiimote_data *wdata, const __u8 *payload)
 		wdata->state.cmd_err = err;
 		wiimote_cmd_complete(wdata);
 	} else if (err) {
-		hid_warn(wdata->hdev, "Remote error %hhu on req %hhu\n", err,
+		hid_warn(wdata->hdev, "Remote error %u on req %u\n", err,
 									cmd);
 	}
 }
-- 
2.27.0

