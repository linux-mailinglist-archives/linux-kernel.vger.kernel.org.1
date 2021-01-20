Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1C2FD8E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392024AbhATSzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:55:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390174AbhATRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRnNjmYT/ZeNDPernGD7mn1nezFUsPnB2CCiwO9XXDo=;
        b=eqojv05tKpkrWvVh6rF5Qcj8bp4JrIvQEj0sDladv/cTL8YKVZW2DgRq6dsiAXLTu5dlsb
        XjUY5tjFX7dUKXmRnEGYOQUVRYh0BXE5i0TPBzTQwYNoSfYxmPye98CY/rIr+BEXRZZvlU
        E4YlD/kBFFVLtc9K2CLbMIdzkZNEzow=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-3TJ_CdRPMCi-ZoK-OghAwQ-1; Wed, 20 Jan 2021 12:38:43 -0500
X-MC-Unique: 3TJ_CdRPMCi-ZoK-OghAwQ-1
Received: by mail-wr1-f70.google.com with SMTP id u14so11977954wrr.15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRnNjmYT/ZeNDPernGD7mn1nezFUsPnB2CCiwO9XXDo=;
        b=aVXB5wmb6UHnGZQYRniX3XSTA5tESNkquPUGu53tIoG95F2Bb0glU+K5uelHYfAD0Z
         ft+sO6GwZaWKFaSuu8OhOTejKujKr3Ui5WCKquT6CSRHvGQ9fWAfpQXx4NHn5ydDD9dQ
         +qFnRisbysD6n8EoMdLAkLhOKTGE1wzM3eeceOTfzG2k+7eimAuZDDptsWWenvITJCto
         bBxp9A2k2+Pxl7wdbMLtUWCAPZcUFVZQYB9nlKfFJrqV68SbT1vP73kNt0wvOtJe5LRp
         zUca6fOS3K6uF9KHPZW575CFrXajC0c3KtzKpGa9LJ6IWvJLf1R8351OipYGEWy1Rhau
         D8qA==
X-Gm-Message-State: AOAM530PDMQm5CqInxHVTFtUKoNxIyBtQha1/5bQzAlxB9udmqgf0afG
        qOPrerguCf2wNCvB/nukUP0Iuu1IzhOH2qwS7c7i7HLWL2b9CUfTSu/jqFfPWocWW0CMCnGJKNe
        gRw+1Q/IwqUfsAKvQRR8OiPganRMTNzXLI5v7YDAO0rr4WVbJ7zYNrAN8TY1wvka9uWHYzPl9mt
        2B
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr10468167wri.373.1611164322364;
        Wed, 20 Jan 2021 09:38:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEuPLL/MUsHXrjcP2RWYCjypmma6HnlV61saf901CvvVF6JcK5tnGFyGuV8565mW/HkAJnQw==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr10468144wri.373.1611164322230;
        Wed, 20 Jan 2021 09:38:42 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:41 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 15/17] objtool: arm64: Handle supported relocations in alternatives
Date:   Wed, 20 Jan 2021 18:37:58 +0100
Message-Id: <20210120173800.1660730-16-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on get_alt_insn() in arch/arm64/kernel/alternative.c, arm64
alternative code adapts offsets for static branches and adrp
instructions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/special.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index c9c3e0bfd581..d47e5590ed60 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -30,7 +30,11 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
 				 struct reloc *reloc)
 {
-	return false;
+	u32 opcode = *(u32 *)(insn->sec->data->d_buf + insn->offset);
+
+	return aarch64_insn_is_branch_imm(opcode) ||
+	       aarch64_insn_is_adrp(opcode) ||
+	       !aarch64_insn_uses_literal(opcode);
 }
 
 static struct section *get_switch_table_info_section(struct objtool_file *file)
-- 
2.25.4

