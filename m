Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C32246E30
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 19:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389990AbgHQRYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 13:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389192AbgHQRKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:10:19 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38B1C061347
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 10:09:00 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id i23so5769230ejx.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=WC3qwxqXOlSZ7jnjgYv3zuH5IVQQXftskmacAfSf8Yw=;
        b=qmB2whkq1uymJPwNU/dDDT6gtA/BtcTHWj8k0C5guxkVqvJZ5JF9mHavC6v7+R7mDf
         G8Fr+tSFgNpb6Sv7ozrK+Wle5+N1EXGfrR+vr0QfX0cqIKQ6vCOV9x2p2Ri+EPjZfbRq
         QE54d3Sq4JZHH4lkmMFWDhxtnaN0l2T6BTOe7Yo2GQQBZmdW1kpBpZrcbkJU8iRQlt8s
         D2SpbNF7gUuVIsjXMOKKpJe0ubhjI6cc7jVHbkG5IQQjnOu4Bx8oYVMIHUoptEN0JnZB
         OL5i19HZ5bl7yLF3kbLpyEt8SSLnPj/rfic6DqR3n03NK1Cmo6GqM/GHRtzIPyEsCg4s
         JHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=WC3qwxqXOlSZ7jnjgYv3zuH5IVQQXftskmacAfSf8Yw=;
        b=He5cOlf3Rnv4hsMjMvm3DGhDguCldXNqIL9a9hyWaPmD1xIE2eeuXgDBhe+ZmxJNHN
         vyJBAQzbqO5/4IpyXBHJykWbw1UP9Cqkdd9VIGqBxpAX6KMYJgwwIuz7Eg+KspFG+n98
         MWTt3T0Cw0l4CjBijZvusxY8xRZ+4gBcJthRqZzQumACUdYXPJA8nQxkw71veF+cGv+p
         yFEg/39FBRq86wTw6s1j/8KUNSN3aH/X2dH+cOQO83WVcZzHULSU4WoADzfi+EHqME4q
         33kNR5WvNhyjM7XXn8EO3YZRQVBBJ3cAIAtpOJ+n4tUR2B6ZktdJ1O7+AtJ2IVbNn5ax
         tB+A==
X-Gm-Message-State: AOAM530ZpIUhT2dYaPaP7BPu5PmIGVRYBUPr85Nx2fatFoQYe/zcQFVQ
        i/n8wvusHAPjQWq/0hd/NAFomir05Q==
X-Google-Smtp-Source: ABdhPJz7JK/4hALFPPtoFqZ5PnvZtUHs3KrjtksrheYnNRpGzoaAxixQEyGO565iJ4PqgGlDWXo2/lKFCQ==
X-Received: by 2002:aa7:d410:: with SMTP id z16mr15548395edq.287.1597684139613;
 Mon, 17 Aug 2020 10:08:59 -0700 (PDT)
Date:   Mon, 17 Aug 2020 19:07:14 +0200
In-Reply-To: <20200817170729.2605279-1-tweek@google.com>
Message-Id: <20200817170729.2605279-4-tweek@google.com>
Mime-Version: 1.0
References: <20200817170729.2605279-1-tweek@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 3/3] selinux: add permission names to trace event
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>,
        Eric Paris <eparis@parisplace.org>,
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

From: Peter Enderborg <peter.enderborg@sony.com>

In the print out add permissions, it will look like:
    <...>-1042  [007] ....   201.965142: selinux_audited:
    requested=3D0x4000000 denied=3D0x4000000 audited=3D0x4000000
    result=3D-13
    scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.c1023
    tcontext=3Dsystem_u:object_r:bin_t:s0
    tclass=3Dfile permissions=3D{ !entrypoint }

This patch is adding the "permissions=3D{ !entrypoint }".
The permissions preceded by "!" have been denied and the permissions
without have been accepted.

