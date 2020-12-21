Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1D42DFEDD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 18:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgLURPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 12:15:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgLURPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 12:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608570845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=XKVUppr1rM5syq4MOs0lnpavZ6GSfR5hr9FpW4a0PbI=;
        b=M095bFAX4c3wC0Ct93jOX+gwR1VgNnrcn1xXsvTFO8ooq/itXh1bu3GE01zC11BM6UbgiN
        oYXM1fNuWtaKvJ202MgEomCM9JVR4K02fD6C0R3nBzigFVn4Htupef88YQpSj4lIbcSHh/
        WtZ/MTGS/0uNFV1XKvFVs0HpZFzJX54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-fkmImXeqMb6RWByuNzYJtA-1; Mon, 21 Dec 2020 12:14:03 -0500
X-MC-Unique: fkmImXeqMb6RWByuNzYJtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 652BA192CC52;
        Mon, 21 Dec 2020 17:14:02 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1EBF5D9CA;
        Mon, 21 Dec 2020 17:13:52 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux Containers List <containers@lists.linux-foundation.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Neil Horman <nhorman@tuxdriver.com>,
        Eric Paris <eparis@parisplace.org>, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v10 06/11] libaudit: add support to get the task audit container identifier
Date:   Mon, 21 Dec 2020 12:12:46 -0500
Message-Id: <20201221171251.2610890-7-rgb@redhat.com>
In-Reply-To: <20201221171251.2610890-1-rgb@redhat.com>
References: <20201221171251.2610890-1-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the audit_get_containerid() call analogous to audit_getloginuid()
and audit_get_session() calls to get our own audit container identifier.

This is intended as a debug patch, not to be upstreamed.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 docs/Makefile.am             |  2 +-
 docs/audit_get_containerid.3 | 25 +++++++++++++++++++++++++
 lib/libaudit.c               | 29 +++++++++++++++++++++++++++++
 lib/libaudit.h               |  1 +
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 docs/audit_get_containerid.3

diff --git a/docs/Makefile.am b/docs/Makefile.am
index 8fb030c6e5e4..209789bb2051 100644
--- a/docs/Makefile.am
+++ b/docs/Makefile.am
@@ -28,7 +28,7 @@ man_MANS = audit_add_rule_data.3 audit_add_watch.3 auditctl.8 auditd.8 \
 auditd.conf.5 auditd-plugins.5 \
 audit_delete_rule_data.3 audit_detect_machine.3 \
 audit_encode_nv_string.3 audit_getloginuid.3 \
-audit_get_reply.3 audit_get_session.3 \
+audit_get_reply.3 audit_get_session.3 audit_get_containerid.3 \
 audit_log_acct_message.3 audit_log_user_avc_message.3 \
 audit_log_user_command.3 audit_log_user_comm_message.3 \
 audit_log_user_message.3 audit_log_semanage_message.3 \
diff --git a/docs/audit_get_containerid.3 b/docs/audit_get_containerid.3
new file mode 100644
index 000000000000..ef62a25db970
--- /dev/null
+++ b/docs/audit_get_containerid.3
@@ -0,0 +1,25 @@
+.TH "AUDIT_GET_CONTAINERID" "3" "Feb 2018" "Red Hat" "Linux Audit API"
+.SH NAME
+audit_get_containerid \- Get a program's container id value
+.SH SYNOPSIS
+.B #include <libaudit.h>
+.sp
+uin64_t audit_get_containerid(void);
+
+.SH DESCRIPTION
+This function returns the task's audit container identifier attribute.
+
+.SH "RETURN VALUE"
+
+This function returns the audit container identifier value if it was set. It will return a \-1 if the audit container identifier is unset. However, since uint64_t is an unsigned type, you will see the converted value instead of \-1.
+
+.SH "ERRORS"
+
+This function returns \-2 on failure. Additionally, in the event of a real error, errno would be set. The function can set errno based on failures of open, read, or strtoull.
+
+.SH "SEE ALSO"
+
+.BR audit_getloginuid (3).
+
+.SH AUTHOR
+Richard Guy Briggs
diff --git a/lib/libaudit.c b/lib/libaudit.c
index bcef9dc7a2cc..43c166fabbd8 100644
--- a/lib/libaudit.c
+++ b/lib/libaudit.c
@@ -967,6 +967,35 @@ uint32_t audit_get_session(void)
 		return ses;
 }
 
+/*
+ * This function will retrieve the audit container identifier or -2 if
+ * there is an error.
+ */
+uint64_t audit_get_containerid(void)
+{
+	uint64_t containerid;
+	int len, in;
+	char buf[32];
+
+	errno = 0;
+	in = open("/proc/self/audit_containerid", O_NOFOLLOW|O_RDONLY);
+	if (in < 0)
+		return -2;
+	do {
+		len = read(in, buf, sizeof(buf));
+	} while (len < 0 && errno == EINTR);
+	close(in);
+	if (len < 0 || len >= sizeof(buf))
+		return -2;
+	buf[len] = 0;
+	errno = 0;
+	containerid = strtoull(buf, 0, 10);
+	if (errno)
+		return -2;
+	else
+		return containerid;
+}
+
 int audit_rule_syscall_data(struct audit_rule_data *rule, int scall)
 {
 	int word = AUDIT_WORD(scall);
diff --git a/lib/libaudit.h b/lib/libaudit.h
index a252813d1f72..c6f45fdf7abc 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -602,6 +602,7 @@ extern int  audit_get_reply(int fd, struct audit_reply *rep, reply_t block,
 extern uid_t audit_getloginuid(void);
 extern int  audit_setloginuid(uid_t uid);
 extern uint32_t audit_get_session(void);
+extern uint64_t audit_get_containerid(void);
 extern int  audit_detect_machine(void);
 extern int audit_determine_machine(const char *arch);
 extern char *audit_format_signal_info(char *buf, int len, char *op, struct audit_reply *rep, char *res);
-- 
2.18.4

