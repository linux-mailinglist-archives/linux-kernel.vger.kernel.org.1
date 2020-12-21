Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD312E019D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 21:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgLUUlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 15:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgLUUlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:41:12 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B485C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:40:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y23so171619wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jund9TXlnupe35gJiRs3rlJ2dF8c/LF0cBDOiamrga4=;
        b=dcjeDWM97PPAPy3EN2Fu4DTPB0b3hUyVJD61ZljZLy948ZzfWKnpXNhikzBKuTGaiF
         Mq8Y279C6taJxuCIbXG/nQ2Bpb3ntYjpelqFT81R4Owh2B2z+9y+3Az/AE5cTM3+xyxn
         Nsd1jjs9muTxWq+gvNSYx5hpbN1+HN4I8pJDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jund9TXlnupe35gJiRs3rlJ2dF8c/LF0cBDOiamrga4=;
        b=tQa3zTgX3EVIzKpNxkSKoWs43/Om6Qw8Z60Ql4NSzxY/AOaTSs8surYFYZ6ar1We0S
         9rbZcakrDO80Jsw44rcdz1wo9rNIFXaFjZipk6nYFWAo1od13El/wRp1D5pfW130zwPs
         poR4GCiNEHmosPSbYLRwzemqN8RTx+vrn0MF+5eP6EXuS54hCIHq12pQL2gUgAxmjWrO
         0zvGqR+sY44RRywJBbIopI/mmIspZAJ1qOr0BmRLCMEDxPGtq5QFc/w2Kj81yOZJTTFR
         fEMBCyqZKomtXAXI5rm7S01JgMr8ii/WRpAkUGbQbuMs27Yi9E8xHIY1E5Y9lU7YqVNb
         HbwA==
X-Gm-Message-State: AOAM531CfuAeRg/wnYLrLBrp80aKVW06KmaDF5NKVb12XZUEhicNKdOg
        RuW1XtFykykqhT0RpxrfXD02MFM6G6P4TgLutkc=
X-Google-Smtp-Source: ABdhPJyPzseWQbr4uS6KoyR6F4QNx3b85eBpNFiMwvxbxmxi2/6uD4SrqacbKdYMsnecOASGec1lKw==
X-Received: by 2002:a1c:6056:: with SMTP id u83mr18072152wmb.90.1608583230972;
        Mon, 21 Dec 2020 12:40:30 -0800 (PST)
Received: from lootbox.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id v11sm28385656wrt.25.2020.12.21.12.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 12:40:30 -0800 (PST)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
To:     linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH] arch/Kconfig: JUMP_LABEL should depend on !XIP
Date:   Mon, 21 Dec 2020 22:40:05 +0200
Message-Id: <20201221204004.16138-1-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point in trying to optimize the code when the code is
executed from a read-only medium (e. g. NOR flash) as in the XIP
case. Moreover, trying to do so in a XIP kernel may result in
faults and kernel crashes so let's explicitly disallow JUMP_LABEL
if XIP_KERNEL configuration option is set.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..88632c9588ae 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -81,6 +81,7 @@ config JUMP_LABEL
 	bool "Optimize very unlikely/likely branches"
 	depends on HAVE_ARCH_JUMP_LABEL
 	depends on CC_HAS_ASM_GOTO
+	depends on !XIP_KERNEL
 	help
 	 This option enables a transparent branch optimization that
 	 makes certain almost-always-true or almost-always-false branch
-- 
2.29.2

