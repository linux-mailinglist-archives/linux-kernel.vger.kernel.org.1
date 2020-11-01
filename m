Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061C92A2201
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 23:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgKAWIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 17:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgKAWIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 17:08:48 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAADC0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 14:08:48 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id f10so7045464qtv.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 14:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=NKp1/xBXDkl0efhdXNrgYc0O7jfhOuUU7342EXqTwg4=;
        b=FsnpzJJWXhtPreieRoDxDeeMlTQBlq/mJJqfi2mvOuie/Fj9mmqbbp644xxA+7EH/H
         nEu7H3reDXz2RiMRJHutBkb5adCfGBDTW5GaEN7o/p7bBO7cGBJuAeV84qQ1KVtorK1w
         ktmk3CF+IyQtw4aGPFzI05sRg6Qq3c0gZebh6hHfG2yrCDL5qvFxab8lSGvrHUaDLubp
         0rCHIFcEz14jVVG3XFWfzVgyNPUmnBA8T8owbq/DSh7c7hcyBL//HVd3ouaqFEz4HkmE
         CkWnjchPAcxUN9Vxrcs/yz+cutc2vQ9rMRoYZLJQ57+V2TLBVDU+tK9OaI9e0MLW9P+H
         rnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=NKp1/xBXDkl0efhdXNrgYc0O7jfhOuUU7342EXqTwg4=;
        b=XJFDQHo0T/cQl2JNRA3etB1JUraJJgwjxrjTjG5nzZt1OD+UQdkWQe/qCW7caGSEBT
         rV6i8E+xxaPD9b70j/zp8WFB3KsQbsDyUxO5fwllk2W63Ie5ZjbAInvbbIfB5bA6HAjm
         +Oqi3GtQMmOX2B7q/99VwZd9n+039Ui3kJpw8MiKpDz1NSqbe78VEDQwUjedeWq45xNK
         fJvge14tUUhW/PucSdtwN7+JDLmw578gITUxU/5C4z1oS673VFsy4jQJLQeKw/RECtia
         SUuIzoyoY5dazMIAWc0XWK2TQjvmfw/QjICXZQVaz05x+qYR+9itlII8i6sz4PyhV230
         he2Q==
X-Gm-Message-State: AOAM533/GUEgj+Sm8mLGCkqtodtYn+61qhx6gxjR+wq2NZPmq0g7m/9z
        hAcBJPS3mumNnlgKFfS4qWDczuf9DIs=
X-Google-Smtp-Source: ABdhPJxP49gIPiKCuz6nQCcKDAcO3PZrEReCiIRv/Hl/O9yFNY5Xy2r0lt3sA3tBRNUVU6I+TBC4G7b5tu4=
Sender: "adelva via sendgmr" <adelva@adelva.mtv.corp.google.com>
X-Received: from adelva.mtv.corp.google.com ([2620:15c:211:200:3e52:82ff:fe5f:1593])
 (user=adelva job=sendgmr) by 2002:a0c:eec4:: with SMTP id h4mr19229603qvs.52.1604268527352;
 Sun, 01 Nov 2020 14:08:47 -0800 (PST)
Date:   Sun,  1 Nov 2020 14:08:45 -0800
Message-Id: <20201101220845.2391858-1-adelva@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] xfrm/compat: Remove use of kmalloc_track_caller
From:   Alistair Delva <adelva@google.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kernel-team@android.com,
        "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __kmalloc_track_caller symbol is not exported if SLUB/SLOB are
enabled instead of SLAB, which breaks the build on such configs when
CONFIG_XFRM_USER_COMPAT=3Dm.

ERROR: "__kmalloc_track_caller" [net/xfrm/xfrm_compat.ko] undefined!

Other users of this symbol are 'bool' options, but changing this to
bool would require XFRM_USER to be built in as well, which doesn't
seem worth it. Go back to kmalloc().

Fixes: 96392ee5a13b9 ("xfrm/compat: Translate 32-bit user_policy from sockp=
tr")
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Alistair Delva <adelva@google.com>
---
 net/xfrm/xfrm_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index e28f0c9ecd6a..c1dee0696dfb 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -585,7 +585,7 @@ static int xfrm_user_policy_compat(u8 **pdata32, int op=
tlen)
 	if (optlen < sizeof(*p))
 		return -EINVAL;
=20
-	data64 =3D kmalloc_track_caller(optlen + 4, GFP_USER | __GFP_NOWARN);
+	data64 =3D kmalloc(optlen + 4, GFP_USER | __GFP_NOWARN);
 	if (!data64)
 		return -ENOMEM;
=20
--=20
2.29.1.341.ge80a0c044ae-goog

