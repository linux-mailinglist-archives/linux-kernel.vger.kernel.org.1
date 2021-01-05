Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E392EA72E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbhAEJUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:20:33 -0500
Received: from mail.loongson.cn ([114.242.206.163]:33284 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbhAEJUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:20:32 -0500
Received: from localhost.localdomain (unknown [112.20.112.14])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxTzYxL_RfPGYKAA--.726S2;
        Tue, 05 Jan 2021 17:19:46 +0800 (CST)
From:   siyanteng@loongson.cn
To:     Harry Wei <harryxiyou@gmail.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH] docs/zh_CN: add Chinese booting and index file
Date:   Tue,  5 Jan 2021 17:19:42 +0800
Message-Id: <20210105091942.812515-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxTzYxL_RfPGYKAA--.726S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr48AF4rKrWxtr4rAr13urg_yoW7Jw17pr
        s3GryfKa1UA342vrWfKF1UJr1rJr4fGFWUJ3Wktw1kXrn7AF18JrnFyry0yry7Kry8uFW2
        vrWUKrWjkr1Yk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUva14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
        MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjfUntxhDUUUU
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanteng Si <siyanteng@loongson.cn>

This is the Chinese version of booting and index file

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../translations/zh_CN/mips/booting.rst       | 47 +++++++++++++++++++
 .../translations/zh_CN/mips/index.rst         | 45 ++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/mips/booting.rst
 create mode 100644 Documentation/translations/zh_CN/mips/index.rst

diff --git a/Documentation/translations/zh_CN/mips/booting.rst b/Documentation/translations/zh_CN/mips/booting.rst
new file mode 100644
index 000000000000..12e0aa76b485
--- /dev/null
+++ b/Documentation/translations/zh_CN/mips/booting.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Chinese translated version of Documentation/mips/booting.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Chinese maintainer: Yanteng Si <siyanteng@loongson.cn>
+---------------------------------------------------------------------
+Documentation/mips/booting.rst 的中文翻译
+
+如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
+交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
+译存在问题，请联系中文版维护者。
+
+中文版维护者： 司延腾  Yanteng Si <siyanteng@loongson.cn>
+中文版翻译者： 司延腾  Yanteng Si <siyanteng@loongson.cn>
+中文版校译者： 司延腾  Yanteng Si <siyanteng@loongson.cn>
+
+以下为正文
+---------------------------------------------------------------------
+
+BMIPS设备树引导
+------------------------
+
+  一些bootloaders只支持在内核镜像开始地址处的单一入口点。而其它
+  bootloaders将跳转到ELF的开始地址处。两种方案都被支持的；因为
+  CONFIG_BOOT_RAW=y and CONFIG_NO_EXCEPT_FILL=y, 所以第一条指令
+  会立即跳转到kernel_entry()入口处执行。
+
+  与arch/arm情况(b)类似，dt感知的引导加载程序需要设置以下寄存器:
+
+         a0 : 0
+
+         a1 : 0xffffffff
+
+         a2 : RAM中指向设备树块的物理指针(在chapterII中定义)。
+              设备树可以位于前512MB物理地址空间(0x00000000 -
+              0x1fffffff)的任何位置，以64位边界对齐。
+
+  legacy bootloaders不会使用这样的约定，并且它们不传入DT块。
+  在这种情况下，Linux将通过选中CONFIG_DT_*查找DTB。
+
+  这个约定只在32位系统中定义，因为目前没有任何64位的BMIPS实现。
diff --git a/Documentation/translations/zh_CN/mips/index.rst b/Documentation/translations/zh_CN/mips/index.rst
new file mode 100644
index 000000000000..244b16b7ef51
--- /dev/null
+++ b/Documentation/translations/zh_CN/mips/index.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Chinese translated version of Documentation/mips/index.rst
+
+If you have any comment or update to the content, please contact the
+original document maintainer directly.  However, if you have a problem
+communicating in English you can also ask the Chinese maintainer for
+help.  Contact the Chinese maintainer if this translation is outdated
+or if there is a problem with the translation.
+
+Chinese maintainer: Yanteng Si <siyanteng@loongson.cn>
+---------------------------------------------------------------------
+Documentation/mips/index.rst 的中文翻译
+
+如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
+交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
+译存在问题，请联系中文版维护者。
+
+中文版维护者： 司延腾  Yanteng Si <siyanteng@loongson.cn>
+中文版翻译者： 司延腾  Yanteng Si <siyanteng@loongson.cn>
+中文版校译者： 司延腾  Yanteng Si <siyanteng@loongson.cn>
+
+以下为正文
+---------------------------------------------------------------------
+
+
+===========================
+MIPS特性文档
+===========================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
+
+   booting
+   ingenic-tcu
+
+   features
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
-- 
2.27.0

