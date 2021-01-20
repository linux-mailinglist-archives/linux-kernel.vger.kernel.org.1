Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CA32FD6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404223AbhATRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:20:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404215AbhATRT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611163081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIEs+9ktHuoYNXdMA+KJi5nyHq47tkG01J4/C6Osfbo=;
        b=AqRcS2p/qNzQJS76RYWaavcZSD2ZGCLtQY1qVD32wbB0rLAa4Nb9/vk+bS0RhyOQsoUCKF
        xtplH71wNbrU+FHVnOqdLwwhf3/oCChT2WF4z/vwV4Q+OqOkeu/iBOsAPXQ7A28Bmb5f41
        dDYQupsbPHmUSzooGfEpObHVgFiHgYY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-skaZsV9FPnOMafp25AfPqA-1; Wed, 20 Jan 2021 12:17:59 -0500
X-MC-Unique: skaZsV9FPnOMafp25AfPqA-1
Received: by mail-wm1-f72.google.com with SMTP id u67so1280334wmg.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:17:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIEs+9ktHuoYNXdMA+KJi5nyHq47tkG01J4/C6Osfbo=;
        b=bQkC/rCaST7xv35m3lolLqtvTAlTkS+MqIt6/VHJbV6LkJ1btw/RN1akgCqJVVZFHM
         8LWnWlgWHj81iUvUoKsSvuQiGgf3qMlPIf5SLPm0QC6OkLOa251gDcifwfgpwp+6yBXE
         ykq13LoXLacmyDr6WvDrg9yRFlb3NDoOhXH0+8wBImwkNUflPzUfVo+wGWc6XFGnFjUp
         aL39GJ2vwjcd+NA0rFhZ8gvRXR4Y+LPnvCH52OpsJQvzPRL8TBmCVZlBBsKG/zeZfgCB
         jY8sm+abm5Z9ZyBx8Ch+RDyWJ+n6l1CHQe5J99Y1rUc360t9KozISiArF4lNEDnmCi89
         p43A==
X-Gm-Message-State: AOAM530DKFCWedXvkFmF0v4vIqKDYI6NpTESXZCkdUuF52IHkvNbokZG
        xMlOATWVHaJbIWayeXLTuzVtREdwhsHr2MbSTzO1HwZN27hnQz/vK3bzgOwEnkbGDXiHOUrZJNc
        J+WELkaUVYtmOt3/KqSwtRqBq04bgvxT3VlzGpC13HKMgkIcfGcmdlY4zBjD6m1NKLzZRiOdTM4
        xV
X-Received: by 2002:adf:ffc8:: with SMTP id x8mr10346062wrs.158.1611163078117;
        Wed, 20 Jan 2021 09:17:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbSbbQQqfi4fF3PmiXRlkX+5DNHzbFTBr8fiWRkMONP12dbuRjNvOpJ12jP2HbtPwj2PvqxA==
X-Received: by 2002:adf:ffc8:: with SMTP id x8mr10346046wrs.158.1611163077975;
        Wed, 20 Jan 2021 09:17:57 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id o124sm5444077wmb.5.2021.01.20.09.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:17:57 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 5/5] arm64: Add load/store decoding helpers
Date:   Wed, 20 Jan 2021 18:17:45 +0100
Message-Id: <20210120171745.1657762-6-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120171745.1657762-1-jthierry@redhat.com>
References: <20210120171745.1657762-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide some function to group different load/store instructions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/include/asm/aarch64-insn.h | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/aarch64-insn.h b/arch/arm64/include/asm/aarch64-insn.h
index 3a0e0ad51f5b..f1b5b652c400 100644
--- a/arch/arm64/include/asm/aarch64-insn.h
+++ b/arch/arm64/include/asm/aarch64-insn.h
@@ -408,6 +408,34 @@ static inline bool aarch64_insn_is_barrier(u32 insn)
 	       aarch64_insn_is_isb(insn);
 }
 
+static inline bool aarch64_insn_is_store_single(u32 insn)
+{
+	return aarch64_insn_is_store_imm(insn) ||
+	       aarch64_insn_is_store_pre(insn) ||
+	       aarch64_insn_is_store_post(insn);
+}
+
+static inline bool aarch64_insn_is_store_pair(u32 insn)
+{
+	return aarch64_insn_is_stp(insn) ||
+	       aarch64_insn_is_stp_pre(insn) ||
+	       aarch64_insn_is_stp_post(insn);
+}
+
+static inline bool aarch64_insn_is_load_single(u32 insn)
+{
+	return aarch64_insn_is_load_imm(insn) ||
+	       aarch64_insn_is_load_pre(insn) ||
+	       aarch64_insn_is_load_post(insn);
+}
+
+static inline bool aarch64_insn_is_load_pair(u32 insn)
+{
+	return aarch64_insn_is_ldp(insn) ||
+	       aarch64_insn_is_ldp_pre(insn) ||
+	       aarch64_insn_is_ldp_post(insn);
+}
+
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 bool aarch64_insn_uses_literal(u32 insn);
 bool aarch64_insn_is_branch(u32 insn);
-- 
2.25.4

