Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FB6230ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgG1NBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 09:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbgG1NBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:01:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7943C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:01:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p138so1472819yba.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Ya+X644CIpKsu+82u267rP7HaSbeBJBhbsTwGl4hFHQ=;
        b=nPqbrV7DC1dyJE0ydgyu3pBUTlTM1knV1rD2zKoyI4ZFEgp/qomKbc4jkGR/xU0D2k
         AGUi8yp+/M17ScdyzCfZixdlXUJhE3sCyoRmBOch35bQsSMeSQOfZGUQQ8Ucu6Kj5bvp
         +GdYhMAefN2C61kWnH9HF6PfesS0k63dlm/VQ2ua+Nikh2KkGjpv7Rqp29SX3QRnHpEE
         zbhNjMaffKv6/RJ/McYzQr9ZjylEnE2SzBjYyidi9UmF7DOLJCYMaTwJDSXffoLCN/qp
         j4db66drGJlDAw/P5AvAt0PsKz20Uj6s/zNlXPJ0212XbVlaLSgBxT5RjIO4evss2+qB
         j7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Ya+X644CIpKsu+82u267rP7HaSbeBJBhbsTwGl4hFHQ=;
        b=PbzHSdQXNxBcOeIflqeZMws5WuV7ENxg3EgeB5SXgAjkyf16snRNJZcI7ZprA0Qc7c
         Q68cgKwJth6r+ANUgrFKrUyDfqbN8SK4HU4WRZ/ICoktMvXTsO+SYupry5ufAvjuW3cG
         wpVszFY28b2rTv0dF4AcX8PPg/uJ8VMcX4PbGZWIr8Ts+q84cDfrXXdjQODkg6yPfzbU
         1M0VEzeT2baM+2pf6tr0ABQ9QrKhH6PiVgxm+cDTogWzK0SRNkTtMBjdvo4UxnoaxO0q
         IpJF5mbKMEVG9/F3jA/6NhUrCFmpCNbBRkpLIPuNB2o9vSICUnWJgg1899+LooH2em+n
         KTCw==
X-Gm-Message-State: AOAM531b6M1ywaRRfR83apkxBfArDmjFtUst5LnPXLllXPiXLi+kDn0c
        HMawGdMqUh38GnI2KY8EXmeJyZ910g==
X-Google-Smtp-Source: ABdhPJy4hzucmW0xAq9k3SvB7xnSJEQ4n7JtK2bmteR8LMMvdZaP74tgxJV1oY1S3YTTAhoeu/jMAo8mlQ==
X-Received: by 2002:a05:6902:512:: with SMTP id x18mr13070478ybs.496.1595941300068;
 Tue, 28 Jul 2020 06:01:40 -0700 (PDT)
Date:   Tue, 28 Jul 2020 15:01:04 +0200
Message-Id: <20200728130120.3633360-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2] selinux: add tracepoint on denials
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audit data currently captures which process and which target
is responsible for a denial. There is no data on where exactly in the
process that call occurred. Debugging can be made easier by being able to
reconstruct the unified kernel and userland stack traces [1]. Add a
tracepoint on the SELinux denials which can then be used by userland
(i.e. perf).

Although this patch could manually be added by each OS developer to
trouble shoot a denial, adding it to the kernel streamlines the
developers workflow.

[1] https://source.android.com/devices/tech/debug/native_stack_dump

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
Changes in v2:
- Replace %d formatter with %x
- Replace TRACE_EVENT with TRACE_EVENT_CONDITION
- Add pid to structure and printk
- Rename structure fields for clarity


 MAINTAINERS                    |  1 +
 include/trace/events/selinux.h | 39 ++++++++++++++++++++++++++++++++++
 security/selinux/avc.c         |  5 +++++
 3 files changed, 45 insertions(+)
 create mode 100644 include/trace/events/selinux.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f0569cf304ca..0f74c8f073ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15369,6 +15369,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/gi=
t/pcmoore/selinux.git
 F:	Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
 F:	Documentation/ABI/obsolete/sysfs-selinux-disable
 F:	Documentation/admin-guide/LSM/SELinux.rst
+F:	include/trace/events/selinux.h
 F:	include/uapi/linux/selinux_netlink.h
 F:	scripts/selinux/
 F:	security/selinux/
diff --git a/include/trace/events/selinux.h b/include/trace/events/selinux.=
h
new file mode 100644
index 000000000000..287e1ecb4451
--- /dev/null
+++ b/include/trace/events/selinux.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM selinux
+
+#if !defined(_TRACE_SELINUX_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SELINUX_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT_CONDITION(selinux_denied,
+
+	TP_PROTO(struct selinux_audit_data *sad, pid_t pid),
+
+	TP_ARGS(sad, pid),
+
+	TP_CONDITION(sad->denied),
+
+	TP_STRUCT__entry(
+		__field(pid_t, pid)
+		__field(int, tclass)
+		__field(int, audited)
+	),
+
+	TP_fast_assign(
+		__entry->pid =3D pid;
+		__entry->tclass =3D sad->tclass;
+		__entry->audited =3D sad->audited;
+	),
+
+	TP_printk("denied pid=3D%d tclass=3D%x audited=3D%x",
+		__entry->pid,
+		__entry->tclass,
+		__entry->audited)
+);
+
+#endif
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index d18cb32a242a..ca8206f38d8a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -31,6 +31,9 @@
 #include "avc_ss.h"
 #include "classmap.h"
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/selinux.h>
+
 #define AVC_CACHE_SLOTS			512
 #define AVC_DEF_CACHE_THRESHOLD		512
 #define AVC_CACHE_RECLAIM		16
@@ -665,6 +668,8 @@ static void avc_audit_pre_callback(struct audit_buffer =
*ab, void *a)
 	const char **perms;
 	int i, perm;
=20
+	trace_selinux_denied(sad, task_tgid_nr(current));
+
 	audit_log_format(ab, "avc:  %s ", sad->denied ? "denied" : "granted");
=20
 	if (av =3D=3D 0) {
--=20
2.28.0.rc0.142.g3c755180ce-goog