Note that permission filtering is done on the audited, denied or
requested attributes.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reviewed-by: Thi=C3=A9baud Weksteen <tweek@google.com>
Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 include/trace/events/avc.h | 11 +++++++++--
 security/selinux/avc.c     | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
index b55fda2e0773..94bca8bef8d2 100644
--- a/include/trace/events/avc.h
+++ b/include/trace/events/avc.h
@@ -10,6 +10,10 @@
 #define _TRACE_SELINUX_H
=20
 #include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+extern const char *avc_trace_perm_to_name(struct trace_seq *p, u16 class, =
u32 audited, u32 denied);
+#define __perm_to_name(class, audited, denied) avc_trace_perm_to_name(p, c=
lass, audited, denied)
=20
 TRACE_EVENT(selinux_audited,
=20
@@ -29,6 +33,7 @@ TRACE_EVENT(selinux_audited,
 		__string(scontext, scontext)
 		__string(tcontext, tcontext)
 		__string(tclass, tclass)
+		__field(u16, utclass)
 	),
=20
 	TP_fast_assign(
@@ -36,14 +41,16 @@ TRACE_EVENT(selinux_audited,
 		__entry->denied		=3D sad->denied;
 		__entry->audited	=3D sad->audited;
 		__entry->result		=3D sad->result;
+		__entry->utclass	=3D sad->tclass;
 		__assign_str(tcontext, tcontext);
 		__assign_str(scontext, scontext);
 		__assign_str(tclass, tclass);
 	),
=20
-	TP_printk("requested=3D0x%x denied=3D0x%x audited=3D0x%x result=3D%d scon=
text=3D%s tcontext=3D%s tclass=3D%s",
+	TP_printk("requested=3D0x%x denied=3D0x%x audited=3D0x%x result=3D%d scon=
text=3D%s tcontext=3D%s tclass=3D%s permissions=3D{%s }",
 		__entry->requested, __entry->denied, __entry->audited, __entry->result,
-		__get_str(scontext), __get_str(tcontext), __get_str(tclass)
+		__get_str(scontext), __get_str(tcontext), __get_str(tclass),
+		__perm_to_name(__entry->utclass, __entry->audited, __entry->denied)
 	)
 );
=20
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 7de5cc5169af..d585b68c2a50 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -695,6 +695,7 @@ static void avc_audit_pre_callback(struct audit_buffer =
*ab, void *a)
 	audit_log_format(ab, " } for ");
 }
=20
+
 /**
  * avc_audit_post_callback - SELinux specific information
  * will be called by generic audit code
@@ -991,6 +992,41 @@ int avc_ss_reset(struct selinux_avc *avc, u32 seqno)
 	return rc;
 }
=20
+/**
+ * avc_trace_perm_to_name - SELinux help function for trace
+ * @p pointer to output storage
+ * @tclass tclass for the event
+ * @av access vector
+ * @avdenied denied permissions in av format
+ */
+const char *avc_trace_perm_to_name(struct trace_seq *p, u16 tclass, u32 av=
, u32 avdenied)
+{
+	const char *ret =3D trace_seq_buffer_ptr(p);
+	int i, perm;
+	const char **perms;
+
+	if (WARN_ON(!tclass || tclass >=3D ARRAY_SIZE(secclass_map)))
+		return NULL;
+
+	perms =3D secclass_map[tclass-1].perms;
+
+	i =3D 0;
+	perm =3D 1;
+	while (i < (sizeof(av) * 8)) {
+		if ((perm & av)  && perms[i]) {
+			if (!(perm & avdenied))
+				trace_seq_printf(p, " %s", perms[i]);
+			else
+				trace_seq_printf(p, " !%s", perms[i]);
+			av &=3D ~perm;
+		}
+		i++;
+		perm <<=3D 1;
+	}
+
+	return ret;
+}
+
 /*
  * Slow-path helper function for avc_has_perm_noaudit,
  * when the avc_node lookup fails. We get called with
--=20
2.28.0.220.ged08abb693-goog

