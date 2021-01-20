Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657092FD2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbhATO3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390354AbhATOWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:22:48 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477B8C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 06:22:08 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 19so25426343qkm.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 06:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4W9rabaHYlfp3dZefhZ5eDc2vFVS8lzPwoif6mGzIk=;
        b=lSs9ai1zpvEddnzbn0rPsX1lMsDhdwTM2sGuacKqBuxvFOp54XeD5QVbqhtCJ3jvdE
         7jeoGRp5VQH3Yuoxr7uVpSAknAQQ6kfPLR0Nb4s2MXshtYqE9Qasr3BHDUswnNpbVKot
         h8vTMB6s2y/krzb9joV4VLeAAg4rOKCJ0r29LeLWbN5LxNWvsF7ljOlhFUAToZb30CXT
         tpCqnpGmSVqGc1jpsd+orsN+cDWxWhAf89+XBMouzdpubCPgNd2bSeEpJEhI/8MJjTvp
         n4sye4N1CGVVJaLvSEC4dr2MrL7wNp27sIqy3NorhXvT3FbNUYbq7zrZ10x2qZEmjsED
         HjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4W9rabaHYlfp3dZefhZ5eDc2vFVS8lzPwoif6mGzIk=;
        b=h1YJC/Pl3d3Tjwg7KKXlgqtPQSqAN03vzrQFVWPf9GMFcxNOEWfMyZDXzOOFsNQiqo
         RqxcAhdYuIYWI0mHBW3Sil+m7mq+sYsy+eE2vXxdZtCNs3XZ2ZSjOJt6XkhuPdYhVjVH
         px7w0Ee5LoadlsgCK7XV59QFCns6SSnMBG94g9HQaqcLGCvpaqcwOyqnAu/goWlkJyK3
         fruEQKnd+R8CnpfSQvKRg/VrIDbEY2PA7AvCP5lEEiwi7MIhjdB9cfVGKqlyzzaBGTDv
         qPdKQ+GxEKdHxfFB77k7dQCxMr5eodF5tUj4Zpncbc5RIae0CyuhBaJVRIfA68cDg77f
         ilcQ==
X-Gm-Message-State: AOAM531lZ1Lwd37BpvjC+kR4rXGLcVhxGMt0k4JRLvyyrUR1PYoazOy8
        ddH1+cgKSWIvunCjCCQ0MBniPQ+u+APS9g==
X-Google-Smtp-Source: ABdhPJxkYYw2XbGfGKURyhRpH6boaYYKpat53CLT9cYotcvRIL2s4CHl/gop67NAmIcos1xmP/Y+CQ==
X-Received: by 2002:a05:620a:788:: with SMTP id 8mr9564286qka.224.1611152527536;
        Wed, 20 Jan 2021 06:22:07 -0800 (PST)
Received: from localhost.localdomain ([156.146.54.160])
        by smtp.gmail.com with ESMTPSA id n7sm1402912qkg.19.2021.01.20.06.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 06:22:05 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, rppt@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] arch: powerpc: mm: book3s64: Fixed spelling architectue -> architecture in line number 1061
Date:   Wed, 20 Jan 2021 19:50:21 +0530
Message-Id: <20210120142020.2623355-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/architectue/architecture/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 98f0b243c1ab..8b8f1451e944 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1058,7 +1058,7 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
 		 * Book3S does not require a TLB flush when relaxing access
 		 * restrictions when the address space is not attached to a
 		 * NMMU, because the core MMU will reload the pte after taking
-		 * an access fault, which is defined by the architectue.
+		 * an access fault, which is defined by the architecture.
 		 */
 	}
 	/* See ptesync comment in radix__set_pte_at */
--
2.30.0

