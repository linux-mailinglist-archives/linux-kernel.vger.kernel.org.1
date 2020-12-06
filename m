Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92ED2D0174
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 08:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgLFHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 02:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLFHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 02:40:31 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02798C0613D1;
        Sat,  5 Dec 2020 23:39:45 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q3so6339934pgr.3;
        Sat, 05 Dec 2020 23:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iXEd1mw4OixI5+E3VPtVjvelJMnMwujO4qOIvYeoJBY=;
        b=QHmd/IWOZp8JTofSo/sgmRoIzVnX7SwBmhkNKvE1I/XMW40VSbDvbiPP+NdWw0WqYU
         dCO8MRzEyRlbMFCnfHxU2FY0w7IU6H/FC6FTgbM8RYZq6tMenLONN/CJC2JFjZFfxJbi
         j2fLRoJGK6dEP1lbNssCiGCQoW58b+9rkGy+b4hiHT7ndNVE4wULZVH6u/Xd8eYPKUc5
         0SWh3co4DArHu6QMwH95SKiev6bwTQ7pfYdeG/gRS+dYDoqlrs5rOdmUYdWSfQopsQqD
         Qp57CCZQWIksdjTGCv0N7u5PWSb2M6XeyvHFJ8spIh12d/Ib93TSKxSXxGmBewdtrY0Q
         wG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iXEd1mw4OixI5+E3VPtVjvelJMnMwujO4qOIvYeoJBY=;
        b=G6MDBDyxgJ7CHw7z4IA967nU8m2BbAAX0vT2d75TIx/2RVgggrS6yjg9O/FwBuxbZE
         frMRpCQKmuRHGIDqvAb3Eh2IMGThxIqo43jwCqn8pHs9bS/X6ZB/kuBfbTix8GRZGg6Z
         Ea5p8x5zKOCCLRG76lskbqZAf3MrRKBRPC7GG+JEMS5uE8cDTSGFQkucVX6DTovcDbf6
         tMPkx1GSNi/zz8qokUvSqeyEdMkuQnEPi30JJfIIbhNmgO6L9L4WlB+lIoBobSq2bHBM
         CuY6ULiAAfSjvDW3O4FiNtKQ7xlIODSHv4qd8OQIDhmyEjM2xIxzaW2+/VXSz7WVHi0T
         ND8g==
X-Gm-Message-State: AOAM532usxcD18Rmzc2dmc0XqUfslyQ7b0aNB3UDAUroik4GZykBo2J8
        FO7/VTDiMZpHaBRWz/AyEg8=
X-Google-Smtp-Source: ABdhPJzFoLseQ1mp5uPRtBIffBQghrATj5HBe0uhF6E+8LX7QUqvl0wuopop4uA8CeXRD5mmkJutVA==
X-Received: by 2002:a65:4c01:: with SMTP id u1mr14243590pgq.35.1607240384317;
        Sat, 05 Dec 2020 23:39:44 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f092:5562:8d65:7204:31e])
        by smtp.gmail.com with ESMTPSA id mz1sm4101275pjb.33.2020.12.05.23.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 23:39:43 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 2/8] tty: serial: jsm: Fixed file by added more spacing
Date:   Sun,  6 Dec 2020 13:09:26 +0530
Message-Id: <1d21fbfef601dc400cb0d50ec2ee1e85dc3b6f91.1607240285.git.rclemsmith@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
References: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Clement Smith <rclemsmith@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 512b77195e9f..202d6ba93313 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -608,7 +608,7 @@ void jsm_input(struct jsm_channel *ch)
 				 * format it likes.
 				 */
 				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i),  TTY_BREAK);
 				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
 				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
-- 
2.27.0

