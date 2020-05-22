Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713721DF163
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 23:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgEVVmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 17:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbgEVVmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:42:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F7CC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:42:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d10so5624073pgn.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GgtkiazwQoiTvdTYPMpf28KQw+7R+qBoN6rSS4orM1s=;
        b=HjRVxmVf1ldbdQQ4jNcadad7e/KmN7zX/mXlPZvNTiCYkFgoNVyaBwqVVZufsT5Kzv
         WeRED5ZDTFO1Dq1gsi2RuHgeAOWVlGDpU92OdtXKa8vmBBsOEwYT9GzhXt/+8ihBHXM6
         neVBMtFF5nkFfjdhHFAEKbr9wYKK2dX/z7VhUV9TeMSXXAGvhVJ9JCjKuo0Uic6EUVtv
         LWJzMPhHlcO5oQUCnLf0nV5bR9LhIbpiyGEB1GrhHTGk7f1GlG03kWyFwbz3r8J3oont
         RiHHjbG37wSn1RwjIDl3jfQsst2KEODtihMM7EnQBz2PWRKIPcUd3pVAZ24OKYizQHHY
         blgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GgtkiazwQoiTvdTYPMpf28KQw+7R+qBoN6rSS4orM1s=;
        b=mCJaGxSqpVEAy7aQTQEGn5Qu3VFv2p1HEJZ2BBooRNvdGBl2HIkWDRSm0pbNOsvANd
         UIKjWPiS/Ki9b/ZR5i2fhlUgK2ZHN5p6q4/FM7s1NtK64M7iX9CRICQ9n6zSfKMmXWrC
         UoEbh+48uJCy4nWLk8r1ELD5IN4K6NKfgiTCLofxoq276gfslwzGySEdgjgU5Ya+05ku
         VK1dK+TZT96YT2tDIAobIixoWhiSnvVSCZ0gJsb51k7Iuvew/QBfZEsN9F3LhCBkJjgh
         xO15fZYJgngfD0PsVo5YM1lUzRW4wR7si7qpmsDGelORCOWuzM2YBcjjxYFhdaHLv8oL
         W2MA==
X-Gm-Message-State: AOAM530kABvjTJHiKuG2/StHNBdZyywpNu4G2J/ENo7WR1DpapB9Jvpg
        JTmARN+FJ65TgUNtNXJ+UW8=
X-Google-Smtp-Source: ABdhPJxNTB8cdqBhGd0hJ8o5xV7Aiz2GsTjFcgw9TWk0AHBHzHgdRbaBU2e3vbs1ORg87i+p/WW6Gw==
X-Received: by 2002:a63:3449:: with SMTP id b70mr16118674pga.289.1590183735190;
        Fri, 22 May 2020 14:42:15 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:d0d2:96ff:22ac:b8e6])
        by smtp.gmail.com with ESMTPSA id 4sm7625098pff.18.2020.05.22.14.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:42:14 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/3] xtensa: fix type conversion in __get_user_size
Date:   Fri, 22 May 2020 14:41:52 -0700
Message-Id: <20200522214153.30163-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522214153.30163-1-jcmvbkbc@gmail.com>
References: <20200522214153.30163-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8-byte access in __get_user_size converts pointer to temporary variable
to the type of original user pointer and then dereferences it, resulting
in the following sparse warning:

  sparse: warning: dereference of noderef expression

Instead dereference the original user pointer under the __typeof__ and
add indirection outside.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index 754a7c96b9da..445bb4cf3c28 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -204,7 +204,7 @@ do {									\
 			retval = -EFAULT;				\
 			(x) = 0;					\
 		} else {						\
-			(x) = *(__force __typeof__((ptr)))&__x;		\
+			(x) = *(__force __typeof__(*(ptr)) *)&__x;	\
 		}							\
 		break;							\
 	}								\
-- 
2.20.1

