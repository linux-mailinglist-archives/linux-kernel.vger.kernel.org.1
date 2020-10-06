Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58352852F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgJFULb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgJFULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:11:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CC2C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 13:11:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a1so2157598pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9Kgi1FQskOa5rSl0SoHJY6w4fOZRjsIxfeDIa/Yl5g=;
        b=bngJdOednPPuqfXzuTJ3Dna0ddWYu8EHGAsghPWNLqJ86xkIxlVYD3DaouvgHlvfr1
         tsbrpAorqyu87ogKgW7Kzqb20vTlFInPzWyEde1ZEN3f73TuSOgtc3TiI3BrvhbpOTip
         qsQQ3OcXdR1wmhVUyWYbqAWOu9INTKEK7EdaU6G4trqmG7SwMjrb8yIu+F3PK8n26F01
         3kLgcXPtzfSQpb8HCdi7h0JgfRs8xUHSQ8myifYJ5K8Yp0iY8j0qOldzO9qa+eKj0vCe
         NfXCRjiDklhO2TGhN1UQLb64yfHgFSoTUAJtc8WLmhZayGufgO3I5sHK+Mw30JNry16E
         zh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9Kgi1FQskOa5rSl0SoHJY6w4fOZRjsIxfeDIa/Yl5g=;
        b=F9OfvDCJ+7Ggt9sStWocur+alO0p9l/151ckixavkKxsB0y98eGkdISzbkX5xujqrX
         cDVNbHS0WwrI1aFFEJ9pdCq/aIeZb9nqzTOkg7ajSQV415xIMSMPYVNLMxjf/csGdoF/
         u12x81fy98V9qkqeH1NUuFpxexqcVwmSKBuUUr0ylWzTJlS0GN5w7HeH8DeI3ozogNK0
         36hKQyHFdpEVCHtoY3cvzpe9M+HhsP8dwEGSt/757dsZOY8eM2jntqP6sD+3XHPrRHKy
         4vBQSwkGaINfhgR0DWZ9/ATxzjKO2FcDnFeeNcFQlYgenCgbSOP3J2duayzDtR8mYwB2
         ugmQ==
X-Gm-Message-State: AOAM532LFVtg+AoVLrbpbCif7/fLwWqIEl/U+2pVIJxYpgcN2EFKcvLP
        XQkfkzVAuuA2YLxJPQi3z/E=
X-Google-Smtp-Source: ABdhPJyzZeCqbMGIe9fwsCjHJi8T25atdRy70SOIh1kg2RHVkXJKhsTDrSI/CDE6vczBsNkMcQ2qDw==
X-Received: by 2002:a17:902:7896:b029:d3:7768:1eb with SMTP id q22-20020a1709027896b02900d3776801ebmr4632386pll.17.1602015090360;
        Tue, 06 Oct 2020 13:11:30 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id e27sm13504pfj.62.2020.10.06.13.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:11:29 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, KP Singh <kpsingh@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] LSM: Fix type of id parameter in kernel_post_load_data prototype
Date:   Tue,  6 Oct 2020 13:11:15 -0700
Message-Id: <20201006201115.716550-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.29.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

security/security.c:1716:59: warning: implicit conversion from
enumeration type 'enum kernel_load_data_id' to different enumeration
type 'enum kernel_read_file_id' [-Wenum-conversion]
        ret = call_int_hook(kernel_post_load_data, 0, buf, size, id,
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
security/security.c:715:22: note: expanded from macro 'call_int_hook'
                        RC = P->hook.FUNC(__VA_ARGS__);         \
                             ~            ^~~~~~~~~~~
1 warning generated.

There is a mismatch between the id parameter type in
security_kernel_post_load_data and the function pointer prototype that
is created by the LSM_HOOK macro in the security_list_options union. Fix
the type in the LSM_HOOK macro as 'enum kernel_load_data_id' is what is
expected.

Fixes: b64fcae74b6d ("LSM: Introduce kernel_post_load_data() hook")
Link: https://github.com/ClangBuiltLinux/linux/issues/1172
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index d67cb3502310..32a940117e7a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -186,7 +186,7 @@ LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
 LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
 LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
 LSM_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
-	 enum kernel_read_file_id id, char *description)
+	 enum kernel_load_data_id id, char *description)
 LSM_HOOK(int, 0, kernel_read_file, struct file *file,
 	 enum kernel_read_file_id id, bool contents)
 LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,

base-commit: dba8648dcab90564b8a11c952c06a9e1153506fb
-- 
2.29.0.rc0

