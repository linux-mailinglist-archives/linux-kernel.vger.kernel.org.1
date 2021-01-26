Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A8F304E77
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391153AbhA0Abm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbhAZRWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:22:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C767C061786;
        Tue, 26 Jan 2021 09:22:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c127so3431648wmf.5;
        Tue, 26 Jan 2021 09:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FXRZlniX4gZ072w8uwiSJDkEGOzFxGv7oD25jhieqoA=;
        b=ib220PyJYk+28pHcN7hPNfQAp3VSlPSkb7xbciCFT570jmuCEdl1xvE6fLCpX4jAc0
         aQRsq360h3DhSipawGaU2Nw7lAo/vMbtJUyMIBRldAr+G4ul43e8cOEL0vyV+dtK3TM4
         GRQffaFMObeN0ashevrv8rVcvsDDZBsNJnLhdFJ0EP5tMd87BeGAkitUtTVBY2e5T2oS
         SqYshql2kBvGYcPM2R0e/mD2c+gJ0Yx68rHtVZ+tIyV8Y7GLHm4OHIakMtfPSj0LbksS
         7IBVKtsSZHTdlp9iTQuvzU0eR1w5Z5XM85/bWE1O8SYjz697kj67L+mPRCi9+sXyKO2J
         x/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FXRZlniX4gZ072w8uwiSJDkEGOzFxGv7oD25jhieqoA=;
        b=RD3/cGUCQlwEpWOZFT9cmoypHBBX2VER6FvzY7Oy7dEu9xYcY5KSU+vfporxZf3zye
         o5z9JSZwY2ED5/3yyDjWG5tQLy0fei+c8PEzvqx1KTgQ30+LbtyvmgN0boTWX4dRsO5v
         3zn4M+2QjDr7fldWilmnfvQjgzX12SBDaWq9wF1pvPDshitacvATAkRHSail+Zd57OQE
         Lh74WYjmRbmm+DYlM3BHewGcMj18denjmv+h/0s8KhohxPlbovIpvQPgWGOH7X8kcn6Q
         Vh5TyL7EqFRUwlIUHg2rdA1YVZT2unqnB+x87387jppGTS9VIAw9EFpGCTlQzUPHt0Lg
         k5CA==
X-Gm-Message-State: AOAM531Od+yXaYg5wnvo0UY1YF6jt9VjZaFjwxYtIOt5mElvfKiAxc6f
        an2n92zRHxEifEjynNWKNVVbzGu5xkQ6lg==
X-Google-Smtp-Source: ABdhPJyYgUL2++VpWL9kz47EF9vUH1dIpMhwnUMLSHedFIyqE8zr5/yOrXSLgUhQHUAtzi2ovKwsWA==
X-Received: by 2002:a05:600c:154c:: with SMTP id f12mr734626wmg.40.1611681732538;
        Tue, 26 Jan 2021 09:22:12 -0800 (PST)
Received: from xws.localdomain (p5487bbca.dip0.t-ipconnect.de. [84.135.187.202])
        by smtp.gmail.com with ESMTPSA id d9sm20768092wrq.74.2021.01.26.09.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 09:22:11 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/surface: aggregator: Fix braces in if condition with unlikely() macro
Date:   Tue, 26 Jan 2021 18:22:02 +0100
Message-Id: <20210126172202.1428367-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The braces of the unlikely() macro inside the if condition only cover
the subtraction part, not the whole statement. This causes the result of
the subtraction to be converted to zero or one. While that still works
in this context, it causes static analysis tools to complain (and is
just plain wrong).

Fix the bracket placement and, while at it, simplify the if-condition.
Also add a comment to the if-condition explaining what we expect the
result to be and what happens on the failure path, as it seems to have
caused a bit of confusion.

This commit should not cause any difference in behavior or generated
code.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/aggregator/ssh_packet_layer.c     | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index 74f0faaa2b27..583315db8b02 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -1694,7 +1694,24 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
 	/* Find SYN. */
 	syn_found = sshp_find_syn(source, &aligned);
 
-	if (unlikely(aligned.ptr - source->ptr) > 0) {
+	if (unlikely(aligned.ptr != source->ptr)) {
+		/*
+		 * We expect aligned.ptr == source->ptr. If this is not the
+		 * case, then aligned.ptr > source->ptr and we've encountered
+		 * some unexpected data where we'd expect the start of a new
+		 * message (i.e. the SYN sequence).
+		 *
+		 * This can happen when a CRC check for the previous message
+		 * failed and we start actively searching for the next one
+		 * (via the call to sshp_find_syn() above), or the first bytes
+		 * of a message got dropped or corrupted.
+		 *
+		 * In any case, we issue a warning, send a NAK to the EC to
+		 * request re-transmission of any data we haven't acknowledged
+		 * yet, and finally, skip everything up to the next SYN
+		 * sequence.
+		 */
+
 		ptl_warn(ptl, "rx: parser: invalid start of frame, skipping\n");
 
 		/*
-- 
2.30.0

