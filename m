Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5F292A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgJSPa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:30:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34348 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbgJSPaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:30:25 -0400
Received: by mail-io1-f66.google.com with SMTP id z5so120353iob.1;
        Mon, 19 Oct 2020 08:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzYmFSsh+U7GF8xlM4YuqEnDsnPAb1qT8npErxi7XZ0=;
        b=oxQDpqyq5ByWidI+s93fYZc+QqgucrMJG55H99w5UK1haTDCLY6M6ajBAjUMGtGceR
         8hWirStOYm7LMXeFQu9I6zECI/Ls0UdfoNl1Ql9vVr4RGGzBYzCcx/0Dt4kFdckdPA/+
         E9LYykJlRecjMHFAQ9TjjOB3BMnoPUZAU6kkkuhPE9E/DidKDiz1Xi5Cu7mn6h1zjsYU
         vFhIlwNRcADGa2yEXOWp9gU0krnxVWYfkf7Z0z5RjsxYWHIOV4vOdd7SirpTPG/uyKmw
         EzbJVDld9l0pc0JPByFZn550TAs9w/b/pje3vVMPFuMMh9uJTUrvkNRbqZiSO7RfXayY
         cZRQ==
X-Gm-Message-State: AOAM530HrBrKcqf/hqRc1gnXH60TjnQRQYdkJsGkP9GJ3n/czv7FjN/N
        SPfkrb8OqKcyXrXmr36Vp9A=
X-Google-Smtp-Source: ABdhPJyoR4X0KmSQMtEOPRbUDiwV1OESmJAv2oOgSqqKZK/rX7Fn+/eU9eZYrSwiZUFKLVclxXUPVg==
X-Received: by 2002:a5d:9042:: with SMTP id v2mr506ioq.18.1603121424492;
        Mon, 19 Oct 2020 08:30:24 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m86sm20898ilb.44.2020.10.19.08.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 08:30:23 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] crypto: lib/sha256 - Unroll LOAD and BLEND loops
Date:   Mon, 19 Oct 2020 11:30:16 -0400
Message-Id: <20201019153016.2698303-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201019153016.2698303-1-nivedita@alum.mit.edu>
References: <20201019153016.2698303-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unrolling the LOAD and BLEND loops improves performance by ~8% on x86
while not increasing code size too much.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 lib/crypto/sha256.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 9f0b71d41ea0..a3db88d10523 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -66,12 +66,28 @@ static void sha256_transform(u32 *state, const u8 *input, u32 *W)
 	int i;
 
 	/* load the input */
-	for (i = 0; i < 16; i++)
-		LOAD_OP(i, W, input);
+	for (i = 0; i < 16; i += 8) {
+		LOAD_OP(i + 0, W, input);
+		LOAD_OP(i + 1, W, input);
+		LOAD_OP(i + 2, W, input);
+		LOAD_OP(i + 3, W, input);
+		LOAD_OP(i + 4, W, input);
+		LOAD_OP(i + 5, W, input);
+		LOAD_OP(i + 6, W, input);
+		LOAD_OP(i + 7, W, input);
+	}
 
 	/* now blend */
-	for (i = 16; i < 64; i++)
-		BLEND_OP(i, W);
+	for (i = 16; i < 64; i += 8) {
+		BLEND_OP(i + 0, W);
+		BLEND_OP(i + 1, W);
+		BLEND_OP(i + 2, W);
+		BLEND_OP(i + 3, W);
+		BLEND_OP(i + 4, W);
+		BLEND_OP(i + 5, W);
+		BLEND_OP(i + 6, W);
+		BLEND_OP(i + 7, W);
+	}
 
 	/* load the state into our registers */
 	a = state[0];  b = state[1];  c = state[2];  d = state[3];
-- 
2.26.2

