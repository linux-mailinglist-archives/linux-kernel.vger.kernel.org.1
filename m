Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2084E2A49CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgKCPaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbgKCP3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:22 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C0DC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:20 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id w14so18974727wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Chem4IZkNwwgFSwqp6pHX1gkK2ZVNdpiVbuoZ9pQWAg=;
        b=Ht6QrGtmM5QicdsS87qOW2/zFjuKCxiNBDANBWnvsXejeAQdA+RMRJqirV8zkkk4LK
         0JP6CCc2KDqRfUJPiwN0ExIHk1tATT934zB7sJBqqU0pODRt7WcF5U8MofCBwYxFZcfj
         epYf7e6HiD4rIKqbKNS47QK9oaUAxcjpOylID4mPdnaMROf9+Ok4T5e3hXAiiEVMC+9w
         kTAWT8uqKZbLWm9unGFANyRCsQn5mTjoOM7iXz+PcHjWx3pK+Wsd7tfc5XUnFYJK9k3V
         K98UISZ4plTqKZVSxlvjux/0sr4b62UKjGuhpouLyh3O9lrVxVLcfW1pylS4UTdeT9GD
         b2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Chem4IZkNwwgFSwqp6pHX1gkK2ZVNdpiVbuoZ9pQWAg=;
        b=t6+b/oS1DnrqfRkEareu7BfzH0430ityy5705y8R0Z9XTvkTz9j41v6DBmxdPK+PkF
         cm6l9S9viWmHiV1xvnr4T7XXaBZweyGoaHVeZUH1cYrxDIoycSqtSypK1KeLfsDRbpyP
         QUbALxH0zSq+moqS1tPJdrIgT6vSRKGXFA2QCKLfelNN54DafZCj2vLCOiLJngVPKr3+
         dn7m1fBFkFRLE/10K1nzN972fMY11xetAKq/hMyeS53tpRp1UulWJDfOaCVQwPOvRHRq
         nxO1bWp7exp+TFjEtpzVF9zTvB7fucyStdq0Z52TLEK4etVeBA1XBpX/cgxOPbaCAxWK
         2kkA==
X-Gm-Message-State: AOAM5301qMfgsYbY8rHyrFX/Q86RC+NsnED0Ip4+b16PJdM45ggev0b5
        c6hz/HbLU46MGjE7+bJ4GHuVRw==
X-Google-Smtp-Source: ABdhPJy9Tp7qLxG4jbY2hAIsTaFD7cy6MjPKzYAoR1RZViCdFIbtB4J+9p5kbFZXjr9m9Wo1OlbuvQ==
X-Received: by 2002:adf:fa8a:: with SMTP id h10mr26523661wrr.336.1604417359322;
        Tue, 03 Nov 2020 07:29:19 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sandeep Nair <sandeep_n@ti.com>,
        Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH 07/25] soc: ti: knav_qmss_queue: Fix a whole host of function documentation issues
