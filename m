Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F881CBE19
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 08:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgEIGhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 02:37:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4366 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbgEIGhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 02:37:02 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 22E617A58DA31AE840BE;
        Sat,  9 May 2020 14:36:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 14:36:47 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/3] seq_file: Introduce DEFINE_SEQ_ATTRIBUTE() helper macro
Date:   Sat, 9 May 2020 14:40:29 +0800
Message-ID: <20200509064031.181091-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200509064031.181091-1-wangkefeng.wang@huawei.com>
References: <20200509064031.181091-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce DEFINE_SEQ_ATTRIBUTE() helper macro to decrease code duplication.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/seq_file.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 1672cf6f7614..c77869cf7d10 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -145,6 +145,25 @@ void *__seq_open_private(struct file *, const struct seq_operations *, int);
 int seq_open_private(struct file *, const struct seq_operations *, int);
 int seq_release_private(struct inode *, struct file *);
 
+#define DEFINE_SEQ_ATTRIBUTE(__name)					\
+static int __name ## _open(struct inode *inode, struct file *file)	\
+{									\
+	int ret = seq_open(file, &__name ## _sops);			\
+	if (!ret && inode->i_private) {					\
+			struct seq_file *seq_f = file->private_data;	\
+			seq_f->private = inode->i_private;		\
+	}								\
+	return ret;							\
+}									\
+									\
+static const struct file_operations __name ## _fops = {			\
+	.owner		= THIS_MODULE,					\
+	.open		= __name ## _open,				\
+	.read		= seq_read,					\
+	.llseek		= seq_lseek,					\
+	.release	= seq_release,					\
+}
+
 #define DEFINE_SHOW_ATTRIBUTE(__name)					\
 static int __name ## _open(struct inode *inode, struct file *file)	\
 {									\
-- 
2.26.2

