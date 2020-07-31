Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8893234DF4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 01:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgGaXIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 19:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgGaXIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:08:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C0EC06179F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y206so4890850pfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trKW+y6QNGDib0LNTvVtHw5m6UTBgmGvLbmxtpBgaL0=;
        b=De36nKOtpwsMqO/u4tRAWqVBvir2dLkSaohu1f53IavT3wv9lR7e0hWZSL83j1HWKZ
         rY9B4gPBpbNmb8nPsaGi7A0vFOBYN9VMjC2dQMJB0cZqVHEEmlhv4MftBmYpUmCh97rG
         af7Dn2HaS1FdHmrNihpjv3LcQzJOvb78J2620=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trKW+y6QNGDib0LNTvVtHw5m6UTBgmGvLbmxtpBgaL0=;
        b=iD9yesqMh4z/1TZjcbaOP3FwY/NIsh+fbs02Y78vzZDQqJr/+a/8DMWY8VLKjwoI8p
         5qwnqs9PnAU+kDXlHCaJChfjDV55C67AXoAKgAJpgBF21flUWR0Pe4wfefNx2kg98Ghs
         5GzSeqVHYlmjSRXTfozAlXHGtxDKjeTul4j4+4r2V90P7ibZvCdIIII+yq3hIYELApt7
         tPsDmL2dt2XgB1PT085OT68intPq6XC4i86tA/VN5z+NPHpyV5gemnrRnFLdgru3H7UC
         H6Vtl//gjiOLoAELjtJHqjWp9e0aYa/nc3qgRmoh6Xhl6X2jKLBh26H5M6jZZ0bp2prL
         qojg==
X-Gm-Message-State: AOAM532aOfRksD95sapbM+l8yO50xGK0bvOzVm2J8R4RL7fcPaJA7sVE
        +ixSEHza0r5YQhGW/K5osJQlpA==
X-Google-Smtp-Source: ABdhPJxNYU1OV0bbGH5LVe0igil+VUHzo3wFC8ED7HbZKWsssjYo+rn362BnedNm2DgfjyOMkog94g==
X-Received: by 2002:a05:6a00:2247:: with SMTP id i7mr5645713pfu.217.1596236917400;
        Fri, 31 Jul 2020 16:08:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p9sm11680681pgc.77.2020.07.31.16.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/36] vmlinux.lds.h: Create COMMON_DISCARDS
Date:   Fri, 31 Jul 2020 16:07:52 -0700
Message-Id: <20200731230820.1742553-9-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collect the common DISCARD sections for architectures that need more
specialized discard control than what the standard DISCARDS section
provides.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 052e0f05a984..ff65a20faf4c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -930,13 +930,16 @@
 	EXIT_DATA
 #endif
 
+#define COMMON_DISCARDS							\
+	*(.discard)							\
+	*(.discard.*)							\
+	*(.modinfo)
+
 #define DISCARDS							\
 	/DISCARD/ : {							\
 	EXIT_DISCARDS							\
 	EXIT_CALL							\
-	*(.discard)							\
-	*(.discard.*)							\
-	*(.modinfo)							\
+	COMMON_DISCARDS							\
 	}
 
 /**
-- 
2.25.1

