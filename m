Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063982FD8E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392396AbhATS4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:56:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387699AbhATRjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybADuVVj33zXJpBTN6zXgGLfnzshZUI1ojUuRxuiGxo=;
        b=IRoiuwMiNY+QQxnVSMo7/6CPPzufqAPivop7ams7efCwxaQDMr8fYjEaskDWgRJmOe8Gvg
        0I4R75lsO2csRkzMLfdFN2i9mm4ALYTTCWRjC8RNWuZqKtX3mgafOmnjoQwR15emi4M5p5
        ths8w+XJ3f1FEp35NYBzq6O3eWNKqtg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-wVmZokurMpWF-tX7VxFNrg-1; Wed, 20 Jan 2021 12:38:20 -0500
X-MC-Unique: wVmZokurMpWF-tX7VxFNrg-1
Received: by mail-wr1-f70.google.com with SMTP id r8so11923075wro.22
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybADuVVj33zXJpBTN6zXgGLfnzshZUI1ojUuRxuiGxo=;
        b=KphlFN/PI+oCTTlaiOposiWJxhiZ50+x9msSlMFX06C5swcZsJxkFcx916NCYMSFzt
         Jgh1HbUvtFsOqaP0o1iO3DlY54zJNjMRHm5O1MKGB9Tmf624pQMBtXqcxuaQgFk07IAT
         2pexiC+u+HiFDU9TW63XbWzIhlMM+duVm5Vi/noJMsEX6T67YIbR2KEiTaGYVNYNzYpW
         oJJN93YMfGndtFRGvLGki7rX6KeRv0JgUUtFBTZdM4/DHCZTRm9v872EGhcnsZo6sMh0
         NkQE0r/9cOVpdVrthqsjlOZFtUEdoW3R7G0NLIGDWv8Gke5aou3oFET5AnO5dr7WfFD4
         wRbA==
X-Gm-Message-State: AOAM530z23bU/GProutrIeSyguHVyaxOa66j4TKzQOumemQK6TlglYEb
        ckPZNgJBoIWBE7nPNNKUw+JS+YENEWossSQ2JViXjLWucuqDTLijvHRqfR78Wo34szqGVzsddsM
        HfmV+RgYXGwwyq/HR3FPTTc7SYkIlGzN0tnA9/EEe3QnpVNygtiTAR0tnsPzVE66VHPoRRs188H
        W0
X-Received: by 2002:a5d:5917:: with SMTP id v23mr10790338wrd.308.1611164298857;
        Wed, 20 Jan 2021 09:38:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCWhKh32IYPGwQ7eOyS6NFprZttJ5fMUAm09DXGKOoX6f0LQRibhfxka+az9xnCWXYUtnyTw==
X-Received: by 2002:a5d:5917:: with SMTP id v23mr10790318wrd.308.1611164298719;
        Wed, 20 Jan 2021 09:38:18 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:18 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 06/17] objtool: arm64: Decode jump and call related instructions
Date:   Wed, 20 Jan 2021 18:37:49 +0100
Message-Id: <20210120173800.1660730-7-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode branch, branch and link (aarch64's call) and return instructions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 0f312dd1b146..924121b4b466 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -205,6 +205,28 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		}
 		*type = INSN_OTHER;
 		break;
+	case AARCH64_INSN_CLS_BR_SYS:
+		if (aarch64_insn_is_ret(insn) &&
+		    aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn) == AARCH64_INSN_REG_LR) {
+			*type = INSN_RETURN;
+		} else if (aarch64_insn_is_bl(insn)) {
+			*type = INSN_CALL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_blr(insn)) {
+			*type = INSN_CALL_DYNAMIC;
+		} else if (aarch64_insn_is_b(insn)) {
+			*type = INSN_JUMP_UNCONDITIONAL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_br(insn)) {
+			*type = INSN_JUMP_DYNAMIC;
+		} else if (aarch64_insn_is_branch_imm(insn)) {
+			/* Remaining branch opcodes are conditional */
+			*type = INSN_JUMP_CONDITIONAL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else {
+			*type = INSN_OTHER;
+		}
+		break;
 	default:
 		*type = INSN_OTHER;
 		break;
-- 
2.25.4

