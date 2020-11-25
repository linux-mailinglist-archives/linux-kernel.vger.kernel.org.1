Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA32C3A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgKYH1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgKYH1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:27:33 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589F8C0613D4;
        Tue, 24 Nov 2020 23:27:33 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t8so1483707pfg.8;
        Tue, 24 Nov 2020 23:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EtMyIIa0dfE/QxK1mo3o94wUXlDlUpOZPp8wYKgkTzw=;
        b=GAuDDIGoz/9BjdCLAX04/32hETUiy4Y/DNu0ABD2vXYvye7w29Sg5wLDbijD0LT1Od
         G8qBzBfvisETGWWgel0V7vLklretDFquuVvOiGj24DcwR5FnI6SItOXI6YTEoP2IRSUD
         Vw/r4wq1z1BBUnSnqwnUjo0kDGT7idCBPtBW8Ye2iU61M+c3buiJDZTHPt78YcwMWx6e
         9fwKRKiL/Dt5QfvYZ6X00w57TRIu+0oDizsMty0JAGM3YWXUzozLewXdNZ72W/PSKdXG
         nw7FvozffiqqXXN1+XejOdjT9c57FzTRde39pGP5oPuEZFzSblL6Rl7N6MxmeefgTjv2
         0F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EtMyIIa0dfE/QxK1mo3o94wUXlDlUpOZPp8wYKgkTzw=;
        b=ZXMLY8/V0FdC/T7df6Two0BKXzIVJPYj+wfxfT2v815DMio0bkzDuCZCkBKx2TOmTe
         Ju4vJlPu+MfyUY0452cR3oHpEgij4f9OIKfNHCzNxFs+hTvOhBacAcQtX3cacKq2Opqy
         7HO5T5KZDjaH0QonW7EHjlUsj+xciwT0VmhB1lF/XQyKJm7j06dhGgWZVLWeS/Xlz2YN
         g3BvHHZtps72MW8S8k0G9AF1T34XNyehB50wX8Df+5BYUb4woOz3bL73SA6UeD1topVE
         aeyIUsuos0KL0dko3vPmx2DX5rLoq3PvFzJwpylf+IglvBkmyFn2bcR6oxUPZTIq275Q
         ajHA==
X-Gm-Message-State: AOAM532atMzZSwfGD8TqXqREUL28GZSbAlbjnX6naxGd/9Pd8mCm3da4
        jcutglRrvOLgofj49cseD2WeapdC6gI=
X-Google-Smtp-Source: ABdhPJxtv1hHifHhJ432ltFaM2mpBjgORSGHWd1aQFRx5D9QizTblsSkNjhiNT6hwmnCsCce6Y7J3g==
X-Received: by 2002:a17:90a:6041:: with SMTP id h1mr2601701pjm.35.1606289253026;
        Tue, 24 Nov 2020 23:27:33 -0800 (PST)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id q7sm1006055pfh.91.2020.11.24.23.27.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 23:27:32 -0800 (PST)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Ben Boeckel <me@benboeckel.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Malte Gell <malte.gell@gmx.de>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH 4/4] Documentation/admin-guide/module-signing.rst: add openssl command option example for CodeSign EKU
Date:   Wed, 25 Nov 2020 15:26:53 +0800
Message-Id: <20201125072653.15657-5-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20201125072653.15657-1-jlee@suse.com>
References: <20201125072653.15657-1-jlee@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an openssl command option example for generating CodeSign extended
key usage in X.509 when CONFIG_CHECK_CODESIGN_EKU be enabled.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 Documentation/admin-guide/module-signing.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index f8b584179cff..bc184124d646 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -170,6 +170,12 @@ generate the public/private key files::
 	   -config x509.genkey -outform PEM -out kernel_key.pem \
 	   -keyout kernel_key.pem
 
+When ``CONFIG_CHECK_CODESIGN_EKU`` option be enabled, the following openssl
+command option should be added for generating CodeSign extended key usage in
+X.509::
+
+        -addext "extendedKeyUsage=codeSigning"
+
 The full pathname for the resulting kernel_key.pem file can then be specified
 in the ``CONFIG_MODULE_SIG_KEY`` option, and the certificate and key therein will
 be used instead of an autogenerated keypair.
-- 
2.16.4

