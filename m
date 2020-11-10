Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C802ADD21
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgKJRkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJRkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:40:02 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C18C0613CF;
        Tue, 10 Nov 2020 09:40:02 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so12084893pfp.5;
        Tue, 10 Nov 2020 09:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=p7BfMtOnE/LpJ0Crt8wgon1nRqzmHVhKaZn6sFng2vo=;
        b=eq5TMPQeMleFC6KYmEaKtqCQ8XOiEeuzVnlp0OLQ9Z6KFGM9MtOBP0U7FbTPxbO7nD
         z9hsaWqVJFg2s2zO2ZeNwDaBg/ww7cTfXLf2lGdBK/ZGRAxpOhdL9nPyl3VqdRkuH8Ny
         WDNHDbNM71onsk2q+yRgHaYdD0qWCM96VievigG/LQWSr4P9XRc3TcGk/yYfWMlTqPad
         hZ/SKiWBe7hptVyzpUsF2xDfX+7Q2CQ6QMFvhm4QpREQLqKcxuw4Vm8pJWna3apA6pzz
         7rC0nEBL7vlKWuKyftCGOmFJuT9v/Qv3nU2UAC7gxqf13Yp2+Lp5eByPLK5eyyJJ9osw
         Jq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p7BfMtOnE/LpJ0Crt8wgon1nRqzmHVhKaZn6sFng2vo=;
        b=b48l0OK1eGMLvP8BWsRmeqBtlwVtVsh5Ry+hIHBVOshULK/FHbZKf1h+QiLAkXB1Qg
         zhBtW6bkdTcYtLh5jkaN7UzB4deHcHJdw7yFN0RIRxsWFzIGlmpEeAQE2WDX4804f3bK
         C85TVinsOTSuqXPcnxoPTXG/kThIiFHsTkVQTUgJQOAol4kafeuCm+6r97DasRV8B84d
         3kkPFycPpS411Sx3OClDfCM7qiHhKZWEfUukU/c3cXCKDd1zZ7erfpTU5bI+MMl1mExQ
         xrkcJ7gfHrsdA4RYtdviN10tiWRRlHcGlQR5RIi9uon8LkKSg8fDVzbqhErNwB3soqH1
         UU3w==
X-Gm-Message-State: AOAM532iIXvgBf5zeTdqVBHxKjjaw37NlkBAQ5mZC8EGbr4ZQOKcQKSi
        dhnpsVmCf7lVMmPoRmOEe1HnjSMJ2JgmiZSw
X-Google-Smtp-Source: ABdhPJxECH3a18hQsaUAip8HkJA5gBzHNW0BBptf81qUIyiqeNS3ns8/w6t1VQjw9XHJVjuy9s1eNg==
X-Received: by 2002:a65:4b81:: with SMTP id t1mr18674440pgq.263.1605030002241;
        Tue, 10 Nov 2020 09:40:02 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:413:8adf:79d0:1679:313c:70a2])
        by smtp.googlemail.com with ESMTPSA id f4sm4461724pjp.3.2020.11.10.09.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 09:40:01 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com, joe@perches.com,
        sir@cmpwn.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] Documentation: include sign off for reverts
Date:   Tue, 10 Nov 2020 23:09:49 +0530
Message-Id: <20201110173949.31440-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we do not have any documentation on commit reverts regarding
the requirement of Signed-off-by tag for it. This may be misleading to
the users.

Evaluating MISSING_SIGN_OFF checkpatch warnings on v4.13..v5.8 showed
that 4 out of 11 cases missing a sign-off are revert commits.

Add documentation regarding the same to document the community
consensus and let readers know.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 Documentation/process/submitting-patches.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 83d9a82055a7..ff065e1f6a25 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -404,6 +404,8 @@ then you just add a line saying::
 
 using your real name (sorry, no pseudonyms or anonymous contributions.)
 This will be done for you automatically if you use ``git commit -s``.
+Also reverts should include a Signed-off-by. ``git revert -s`` does
+that for you.
 
 Some people also put extra tags at the end.  They'll just be ignored for
 now, but you can do this to mark internal company procedures or just
-- 
2.17.1

