Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E8621D56A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgGML6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 07:58:23 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44636 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgGML6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:58:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U2bYiCk_1594641495;
Received: from localhost.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2bYiCk_1594641495)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Jul 2020 19:58:19 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] doc/zh_CN: add Chinese translation prefer section
Date:   Mon, 13 Jul 2020 19:58:07 +0800
Message-Id: <20200713115807.56362-3-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200713115807.56362-1-alex.shi@linux.alibaba.com>
References: <20200713115807.56362-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The add words is:

Tranlation plan:
Welcome for any part of kernel doc Chinese translation, expecially for
admin-guide part.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/translations/zh_CN/index.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 301e50a64dc6..85643e46e308 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -10,6 +10,9 @@
 人员做出贡献。 与任何大型社区一样，知道如何完成任务将使得更改合并的过程变得更
 加容易。
 
+翻译计划:
+内核中文文档欢迎任何翻译投稿，特别是关于内核用户和管理员指南部分。
+
 .. toctree::
    :maxdepth: 2
 
-- 
2.18.4

