Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF82A0FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgJ3U7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:59:21 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35655 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgJ3U7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:59:20 -0400
Received: by mail-ua1-f68.google.com with SMTP id f20so2139459uap.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 13:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0UF2Pmf+rwRBHY8l9mzh5Ann9thyXoIS3meDLoOTDgU=;
        b=iC5u3aBoMuTm4wozxh9IV2gbv/eULJVvGJwWISRtlH6/QZ/5QTNObNPgcRygnPoup2
         gJWynJb0Vzl7r/V/GgAPFNSXlWHl5B4S03tw8+ncgQxSD/z+KPAoeu10j/zc0m6Dm44n
         oqeYKNPVGz4Qi8Vm9tkC+G7kQWnu2guC+ftnk1apgb4XBkO0Erzmv5gD9QhZ8Id/fOKs
         XTDydJGK0o9drRmRXXX8tN+r2E09Qt+ivQKlzJ+Zn8n6pW2PF1JEmvPIQBpE5g9Co9vg
         0ZWH+CfvBi9Wu3t63KanwE32eTBNGwfVaezmN5leKDkEKr02TcRy5C+1HmLlu+V5mM3N
         Oj4A==
X-Gm-Message-State: AOAM533sEhzdyBLMNYl2xUAmGQ4yfSWjlJHCq1wMFMbt5Sv5J8oHzKpl
        HyK1dWdtCuPVJOnm0YY34NY=
X-Google-Smtp-Source: ABdhPJyH72AuFmsvzp0sbpVX9j78iQsXQAIeLz8oNvMQJ3HePx7NsJR7CYskCVyb7OINrFDNoMoQWg==
X-Received: by 2002:a9f:2212:: with SMTP id 18mr3048462uad.89.1604091559492;
        Fri, 30 Oct 2020 13:59:19 -0700 (PDT)
Received: from killington.c.googlers.com.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id w123sm874205vke.26.2020.10.30.13.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 13:59:18 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] percpu: convert flexible array initializers to use struct_size()
Date:   Fri, 30 Oct 2020 20:58:46 +0000
Message-Id: <20201030205846.1105106-1-dennis@kernel.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer macro as sparked by the long discussion in [1].

[1] https://lore.kernel.org/lkml/20200917204514.GA2880159@google.com/

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
I'll apply it to for-5.10-fixes.

 mm/percpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 66a93f096394..ad7a37ee74ef 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1315,8 +1315,8 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 	region_size = ALIGN(start_offset + map_size, lcm_align);
 
 	/* allocate chunk */
-	alloc_size = sizeof(struct pcpu_chunk) +
-		BITS_TO_LONGS(region_size >> PAGE_SHIFT) * sizeof(unsigned long);
+	alloc_size = struct_size(chunk, populated,
+				 BITS_TO_LONGS(region_size >> PAGE_SHIFT));
 	chunk = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
 	if (!chunk)
 		panic("%s: Failed to allocate %zu bytes\n", __func__,
@@ -2521,8 +2521,8 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 	pcpu_unit_pages = ai->unit_size >> PAGE_SHIFT;
 	pcpu_unit_size = pcpu_unit_pages << PAGE_SHIFT;
 	pcpu_atom_size = ai->atom_size;
-	pcpu_chunk_struct_size = sizeof(struct pcpu_chunk) +
-		BITS_TO_LONGS(pcpu_unit_pages) * sizeof(unsigned long);
+	pcpu_chunk_struct_size = struct_size(chunk, populated,
+					     BITS_TO_LONGS(pcpu_unit_pages));
 
 	pcpu_stats_save_ai(ai);
 
-- 
2.29.1.341.ge80a0c044ae-goog

