Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB481F57B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgFJPXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 11:23:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33625 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgFJPXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:23:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id s1so3017627ljo.0;
        Wed, 10 Jun 2020 08:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJ5kiBklTycoPKW6IVguv1VO+B8tcW5siLL6Q9kRKKg=;
        b=dtDPU9+PYDCemgge2fSFqHISEHn3RKBLzMGrWsCxZATlSWi7nQQETsVDHW9fyamT9S
         ank6kAwqi78jVvdjtlRt4EaN7pWPIa/UIl9MFqMc8rKksxKPfQ3dvoxBbTcfvkqr1Crq
         Wdih2fY0RN9OrKkjYXrlc6LpWr/5ShlzzGIxaaRaXZnBePu9nBqfpAalw/hvPa4WiigJ
         b56iKI/BHHLyoBpfReBCKnXePRz0FoO9/ItAaiejZGFwoH0NLrvXTKW8Cl5NUrZQQ7x4
         Hz+vLjXDGlGaYYPrmdpJbof4hBZKFtmEWjpzRTDr6tGuIx0xkmzZlLCQmToL2bKRMqyf
         M/OA==
X-Gm-Message-State: AOAM532fQjbhEpGLcdUHWJeI4h4ReXJNUpIx5aW8ZYwv47H46Yy2ClfQ
        P2+/e/b8XfE1PXeU3nl+dRE=
X-Google-Smtp-Source: ABdhPJzCGgC4adyTllMpsAqfg71/Cburvf3+0VESbttBGsAvE3VcGLFwwm94gW9f1SsYdNIeV26Vhw==
X-Received: by 2002:a2e:8490:: with SMTP id b16mr2124983ljh.325.1591802584284;
        Wed, 10 Jun 2020 08:23:04 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id n9sm12853ljc.69.2020.06.10.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:23:01 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jj2Z8-0004Q2-FY; Wed, 10 Jun 2020 17:22:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/3] serial: core: drop redundant sysrq checks
Date:   Wed, 10 Jun 2020 17:22:32 +0200
Message-Id: <20200610152232.16925-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610152232.16925-1-johan@kernel.org>
References: <20200610152232.16925-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysrq timestamp will never be set unless port->has_sysrq is set (see
uart_handle_break()) so drop the redundant checks that were added by
commit 1997e9dfdc84 ("serial_core: Un-ifdef sysrq SUPPORT_SYSRQ").

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/serial_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 03fa7b967103..791f4844efeb 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -469,7 +469,7 @@ bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch);
 
 static inline int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 {
-	if (!port->has_sysrq || !port->sysrq)
+	if (!port->sysrq)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
@@ -488,7 +488,7 @@ static inline int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch
 
 static inline int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
 {
-	if (!port->has_sysrq || !port->sysrq)
+	if (!port->sysrq)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
-- 
2.26.2

