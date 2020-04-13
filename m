Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23531A67B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbgDMOQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 10:16:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41919 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730468AbgDMOQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586787373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1FXBt/UFCukR9oL8jqZar//KnIeZ8VrgN9z1x/j3tC8=;
        b=XE17EoIQZydLF5H2/+kLUYIyDWB+pQHZ5qq17MzLns+AcB4E/T1RcvrHl2TtgGpqebHaGl
        yVcFq1iu0lEg4oPSKIr1sA+A9SuHf3wwJ8DQehncvvJIMGU2GZ+p/9l8hWysJFq70BY/2c
        1n7m4m38KgzKCqlX8fiXyBQmVPBd064=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-dgVnC2kYPcKY4i0vNM3AKA-1; Mon, 13 Apr 2020 10:16:12 -0400
X-MC-Unique: dgVnC2kYPcKY4i0vNM3AKA-1
Received: by mail-qk1-f197.google.com with SMTP id k16so8524272qkk.16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FXBt/UFCukR9oL8jqZar//KnIeZ8VrgN9z1x/j3tC8=;
        b=cDI+9WY20AgjjjbNvJw0zxMHhH/uoNrpszU2/FuvNE4f5ARLTPp6AL/nmv8AO6Es1y
         f7sYyLnV4ibqCnDhjp6F0UbDGoisRYGlev9ig2QOdiPjYbMI35VZtV0rRz/XUTL95NJ8
         jYJsRErYsPK4pvqiAl9wB5R2GnCif9ip74YMkCrV0orRDr/uJIBn824GxvRrE9KVzFlL
         jAXdYli64j3SSuaAuGWlF6TvW8wrnw1VhTU34/nDGpA7TcJPuBvJLXLJp+/BEQO4zb5m
         EQGhS7HSwLEY9GI0QIP/03s2f61FQXeo1UDddqXoKsglBsKobIKcGese/loFpZZuuV79
         gzfQ==
X-Gm-Message-State: AGi0PuYuTgobMVsMuvXatxaHbEYWfx/6TDBZdUx5PEfr18q5w8cdBRzz
        WV76GtQH3Oi4bXYguU+BWeEZv7Te7/H0rBBoNmy4bqnQYIIvMbq5UfW68/BBU9OilmiYnKl2lc/
        z2AaOi20hUQM/v+CO5v6BOxse
X-Received: by 2002:ac8:710c:: with SMTP id z12mr11260268qto.193.1586787370880;
        Mon, 13 Apr 2020 07:16:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypIhL4isRvrYPeeHxLJY1EauygV6cxeMMoZdt6uCmP3o0zJ8IaRp2h7ptuOgHnbEfTO3Qydwqw==
X-Received: by 2002:ac8:710c:: with SMTP id z12mr11260247qto.193.1586787370655;
        Mon, 13 Apr 2020 07:16:10 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j2sm4633938qtp.5.2020.04.13.07.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 07:16:10 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mm/userfaultfd: Disable userfaultfd-wp on x86_32
Date:   Mon, 13 Apr 2020 10:16:08 -0400
Message-Id: <20200413141608.109211-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd-wp is not yet working on 32bit hosts, but it's
accidentally enabled previously.  Disable it.

Fixes: 5a281062af1d ("userfaultfd: wp: add WP pagetable tracking to x86")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8d078642b4be..7a7d2db366a3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -149,7 +149,7 @@ config X86
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
-	select HAVE_ARCH_USERFAULTFD_WP		if USERFAULTFD
+	select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK		if X86_64
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_ASM_MODVERSIONS
-- 
2.24.1

