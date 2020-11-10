Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5BA2ADD55
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbgKJRsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJRsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:48:02 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400B7C0613CF;
        Tue, 10 Nov 2020 09:48:02 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id z3so12072471pfb.10;
        Tue, 10 Nov 2020 09:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U9vV/by1ItPYBZ2k5CLKKGvVkSRTIRG0FFRZLlCzvvc=;
        b=u3SXUAuzhxj86zTh3yQ/bq81MAfg+SDUBuGLVOx99opPRp59nwLpQ0saG0ZkSkURYP
         KILAOS9IRGLDA78fsRp0dVKLx6ziGiDeTnK6QAg/OuSdX6YyWhfl1puVnuPTGimTFeuC
         eY8D2J2HY+mlB+YTQgi0To4KXEnGiucYUVQwBemTALtsPpfqY8rgGmQxfvltuLnuJHao
         ebKydSxla8Upp94wwyr4QaY7A8TzS/yng7wRfmrNqqHbxlkSWiuCll6TgeuG8br080G1
         Ix2SGc/1b/m7BLP21CrX0L7xzUh4yhtHPyX78BzLixnTjItJDXoAucbKNK/7FNnrco/y
         HMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U9vV/by1ItPYBZ2k5CLKKGvVkSRTIRG0FFRZLlCzvvc=;
        b=YWE7jRzoZkYZk/mhi2pZTo03XmEicHUPWvkhDnr//rdnW+sArDstAPLPcvWOcwFsQh
         tGQjV3iWfDHzIxIncXIakwq8KKvzQNNdQ9ziGpk4c7Q7yOlHHNz6tbANOlOG9xFH1oiD
         5SmZoFKhVi9qXHEKSy94D/w7JVKm1Oe597AwacMyP/zUTukh0+V/2pn2W9x48Rh8w1vH
         U61Q0XLma0lrusbLeQPXyIxO2G4g9ehDA5ZyBb4PQXxRwFC9Dz2LlB6YDcurdkGnsKAH
         gCNqaJHoE4UGkOe5vcUjIY2XnrXhGK67a+0xI/02yAx4IHBGnXJymBR0b7X3qqPgIb3R
         f1ew==
X-Gm-Message-State: AOAM532sFQbMeKIFJOSA78nH41PcFCevJSNnh4HmD2XwkiQKsIZcdjae
        wYdMkFv/+bEIKz5y77pKhiY=
X-Google-Smtp-Source: ABdhPJyBIEL1hhryFvJ9rEu0JTFr7pT4XBArdvDD9AJAm96SIh20Jp1eaZp4m2C67D5VnkhlZpMh6w==
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr272717pjb.172.1605030481654;
        Tue, 10 Nov 2020 09:48:01 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:413:8adf:79d0:1679:313c:70a2])
        by smtp.googlemail.com with ESMTPSA id z21sm14654325pfa.158.2020.11.10.09.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 09:48:01 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com, joe@perches.com,
        sir@cmpwn.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] Documentation: include sign off for reverts
Date:   Tue, 10 Nov 2020 23:17:49 +0530
Message-Id: <20201110174749.32068-1-yashsri421@gmail.com>
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
index 83d9a82055a7..fb8261a4be30 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -404,6 +404,8 @@ then you just add a line saying::
 
 using your real name (sorry, no pseudonyms or anonymous contributions.)
 This will be done for you automatically if you use ``git commit -s``.
+Reverts should also include "Signed-off-by". ``git revert -s`` does that
+for you.
 
 Some people also put extra tags at the end.  They'll just be ignored for
 now, but you can do this to mark internal company procedures or just
-- 
2.17.1

