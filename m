Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A3F302C24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbhAYUCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732229AbhAYUAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:00:10 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9FFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3t5WYnhXF+hxAxUzh0I9aHoPaaqXPrqRLFEphVFh7pI=; b=aesDg0Jcy7RCenQLKgaxT1osHq
        pj3+p2emEYHp4k/txnsSuL13forBYoEcCLmPft0nz9LFpjKTwipmw77Wy04Qqle9lVrFzlvTSzEZy
        JwbVpiQUUS5aX8lpgoJ9rOvMZAX4N5Ur2VTmahzmOeUZ8nHTfmSNWUTkbgtJdWPXfrVAo4IemLALj
        lp4OlEWnwbPw+VUOXlYhthLra3lgcsBWuJ8ES0ieNLyz+4fgFyWyUxs/q4etTp8pnrOg+TfROL9/6
        C6QkkWhdGqb5EjdhemeDFXBjH9Qf1/yqsmpzympFaFcJNLMYDdukOv78YDikA3F4RpMvDnxL+JJua
        DWjXvqTA==;
Received: from [2601:1c0:6280:3f0::7650] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l481F-0008Is-Qj; Mon, 25 Jan 2021 19:59:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND] genwqe: clarify repeated word
Date:   Mon, 25 Jan 2021 11:59:20 -0800
Message-Id: <20210125195920.25021-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hyphen between duplicated word "Window" for clarity.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/uapi/linux/genwqe/genwqe_card.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/uapi/linux/genwqe/genwqe_card.h
+++ linux-next-20200714/include/uapi/linux/genwqe/genwqe_card.h
@@ -86,7 +86,7 @@
  * The Physical Function's Access is from offset 0x00050000
  * Single Shared Registers exists only at offset 0x00060000
  *
- * SLC: Queue Virtual Window Window for accessing into a specific VF
+ * SLC: Queue Virtual Window - Window for accessing into a specific VF
  * queue. When accessing the 0x10000 space using the 0x50000 address
  * segment, the value indicated here is used to specify which VF
  * register is decoded. This register, and the 0x50000 register space
