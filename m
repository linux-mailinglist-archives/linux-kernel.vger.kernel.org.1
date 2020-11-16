Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154CD2B4010
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgKPJmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:42:55 -0500
Received: from mail.loongson.cn ([114.242.206.163]:54454 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbgKPJmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:42:55 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv9OYSbJfoOEPAA--.33384S2;
        Mon, 16 Nov 2020 17:42:48 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: [PATCH] Documentation: kgdb: Fix a typo
Date:   Mon, 16 Nov 2020 17:42:47 +0800
Message-Id: <1605519767-25502-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxv9OYSbJfoOEPAA--.33384S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW7Zr4kur1fuFWDuFy5XFb_yoW8GrW5pr
        s8C3saq3yDJw15K3y8Kr1UC343AFZ3X3yUCrZ2gF45XF15XwnYqry3K3WkZ3WDJF4IyFWj
        vr9IgFyqk3Wqy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4f
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0xhLUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"to into" -> "into"

Reported-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/dev-tools/kgdb.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
index 77b688e..4345624 100644
--- a/Documentation/dev-tools/kgdb.rst
+++ b/Documentation/dev-tools/kgdb.rst
@@ -63,10 +63,9 @@ will want to turn on ``CONFIG_DEBUG_INFO`` which is called
 It is advised, but not required, that you turn on the
 ``CONFIG_FRAME_POINTER`` kernel option which is called :menuselection:`Compile
 the kernel with frame pointers` in the config menu. This option inserts code
-to into the compiled executable which saves the frame information in
-registers or on the stack at different points which allows a debugger
-such as gdb to more accurately construct stack back traces while
-debugging the kernel.
+into the compiled executable which saves the frame information in registers
+or on the stack at different points which allows a debugger such as gdb to
+more accurately construct stack back traces while debugging the kernel.
 
 If the architecture that you are using supports the kernel option
 ``CONFIG_STRICT_KERNEL_RWX``, you should consider turning it off. This
-- 
2.1.0

