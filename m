Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C061EB4C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 07:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgFBFAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 01:00:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44315 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725787AbgFBFAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591074013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=n9PkjNEQqqTWuaN+CVoilTQvSdVudQk6CXvQLcnvEcI=;
        b=FmesZJFaNbz0NUKCO50Jr4s6+aV+wqcJeIlu+m3WLBPsdc8NL80xo63OVTb2StGzwDrA7V
        Xd+cCiQ54hMbZWWjDJ8+ET9vKxp37/piRwgaUApumPN4dnU7LZpRap/QIx1bKJDWYpgzHu
        WPlGymCQ3237+tF3QY/Xks9gwZf8028=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-bH8aMhohMw6LmvpSZYUiIQ-1; Tue, 02 Jun 2020 01:00:11 -0400
X-MC-Unique: bH8aMhohMw6LmvpSZYUiIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 734E5107ACF5;
        Tue,  2 Jun 2020 05:00:09 +0000 (UTC)
Received: from unused.redhat.com (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABF867B918;
        Tue,  2 Jun 2020 04:59:54 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, jbohac@suse.cz, jmorris@namei.org,
        mjg59@google.com, dyoung@redhat.com, bhe@redhat.com
Subject: [PATCH v2] kexec: Do not verify the signature without the lockdown or mandatory signature
Date:   Tue,  2 Jun 2020 12:59:52 +0800
Message-Id: <20200602045952.27487-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signature verification is an important security feature, to protect
system from being attacked with a kernel of unknown origin. Kexec
rebooting is a way to replace the running kernel, hence need be
secured carefully.

In the current code of handling signature verification of kexec kernel,
the logic is very twisted. It mixes signature verification, IMA signature
appraising and kexec lockdown.

If there is no KEXEC_SIG_FORCE, kexec kernel image doesn't have one of
signature, the supported crypto, and key, we don't think this is wrong,
Unless kexec lockdown is executed. IMA is considered as another kind of
signature appraising method.

If kexec kernel image has signature/crypto/key, it has to go through the
signature verification and pass. Otherwise it's seen as verification
failure, and won't be loaded.

Seems kexec kernel image with an unqualified signature is even worse than
those w/o signature at all, this sounds very unreasonable. E.g. If people
get a unsigned kernel to load, or a kernel signed with expired key, which
one is more dangerous?

So, here, let's simplify the logic to improve code readability. If the
KEXEC_SIG_FORCE enabled or kexec lockdown enabled, signature verification
is mandated. Otherwise, we lift the bar for any kernel image.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
Changes since v1:
[1] Modify the log level(suggested by Jiri Bohac)

 kernel/kexec_file.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index faa74d5f6941..fae496958a68 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -181,34 +181,19 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 static int
 kimage_validate_signature(struct kimage *image)
 {
-	const char *reason;
 	int ret;
 
 	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
 					   image->kernel_buf_len);
-	switch (ret) {
-	case 0:
-		break;
+	if (ret) {
 
-		/* Certain verification errors are non-fatal if we're not
-		 * checking errors, provided we aren't mandating that there
-		 * must be a valid signature.
-		 */
-	case -ENODATA:
-		reason = "kexec of unsigned image";
-		goto decide;
-	case -ENOPKG:
-		reason = "kexec of image with unsupported crypto";
-		goto decide;
-	case -ENOKEY:
-		reason = "kexec of image with unavailable key";
-	decide:
 		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
-			pr_notice("%s rejected\n", reason);
+			pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
 			return ret;
 		}
 
-		/* If IMA is guaranteed to appraise a signature on the kexec
+		/*
+		 * If IMA is guaranteed to appraise a signature on the kexec
 		 * image, permit it even if the kernel is otherwise locked
 		 * down.
 		 */
@@ -216,17 +201,10 @@ kimage_validate_signature(struct kimage *image)
 		    security_locked_down(LOCKDOWN_KEXEC))
 			return -EPERM;
 
-		return 0;
-
-		/* All other errors are fatal, including nomem, unparseable
-		 * signatures and signature check failures - even if signatures
-		 * aren't required.
-		 */
-	default:
-		pr_notice("kernel signature verification failed (%d).\n", ret);
+		pr_debug("kernel signature verification failed (%d).\n", ret);
 	}
 
-	return ret;
+	return 0;
 }
 #endif
 
-- 
2.17.1

