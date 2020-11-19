Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787CF2B9D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 23:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKSWUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 17:20:13 -0500
Received: from drummond.us ([74.95.14.229]:4564 "EHLO
        talisker.home.drummond.us" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbgKSWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 17:20:13 -0500
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Nov 2020 17:20:12 EST
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 0AJMBolN1515759;
        Thu, 19 Nov 2020 14:11:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1605823911;
        bh=Ayx7/03KKR9LNFXEVXiNjLwjKsBf8QCVWMy0RTPXC3A=;
        h=From:To:Subject:Date:From;
        b=E1o03DRpQSuWoGSlGl/mfkHO4gTUiBjNeD5f6fi2f+8uQRlkMJsIGjBsUAD1WUIor
         wY6ioximfxcU0h2Rc6mBdt//7Wiu/bD0YXlVqj4l8li7SJ7USPbnSoxqwdILOonX1d
         viNn1+6TPmngWXWSLPu9InO/rPuI3g8JEi4Epcmvw9dHb10Z4OnoRlNRJCWBLIUW3T
         C6Om90k6BrPMBWx80OFdw+0vd2gKGIy+dXP7UzxWF4cWdf7qQ3kgVOa8jjrqQlWjkG
         uSRaCWlrXIiWxWeTE/ljDWJIe41gKCDkp8Eo7fE2WAacJ7rKxwoXRleiMph+lc6X0i
         rZU9CjFTW4KxA==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 0AJMBlFG1515758;
        Thu, 19 Nov 2020 14:11:47 -0800
From:   Walt Drummond <walt@drummond.us>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, brgerst@gmail.com,
        linux@dominikbrodowski.net, walt@drummond.us,
        gustavoars@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/signals: Fix save/restore signal stack to correctly support sigset_t
Date:   Thu, 19 Nov 2020 14:11:33 -0800
Message-Id: <20201119221132.1515696-1-walt@drummond.us>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro unsafe_put_sigmask() only handles the first 64 bits of the
sigmask_t, which works today.  However, if the definition of the
sigset_t structure ever changed, this would fail to setup/restore the
signal stack properly and likely corrupt the sigset. This patch
updates unsafe_put_sigmask() to correctly save all the fields in the
sigmask_t struct, and adds unsafe_put_compat_sigmask() to handle the
compat_sigset_t cases.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 arch/x86/kernel/signal.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index be0d7d4152ec..4d5134b4bb5f 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -203,11 +203,18 @@ do {									\
 		goto label;						\
 } while(0);
 
-#define unsafe_put_sigmask(set, frame, label) \
+#define unsafe_put_compat_sigmask(set, frame, label) \
 	unsafe_put_user(*(__u64 *)(set), \
 			(__u64 __user *)&(frame)->uc.uc_sigmask, \
 			label)
 
+#define unsafe_put_sigmask(set, frame, label)           \
+do {                                                    \
+	int i;								\
+	for (i = 0; i < _NSIG_WORDS; i++)				\
+		unsafe_put_user((set)->sig[i], &(frame)->uc.uc_sigmask.sig[i], label); \
+} while(0);
+
 /*
  * Set up a signal frame.
  */
@@ -566,7 +573,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 	restorer = ksig->ka.sa.sa_restorer;
 	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
 	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_sigmask(set, frame, Efault);
+	unsafe_put_compat_sigmask(set, frame, Efault);
 	user_access_end();
 
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
@@ -643,7 +650,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
+	if (copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(sigset_t)))
 		goto badframe;
 	if (__get_user(uc_flags, &frame->uc.uc_flags))
 		goto badframe;
-- 
2.27.0

