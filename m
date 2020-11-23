Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6906D2C19A2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgKWXyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbgKWXyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:54:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B2DC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:54:35 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so20499128wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZB3RzTtOX5Vi4wJPeUnMotilF2kP22sMOQsBxc6+YQs=;
        b=rX3Q/KMPxyAVPoYlG/3ex3KT+pJZzoCmRUPGxMABV+0J6MCzg40pmf24cvQC73ClD/
         egCSQKk2ZVgLtnEoLw8RjKCX6TrsLh4F+L+FSHwbv9LhIn8UyzGSiuf+3RVQBsCFeTqs
         6vYNqHgCxUvvNBZUo7a91GgGX3utvoFurF3zW+nobJzb+2JHT7dEMXZVAMadQu4871FL
         tqzOVWPDQDlF4+q3eyEYCzYRhXgDVwY5juYAe5F7Br85R9rvKMXolbs8hcr6y3zXVILR
         ijGnVWOGhA4ugHKpQU5m/piWwr2UWn70UpOHaHaRxIMlX2ra3vihp3t4wiAa/qdh4ULY
         pmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZB3RzTtOX5Vi4wJPeUnMotilF2kP22sMOQsBxc6+YQs=;
        b=CN4e1VBKErMpb8Dr9RMvudBuNF2RVZ8xPkfDqo37b4bNvKXZD5dV+Vyd6uzURBmKU5
         nsj+3EospTb/cM1t/V0AtDaH89RhzF0XrPbAgflHMwlBI8BsEXxPqvIFwVoZ/KkhNpoj
         X5r2imGzo/nqiJDpzfxsqcQyAHZhSIx7etsArnANWvkK0m3L9BQzihwDB0+Qbg7yja1l
         9jBafoP4uvgS78x0sAJKh17JEbfASPVqXZnmQREOy67LF7/QR3Yv3V7NUZoZDsfHOn3r
         06JF1bO9FMRcirEzIXTT8UFFQaKp0oKkmIQIGmB5NExgAv+anblpiKZLuaskptQ3QItn
         foLQ==
X-Gm-Message-State: AOAM5324vGBjMnwOIwDRx0H6yAr/btL10i6IdcUDKbSTCOGirN2qsS1P
        QveBnqsYP8XADTWgvg+aXXbc5HiolSTB194u
X-Google-Smtp-Source: ABdhPJwsyTAO+I0Qh+xGi5SqAtchc9g2tyh6CpqTZsdoVWlMyoEVUO+GzF8teUGJN6bMS4ndcE5NGw==
X-Received: by 2002:adf:f5c8:: with SMTP id k8mr2230194wrp.2.1606175673552;
        Mon, 23 Nov 2020 15:54:33 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id z6sm1704751wmi.1.2020.11.23.15.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 15:54:32 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] keys: Remove outdated __user annotations
Date:   Tue, 24 Nov 2020 00:54:00 +0100
Message-Id: <20201123235400.1609970-1-jannh@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the semantics of the ->read() handlers were changed such that "buffer"
is a kernel pointer, some __user annotations survived.
Since they're wrong now, get rid of them.

Fixes: d3ec10aa9581 ("KEYS: Don't write out to userspace while holding key =
semaphore")
Signed-off-by: Jann Horn <jannh@google.com>
---
 security/keys/keyring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 14abfe765b7e..977066208387 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -452,7 +452,7 @@ static void keyring_describe(const struct key *keyring,=
 struct seq_file *m)
 struct keyring_read_iterator_context {
 	size_t			buflen;
 	size_t			count;
-	key_serial_t __user	*buffer;
+	key_serial_t		*buffer;
 };
=20
 static int keyring_read_iterator(const void *object, void *data)
@@ -479,7 +479,7 @@ static int keyring_read_iterator(const void *object, vo=
id *data)
  * times.
  */
 static long keyring_read(const struct key *keyring,
-			 char __user *buffer, size_t buflen)
+			 char *buffer, size_t buflen)
 {
 	struct keyring_read_iterator_context ctx;
 	long ret;
@@ -491,7 +491,7 @@ static long keyring_read(const struct key *keyring,
=20
 	/* Copy as many key IDs as fit into the buffer */
 	if (buffer && buflen) {
-		ctx.buffer =3D (key_serial_t __user *)buffer;
+		ctx.buffer =3D (key_serial_t *)buffer;
 		ctx.buflen =3D buflen;
 		ctx.count =3D 0;
 		ret =3D assoc_array_iterate(&keyring->keys,

base-commit: d5beb3140f91b1c8a3d41b14d729aefa4dcc58bc
--=20
2.29.2.454.gaff20da3a2-goog

