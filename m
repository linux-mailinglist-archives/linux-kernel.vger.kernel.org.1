Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0D22B55D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 01:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgKQAsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 19:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgKQAsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 19:48:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B288EC0613CF;
        Mon, 16 Nov 2020 16:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=uUIXCUNr7RNJdZ9HoYd/HshSNPt0vV3H87AKi8GmjxY=; b=Vxicb8OXX/0PSxT4jPinQITdcT
        5Q8lujGw9QEmpVbUhTtxfQcfraqZiSooPyzDMFe82qlxC65AL31064VdGg4UfrRi/HAbTFS/Lz2fX
        PKt1j6DFZAkoohtd6R8eRwGQGNH5UnYl+X/Cp/orxOolrVUOnGWJ6xhPkzek9m3Ce7b8IpGj5GF34
        vW4HrFrZqwKrIub7OytGN+3cFLbc5Tuh14ut2/CQ7Ht+duQ+tAxGPA0Pk8jLd//ULCCamSTx1+EW9
        cy5YBsxLfd+3+RYFAtklw/BJbLHCK/M2QBSOvXWFtg1E8f234s4+eupary1jKt3Bfa0WCEQL4PZJK
        KZkdOGaA==;
Received: from [2601:1c0:6280:3f0::990e] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kepAD-0001P8-15; Tue, 17 Nov 2020 00:48:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lars Kotthoff <metalhead@metalhead.ws>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH] sparc: fix led.c driver when PROC_FS is not enabled
Date:   Mon, 16 Nov 2020 16:48:00 -0800
Message-Id: <20201117004800.16734-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Sparc build when CONFIG_PROC_FS is not enabled.

Fixes this build error:
arch/sparc/kernel/led.c:107:30: error: 'led_proc_ops' defined but not used [-Werror=unused-const-variable=]
     107 | static const struct proc_ops led_proc_ops = {
         |                              ^~~~~~~~~~~~
   cc1: all warnings being treated as errors

Fixes: 97a32539b956 ("proc: convert everything to "struct proc_ops"")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lars Kotthoff <metalhead@metalhead.ws>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
This driver is mostly useless without CONFIG_PROC_FS.
I think it would be just as satisfactory to make it depend on
PROC_FS.  Eh?

 arch/sparc/kernel/led.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20201116.orig/arch/sparc/kernel/led.c
+++ linux-next-20201116/arch/sparc/kernel/led.c
@@ -50,6 +50,7 @@ static void led_blink(struct timer_list
 	add_timer(&led_blink_timer);
 }
 
+#ifdef CONFIG_PROC_FS
 static int led_proc_show(struct seq_file *m, void *v)
 {
 	if (get_auxio() & AUXIO_LED)
@@ -111,6 +112,7 @@ static const struct proc_ops led_proc_op
 	.proc_release	= single_release,
 	.proc_write	= led_proc_write,
 };
+#endif
 
 static struct proc_dir_entry *led;
 
