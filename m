Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1394B29F168
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgJ2Q1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbgJ2Q1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603988859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7siXqe9xLyC5jnHaj5YIsmBgb0Hn9zRskk7tPjv5dw=;
        b=fNJhb3Q0xJWKgoQrcxQOwyc6uEOMgPm/nH1HT6wUKPZwMN0lMrlI07v1U9Vt0J2VPuTGMB
        U4uMPXBzQ4g3oszWegfW8Hp0TUPCNRKpzz2FOxzcJuQThrOhz8Eaw74I2/yCn4JsnKIvT+
        ka9x21ovdie8ZRhMqCGa/XG18F+7sBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-xWjC179tNFKDqVFXM7kCyQ-1; Thu, 29 Oct 2020 12:27:35 -0400
X-MC-Unique: xWjC179tNFKDqVFXM7kCyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2D6980B714;
        Thu, 29 Oct 2020 16:27:33 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-181.ams2.redhat.com [10.36.112.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 334855C1C4;
        Thu, 29 Oct 2020 16:27:31 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 2/4] powerpc/mm: print warning in arch_remove_linear_mapping()
Date:   Thu, 29 Oct 2020 17:27:16 +0100
Message-Id: <20201029162718.29910-3-david@redhat.com>
In-Reply-To: <20201029162718.29910-1-david@redhat.com>
References: <20201029162718.29910-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's print a warning similar to in arch_add_linear_mapping() instead of
WARN_ON_ONCE() and eventually crashing the kernel.

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
index 8a86d81f8df0..685028451dd2 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -145,7 +145,9 @@ void __ref arch_remove_linear_mapping(u64 start, u64 size)
 	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
 
 	ret = remove_section_mapping(start, start + size);
-	WARN_ON_ONCE(ret);
+	if (ret)
+		pr_warn("Unable to remove linear mapping for 0x%llx..0x%llx: %d\n",
+			start, start + size, ret);
 
 	/* Ensure all vmalloc mappings are flushed in case they also
 	 * hit that section of memory
-- 
2.26.2

