Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E681270EC6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgISPMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 11:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgISPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 11:12:32 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB195C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 08:12:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f142so10024845qke.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6fVk3SkoqSjFVNo3hENg6/712uFKZxhyKcdpxBqMVg=;
        b=UqSvKAAQu5RpAxviVL3nmvQ/ulxxBKpXk+q63/hmKnOygBvUOyYjwmQm72dNbGzfYJ
         e7qmlHI7uSCF9CX3Z7roQS7j0vsMXxFL/2J/MCU0csgwkebyfBdf3pkVSmPlveo3XSiX
         CFtwNGrX1IBh9lFjulYlAU8llMFlWvJl8fiF4p2pDh30EYXorD1jt82nF91Jy6S9S8NC
         24TIOa8rOll1Vpn0u73Z2d+UMVmMc2p38MScaUcpiDXGuEHNV/zwnVSAC4gIOUuIQzP8
         hPWltISsbkObN3WFZb9hjJzILL8fJirRhCsnxcb1LeVwSMFiebTVU+4eq1d4V89r3mKJ
         9YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6fVk3SkoqSjFVNo3hENg6/712uFKZxhyKcdpxBqMVg=;
        b=iQHe3bxUPHmIR8QHtRCUPfkuUGN+7Hg1JZBnQ7fX1lvQPe2Kxe9FkvTS/j2e9eeWVK
         IPsKdZp8KcqLVd055/PA9dVW2dJTEsTwtQYr+gZwZDNb65njZz9RqRGMkBlV9Y9JNVn9
         ApL1lcfJZSjjaq+U5Xlx8toSQ8mac58HZEur53ZIkCv+0y4kjpbMbalvPaJb2dY872zV
         aDLK3h6CNFDAmANk+nIwMrfqd4IwovI0C1zjiqEGyprIQFBzdcpwOWF/hCbdWXqC8zIY
         SYiqUBAjhHWqM91Wisz3wlSZM2dm0j0E1q+sAmwGdu40yl1WReu9nl4ZMsk9okpthiw4
         1XaQ==
X-Gm-Message-State: AOAM532na0cSai1LAPWZqTrBje5uMicEyzo8BvkZsZRR8SBSzvNigOAu
        f5OKc2heDalI9nI22xm9BxxWKCxljSQ=
X-Google-Smtp-Source: ABdhPJyCmTd+6VfyvcKSUT28I0xs3stDbMgHJo0xDoVwtuItwYr96eoITq3QNzDGSccIQ58BtSkVcA==
X-Received: by 2002:a05:620a:716:: with SMTP id 22mr37673774qkc.356.1600528351111;
        Sat, 19 Sep 2020 08:12:31 -0700 (PDT)
Received: from localhost.localdomain (dslb-092-073-054-206.092.073.pools.vodafone-ip.de. [92.73.54.206])
        by smtp.gmail.com with ESMTPSA id z3sm4513222qkj.0.2020.09.19.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 08:12:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8192u: correct placement of else if
Date:   Sat, 19 Sep 2020 17:08:22 +0200
Message-Id: <20200919150823.16923-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200919150823.16923-1-straube.linux@gmail.com>
References: <20200919150823.16923-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move 'else if' to the same line as the closing brace of the
corresponding 'if' to follow kernel coding style.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_wx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index 4ac0baf8be83..1d1685d2e908 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -561,9 +561,7 @@ static int r8192_wx_set_enc(struct net_device *dev,
 				zero_addr[key_idx],
 				0,                      /* DefaultKey */
 				hwkey);                 /* KeyContent */
-		}
-
-		else if (wrqu->encoding.length == 0xd) {
+		} else if (wrqu->encoding.length == 0xd) {
 			ieee->pairwise_key_type = KEY_TYPE_WEP104;
 			EnableHWSecurityConfig8192(dev);
 
-- 
2.28.0

