Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2122F6554
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbhANP72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:59:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbhANP71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610639894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=At1pxx2fmt1WO+Rmj3gTIFAZaoXRqCHIYYWGJ4oZ7Vs=;
        b=S97aABjBrY2gzOg+HpubLtGrENklscuMhhrbMgJ5NARVMnCJzc5hs+zcwBa9D18vlu5f4C
        lWZ+5bMQl9+ehwHLEVOat0DdFjoaFAShfTtMDij5ySdebTR3czsNaNWSHgjUuhspucyeVw
        Gv/hbYyfNu1rBfbfPQzWAPOhkpC0jzU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-M1EV2reXNX2AbXtGOGbjqA-1; Thu, 14 Jan 2021 10:58:12 -0500
X-MC-Unique: M1EV2reXNX2AbXtGOGbjqA-1
Received: by mail-qv1-f69.google.com with SMTP id bp20so4902421qvb.20
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=At1pxx2fmt1WO+Rmj3gTIFAZaoXRqCHIYYWGJ4oZ7Vs=;
        b=R8LQx0/mFK3Pb+tzMf8K07/vay5XkAUf634a1eRS9AWG44gS38KIRHB8kentrXkmcd
         Ifk5FwRVuxHd78IMDal86dL90e04bxjf+PuEnRFbEhZ0Ow8cn83RZ8PEp/SIzIYM/127
         fwuWKmJKc+pyUTN47FHEjS32QmD+phzRMx06gb7P5bz/7JgAokS7pHQO+Hj0GerUMZgD
         hNXa86GuL1uFceUeRDyf12nkEwn3QowxNscdTLToDO0bOLEK9g+4rahJJMXwoxWYLW8a
         JXZqT9uYHc9mHhbJGvGm8mYZRaJP3f7T7xBnUFER4kK20J4DdoY0J/oNq6kQQu2P6MyB
         LAmQ==
X-Gm-Message-State: AOAM532MZsi4kCvQNBV0f9b+B7PHXjfTBrNBGLz9lgRLh/MsM9VgsQGC
        UcCx30jPal2xk89r1odl9zjpo+kqZwwGOGTy3xa+4gbMa2vOagZHmTMN6iJX71HXawmRTfUBtRg
        GVj3Bycw1UtYMZIhvr/uSuu72
X-Received: by 2002:ad4:5445:: with SMTP id h5mr7495256qvt.22.1610639892021;
        Thu, 14 Jan 2021 07:58:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNJ/OjrPKJaBcEtfj6OjYKiknPYFfxrUC/tVzu4Dv2nkU5I22OSsFjRKbNhxExcoccagPBgg==
X-Received: by 2002:ad4:5445:: with SMTP id h5mr7495241qvt.22.1610639891841;
        Thu, 14 Jan 2021 07:58:11 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 14sm3171968qkv.25.2021.01.14.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:58:11 -0800 (PST)
From:   trix@redhat.com
To:     rostedt@goodmis.org, mingo@kernel.org, karolherbst@gmail.com,
        ppaalanen@gmail.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] x86 mmiotrace: remove definition of DEBUG
Date:   Thu, 14 Jan 2021 07:58:04 -0800
Message-Id: <20210114155804.17325-1-trix@redhat.com>
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
 arch/x86/mm/mmio-mod.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index bd7aff5c51f7..cd768dafca9e 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -10,8 +10,6 @@
 
 #define pr_fmt(fmt) "mmiotrace: " fmt
 
-#define DEBUG 1
-
 #include <linux/moduleparam.h>
 #include <linux/debugfs.h>
 #include <linux/slab.h>
-- 
2.27.0

