Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B012FD8EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbhATS5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:57:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387505AbhATRjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YEVSMla8UOmgBC4LmzAJMeE/UB0SCvN1vHTnN1GioY=;
        b=eRFp/dslELn1Z1K8T71nM0v6M9sdr6YvkLoStbkmEJEkXd3ZD4OYVesbtGP+C71U/y8C9n
        RRgPs1DCiqpljKunWApaWRGpNVr/ZPjLRuru626s9yUsCWAMuRaNVsSp48P2pcks0/lo+5
        I7hBgjEZmLB6j5DIDxlvTggHejsaBVw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-pTrozdxOMTqt0p6c8Tq1xQ-1; Wed, 20 Jan 2021 12:38:12 -0500
X-MC-Unique: pTrozdxOMTqt0p6c8Tq1xQ-1
Received: by mail-wr1-f69.google.com with SMTP id x12so1004976wrw.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YEVSMla8UOmgBC4LmzAJMeE/UB0SCvN1vHTnN1GioY=;
        b=NDtToDyoZuRziK2st5ZQ16gfsbvU2OvAIpncnUI+QD783BFonuT6/ZOQ9wbZdRyw/N
         Fql7H0I1xhlxiotv8UXRPd960zOxQa0DNDzszdIGDmHV2Ntic8PAOAobN0RPSv8rIT6o
         7tLu/R+JliJXi++ywZ8MHynQ1mUzoGgquV5WWK73SKhoKqjhEOyvfVZaCFga3dVrE0vF
         aY1raX5Oreu2DneaGNGXUnqfngtnwSP8ib4WkwdCQR5/QPyNj+6khdonWwsTiDbD5w8X
         maPGGeTyYAmzmm+ADojnEPIU3k12S7TlRNuEbN9EDi8M9bTug1tv96Alczb3Bm/ePYwC
         JnrA==
X-Gm-Message-State: AOAM531r1qIe7cgUcYFDV7NXUaHDx9H4Os1JJIEoEMMGQ1U4UWLUuGO0
        Eue+E6eeDQexeMsxMx5daynFYSsDpNK8Rf33AWSrMTPZIyPnLe0hYvgnsXVrTIeOfAErDXeLSNa
        WPYiNrbOh5+mM+R2Hyr+ER/lPiqR9wsEnBBZrvplAgM76MpDUqyxE3MDNjUc5engzN+LGKb2VDJ
        yw
X-Received: by 2002:adf:d238:: with SMTP id k24mr10316342wrh.414.1611164290652;
        Wed, 20 Jan 2021 09:38:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsXKBygCbH5ehSM3hv+i9wV2hjiG6FmiP83Wor2Wz+s8QTVOj8s3jD6nPK36EhOefk08Au5A==
X-Received: by 2002:adf:d238:: with SMTP id k24mr10316310wrh.414.1611164290420;
        Wed, 20 Jan 2021 09:38:10 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:08 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 03/17] tools: bug: Remove duplicate definition
Date:   Wed, 20 Jan 2021 18:37:46 +0100
Message-Id: <20210120173800.1660730-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under tools, bug.h only defines BUILD_BUG_ON_ZERO() which is already
defined in build_bug.h. This prevents a file to include both headers at
the same time.

Have bug.h include build_bug.h instead.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/include/linux/bug.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/include/linux/bug.h b/tools/include/linux/bug.h
index 85f80258a15f..548be7cffa8e 100644
--- a/tools/include/linux/bug.h
+++ b/tools/include/linux/bug.h
@@ -2,10 +2,6 @@
 #ifndef _TOOLS_PERF_LINUX_BUG_H
 #define _TOOLS_PERF_LINUX_BUG_H
 
-/* Force a compilation error if condition is true, but also produce a
-   result (of value 0 and type size_t), so the expression can be used
-   e.g. in a structure initializer (or where-ever else comma expressions
-   aren't permitted). */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
+#include <linux/build_bug.h>
 
 #endif	/* _TOOLS_PERF_LINUX_BUG_H */
-- 
2.25.4

