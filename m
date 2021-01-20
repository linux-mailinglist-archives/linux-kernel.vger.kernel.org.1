Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B92C2FD938
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392305AbhATS4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:56:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387765AbhATRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/xnDCC8nOFGfsA+lStDur0FhQOLzj3Vyiz97OzDpc8=;
        b=gUFlrtaEr7qsAtT1h1dRYUW3jycPC8WQ4rOwmnolbIFHWNmPUoEhd6J++ryIQ0s/4aMX4U
        +XKqAMBV2pEgXfgpI1fPA8ZOlCv7uyZBsetDiK01L6ScObo2dYZ3GzBRCT7EWQQeUILb0c
        Ow4KS0HV9M9C3pA6pW0OnT9vzBflld8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-q0O4Oi6cPuy--ujO7x__iQ-1; Wed, 20 Jan 2021 12:38:23 -0500
X-MC-Unique: q0O4Oi6cPuy--ujO7x__iQ-1
Received: by mail-wr1-f72.google.com with SMTP id o12so11853647wrq.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/xnDCC8nOFGfsA+lStDur0FhQOLzj3Vyiz97OzDpc8=;
        b=b81IdY6HlKNZcExnCuHVqSltN/Hq0Tb0LhwfB3NMU7yq/FnCu6Ukb/tIgN18O3QS51
         xfnnjGpvjVFiXkJxCaghAi2qIv3ChKoYfM664bs43t3HbBfVCglaDDfHNDiL9TbkxzsE
         EWLBlTK9t2JLVUQqNeQq3/VEhu8OdQVa1zk5eRVUOxqMAy6hJa2eBZoP0xff8de4eCi+
         6FLzo44IRpOimG+KumPs014dsopsCujQt7SBgXdcENRp/E9ihHbxAwHJE81wN/oOOD0G
         smHY+zULu92wSJPtenrSqpEThuc0lVbWQ89GLAkZz+/oh3AOLRf/GDd2viVam4xaLKhq
         SW5A==
X-Gm-Message-State: AOAM533BnxdCKJga9vlNbmGOVPCVnpz4ENg2rWYNEjojD06VtMxVhWUU
        zzhF3aCq0kQ8IlvVgkUZXB+fM14GSV111Ut2C+nH4Gq1aHGQxZ8bML6kahBecelyIRTCGb8hX9h
        Qck0SJPOJUoDDUn8kW3WIqHPqC1Td5Aggappx/Vdf7unrJoyeoq0v2E5MAZwlP6Wu2uW2T4cPRW
        AN
X-Received: by 2002:a5d:660c:: with SMTP id n12mr10531790wru.291.1611164300970;
        Wed, 20 Jan 2021 09:38:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5Gt3Pu1qW2EdggZtB7MguFp/4lDK5HfkXjM4AsXdknZgXR2j5+4eIlyKpZr1CO2oaPexByA==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr10531762wru.291.1611164300731;
        Wed, 20 Jan 2021 09:38:20 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:20 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 07/17] objtool: arm64: Decode other system instructions
Date:   Wed, 20 Jan 2021 18:37:50 +0100
Message-Id: <20210120173800.1660730-8-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode ERET, BRK and NOPs

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 924121b4b466..a4a587c400a1 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -223,6 +223,13 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			/* Remaining branch opcodes are conditional */
 			*type = INSN_JUMP_CONDITIONAL;
 			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_eret(insn)) {
+			*type = INSN_CONTEXT_SWITCH;
+		} else if (aarch64_insn_is_steppable_hint(insn)) {
+			*type = INSN_NOP;
+		} else if (aarch64_insn_is_brk(insn)) {
+			*immediate = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn);
+			*type = INSN_BUG;
 		} else {
 			*type = INSN_OTHER;
 		}
-- 
2.25.4

