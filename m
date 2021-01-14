Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA062F5BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbhANHzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbhANHzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:55:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F6D223A05;
        Thu, 14 Jan 2021 07:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610610830;
        bh=KwLtm2qE/P7KUgXcQLH4sQbqeaDZcG9TP2B7eAOt4uE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yx/Pk4w5/cjbtL1uW3DC5jTyrO725POQij7w7h+EGg2cQFF70Qtcb5iul4HHEGqSS
         nrbBVZa+By00SEIYiqxYk9q8ngvnBhqyptchkIlkeC1soYOyyQ0oRIs8LvlzAE5GRt
         6UWg8b16LckFBXGrhNiqtsrLUURdpzigEj3y31SlDG7Zhnaq1BRfzoMWQxsEAQL9rt
         UIOlmzMU1HGQW7mgJ+q01czGdOEteH9IRV2rMyD6iND1RVkAklFdggrhSeLmZNMrr0
         Ar1y/GbJLaVnRYb5QNOMV5sm4Pu39War4gDsEGKw4q7T24ij+pcj/82rRwnyqMHCHH
         mcT08vaA+/p9Q==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxRz-00EPuH-B8; Thu, 14 Jan 2021 08:53:47 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Harry Wei <harryxiyou@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] doc: zh_CN/mips: fix doc cross-references
Date:   Thu, 14 Jan 2021 08:53:43 +0100
Message-Id: <dab7d447742b36915115d0364edbfb337de4bf96.1610610444.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610444.git.mchehab+huawei@kernel.org>
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several wrong references there:

    .../Documentation/translations/zh_CN/mips/booting.rst:5: WARNING: undefined label: booting (if the link has no caption the label must precede a section header)
    .../Documentation/translations/zh_CN/mips/features.rst:5: WARNING: undefined label: features (if the link has no caption the label must precede a section header)
    .../Documentation/translations/zh_CN/mips/index.rst:5: WARNING: undefined label: index (if the link has no caption the label must precede a section header)
    .../Documentation/translations/zh_CN/mips/ingenic-tcu.rst:5: WARNING: undefined label: ingenic-tcu (if the link has no caption the label must precede a section header)

Replace them by :doc: markup, which won't require to add anything
extra at the existing documents.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/translations/zh_CN/mips/booting.rst     | 2 +-
 Documentation/translations/zh_CN/mips/features.rst    | 2 +-
 Documentation/translations/zh_CN/mips/index.rst       | 2 +-
 Documentation/translations/zh_CN/mips/ingenic-tcu.rst | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/translations/zh_CN/mips/booting.rst b/Documentation/translations/zh_CN/mips/booting.rst
index 3099d0fff7a6..00bebf7681f9 100644
--- a/Documentation/translations/zh_CN/mips/booting.rst
+++ b/Documentation/translations/zh_CN/mips/booting.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/mips/booting.rst <booting>`
+:Original: :doc:`/mips/booting`
 :Translator: Yanteng Si <siyanteng@loongson.cn>
 
 .. _cn_booting:
diff --git a/Documentation/translations/zh_CN/mips/features.rst b/Documentation/translations/zh_CN/mips/features.rst
index 7e67f81a0982..72adcd9b360f 100644
--- a/Documentation/translations/zh_CN/mips/features.rst
+++ b/Documentation/translations/zh_CN/mips/features.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/mips/features.rst <features>`
+:Original: :doc:`/mips/features`
 :Translator: Yanteng Si <siyanteng@loongson.cn>
 
 .. _cn_features:
diff --git a/Documentation/translations/zh_CN/mips/index.rst b/Documentation/translations/zh_CN/mips/index.rst
index 2c7b836a3da5..c2ab89890979 100644
--- a/Documentation/translations/zh_CN/mips/index.rst
+++ b/Documentation/translations/zh_CN/mips/index.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/mips/index.rst <index>`
+:Original: :doc:`/mips/index`
 :Translator: Yanteng Si <siyanteng@loongson.cn>
 
 .. _cn_index:
diff --git a/Documentation/translations/zh_CN/mips/ingenic-tcu.rst b/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
index 919ae1d4734e..cb570d7eca24 100644
--- a/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
+++ b/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/mips/ingenic-tcu.rst <ingenic-tcu>`
+:Original: :doc:`/mips/ingenic-tcu`
 :Translator: Yanteng Si <siyanteng@loongson.cn>
 
 .. _cn_ingenic-tcu:
-- 
2.29.2

