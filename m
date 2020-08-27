Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA88254BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgH0RRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0RRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:17:44 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2528C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:17:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e23so7927758ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OIXKak5CEekt91tBtePjKK7hyZyPdsZcnjuQkNzrSo=;
        b=KWE4cj2qvrEE8G+CfaEkwPZ5HC48biSw26mjeQ+bKm/jjmH8GqGDuazluzoasWRbSd
         l5Tp1Pns0uwfNdmAqjiEq4WRpS7jFckJMyXHFyS30D8qC1U8eMwGskQmECUg5A4fnZ+B
         AJoA1qu4kVltvyaHWgKTdG/UqUTwbwReYGDmNI5WcHBfDczd09xJz42yD+SVmkzIkTVk
         COul0bw6ea4TEIotjUFfAc0xDy0Yfr3f+N/oQIj7/NQMI9CxqnuWVfTAoFKeihBOOvZ0
         9qyihpolL2pFLnMv+vnQ63RBmky2EZ803qchw7sxXpoMsfFv0ZsLcmOd/d/i4pcc8Oa1
         BhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OIXKak5CEekt91tBtePjKK7hyZyPdsZcnjuQkNzrSo=;
        b=arPPWsfT1BHCN45TYR7n2GKJsFPHjrFL2WPMJbJO/h5YWUm4gpDHRUo0lrV3C9L+pm
         JFxgTY9AEP5IdMReqzSbnJY188v8VEkglqdXqtpedoaS5qjNyooUhh9UAdw28KAy3pjx
         qVMU6CpTUeR2HOp5Z7ThpF9pS1UVK9vcoR/rherBhlWOKFcXeUIcM5L1Hk8jqVmrO3fe
         3sMVXqJ2YsJQkmJMdhbvA1By+8fxLvs/kAmIw9gqvWImic2GXvrzBhq6qvOe2SWWyLud
         +2YTC28UHYibuc6dQTl324TMOKeqG13FM6ADH8L78qmQQESbtlNhuWCnkk+I9TtoRdpx
         6Gwg==
X-Gm-Message-State: AOAM531a0PlEVvuYMzg7TIFOA+D0QGKz260LTi/7RUvj56ZsuVHeIeev
        s7T/efrNvXB3bbDCrO2rULo=
X-Google-Smtp-Source: ABdhPJxM3zzY1kLYK4bC0x/JgwzvHYPtI8uSavB5UklHNL187UZg7fJYwYTBrk4om2zcqNZKgYoVBQ==
X-Received: by 2002:a17:906:390d:: with SMTP id f13mr3830053eje.86.1598548662322;
        Thu, 27 Aug 2020 10:17:42 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id l23sm2261214eje.46.2020.08.27.10.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:17:41 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/entry/64: Do not include inst.h in calling.h
Date:   Thu, 27 Aug 2020 19:17:35 +0200
Message-Id: <20200827171735.93825-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inst.h was included in calling.h solely to instantiate RDPID macro.
The usage of RDPID was removed in commit 6a3ea3e68b8a8a.

Fixes: 6a3ea3e68b8a8a ("x86/entry/64: Do not use RDPID in paranoid entry to accomodate KVM")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/entry/calling.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index ae9b0d4615b3..07a9331d55e7 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -6,7 +6,6 @@
 #include <asm/percpu.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
-#include <asm/inst.h>
 
 /*
 
-- 
2.26.2

