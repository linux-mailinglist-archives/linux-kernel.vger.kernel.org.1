Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C4282B38
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJDOYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 10:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgJDOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 10:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601821473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ImS+DzrKsQVbgZPvAgl58XuPNm8KTHvfc5J8ftfxKXw=;
        b=UEDx9DB3XpH2pCZt3k/vVxUqKYC7rBsdhAnEzpAEasOa8n/wx2noARIRqIJ3vcePPex2mH
        P33fgCaYFzMoZnpdA1HJG5rAGk4rCZFWMbBkN+vtKMb4Qv4KvjRESq3llnjkVeTovvuJL0
        ol/X1qdqFQABmCF4ZdIHynQS/1djMbQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-YcpYWJNROYq0gdoeHFbR0Q-1; Sun, 04 Oct 2020 10:24:30 -0400
X-MC-Unique: YcpYWJNROYq0gdoeHFbR0Q-1
Received: by mail-qk1-f199.google.com with SMTP id m186so4744459qkf.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 07:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ImS+DzrKsQVbgZPvAgl58XuPNm8KTHvfc5J8ftfxKXw=;
        b=pO1neGFd7nYj98jaJ5BC9wz6UOZv3eQslu0hx9QnY49Pju/0cSqf2GtqnFRqa5tAil
         kmw5/BkWSsubjBGLPAwujUZ4hmKaVzP8fHhHq0BCo3P4jKNi7g10PXVJZLn7Ksrrun8b
         Gmsuhr9IIsv28j0YHyUypDuqFJgonnAS/EZEAQrwk09tKN5zYvEzLFxqL8JDl1Dsjizk
         /KWcutC9OKnyJt63AWRzL1hV98jr3tjpNG0LEvkQ1Qmn+WI1t6qpqtHNtxBxzwv6qI+8
         J/hgJgqzA9Mlf1XsjD8k8zdEvQKaY48s9LB9efLg7BL5RTUiVz0BFxccJpya7wouLsA/
         KLZQ==
X-Gm-Message-State: AOAM532iBWIcxBNqo+MrRb1VpG1PC4fQUdGdfOJy/gUZnan8n02kHETj
        HBB1g0gx0VwPG39MSj9SF4lbr/B9HIbP8ntOFA66Mmy91XKIe8iTKEVgWhjE8p7dDOUT5e/7ff+
        CI8pXY6MxTvoLUQ7zV08hHSZA
X-Received: by 2002:a05:620a:10a7:: with SMTP id h7mr2850456qkk.40.1601821469668;
        Sun, 04 Oct 2020 07:24:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznXfn0azZEw4IrpOhwWc02Vc6jdkQKYSLJTj5F+V8VauW2yCaxAoTWsPnZlcn+8Dc1Cr58Yg==
X-Received: by 2002:a05:620a:10a7:: with SMTP id h7mr2850439qkk.40.1601821469386;
        Sun, 04 Oct 2020 07:24:29 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g12sm5292344qke.90.2020.10.04.07.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 07:24:28 -0700 (PDT)
From:   trix@redhat.com
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        natechancellor@gmail.com, ndesaulniers@google.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] apparmor: fix error check
Date:   Sun,  4 Oct 2020 07:24:22 -0700
Message-Id: <20201004142422.5717-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this representative problem:

label.c:1463:16: warning: Assigned value is garbage or undefined
        label->hname = name;
                     ^ ~~~~

In aa_update_label_name(), this the problem block of code

	if (aa_label_acntsxprint(&name, ...) == -1)
		return res;

On failure, aa_label_acntsxprint() has a more complicated return
that just -1.  So check for a negative return.

It was also noted that the aa_label_acntsxprint() main comment refers
to a nonexistent parameter, so clean up the comment.

Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/apparmor/label.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index e68bcedca976..6222fdfebe4e 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1454,7 +1454,7 @@ bool aa_update_label_name(struct aa_ns *ns, struct aa_label *label, gfp_t gfp)
 	if (label->hname || labels_ns(label) != ns)
 		return res;
 
-	if (aa_label_acntsxprint(&name, ns, label, FLAGS_NONE, gfp) == -1)
+	if (aa_label_acntsxprint(&name, ns, label, FLAGS_NONE, gfp) < 0)
 		return res;
 
 	ls = labels_set(label);
@@ -1704,7 +1704,7 @@ int aa_label_asxprint(char **strp, struct aa_ns *ns, struct aa_label *label,
 
 /**
  * aa_label_acntsxprint - allocate a __counted string buffer and print label
- * @strp: buffer to write to. (MAY BE NULL if @size == 0)
+ * @strp: buffer to write to.
  * @ns: namespace profile is being viewed from
  * @label: label to view (NOT NULL)
  * @flags: flags controlling what label info is printed
-- 
2.18.1

