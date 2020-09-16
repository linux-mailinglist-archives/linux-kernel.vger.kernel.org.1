Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1410626B955
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIPBXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgIPBXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:23:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473B4C06174A;
        Tue, 15 Sep 2020 18:23:41 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s65so2986358pgb.0;
        Tue, 15 Sep 2020 18:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+68u2MIINSbQZ35J94IbVZzxe7hVNzyM2OvbuirUZ8=;
        b=lX7GyUTznKTKSRirfofKbf1FX+Zt3luuetp6BMJU7MdX169lJGLx5syQFENwO9fmiK
         9Lxma/uxJzYvOnN8tkFg2NcR9FOfa0ki+LPvPqY2Xh8KJkwc/jc4I6PM4K0waCPacxNN
         lkXzJgd2uakxRG5WVhWjCKwSpYNxK2wB8EtUxRFEpf9EnK7zQboo0PSUdyF0H7Q+UHBR
         X0cEJhlhghxHkos+RuUo+OfhIPq+xwbBqq19Eo7IUU60fPUR15JMv/N0ETvvKn4dn2hu
         AHpqccjlGU6W4lOd8/uf76ftk8Dh1iGXRMFMQ82GT+nSTKya3wmkAQOiqOugvWkUgMqN
         1X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+68u2MIINSbQZ35J94IbVZzxe7hVNzyM2OvbuirUZ8=;
        b=k1GDNGSl1lmOUh9LNuS7tugW7hd9WJvQwJ2/2rQrwIeCGXBTbM6ZEBjS751zBuqPCS
         XRtlAJ20kZuqnHmcRucUEmn0XFVa6KJWrVrb1tMnvwmA5qUbpe6C1dUY9V6YyeDguRnP
         e74sKT2YEqOAC8GtG1ru9sPcU5kwn3RL6QUoQ78xALvKAh9iodfxNlswyKICBJ35+DUo
         412fqVzQiLFNOUmnaIDOc7tTmb67LV1Vmf/yLc1lb7QmHv72ouIS/NKAc+ROPLCpN8at
         2L+xtuWACOwB0+/8f9Gw64yVQVd7p0oyHtzNGFkYEpfmGuPtVn1Xs/nF9u6WBXqUIoNQ
         F7GQ==
X-Gm-Message-State: AOAM532TudbKkfPdobU8BrGevmc5UVHdc8LIR1VVAV3X6j2HdXk3Uvj2
        gwqE8LkTDtJeoCaqDUdtTQYXiI3VhP/jNg==
X-Google-Smtp-Source: ABdhPJxSqgszqpcGb1L8+kh/YnUqtC5288Dar3j+Jhb5QibFfS310JLFkyUPbOYJU8iE4Z5tsmaT5g==
X-Received: by 2002:a65:4641:: with SMTP id k1mr16589709pgr.133.1600219420865;
        Tue, 15 Sep 2020 18:23:40 -0700 (PDT)
Received: from localhost.localdomain (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id c4sm649920pjq.7.2020.09.15.18.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 18:23:39 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs: fb: Removed the scrollback related option
Date:   Wed, 16 Sep 2020 06:51:12 +0530
Message-Id: <20200916012112.13054-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch remove the scrollback related option.

Commit 973c096f6a85(vgacon: remove software scrollback support)
Commit 50145474f6ef(fbcon: remove soft scrollback code)

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/fb/vesafb.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/fb/vesafb.rst b/Documentation/fb/vesafb.rst
index 6821c87b7893..f890a4f5623b 100644
--- a/Documentation/fb/vesafb.rst
+++ b/Documentation/fb/vesafb.rst
@@ -135,8 +135,6 @@ ypan	  enable display panning using the VESA protected mode
 
                 * scrolling (fullscreen) is fast, because there is
 		  no need to copy around data.
-		* You'll get scrollback (the Shift-PgUp thing),
-		  the video memory can be used as scrollback buffer
 
           kontra:
 
-- 
2.26.2

