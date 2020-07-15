Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCC7221263
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 18:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGOQb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 12:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgGOQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:31:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B32AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:31:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ch3so3317538pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wp4UOgJ9IaPMlVofUUpLKOTdSoidBDOlTFMjlw713KI=;
        b=qp3X2aNnYkvFCE1oEmrIHZI3GMt4s2CoW6RgLUsUDKN6rLZdo6uiAf6fx4sane/mQi
         dYks0Zb11VL93pUV7JKGPL8aMHeTHRdgexhsyKSgZoIb+jeg8iWJCa1V/tgVjbq/L1cr
         GDLO+VIEhGDlISgw040caYyDOAvHML7RK/M8HKqpeeJJlhS/fsXn5RHaPF447zdBtWe5
         3B+j8IwDX6/HgBh/64LOY/IrWj2abQ7J/VwFaKaOEhoTycS1d7oshGMo4F0K1J4oNeeY
         AboaylwzIrUeDkyaXh7ENnS4iaWHA8G8jPIE3Z5Rj5BQlpzeYSkKirIquKxp/ghEoneL
         Q6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wp4UOgJ9IaPMlVofUUpLKOTdSoidBDOlTFMjlw713KI=;
        b=lsiYKt0FiECMp9dqIuQfRHQIY+bLmu+iWl/WgCYUI0DOgYSm6L03ge1sn46RfBAZJ9
         9QtVzDjG4dAOKxp7gMDIMo7B9CXuPXHOpexTumZl2HXYXm08EkOwXYu7ThSdxfhtnKLt
         Jr0ftsCHlk1sFbIeoI43qZpkGt/Xv+zDZN+EX3ovsL5wgazCwhmgE3TwD6cbir3BRCpB
         hA4t2RIP296UQxaYyAlxXZqcsxgayRSUJ6v5ZcXd294iUmff/AfRmNlBMtWYM/UpKfBr
         wnsF5tXnTHqiEnWBTell0dKaqTowuSxgECu5dF3LC9vHAUlTZg7jLREu3aSKJkKLmVZa
         N68A==
X-Gm-Message-State: AOAM531wYX/6jLUSr79wkap0XYkku9mb9b4ISGM3R+s9mKKw7PVJxUJ6
        dW8X7idmFXK1HCznc+d0e54=
X-Google-Smtp-Source: ABdhPJzygY3bmGTRvfgK+usYtOc0rXBqEqeemhGEsrGlIVj7rCLex3fcm5KJ3w7p0w+pctnwd0d55A==
X-Received: by 2002:a17:90a:3525:: with SMTP id q34mr474785pjb.192.1594830716800;
        Wed, 15 Jul 2020 09:31:56 -0700 (PDT)
Received: from rahulg-ThinkPad-T450 ([171.49.224.17])
        by smtp.gmail.com with ESMTPSA id h15sm2739368pjc.14.2020.07.15.09.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 09:31:56 -0700 (PDT)
Date:   Wed, 15 Jul 2020 22:01:52 +0530
From:   Rahul Gottipati <rahul.blr97@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8188eu: add blank line after declarations
Message-ID: <20200715163152.GA10190@rahulg-ThinkPad-T450>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a blank line after declarations in
drivers/staging/rtl8188eu/core/rtw_security.c to fix a
checkpatch.pl warning

Signed-off-by: Rahul Gottipati <rahul.blr97@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index f9139f72b3a7..bf1582598f1c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -840,6 +840,7 @@ static void next_key(u8 *key, int round)
 static void byte_sub(u8 *in, u8 *out)
 {
 	int i;
+
 	for (i = 0; i < 16; i++)
 		out[i] = sbox(in[i]);
 }
-- 
2.25.1

