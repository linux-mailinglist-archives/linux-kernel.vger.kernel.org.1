Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481F22AE512
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 01:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbgKKAo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 19:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732432AbgKKAo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 19:44:58 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6406C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:44:57 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 33so611279wrl.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/13qwQgQ3Y+lxdm33Ix8mWDwT4msBrtLlbjK58L715E=;
        b=Iv1YLt8AGRr7vcn+UBzP9lP/XbFvroEB/vY4GqAg8hnFDIn5vdmnoGabvEKq0BBpZ1
         K5/cXoeQwgyLtJ5iAVNisuMAB+ESTMLPmU5/PZlqIMmsDVIlPFisYdwUYF2e49c1p9Vo
         HcHxM/I6aNAsUcrXbDCGP90EjShM5Skl15xZ6IMA/pU5FF6Re5f+ZmlsEoM014ZJGZyQ
         pnc5JO2D+5+0MvQBHuvtNB3l3KkBPnMDjp7bAg6kju+wed3H+WWfF+Do51k6986kpJH1
         nUPcGMYJETojhqdMIlnS8+Xd/U74NqyrtbkV/6b+PpPX0dRRd+yP2nobJNkiJcLEXQlI
         xnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/13qwQgQ3Y+lxdm33Ix8mWDwT4msBrtLlbjK58L715E=;
        b=ooUfXoRb8U7xxF3Cb9nHVnJlP7O3AdAt7MWbgdE6dbwOQyU0Cfm9o1iHttWksJbFSV
         tjvsovtzhRUKC2Lh/8IooWofY2lYwEfILB7RR9Q/kfjBPHW7qLQ75l061hBcTvzIuM8t
         HTdI53b+kNzlC8uepk5SzDL+2PlNK0oDQiE8Kv5OtReK5H0/ZWgQ/UMyxvCMwuv1va9N
         /68Su2zWv7HBmq70sQNNPpyJPryKKvwvl9SlNOkqIuMV/gAe+3a1mUusxzQK5D8GGixX
         aXQN8OVC0/f40UqxUKRY9tI4mXkknvN4OEmJ5869laDduU8gGdm0CjGR26t8LDuh2H+j
         sfNA==
X-Gm-Message-State: AOAM531BA0OCmeFt9QFmy9iL3pUTpb+xHAnbmrtJhnvqvXdt8kY3Mrru
        bPX5VLj8TaBZ3gR0TwjKAMg=
X-Google-Smtp-Source: ABdhPJxjCyyhtS6gfnMjb6r1RGKXCCMvZYQDvhogrJTemBZvYL5lOJ4YguBqefLyX1zVAWKAbNSm6A==
X-Received: by 2002:a5d:6447:: with SMTP id d7mr25952011wrw.96.1605055496387;
        Tue, 10 Nov 2020 16:44:56 -0800 (PST)
Received: from ansuel-xps20.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id 18sm514556wmo.3.2020.11.10.16.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 16:44:55 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: fix missing include in asm uaccess.h
Date:   Wed, 11 Nov 2020 01:44:38 +0100
Message-Id: <20201111004440.8783-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a compilation error as PF_KTHREAD is defined in linux/sched.h and
this is missing.

Fixes: df325e05a682 ("arm64: Validate tagged addresses in access_ok()
called from kernel threads")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm64/include/asm/uaccess.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 991dd5f031e4..51a4f63f464a 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -7,6 +7,8 @@
 #ifndef __ASM_UACCESS_H
 #define __ASM_UACCESS_H
 
+#include <linux/sched.h>
+
 #include <asm/alternative.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/sysreg.h>
-- 
2.28.0

