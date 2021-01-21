Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26172FE467
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbhAUHx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:53:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbhAUG6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:58:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59FEF239A1;
        Thu, 21 Jan 2021 06:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212219;
        bh=3QR/mPIQ/la+H7P3+1BAh9UxA6XNcwQLWyNZXuVlEdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YW50V5IPyoi97ATttNTzThLKpqaJvUbn7szOLRX2EaWxbtsQ9NSBN31CDXzzVpVUl
         OdkkIQhPoKsSQrtM3uQe25c7a8qhjMcGRd3BD4pv/OAGxf/mJ7sdAuxzoQjnNcB2VL
         TtCQiqgHa/x35vHQndPKD++gUQyyRWP7uyZ9iNjYkHsgUFlAOeoNRuM60bjUVt4UbH
         uJGSxe12M01fOeCrYMwkPR46U9trfZOY7M0/b9K4LLoPEx681wXv7ke2x3oSkVEDsa
         U9yF4U0kJUr3I0/D/jT8maHMUKi1rj2++efZbBtATLGxkmDKdV1ITF7Vt3eEXIshfH
         dB0856vDiY0Gg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 11/29] csky: Add kmemleak support
Date:   Thu, 21 Jan 2021 14:53:31 +0800
Message-Id: <20210121065349.3188251-11-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Here is the log after enabled:

[    1.798972] kmemleak: Kernel memory leak detector initialized (mem pool available: 15851)
[    1.798983] kmemleak: Automatic memory scanning thread started

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index af640a41b749..7f1721101ea0 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -43,6 +43,7 @@ config CSKY
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HAVE_DEBUG_BUGVERBOSE
+	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_FUNCTION_TRACER
-- 
2.17.1

