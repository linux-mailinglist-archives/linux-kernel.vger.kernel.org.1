Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCBA22BA17
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 01:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgGWXPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 19:15:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36511 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgGWXPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:15:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id g26so7114779qka.3;
        Thu, 23 Jul 2020 16:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6814H9LNFm7mNAgAbdABMO015b6dWxo/CiMH4s9kGpU=;
        b=JIX6uIL1/yV0sTfrYqjrpHtriKWRXGPZChAEX0U3erebMQprreFGFfW1+SVPCFVDlV
         fU4wyWTta2De6K4GbppXF6JkWTEatwuOlp33VC+sdU7KXV43/zP7mwKXGtWKRAGiRft+
         weWZTPOIeNOolzjGseODrPN/pu/j+9EePFsLtbGqeDr9VpoSllRgVYPckdOFLld4Ox1r
         h2+C0T68/hXtdTb6DzKLxw793RPiSha7Ymf12B1m4f2X9vdJuL5qY25b3q3ZCUCbMkJq
         oMH73vJBs6/Mpy7PNO5mlifCmBCra8ZfK0GgShUf/uPGHfbKr6unXrEt4EjB7l74WAn8
         GeIg==
X-Gm-Message-State: AOAM532Ds8E6JCK3FNh9YN5RhuFrECOfrAiLrW8PcFh9ku0KrAnn5mad
        VCTuX0s6bpi6bGQp3fyrEkg=
X-Google-Smtp-Source: ABdhPJy5MXBWH5s3/fFypWtBdB8VuP3zU2BNO8/KzwtRWG7b7u/p/FSVMT5e4B3abtwckXpaKD/qgA==
X-Received: by 2002:a37:b48:: with SMTP id 69mr6950053qkl.407.1595546149397;
        Thu, 23 Jul 2020 16:15:49 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u58sm4196610qth.77.2020.07.23.16.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:15:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sparc: Drop unused MAX_PHYSADDR_BITS
Date:   Thu, 23 Jul 2020 19:15:44 -0400
Message-Id: <20200723231544.17274-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723231544.17274-1-nivedita@alum.mit.edu>
References: <20200723231544.17274-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro is not used anywhere, so remove the definition.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/sparc/include/asm/sparsemem.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/include/asm/sparsemem.h b/arch/sparc/include/asm/sparsemem.h
index 1dd1b61432db..aa9a676bc341 100644
--- a/arch/sparc/include/asm/sparsemem.h
+++ b/arch/sparc/include/asm/sparsemem.h
@@ -7,7 +7,6 @@
 #include <asm/page.h>
 
 #define SECTION_SIZE_BITS       30
-#define MAX_PHYSADDR_BITS       MAX_PHYS_ADDRESS_BITS
 #define MAX_PHYSMEM_BITS        MAX_PHYS_ADDRESS_BITS
 
 #endif /* !(__KERNEL__) */
-- 
2.26.2

