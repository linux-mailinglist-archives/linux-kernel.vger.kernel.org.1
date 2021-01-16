Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7125B2F8E5F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbhAPRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbhAPRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:39:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C4DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 09:38:26 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x20so17917883lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 09:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RXhQCLR7kJ8wXIoAGktxHEJsN7Fs/rfacZeAYDKFmIs=;
        b=sdBAnkXLZiSEhGYam1qUuWzP56Niue66DVFgEdt1Rz43y1S6IdNFkfCnwls9cXBoRu
         H7Mnh4NEeCcFDxV/x+NRCPo572ISiOPh2+Ui0cn3wJesaGBeK2/nAQPu7QM/UfEsE1ps
         9fcwB7f1eBXAxTylN12jvL0Ey7MioXV1IipxMvuY78uF7QVVq68JWJ/eBgv2qjDpGueo
         k2Gej1o/CGHMjBTgKXsb/V0+efCE+YjLhpZvBazc6WFgZGVl/X8yPhswVTWPdp7BS3Ts
         358Nhh/NuyKi85UnNoyDdLoB08blefdiCKCKwkCzcWQAElNQcFcIej5wktZ0dgdw+cT5
         JPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RXhQCLR7kJ8wXIoAGktxHEJsN7Fs/rfacZeAYDKFmIs=;
        b=RjsfN4cihdPMhwNKI+WCULj9w9keeffnrOPn5iNANkL+kXL6OJ7JgV4pGDgiBjXHi/
         UOa2quR1c9cIXyGCwkTb7uv72XKB1RgLLkQQnHyMu12XhjBkbi/V1yuX+MDK4u3Lm2O3
         5KN44qIBjXr5T77NIgQkLfG9PNcG08v9bZK4UrPIzDfDinuqfmpvVPTsUAxeuVYmespu
         RUABJ3Si/G8cmMYo5apoYIg4CX3tfcaqzeESqB5zeEc6UIRxwN+ViTcBIF4mw6nb/fIS
         ar4hkpbqXs3ADKv/5LVv/kvpP9RyCFfnpgmYjA0IZ1UilX9Id6A0pBzl42kcAFZqpRqr
         XojA==
X-Gm-Message-State: AOAM530j6zAH5H57fhkP21vt45HbPzcxzTPLcMkV5tbVyGk7Ty4sbdoW
        yM/Q1ohAPMlF8A7/vTLt5DG+kSOAC3aeAWL7
X-Google-Smtp-Source: ABdhPJyCc4QARongk4fah6RyGiiUm1Q5f/uw+HDYl+VU1QIrWNpifsB8yG5Y5a6N2WPCAwaf2CSaRg==
X-Received: by 2002:a19:c750:: with SMTP id x77mr7443257lff.225.1610818704821;
        Sat, 16 Jan 2021 09:38:24 -0800 (PST)
Received: from xps.lan (238.89-10-169.nextgentel.com. [89.10.169.238])
        by smtp.gmail.com with ESMTPSA id v7sm1134696ljk.60.2021.01.16.09.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 09:38:24 -0800 (PST)
From:   Odin Ugedal <odin@uged.al>
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        dschatzberg@fb.com, surenb@google.com, Odin Ugedal <odin@uged.al>
Subject: [PATCH v2 2/2] cgroup: update PSI file description in docs
Date:   Sat, 16 Jan 2021 18:36:34 +0100
Message-Id: <20210116173634.1615875-3-odin@uged.al>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116173634.1615875-1-odin@uged.al>
References: <20210116173634.1615875-1-odin@uged.al>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update PSI file description in cgroup-v2 docs to reflect the current
implementation.

Signed-off-by: Odin Ugedal <odin@uged.al>
---
 Documentation/admin-guide/cgroup-v2.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 63521cd36ce5..f638c9d3d9f2 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1029,7 +1029,7 @@ All time durations are in microseconds.
 	one number is written, $MAX is updated.
 
   cpu.pressure
-	A read-only nested-key file which exists on non-root cgroups.
+	A read-only nested-keyed file.
 
 	Shows pressure stall information for CPU. See
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
@@ -1475,7 +1475,7 @@ PAGE_SIZE multiple when read back.
 	reduces the impact on the workload and memory management.
 
   memory.pressure
-	A read-only nested-key file which exists on non-root cgroups.
+	A read-only nested-keyed file.
 
 	Shows pressure stall information for memory. See
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
@@ -1714,7 +1714,7 @@ IO Interface Files
 	  8:16 rbps=2097152 wbps=max riops=max wiops=max
 
   io.pressure
-	A read-only nested-key file which exists on non-root cgroups.
+	A read-only nested-keyed file.
 
 	Shows pressure stall information for IO. See
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
-- 
2.30.0

