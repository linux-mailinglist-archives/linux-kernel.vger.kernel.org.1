Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FB72FC52B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 00:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbhASXy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 18:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbhASXxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 18:53:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EED9C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 15:52:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v187so26731770ybv.21
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 15:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=JEMTUZ20yMo08GXgCsAKGqGJK8V3DyGDgd8Y1lymdBc=;
        b=bgjnlKeiHI6RzMOOdt7M8I21LGue+wOl+S6abgFOIJHOYcOtJ7rD2heCgbrnefoF5w
         Xj+3ySLX52m4Tww0KAeEhxlZY0HiMRwYyaIoWnHGEw59zWwYYByZ173ME7fAjVDtHfpB
         Z4RfxSXHvhKt3q6qf5jGByUyrzFTfxO5qMiwAr4cVupbmstS1OJrIhSMrzjTfGM6NCKf
         Qgjw6+/sLBvP8TpmNCIOxMwF71vwGipIJokxov9b7XvUM2jhX9NZA3SR1oE0Iqn889Lb
         TSwxHLVznYUjOt/uKcmz03C8NS2lB9iQxPDaITQqg0/kCrBILQTO72nOAUs5H2Bft625
         w/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=JEMTUZ20yMo08GXgCsAKGqGJK8V3DyGDgd8Y1lymdBc=;
        b=AytTNTffvU0XFCYj2ccERwIMZkRQ/MQfEhXKO8/4uytHhUD45DGGk22aAQsS2DKqiR
         k0EizNS/MjvaSS9IKuWEWRO3V9avzjytN9ADJ9fH5CJV3iDqdUy1OYY2tR3+Sl+rPyKe
         LMmcGG0p1vi0lWXRhEMSv26oipaBFHS16pj2ZWOgT28Wc05VirsKRhIhn6hAeCKcq+P8
         0MF12HlTAU4caBSDvcGm6u9JWwXmrYZIJz+C8zlAijkrQL/nNUcuqm++J2+wnqvVw7mo
         yz89gilHUzIL1USTCoBIY51+yUwk1c7dO8Qai9okZFLGTyHSxyNKgOgq/UwhDDtRviGC
         AOVg==
X-Gm-Message-State: AOAM532PowqCV+SinQd6KqL8gGPW94gpV4HMfd2cQ87XTvPoZFAWBbsc
        +y9v87C9z+0ZYEX1v1Of+igbo7ijcHcuHA==
X-Google-Smtp-Source: ABdhPJx9gADC9+UacYJUO+wrvyHZD58QYvIE7h9HdWAaUkYJWmnpygaVuChl1i21I3HcPfSHcZQtTFAANlaiRg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:99c6:: with SMTP id
 q6mr9687488ybo.408.1611100360313; Tue, 19 Jan 2021 15:52:40 -0800 (PST)
Date:   Tue, 19 Jan 2021 15:52:26 -0800
Message-Id: <20210119235226.93280-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH] KUnit: Docs: make start.rst example Kconfig follow style.rst
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primary change is that we want to encourage people to respect
KUNIT_ALL_TESTS to make it easy to run all the relevant tests for a
given config.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/start.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 454f307813ea..560f27af4619 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -196,8 +196,9 @@ Now add the following to ``drivers/misc/Kconfig``:
 .. code-block:: kconfig
 
 	config MISC_EXAMPLE_TEST
-		bool "Test for my example"
+		tristate "Test for my example" if !KUNIT_ALL_TESTS
 		depends on MISC_EXAMPLE && KUNIT=y
+		default KUNIT_ALL_TESTS
 
 and the following to ``drivers/misc/Makefile``:
 

base-commit: 146620506274bd24d52fb1c589110a30eed8240b
-- 
2.30.0.296.g2bfb1c46d8-goog

