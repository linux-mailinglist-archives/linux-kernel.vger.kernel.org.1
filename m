Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFF72E09FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 13:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgLVMUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 07:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgLVMUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 07:20:16 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26ACC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 04:19:35 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id i6so11750532otr.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 04:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSZyi2h29d/pc/zMIRyzuH+lEXfDxQm0cbyH2qdw1U4=;
        b=jl/5+5wku6WpeCVsW3YLsJk595mxsP2Gdh7aac0/fiEswu+Km8PpqnzR6X9DKyLug2
         a180ENrSt0nRr7UbMRER+qh9S804yURja6flvNp6PRp0PKpCSBKZEvvaPaNVHSJ0Ticd
         ViBbR3Rq3QKEGpLa8F3WqwzDNhsr0rMLGxYO2TAlTrhzHq+UxDYZ+wjysFsF85rqJKN3
         H7lsIudB1H3GtEjs2ZIyKGa0IH+6a6EfvF7DHJk29n1VIxqEO1R7WmBFRn+gqpMV/qwz
         eRvwzmm2Galo4Trb8dtq5M9lR9KsvLXe6gy4ULMrcqxTHFU872kWS8eWaiycemBmZdkY
         KouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSZyi2h29d/pc/zMIRyzuH+lEXfDxQm0cbyH2qdw1U4=;
        b=iVI5x8tzTSFkG4vm3Z/FKL3Kbc40P3eVMuel+51ONpgKPOg5lo2f8O311XPWjtoFV6
         GPsSo9k46gdMNFcpkmmDt7rD/KAp5aDgAbrPzVNasQBaoLo7fijcElQFqeJhhazBfvEB
         mrAS1NHwslS7X1zTmsDh9pJecYnfDGREALkAaOgqNYcRFULRK3nv9DGyQ6zVevR0Kaon
         1s13mmJP8aXQ5RP/2bqoPYVl97uKR6kT6I/SRcIeVYI5IzSd1dBnx5LJriirh7eXoQzE
         0ltTwuoIDNwKQ/SEhg0gWxyaR2slWh1Anhx6kT9a+5owgYAKshkc3jjxV0OSksLlJQb2
         z/OQ==
X-Gm-Message-State: AOAM533S6oGpC0hpquVwhIMEysdpZwr0Y1Z0pmmHfD3xTUCLYSLzUvcn
        NV5mXvp5qga2R4XPEJgy47E=
X-Google-Smtp-Source: ABdhPJzZpP1vlG4raT6ssXYp9jHbcTrMu/sjKBenhHMuFdnNde7uG0JADT3NS/4ELZ3FPAa8U0cb+A==
X-Received: by 2002:a05:6830:1ac3:: with SMTP id r3mr16155256otc.363.1608639575217;
        Tue, 22 Dec 2020 04:19:35 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id z14sm4350985oot.5.2020.12.22.04.19.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 04:19:34 -0800 (PST)
From:   qianjun.kernel@gmail.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH 1/1] mm:improve the performance during fork
Date:   Tue, 22 Dec 2020 20:19:04 +0800
Message-Id: <20201222121904.50845-1-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

In our project, Many business delays come from fork, so
we started looking for the reason why fork is time-consuming.
I used the ftrace with function_graph to trace the fork, found
that the vm_normal_page will be called tens of thousands and
the execution time of this vm_normal_page function is only a
few nanoseconds. And the vm_normal_page is not a inline function.
So I think if the function is inline style, it maybe reduce the
call time overhead.

I did the following experiment:

I have wrote the c test code, pls ignore the memory leak :)
Before fork, I will malloc 4G bytes, then acculate the fork
time.

int main()
{
        char *p;
        unsigned long long i=0;
        float time_use=0;
        struct timeval start;
        struct timeval end;

        for(i=0; i<LEN; i++) {
                p = (char *)malloc(4096);
                if (p == NULL) {
                        printf("malloc failed!\n");
                        return 0;
                }
                p[0] = 0x55;
        }
        gettimeofday(&start,NULL);
        fork();
        gettimeofday(&end,NULL);

        time_use=(end.tv_sec * 1000000 + end.tv_usec) -
                (start.tv_sec * 1000000 + start.tv_usec);
        printf("time_use is %.10f us\n",time_use);

        return 0;
}

We need to compare the changes in the size of vmlinux, the time of
fork in inline and non-inline cases, and the vm_normal_page will be
called in many function. So we also need to compare this function's
size. For examples, the do_wp_page will call vm_normal_page, so I
also calculated it's size.

		  inline           non-inline       diff
vmlinux size      9709248 bytes    9709824 bytes    -576 bytes
fork time         23475ns          24638ns          -4.7%
do_wp_page size   972              743              +229

According to the above test data, I think inline vm_normal_page can
reduce fork execution time.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7d608765932b..a689bb5d3842 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -591,7 +591,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
  * PFNMAP mappings in order to support COWable mappings.
  *
  */
-struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
+inline struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			    pte_t pte)
 {
 	unsigned long pfn = pte_pfn(pte);
-- 
2.18.2

