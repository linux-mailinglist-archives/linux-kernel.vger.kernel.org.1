Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4992AF42C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgKKOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727246AbgKKOxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605106429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HjIV86G4+zXJRkvdg3A94EY+lDllWpujuARJLy+GgHg=;
        b=e/ZEKaNyO7NBJ8K+8/2wWRmhjui8//LCuA9sZgFhK/X4R5vNsZx3SE6MYA/nfRy4c+cEJE
        kwUltwisr/shEmr7qVzzd1YWUkjc6zqzphcRHb2fVPUwnbx9KshCoFNOrT3NV32/nheSl3
        luZt8c5RyxWf/dx9Yemk+krP0kStQN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-hceWkfh2NFaINwskg_F-hQ-1; Wed, 11 Nov 2020 09:53:46 -0500
X-MC-Unique: hceWkfh2NFaINwskg_F-hQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5E7E1099F63;
        Wed, 11 Nov 2020 14:53:44 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F3A2380;
        Wed, 11 Nov 2020 14:53:42 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v2 5/8] powerpc/mm: print warning in arch_remove_linear_mapping()
Date:   Wed, 11 Nov 2020 15:53:19 +0100
Message-Id: <20201111145322.15793-6-david@redhat.com>
In-Reply-To: <20201111145322.15793-1-david@redhat.com>
References: <20201111145322.15793-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's print a warning similar to in arch_add_linear_mapping() instead of
WARN_ON_ONCE() and eventually crashing the kernel.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/mm/mem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index ca5c4b54c366..c5755b9efb64 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -150,7 +150,9 @@ void __ref arch_remove_linear_mapping(u64 start, u64 size)
 	mutex_lock(&linear_mapping_mutex);
 	ret = remove_section_mapping(start, start + size);
 	mutex_unlock(&linear_mapping_mutex);
-	WARN_ON_ONCE(ret);
+	if (ret)
+		pr_warn("Unable to remove linear mapping for 0x%llx..0x%llx: %d\n",
+			start, start + size, ret);
 
 	/* Ensure all vmalloc mappings are flushed in case they also
 	 * hit that section of memory
-- 
2.26.2

