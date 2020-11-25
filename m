Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A442C37AA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 04:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgKYDf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 22:35:57 -0500
Received: from mail.loongson.cn ([114.242.206.163]:35476 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgKYDf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 22:35:57 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxKtAV0b1fR1kWAA--.36754S2;
        Wed, 25 Nov 2020 11:35:49 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH RESEND] checkpatch: Do not check git commit description style when backport the upstream commit
Date:   Wed, 25 Nov 2020 11:35:47 +0800
Message-Id: <1606275347-19297-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxKtAV0b1fR1kWAA--.36754S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1xurW5Cw47Gr47CrykXwb_yoW8tr4xpa
        1DW34FqrWrGF1UJanrG340qayYgws5Xr1I9ryDuF12vFyUKFn2qr9avr1fZr17AFyF9aya
        qa1rC3sag3W0kFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU5pnQUUU
        UU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When backport the upstream commit to the internal LTS kernel version,
we usually use the following description [1] [2]:

[ Upstream commit cc6528bc9a0c901c83b8220a2e2617f3354d6dd9 ]
or
commit c51f8f88d705e06bd696d7510aff22b33eb8e638 upstream.

We use checkpatch.pl before auto build and there exists auto build
failure due to the following checkpatch error:

ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit cc6528bc9a0c ("r8169: fix potential skb double free in an error path")'
#6:
[ Upstream commit cc6528bc9a0c901c83b8220a2e2617f3354d6dd9 ]
or
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit c51f8f88d705 ("random32: make prandom_u32() output unpredictable")'
#6:
commit c51f8f88d705e06bd696d7510aff22b33eb8e638 upstream.

We can use "--ignore GIT_COMMIT_ID" to avoid this checkpatch
error, but I think it is better to modify the check rule of
checkpatch. When there exists "Upstream" or "upstream" in the
commit line, it seems no need to do more check.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.19.y&id=bc571404829755e4a9504cc5fbc636fea80b2d83
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.19.y&id=81d7c56d6fab5ccbf522c47a655cd427808679f2

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

RESEND to Andrew Morton <akpm@linux-foundation.org>

 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b4..f5bbfdd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2889,7 +2889,8 @@ sub process {
 		    ($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
 		     ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
 		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i &&
-		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
+		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i)) &&
+		    $line !~ /^\s*Upstream|upstream/i) {
 			my $init_char = "c";
 			my $orig_commit = "";
 			my $short = 1;
-- 
2.1.0

