Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A19302BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbhAYTio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbhAYTKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:10:12 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15B7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:09:30 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id d7so10646481qkb.23
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=JQp/xg+V+xEulp87Yp8xnpT2qqtG5ZRNNRpdHpHXrd4=;
        b=UNgstl+CPcDmjyeZ2t9Thi4RXI5eqYTx9idTljmwj9o0rh5Sg5VpcYhDDHytdcIjMu
         4RkVCPye78diE74sSohPHs3w95ZaPFQVoh/exje1jufmWAm1XoypUhq4H8tMVxRb76NT
         kNp4yDVYtFtudQ2IboOGJDFF+/jIla+HNA+WhRANtNLFlaj8q1F7W6yEcFQG9BYRWRdu
         bf74yG6gZpmi6p3gxDrw52TiEKVoFfOPlp3viwszLgduhzGmL0ma30UtBvFkNQDAK5IK
         YAoHX0p0qoYKZZwwahKnlrkXJpvmAWKuE+Q6ga3cPwTLurUKIFV929AkhrhJmsGXP29I
         N9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=JQp/xg+V+xEulp87Yp8xnpT2qqtG5ZRNNRpdHpHXrd4=;
        b=rqh9RZaSTIrBfGPAFFuq2exL51scUEyWkBP2RHGebphPFIic1ouFDdFutlHzPBtMJA
         brN68m1+Fk8hb6blFnTLzEgapMUCmpJj/OBoxUgUwae+QJH90oLA3iwNde5NqG6RCY1o
         v+lKhn3PIg7lXFlWYpvgfXbwME0KFCDw18Lsu0WYwyNZbSpi8KXQLRgKDtDsQGjeLnQ8
         4RS4P8FHXFqz7I05KEYIe2DzRw/IfB6Hpchp1JPlvpyEN7YeU8Bz9Q1NLNZ2/5y6MO9o
         3/FQIUeHeGkgVEmIxAEogozvpvFLpHd05LrqWqpNMyOdgDgVoUxq2D9Wxxo0X+5PNbRc
         FEyw==
X-Gm-Message-State: AOAM530LLv0OFx3qQWmfEy+qpGL5Yx0k02Li0M37QTHv99O7XfqhSJkz
        4yZszOgXrkBXp8wmzL1ofpGrqYjZZ7OznNgdMac=
X-Google-Smtp-Source: ABdhPJwP+aYdPVXOWNJALJIxRqDDWAFAJz7sD9CjgfNFC5tDJAxzxjhi3edJEOrL2YGPnI/YG2iO9QTDpaAfKJlSvNA=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:43ea:: with SMTP id
 f10mr2208475qvu.52.1611601770024; Mon, 25 Jan 2021 11:09:30 -0800 (PST)
Date:   Mon, 25 Jan 2021 11:09:25 -0800
Message-Id: <20210125190925.3655829-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH] n_tty: fix redirected_tty_write checks after write_iter conversion
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9bb48c82aced ("tty: implement write_iter") converted the tty
layer to use write_iter. Fix the redirected_tty_write declaration
also in n_tty and change the comparisons to use write_iter instead of
write.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/tty/n_tty.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 319d68c8a5df..ee70937ac2b8 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2081,8 +2081,7 @@ static int canon_copy_from_read_buf(struct tty_struct *tty,
 	return 0;
 }
 
-extern ssize_t redirected_tty_write(struct file *, const char __user *,
-							size_t, loff_t *);
+extern ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
 
 /**
  *	job_control		-	check job control
@@ -2105,7 +2104,7 @@ static int job_control(struct tty_struct *tty, struct file *file)
 	/* NOTE: not yet done after every sleep pending a thorough
 	   check of the logic of this change. -- jlc */
 	/* don't stop on /dev/console */
-	if (file->f_op->write == redirected_tty_write)
+	if (file->f_op->write_iter == redirected_tty_write)
 		return 0;
 
 	return __tty_check_change(tty, SIGTTIN);
@@ -2309,7 +2308,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 	ssize_t retval = 0;
 
 	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
-	if (L_TOSTOP(tty) && file->f_op->write != redirected_tty_write) {
+	if (L_TOSTOP(tty) && file->f_op->write_iter != redirected_tty_write) {
 		retval = tty_check_change(tty);
 		if (retval)
 			return retval;

base-commit: 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04
-- 
2.30.0.280.ga3ce27912f-goog

