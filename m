Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642D42FDFD1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393371AbhAUCxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:53:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436858AbhAUCns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 21:43:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 513F423788;
        Thu, 21 Jan 2021 02:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611196982;
        bh=/tqQxAHrfdF5tKWZgXN2c9dDVKqA7yTD7OKYYDQDReE=;
        h=From:To:Cc:Subject:Date:From;
        b=Hn/LD/H2dFqW76O1sTAqhVei7wKj1L38Fv1iWSbv6zsfDvXTMNFSDeMIQax8CI3Fk
         373Q4+QS8UOJ0gjx/s7ywEr2zbmxgrEBZDFmuKzMTON8x412+L5caCsAqh2D/U03kW
         Me5yfZG6QVYltOLT4EFYcAudjP3dwCJ4O225S71da/RKX2HSDr6U2HxvK/RVqZqBF8
         ZIhlK4YuFkK1JfDduqJV+LSPBiGHhiAguOLfkHT+FqXLxHjIeIx6js6ZylPtcZCfAa
         SGlhLCx6LkrVQJitKqJTQ6J+NDSp7MYexX7g2bLgrJ0O4tN4OEjenDbeqD2dhKPm47
         L2aJgX9OiungQ==
From:   jarkko@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     haitao.huang@intel.com, kai.huang@intel.com, dave.hansen@intel.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] MAINTAINERS: Fix the T-entry for INTEL SGX
Date:   Thu, 21 Jan 2021 04:42:56 +0200
Message-Id: <20210121024256.54565-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

After a discussion with Boris et al, I've come to realize that a disjoint
GIT tree for SGX does not any sense.

Instead follow the pattern of other MAINTAINERS entries, IRQ DOMAINS for
instance, and re-define T-entry so that it will reference the pre-existing
topic branch for SGX. As Boris explained to me, reviewed patches will be
routinely picked to this branch.

CC: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Fixes: bc4bac2ecef0 ("x86/sgx: Update MAINTAINERS")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 705776b31c8d..64fb8658aafb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9227,7 +9227,7 @@ M:	Jarkko Sakkinen <jarkko@kernel.org>
 L:	linux-sgx@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/intel-sgx/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-sgx.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
 F:	Documentation/x86/sgx.rst
 F:	arch/x86/entry/vdso/vsgx.S
 F:	arch/x86/include/uapi/asm/sgx.h
-- 
2.29.2

