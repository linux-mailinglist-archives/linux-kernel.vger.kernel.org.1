Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06592BA022
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 03:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgKTCAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgKTCAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:00:04 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7649C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 18:00:02 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 1so8469402wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 18:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F39VbXXpAOMs7c/cbKtBC1zvASU6hJJhCbsv/h91NIg=;
        b=rAB/ing8Y48Qg7XzyFi3WSc0Ric4MwGGNHW1Y8fgMIzgDx4iqWcTZ4jOJENyTDhvXB
         vDM3w1xXbNUaatiDpbz86ENSfMrfJcLeojREhjbKPI6v4ehPnLPp7lwwUmUQnCQ6sEZT
         uw9BhHnYCGoQ42KjiR8R+h5vRHMRlb2/bu4XeXuVsvRTkM4RX3Fi1u7o4WskbuM0hp4o
         EGwQbNoUSbFIKl4+lzlsZu/+Q5CTet2rIQjUXa+SVPIqunfo4H2NrljVuH1rnQyd/sXY
         F07QOPbN+r0iIiA5eu+6wRdMylR0FYlzv89iVUdn4cMqDsykGcmUtZc2V8aRrII+b6RM
         b19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F39VbXXpAOMs7c/cbKtBC1zvASU6hJJhCbsv/h91NIg=;
        b=CiOmjQ5wkjRniiVrAdKIXyURqJVxyRIFRYOz5srnIBzfOLBjPt/Q884bTPlk1reIAr
         OY94uEwPLI0ub3HqQ2MC7nrnM+vz8lM9Am1sphSTQRU7Q1Wn7c7F0OJt5QTrQliOF+yk
         8H3oR6+hPz39XmfDlTLPSBEirZtAudkh/8T30y6xyILPWFIaZ5V9Ui/Kqz2ptwvn0sJ8
         4Wt6ekZI3i+YygUZdq3OzJJUzNXNKJfsuoPLhIJjQoJK28ps9O5Z/BqDslvxScnnZEJn
         Q8gBA3oxc6CLwxqeqWBxAtOqwQi94TKYv3pRJAQxAPC+/Ndypd6SmToxhKIzU+W2QUrE
         RFvQ==
X-Gm-Message-State: AOAM531zf8ik2VyosRO+Uniy0HDNDEmqyf8oTAThpLawXeFx39wr8x5h
        709jtF/Q9QMU3J9wGtXF5WXlTg==
X-Google-Smtp-Source: ABdhPJxILTSPHT9EmOCMWlazofOqpLuxAtdMQgLzGuwvAOo3z0ubamReMfKSRKyTGq+eTGSB9q3JPw==
X-Received: by 2002:a1c:ddd7:: with SMTP id u206mr7230405wmg.27.1605837601392;
        Thu, 19 Nov 2020 18:00:01 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id h15sm2781146wrw.15.2020.11.19.18.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 18:00:00 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Tyler Hicks <code@tyhicks.com>
Subject: [PATCH] seccomp: Remove bogus __user annotations
Date:   Fri, 20 Nov 2020 02:59:13 +0100
Message-Id: <20201120015913.1375667-1-jannh@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffers that are passed to read_actions_logged() and write_actions_logged()
are in kernel memory; the sysctl core takes care of copying from/to
userspace.

Fixes: 0ddec0fc8900 ("seccomp: Sysctl to configure actions that are allowed=
 to be logged")
Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 8ad7a293255a..c2bff3561846 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1968,7 +1968,7 @@ static bool seccomp_actions_logged_from_names(u32 *ac=
tions_logged, char *names)
 	return true;
 }
=20
-static int read_actions_logged(struct ctl_table *ro_table, void __user *bu=
ffer,
+static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
 			       size_t *lenp, loff_t *ppos)
 {
 	char names[sizeof(seccomp_actions_avail)];
@@ -1986,7 +1986,7 @@ static int read_actions_logged(struct ctl_table *ro_t=
able, void __user *buffer,
 	return proc_dostring(&table, 0, buffer, lenp, ppos);
 }
=20
-static int write_actions_logged(struct ctl_table *ro_table, void __user *b=
uffer,
+static int write_actions_logged(struct ctl_table *ro_table, void *buffer,
 				size_t *lenp, loff_t *ppos, u32 *actions_logged)
 {
 	char names[sizeof(seccomp_actions_avail)];

base-commit: 4d02da974ea85a62074efedf354e82778f910d82
--=20
2.29.2.454.gaff20da3a2-goog

