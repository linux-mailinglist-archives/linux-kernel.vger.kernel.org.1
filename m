Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646192C6916
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbgK0QFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:05:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730324AbgK0QFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606493123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Lx5QA+1c/hyrsXjP+K1B8IolDHDv6r6q6dP4B5qcGoc=;
        b=RrWEF7SzNUJIpHic44l8ad6wqhoYKk0P8k9kz5fb7zcob2/l5jGMEeFBiLNr1vfUVnBfaJ
        +2T+6kv0FYbit9XMPBnAr2EAQo8JC35bECWlJZyTENq0ubJ7VffdY6VEf8mASgEFwcVT6l
        MXKg8HvGOeJf6Fj1oaNveqQmQajNgCY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-AyujGbnnPvKxIL0ziAW1dg-1; Fri, 27 Nov 2020 11:05:20 -0500
X-MC-Unique: AyujGbnnPvKxIL0ziAW1dg-1
Received: by mail-qt1-f198.google.com with SMTP id r29so3484919qtu.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lx5QA+1c/hyrsXjP+K1B8IolDHDv6r6q6dP4B5qcGoc=;
        b=pnPXSl19jAtjRTy9FxLUyCqhlA4N9YfLWsV9z8cBRWcDBQPy2EjMdbbARe2JEGDck1
         QEo67GtYbJ3pWK8q5PEmfwE2lPYEtdGaDbiowYVelQ14TA/PyUEFJkVBxglLsA9Xh/UC
         mp2WXqMw5WbEQQFNoB7bCh4yZAL/A0twg3MBS+4RH+WvmT+CHIIbQHuEsCwX4RJz17lz
         kD0uEW3PJ9UczHxiEFzkFUwITBdsKFhR9UDBdXHG50BKkr66i6lXZvlFUvaFEwnmy3QY
         Ltr26UDkeqfYmUjZRdNgQyBAqNYKlF1WAsCClf/r5FmPPNlCrBDvuQvEoG+dNLslcNpG
         /w7A==
X-Gm-Message-State: AOAM532oNHYOljO9V85DRQQDsSYMl3709KIm2TYfMDZegFeC2fBkVWrN
        Z9S1j0RSubtQEfY4ZPvZQYcrP7qzBnXIlMKoiESeQ4k0p0gX7MutoQfkqByxTgkVOlpkOGu/SLm
        4Amhd8VawTYiS0P+hcXXSTOk4
X-Received: by 2002:ac8:7651:: with SMTP id i17mr9095754qtr.248.1606493119662;
        Fri, 27 Nov 2020 08:05:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrS1i55kyNvlHzcDjmRasvRmA+DWO57YRKCEb4T+Hdkk6tGNT/JOTtakf7XgXiuVwklbeUHQ==
X-Received: by 2002:ac8:7651:: with SMTP id i17mr9095725qtr.248.1606493119425;
        Fri, 27 Nov 2020 08:05:19 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c27sm6359681qkk.57.2020.11.27.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:05:18 -0800 (PST)
From:   trix@redhat.com
To:     code@tyhicks.com, hannes@cmpxchg.org, mhocko@suse.com,
        longman@redhat.com, herbert@gondor.apana.org.au,
        ebiggers@google.com
Cc:     ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] eCryptfs: add a semicolon
Date:   Fri, 27 Nov 2020 08:05:13 -0800
Message-Id: <20201127160513.2619747-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Function like macros should have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/ecryptfs/keystore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index f6a17d259db7..2abd219cfeec 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1172,7 +1172,7 @@ decrypt_pki_encrypted_session_key(struct ecryptfs_auth_tok *auth_tok,
 	rc = ecryptfs_cipher_code_to_string(crypt_stat->cipher, cipher_code);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Cipher code [%d] is invalid\n",
-				cipher_code)
+				cipher_code);
 		goto out;
 	}
 	crypt_stat->flags |= ECRYPTFS_KEY_VALID;
-- 
2.18.4

