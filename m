Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365712D087A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 01:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgLGADn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 19:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGADn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 19:03:43 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13E0C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 16:03:02 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 91so7113316wrj.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 16:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mC3YoKcV6h/4OTV+qmejqeiSs0/6gZwXZU4VbR7pC4=;
        b=ZOlIue3xf69vkO4QJqvYKR6Y1pI/KKsit5xiIxFC4inNgbO+Z+qjSk66jzaRYlYiEc
         um9pbckrn2WZf49nBovPN9hLVfDXMnlYmr4GRHBzzX3SF1dGHlzMowa7qfxn4+Vhicf5
         2QRSnEdJVLOUpMRvfQ9B3e5omtJWzPnUH+uflzvEmrjsdL10x11H9ReTaPkcJVAUkso3
         WjulBNZtsoXGMjG4YImBDMX5OlFD1L8yDCyeE3cSmmvo9K/icvouV48S2gwxMuQfjC+F
         chIBrkiQlNyquJ7xvS3tKerZDxg9NfXCHxkcrynWJw9XUDsZ5N4dlLr2OE1hfOJTm/ay
         4jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mC3YoKcV6h/4OTV+qmejqeiSs0/6gZwXZU4VbR7pC4=;
        b=bv/MLFshVj9XL9ZgmdwE9PDuwKLA/ff0hqRbqTGMNtV0sWcjsG7t3WnwhOMZaYEnxz
         tk1vRtICK/DbQAlhlVmP5wnD1itmrJZcJHWw3/EFsqDNvgrWMMhlteeZn58CLE5q15fW
         5CkmVh7hNYRD+6mO4JCAmBQvSIWalwMISQoeP5JmD3OlNzUBP0tv5VuzoYAJjdb/H7Xy
         OaRPkVfU4HflcwCqDpZETiiaIv/xqjTPA7WnqTcsY2+2O6rC0oBZjo3buOWVd0g5/j/i
         gYOdYqBTNzWPEHkOO/D7fIIzZiwoY3LBlVUktXA3rZBLvP7eMKbjDYr9+wGUe+pU97z4
         3gGQ==
X-Gm-Message-State: AOAM5326zqbnQ/yYzovOsQD8aagT9qVj4cqMLEDa2872Ay0eIxbq+aSO
        gjeN/i2/+bLKh4uGxoi4a0MhhQ==
X-Google-Smtp-Source: ABdhPJyq/y0Usg/htjOoN89qwDk2tNzdxOq4xYyGg8M2HDHutxEX1+4Vd091FtaActysm4bWGJgZbQ==
X-Received: by 2002:adf:f3cf:: with SMTP id g15mr16843502wrp.71.1607299381241;
        Sun, 06 Dec 2020 16:03:01 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id v1sm12614215wrr.48.2020.12.06.16.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 16:03:00 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH pidfd] signal: Add missing __user annotation to copy_siginfo_from_user_any
Date:   Mon,  7 Dec 2020 01:02:52 +0100
Message-Id: <20201207000252.138564-1-jannh@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_siginfo_from_user_any() takes a userspace pointer as second
argument; annotate the parameter type accordingly.

Signed-off-by: Jann Horn <jannh@google.com>
---
I'm messing around with clang's version of __user annotation checking
and it spotted this issue:

kernel/signal.c:3759:44: warning: casting to dereferenceable pointer remove=
s 'noderef' attribute [-Wnoderef]
                ret =3D copy_siginfo_from_user_any(&kinfo, info);
                                                         ^~~~
Untracked cast to function pointer at kernel/signal.c:4294:26


Christian, since this is pidfd code, can you take this through your tree?
Or should I send this to akpm (or someone else)?

 kernel/signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index ef8f2a28d37c..4693191dc17c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3685,7 +3685,8 @@ static bool access_pidfd_pidns(struct pid *pid)
 	return true;
 }
=20
-static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo, siginfo_t *=
info)
+static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
+		siginfo_t __user *info)
 {
 #ifdef CONFIG_COMPAT
 	/*

base-commit: 0477e92881850d44910a7e94fc2c46f96faa131f
--=20
2.29.2.576.ga3fc446d84-goog

