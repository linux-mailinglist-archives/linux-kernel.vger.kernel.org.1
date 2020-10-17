Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183C1290F5A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408935AbgJQFfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411743AbgJQFem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:34:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D81C061787
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 17:44:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 10so2432141pfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 17:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=t9yJLINbzwE8Nu7tDTVwWsu7fLlkt2OC2B8ewL9ichE=;
        b=TC2v/G/X38bPexyIKhyZyIKtPATsnd3MqzNOg8FDA3mUa7Ha5Pf3ZFsjDeLRG9buSF
         Sf9OFpukyi5u2SfavoWjW35cqM6Ue8M/PEOFQ9wi2Ev60rKbUpv8lkOaOjshFqAEitqA
         2VNwzzD5J9u6Rd7RYCYKJrkKU7MPNR17TwA/JD941iXo3Qii5kAtDKR5G/2j/x+CUWYl
         0WT/IL1PD2zj0oKucETXNEkFsovslftYjgeIVB3aD5SxdfauYlPN3qsSc8fAl8J/qZMi
         RXQV5CsGmwW7VZP0j/f7le4EC3tJ7P4yXwnlwSXhGYNkiQpFxcsXXS+2BkIQoAYKs8mj
         kssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=t9yJLINbzwE8Nu7tDTVwWsu7fLlkt2OC2B8ewL9ichE=;
        b=WyjWfGSEQl99e7hXBxEh5c+n5IOT5pFmJOJGmX91eEMy+3loXmkdgY/KG55UlF8nUC
         fxv7pzI61dK6yGPvnBXdp+XrM+Euhm7YjHDJkPWMy3JEfZUhwHib1At55Frl80CUsbGZ
         cLjdQVDov1jvByqHbk1kqb1SDsnMDd/bKpPxB8xL6X2aJ7krvcKDwvyDFVgEtTV9QkGd
         wMWvo6RnXi44fKA+g81OAGoa7ht2iVbImW1T6uBfr/6edC3qJuJpydfYdK9xiv0AMkxi
         WrlW5kwsQyBmddvFt6WLiedEQ26o0wDCSgVMGVrjgRT2T2hBzPSQ8iCnscYeFhPTb+Cu
         9gLg==
X-Gm-Message-State: AOAM530ghq4S0hkIBipaQxbKO4FbNisw1tNcf/ERIrnqW+sdAoNg68vp
        bCo5EJJ7y4jsJ3fw4P+4xf+XvQ==
X-Google-Smtp-Source: ABdhPJxUn+qEjZ3XHAPjLRio5lkyQ0Be3yCgN7hUPgUTuiEtXeaz8Nef0nXDheY0EKD+2ipzx7Smeg==
X-Received: by 2002:a63:4854:: with SMTP id x20mr5534018pgk.220.1602895496832;
        Fri, 16 Oct 2020 17:44:56 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g15sm3851217pgi.89.2020.10.16.17.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 17:44:56 -0700 (PDT)
Subject: [PATCH] nds32: Fix a broken copyright header in gen_vdso_offsets.sh
Date:   Fri, 16 Oct 2020 17:27:54 -0700
Message-Id: <20201017002754.504049-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     nickhu@andestech.com, deanbo422@gmail.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     green.hu@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

I was going to copy this but I didn't want to chase around the build
system stuff so I did it a different way.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/nds32/kernel/vdso/gen_vdso_offsets.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/vdso/gen_vdso_offsets.sh b/arch/nds32/kernel/vdso/gen_vdso_offsets.sh
index 01924ff071ad..5b329aed3501 100755
--- a/arch/nds32/kernel/vdso/gen_vdso_offsets.sh
+++ b/arch/nds32/kernel/vdso/gen_vdso_offsets.sh
@@ -7,7 +7,7 @@
 # Doing this inside the Makefile will break the $(filter-out) function,
 # causing Kbuild to rebuild the vdso-offsets header file every time.
 #
-# Author: Will Deacon <will.deacon@arm.com
+# Author: Will Deacon <will.deacon@arm.com>
 #
 
 LC_ALL=C
-- 
2.29.0.rc1.297.gfa9743e501-goog