Date:   Tue,  3 Nov 2020 15:28:20 +0000
Message-Id: <20201103152838.1290217-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/ti/knav_qmss_queue.c:528: warning: Function parameter or member 'flags' not described in 'knav_queue_open'
 drivers/soc/ti/knav_qmss_queue.c:528: warning: Function parameter or member 'id' not described in 'knav_queue_open'
 drivers/soc/ti/knav_qmss_queue.c:528: warning: Function parameter or member 'name' not described in 'knav_queue_open'
 drivers/soc/ti/knav_qmss_queue.c:551: warning: Excess function parameter 'qh' description in 'knav_queue_close'
 drivers/soc/ti/knav_qmss_queue.c:551: warning: Function parameter or member 'qhandle' not described in 'knav_queue_close'
 drivers/soc/ti/knav_qmss_queue.c:583: warning: Excess function parameter 'qh' description in 'knav_queue_device_control'
 drivers/soc/ti/knav_qmss_queue.c:583: warning: Function parameter or member 'arg' not described in 'knav_queue_device_control'
 drivers/soc/ti/knav_qmss_queue.c:583: warning: Function parameter or member 'cmd' not described in 'knav_queue_device_control'
 drivers/soc/ti/knav_qmss_queue.c:583: warning: Function parameter or member 'qhandle' not described in 'knav_queue_device_control'
 drivers/soc/ti/knav_qmss_queue.c:635: warning: Excess function parameter 'data' description in 'knav_queue_push'
 drivers/soc/ti/knav_qmss_queue.c:635: warning: Excess function parameter 'qh' description in 'knav_queue_push'
 drivers/soc/ti/knav_qmss_queue.c:635: warning: Function parameter or member 'dma' not described in 'knav_queue_push'
 drivers/soc/ti/knav_qmss_queue.c:635: warning: Function parameter or member 'flags' not described in 'knav_queue_push'
 drivers/soc/ti/knav_qmss_queue.c:635: warning: Function parameter or member 'qhandle' not described in 'knav_queue_push'
 drivers/soc/ti/knav_qmss_queue.c:635: warning: Function parameter or member 'size' not described in 'knav_queue_push'
 drivers/soc/ti/knav_qmss_queue.c:655: warning: Excess function parameter 'qh' description in 'knav_queue_pop'
 drivers/soc/ti/knav_qmss_queue.c:655: warning: Function parameter or member 'qhandle' not described in 'knav_queue_pop'
 drivers/soc/ti/knav_qmss_queue.c:655: warning: Function parameter or member 'size' not described in 'knav_queue_pop'
 drivers/soc/ti/knav_qmss_queue.c:759: warning: Function parameter or member 'name' not described in 'knav_pool_create'
 drivers/soc/ti/knav_qmss_queue.c:759: warning: Function parameter or member 'num_desc' not described in 'knav_pool_create'
 drivers/soc/ti/knav_qmss_queue.c:759: warning: Function parameter or member 'region_id' not described in 'knav_pool_create'
 drivers/soc/ti/knav_qmss_queue.c:862: warning: Excess function parameter 'pool' description in 'knav_pool_destroy'
 drivers/soc/ti/knav_qmss_queue.c:862: warning: Function parameter or member 'ph' not described in 'knav_pool_destroy'
 drivers/soc/ti/knav_qmss_queue.c:892: warning: Excess function parameter 'pool' description in 'knav_pool_desc_get'
 drivers/soc/ti/knav_qmss_queue.c:892: warning: Function parameter or member 'ph' not described in 'knav_pool_desc_get'
 drivers/soc/ti/knav_qmss_queue.c:911: warning: Excess function parameter 'pool' description in 'knav_pool_desc_put'
 drivers/soc/ti/knav_qmss_queue.c:911: warning: Function parameter or member 'desc' not described in 'knav_pool_desc_put'
 drivers/soc/ti/knav_qmss_queue.c:911: warning: Function parameter or member 'ph' not described in 'knav_pool_desc_put'
 drivers/soc/ti/knav_qmss_queue.c:931: warning: Excess function parameter 'pool' description in 'knav_pool_desc_map'
 drivers/soc/ti/knav_qmss_queue.c:931: warning: Function parameter or member 'desc' not described in 'knav_pool_desc_map'
 drivers/soc/ti/knav_qmss_queue.c:931: warning: Function parameter or member 'dma' not described in 'knav_pool_desc_map'
 drivers/soc/ti/knav_qmss_queue.c:931: warning: Function parameter or member 'dma_sz' not described in 'knav_pool_desc_map'
 drivers/soc/ti/knav_qmss_queue.c:931: warning: Function parameter or member 'ph' not described in 'knav_pool_desc_map'
 drivers/soc/ti/knav_qmss_queue.c:931: warning: Function parameter or member 'size' not described in 'knav_pool_desc_map'
 drivers/soc/ti/knav_qmss_queue.c:956: warning: Excess function parameter 'pool' description in 'knav_pool_desc_unmap'
 drivers/soc/ti/knav_qmss_queue.c:956: warning: Function parameter or member 'dma' not described in 'knav_pool_desc_unmap'
 drivers/soc/ti/knav_qmss_queue.c:956: warning: Function parameter or member 'dma_sz' not described in 'knav_pool_desc_unmap'
 drivers/soc/ti/knav_qmss_queue.c:956: warning: Function parameter or member 'ph' not described in 'knav_pool_desc_unmap'
 drivers/soc/ti/knav_qmss_queue.c:975: warning: Excess function parameter 'pool' description in 'knav_pool_count'
 drivers/soc/ti/knav_qmss_queue.c:975: warning: Function parameter or member 'ph' not described in 'knav_pool_count'

Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Sandeep Nair <sandeep_n@ti.com>
Cc: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/ti/knav_qmss_queue.c | 59 ++++++++++++++++----------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index f36c2dcb26911..26cc00ee0bd7f 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -79,7 +79,7 @@ EXPORT_SYMBOL_GPL(knav_qmss_device_ready);
 /**
  * knav_queue_notify: qmss queue notfier call
  *
- * @inst:		qmss queue instance like accumulator
+ * @inst:		- qmss queue instance like accumulator
  */
 void knav_queue_notify(struct knav_queue_inst *inst)
 {
@@ -511,10 +511,10 @@ static int knav_queue_flush(struct knav_queue *qh)
 
 /**
  * knav_queue_open()	- open a hardware queue
- * @name		- name to give the queue handle
- * @id			- desired queue number if any or specifes the type
+ * @name:		- name to give the queue handle
+ * @id:			- desired queue number if any or specifes the type
  *			  of queue
- * @flags		- the following flags are applicable to queues:
+ * @flags:		- the following flags are applicable to queues:
  *	KNAV_QUEUE_SHARED - allow the queue to be shared. Queues are
  *			     exclusive by default.
  *			     Subsequent attempts to open a shared queue should
@@ -545,7 +545,7 @@ EXPORT_SYMBOL_GPL(knav_queue_open);
 
 /**
  * knav_queue_close()	- close a hardware queue handle
- * @qh			- handle to close
+ * @qhandle:		- handle to close
  */
 void knav_queue_close(void *qhandle)
 {
@@ -572,9 +572,9 @@ EXPORT_SYMBOL_GPL(knav_queue_close);
 
 /**
  * knav_queue_device_control()	- Perform control operations on a queue
- * @qh				- queue handle
- * @cmd				- control commands
- * @arg				- command argument
+ * @qhandle:			- queue handle
+ * @cmd:			- control commands
+ * @arg:			- command argument
  *
  * Returns 0 on success, errno otherwise.
  */
@@ -623,10 +623,10 @@ EXPORT_SYMBOL_GPL(knav_queue_device_control);
 
 /**
  * knav_queue_push()	- push data (or descriptor) to the tail of a queue
- * @qh			- hardware queue handle
- * @data		- data to push
- * @size		- size of data to push
- * @flags		- can be used to pass additional information
+ * @qhandle:		- hardware queue handle
+ * @dma:		- DMA data to push
+ * @size:		- size of data to push
+ * @flags:		- can be used to pass additional information
  *
  * Returns 0 on success, errno otherwise.
  */
@@ -646,8 +646,8 @@ EXPORT_SYMBOL_GPL(knav_queue_push);
 
 /**
  * knav_queue_pop()	- pop data (or descriptor) from the head of a queue
- * @qh			- hardware queue handle
- * @size		- (optional) size of the data pop'ed.
+ * @qhandle:		- hardware queue handle
+ * @size:		- (optional) size of the data pop'ed.
  *
  * Returns a DMA address on success, 0 on failure.
  */
@@ -746,9 +746,9 @@ EXPORT_SYMBOL_GPL(knav_pool_desc_dma_to_virt);
 
 /**
  * knav_pool_create()	- Create a pool of descriptors
- * @name		- name to give the pool handle
- * @num_desc		- numbers of descriptors in the pool
- * @region_id		- QMSS region id from which the descriptors are to be
+ * @name:		- name to give the pool handle
+ * @num_desc:		- numbers of descriptors in the pool
+ * @region_id:		- QMSS region id from which the descriptors are to be
  *			  allocated.
  *
  * Returns a pool handle on success.
@@ -856,7 +856,7 @@ EXPORT_SYMBOL_GPL(knav_pool_create);
 
 /**
  * knav_pool_destroy()	- Free a pool of descriptors
- * @pool		- pool handle
+ * @ph:		- pool handle
  */
 void knav_pool_destroy(void *ph)
 {
@@ -884,7 +884,7 @@ EXPORT_SYMBOL_GPL(knav_pool_destroy);
 
 /**
  * knav_pool_desc_get()	- Get a descriptor from the pool
- * @pool			- pool handle
+ * @ph:		- pool handle
  *
  * Returns descriptor from the pool.
  */
@@ -905,7 +905,8 @@ EXPORT_SYMBOL_GPL(knav_pool_desc_get);
 
 /**
  * knav_pool_desc_put()	- return a descriptor to the pool
- * @pool			- pool handle
+ * @ph:		- pool handle
+ * @desc:	- virtual address
  */
 void knav_pool_desc_put(void *ph, void *desc)
 {
@@ -918,11 +919,11 @@ EXPORT_SYMBOL_GPL(knav_pool_desc_put);
 
 /**
  * knav_pool_desc_map()	- Map descriptor for DMA transfer
- * @pool			- pool handle
- * @desc			- address of descriptor to map
- * @size			- size of descriptor to map
- * @dma				- DMA address return pointer
- * @dma_sz			- adjusted return pointer
+ * @ph:				- pool handle
+ * @desc:			- address of descriptor to map
+ * @size:			- size of descriptor to map
+ * @dma:			- DMA address return pointer
+ * @dma_sz:			- adjusted return pointer
  *
  * Returns 0 on success, errno otherwise.
  */
@@ -945,9 +946,9 @@ EXPORT_SYMBOL_GPL(knav_pool_desc_map);
 
 /**
  * knav_pool_desc_unmap()	- Unmap descriptor after DMA transfer
- * @pool			- pool handle
- * @dma				- DMA address of descriptor to unmap
- * @dma_sz			- size of descriptor to unmap
+ * @ph:				- pool handle
+ * @dma:			- DMA address of descriptor to unmap
+ * @dma_sz:			- size of descriptor to unmap
  *
  * Returns descriptor address on success, Use IS_ERR_OR_NULL() to identify
  * error values on return.
@@ -968,7 +969,7 @@ EXPORT_SYMBOL_GPL(knav_pool_desc_unmap);
 
 /**
  * knav_pool_count()	- Get the number of descriptors in pool.
- * @pool		- pool handle
+ * @ph:			- pool handle
  * Returns number of elements in the pool.
  */
 int knav_pool_count(void *ph)
-- 
2.25.1

