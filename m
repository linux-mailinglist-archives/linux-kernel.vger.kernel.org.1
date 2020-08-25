Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACE32520D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 21:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHYToX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 15:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHYToS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:44:18 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D68CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:44:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so8143135pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d8/Un318ZcCCy10fIEVIRzShdO9a4RkWIVvjcQb9S7k=;
        b=EJNvcCl9fDrs3+onNrhQI9rAN5wHEYg6FUM4h8EYSqsf0ggKbKpNi4ieqAPSbLEwpU
         8Pt+9Z+s8i0Do34/858mKp0Xso2X8s74B1mxOMqCUroRZFJn04Jz2g9Vjwdlr5XUIGBK
         MgUH8pNj47jpKyw1CXj5xPhcLRBkjSyY2XuNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d8/Un318ZcCCy10fIEVIRzShdO9a4RkWIVvjcQb9S7k=;
        b=AdW392uG5r+SnGBV8m8W6tLYeC0J2r2g3l+omk9G5GCFup6WpgYtYTXjPLLOQvnLX2
         FJiP4FA0C7Tl3OiYnQix5Wi/XZrkbJqAWWJ7VnyZvC2149o6Q18byBdxwtB8qGXv5tdo
         aPuLMvVLIqQrOC1ngEppLHmZaQy1O1/hpJ0GNv3fpkXOf9NQx2UvvltD+2UX1ZXuulR7
         IVbp41uxALUU97xie/eb4ATsFFhIs96AOAHKOk/CmTav1AUmg+YrgR6QQaB0/CvNSi+7
         F6yq8Rsvt6Jm6chiw1ixjy74CNRq4iDbVWXuaV1UATGafR0PEKSmn6X+X28pSViG0dBI
         JcmA==
X-Gm-Message-State: AOAM531wHxafNSvB74KjegdWWomAiQPRWp0V/bfGbEq/VZ9+YM9kYy14
        uHvd9983Hlj81Ii8926h3OhLhImalEdBFkuX
X-Google-Smtp-Source: ABdhPJz6iW/DMeE5Q9PnRtY3u363NVWs0iyLks265waeOU1YIHymcoHqLqnOs9pviQrApYYHqXLQqA==
X-Received: by 2002:a17:902:c111:: with SMTP id 17mr9344661pli.46.1598384656852;
        Tue, 25 Aug 2020 12:44:16 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x5sm45297pfj.1.2020.08.25.12.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 12:44:16 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v3 3/3] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Tue, 25 Aug 2020 12:44:00 -0700
Message-Id: <20200825194400.28960-4-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825194400.28960-1-scott.branden@broadcom.com>
References: <20200825194400.28960-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b186ade3597..5ce9cf6b52d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3699,6 +3699,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

