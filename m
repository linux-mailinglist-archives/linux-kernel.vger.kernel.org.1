Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940E727A289
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgI0TTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:19:02 -0400
Received: from m12-12.163.com ([220.181.12.12]:48492 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgI0TTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Ts6hL
        gPwpuiLUNkEGjyiEe2YUY0QNH9v4Kl5H9rXsIY=; b=Qky9AnXP4cy+9bJeVXyb+
        XGW4hNKZNckZaezuLYpiLuV886lKQRM5F/AEi8mWOlHN4YI8Gy/0xhi02PnhAcB/
        cl/fiKp74iksNAEbQLMkvVfDLQTSYp4ySQHLYoCSWzon3acVQWoiZomdF7znnc9I
        0FDFNikKB+Jo0YcjZUry+A=
Received: from localhost (unknown [101.86.214.224])
        by smtp8 (Coremail) with SMTP id DMCowADXbs8asHBfLYMHPQ--.5479S2;
        Sun, 27 Sep 2020 23:30:34 +0800 (CST)
Date:   Sun, 27 Sep 2020 23:30:34 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmalloc.c: fix the comment of find_vm_area
Message-ID: <20200927153034.GA199877@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DMCowADXbs8asHBfLYMHPQ--.5479S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy8Jw1rGFy8CFyDAw1DKFg_yoWDZFgEya
        18try8WrykJan3tw18uw42qa92ga95ZF1DGFyFqFZxXr9xCa45uFWDGFy3JFWUWr4fJF9r
        WanFkayftr98KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8ymh7UUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiWRqsX1WBsxoaPgAAsp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the comment of find_vm_area() and get_vm_area()

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index be4724b916b3..a2d7900024be 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2133,7 +2133,7 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
  * It is up to the caller to do all required locking to keep the returned
  * pointer valid.
  *
- * Return: pointer to the found area or %NULL on faulure
+ * Return: the area descriptor on success or %NULL on failure.
  */
 struct vm_struct *find_vm_area(const void *addr)
 {
@@ -2154,7 +2154,7 @@ struct vm_struct *find_vm_area(const void *addr)
  * This function returns the found VM area, but using it is NOT safe
  * on SMP machines, except for its size or flags.
  *
- * Return: pointer to the found area or %NULL on faulure
+ * Return: the area descriptor on success or %NULL on failure.
  */
 struct vm_struct *remove_vm_area(const void *addr)
 {
-- 
2.25.1


