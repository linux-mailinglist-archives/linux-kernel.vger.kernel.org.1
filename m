Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D381F5DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 23:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgFJVuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 17:50:00 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42744 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgFJVt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:49:59 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jj8be-00023d-AD; Wed, 10 Jun 2020 15:49:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jj8bd-0000iK-IJ; Wed, 10 Jun 2020 15:49:58 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <875zc8kxyg.fsf@x220.int.ebiederm.org>
Date:   Wed, 10 Jun 2020 16:45:50 -0500
In-Reply-To: <875zc8kxyg.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Wed, 03 Jun 2020 09:47:51 -0500")
Message-ID: <87zh9atx0x.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jj8bd-0000iK-IJ;;;mid=<87zh9atx0x.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18RZcpIlb84vyLBuxdhHPmRMik2Wka0qQo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_12,XMSubMetaSxObfu_03,XMSubMetaSx_00
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 362 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.9%), b_tie_ro: 9 (2.5%), parse: 0.86 (0.2%),
         extract_message_metadata: 14 (3.9%), get_uri_detail_list: 1.76 (0.5%),
         tests_pri_-1000: 14 (3.8%), tests_pri_-950: 1.15 (0.3%),
        tests_pri_-900: 0.93 (0.3%), tests_pri_-90: 65 (18.1%), check_bayes:
        64 (17.7%), b_tokenize: 6 (1.7%), b_tok_get_all: 6 (1.7%),
        b_comp_prob: 1.97 (0.5%), b_tok_touch_all: 47 (13.0%), b_finish: 0.78
        (0.2%), tests_pri_0: 244 (67.4%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.2 (0.6%), poll_dns_idle: 0.71 (0.2%), tests_pri_10:
        2.0 (0.6%), tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] proc fixes for v5.8-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull the proc-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git proc-linus

   HEAD: 058f2e4da79b23afb56ce3d03d907d6cdd36f2b8 proc: s_fs_info may be NULL when proc_kill_sb is called

Syzbot found a NULL pointer dereference if kzalloc of proc's s_fs_info fails.
The fix is the patch below.

---

From: Alexey Gladkov <gladkov.alexey@gmail.com>
Date: Wed, 10 Jun 2020 20:35:49 +0200
Subject: [PATCH] proc: s_fs_info may be NULL when proc_kill_sb is called

syzbot found that proc_fill_super() fails before filling up sb->s_fs_info,
deactivate_locked_super() will be called and sb->s_fs_info will be NULL.
The proc_kill_sb() does not expect fs_info to be NULL which is wrong.

Link: https://lore.kernel.org/lkml/0000000000002d7ca605a7b8b1c5@google.com
Reported-by: syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com
Fixes: fa10fed30f25 ("proc: allow to mount many instances of proc in one pid namespace")
Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/root.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index ffebed1999e5..5e444d4f9717 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -264,11 +264,13 @@ static void proc_kill_sb(struct super_block *sb)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
-	if (fs_info->proc_self)
-		dput(fs_info->proc_self);
+	if (!fs_info) {
+		kill_anon_super(sb);
+		return;
+	}
 
-	if (fs_info->proc_thread_self)
-		dput(fs_info->proc_thread_self);
+	dput(fs_info->proc_self);
+	dput(fs_info->proc_thread_self);
 
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
-- 
2.20.1

