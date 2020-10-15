Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B751F28F1D8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgJOMI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgJOMI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:08:57 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C30BC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 05:08:57 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id a23so2069164qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 05:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQCnc1kT4X0rScHBlHIsBu1n631S09tQozQXpWQBp88=;
        b=Jpxx71PqIJw5HtnGe3yI6um31Ic6Lg7W3j67tcXbUfPv0lQ7aqem+RbXuSnkEQwpMv
         YBcNsdwlx1RWwUQvdO2/Lu5h/sAB/C398QH5nCZa9CNodfJ4zVQzNCI1SwxY7G67rDkH
         eg8yRtkP6DKztGMkh9KgxvaixgfObHKtvn6ulRdx2ff0IRGsLIOZ1g2vixRCUDewP9iu
         w7QOLOf0mZmmlQtfFhc/2eTpWqIwyuWPus3UVsy5JEyPs3tel9h6v/XVsqfwg0NxI4OY
         iFrft2fb7/lnFwjZwLcdsJY4X6sULq5fIuXpkv2xaGfiOkd2DA2T9U6VshZPR5mWnJNe
         x0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQCnc1kT4X0rScHBlHIsBu1n631S09tQozQXpWQBp88=;
        b=Ek+LhUIsm/JXg1tR5BRCQfgcdQHqUX8PV1KJlF1xBejjgoVN+itOPb9YU2GXiZZD9+
         EuRdTW/aYhI7mVyZfAChGxgFlotZaRcrjBNjDbHjOAqhmK9sK5TDNNLE41KHMrh6DlSn
         CaFzxR6aFs7PFrcZ6nyxJ7hI0NPZNRxrPlB45U4jOBToOVcxWnM+cyZWKmaZUVJ0kqnI
         ly6VADL3dhWhIdvt93fGJ+fpb4fB6hSG4WDnLa5eSS3/f05XsCTX4BLEwRzR+HiQEiQc
         wkit/PySW+Bv+VUJpUSkIcgqP2bpeZersSC02PE1sYpa+k7obC+/M+rPKeL7sO41p/bl
         1aFg==
X-Gm-Message-State: AOAM5307XSmo+GnNomnhCTu5siJRXUqJIPEjl1Ue0hP4z0vgsrNDz1ow
        UyFAoe7RB6Y1/0ZFei8cXfHPuA==
X-Google-Smtp-Source: ABdhPJxCINnDLk7Akc7ItVHO/kczk3TZJd90eFchjG6pzINskpyBQpZJsp895Zc8y/tkzYcHWsAPlQ==
X-Received: by 2002:a37:b782:: with SMTP id h124mr3705031qkf.169.1602763736095;
        Thu, 15 Oct 2020 05:08:56 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7cb:5e0b:6f3d:fca0:306c:a15d])
        by smtp.gmail.com with ESMTPSA id 124sm1045375qkn.47.2020.10.15.05.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 05:08:55 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     sfr@canb.auug.org.au, skhan@linuxfoundation.org,
        brendanhiggins@google.com, kunit-dev@googlegroups.com,
        johannes@sipsolutions.net
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] lib: kunit: Fix compilation test when using TEST_BIT_FIELD_COMPILE
Date:   Thu, 15 Oct 2020 09:08:51 -0300
Message-Id: <20201015120851.229242-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A build condition was missing around a compilation test, this compilation
test comes from the original test_bitfield code.

And removed unnecessary code for this test.

Fixes: d2585f5164c2 ("lib: kunit: add bitfield test conversion to KUnit")
Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Link: https://lore.kernel.org/linux-next/20201015163056.56fcc835@canb.auug.org.au/
---
 lib/bitfield_kunit.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bitfield_kunit.c b/lib/bitfield_kunit.c
index d63a2be5aff8..1473d8b4bf0f 100644
--- a/lib/bitfield_kunit.c
+++ b/lib/bitfield_kunit.c
@@ -125,7 +125,7 @@ static void __init test_bitfields_variables(struct kunit *context)
 	CHECK(u64, 0x0000001f8000000ull);
 }
 
-
+#ifdef TEST_BITFIELD_COMPILE
 static void __init test_bitfields_compile(struct kunit *context)
 {
 	/* these should fail compilation */
@@ -135,13 +135,11 @@ static void __init test_bitfields_compile(struct kunit *context)
 	/* this should at least give a warning */
 	u16_encode_bits(0, 0x60000);
 }
+#endif
 
 static struct kunit_case __refdata bitfields_test_cases[] = {
 	KUNIT_CASE(test_bitfields_constants),
 	KUNIT_CASE(test_bitfields_variables),
-#ifdef TEST_BITFIELD_COMPILE
-	KUNIT_CASE(test_bitfields_compile),
-#endif
 	{}
 };
 

base-commit: d2585f5164c298aaaed14c2c8d313cbe7bd5b253
-- 
2.26.2

