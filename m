Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EEE21D2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 11:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgGMJbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 05:31:35 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49033 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728803AbgGMJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:31:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U2ZiJH._1594632693;
Received: from localhost.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2ZiJH._1594632693)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Jul 2020 17:31:33 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] doc/zh_CN: add Chinese translation prefer section
Date:   Mon, 13 Jul 2020 17:31:23 +0800
Message-Id: <20200713093123.45269-1-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The add words is:

Translation Plan
================

Welcome for any part of kernel doc Chinese translation, expecially for
admin-guide part.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Jonathan Corbet <corbet@lwn.net> 
Cc: Harry Wei <harryxiyou@gmail.com> 
Cc: linux-doc@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 Documentation/conf.py                      | 2 +-
 Documentation/translations/zh_CN/index.rst | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index c503188880d9..b5b2be8eec22 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -36,7 +36,7 @@ needs_sphinx = '1.3'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
+extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel' ]
 
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 76850a5dd982..f2e06546ca3f 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -10,6 +10,11 @@
 人员做出贡献。 与任何大型社区一样，知道如何完成任务将使得更改合并的过程变得更
 加容易。
 
+翻译计划
+========
+
+内核中文文档欢迎任何翻译投稿，特别是关于管理员指南部分。
+
 .. toctree::
    :maxdepth: 2
 
-- 
2.18.2

