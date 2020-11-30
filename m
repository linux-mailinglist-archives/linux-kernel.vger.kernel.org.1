Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A142C8D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbgK3SoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388215AbgK3SoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:44:08 -0500
Received: from mail-oi1-x262.google.com (mail-oi1-x262.google.com [IPv6:2607:f8b0:4864:20::262])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33C6C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:43:27 -0800 (PST)
Received: by mail-oi1-x262.google.com with SMTP id f11so15266146oij.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VXn1vesZxZW4DK6lp9K8JbkwaLnF3idVgMw4AAYOqz4=;
        b=fVacpoPwUasJD1D/F9/iYKMJLMuP6ggh9FQiCQJm9Xm8rEbtODLq3G3eC4V48bTHdi
         IzLIxMjkk67nLI2YS8Sna/F/J2gD1LRnUE/RHsyOC3m7HGIOTVPwJMz+05uI1cCTcscC
         Wl/DsYNtk7t+D6xbJUUPZNC+dXIG4aYBpxLjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VXn1vesZxZW4DK6lp9K8JbkwaLnF3idVgMw4AAYOqz4=;
        b=d1iOLJOHv0CVPF2f0k7cADqFrSrwOC5kziSDN3bxiJA0/BcwCPFWP7cXkNqzsHyrDH
         SMcS9ykOYv9iVmK1smWZAP2+7vcpM0qk1VkL3arsTeG3s6CjCry4ErUwRfhwPHcjQgt3
         ANWQrsHBwCwesEZXlHNkrNueEs6qAEkDjQ42OqtUzcquSTNUhRCJi+xGsRKn/kPMF1+v
         bU0jS9cRWfuhmR3VBma9F70gF4gpHelkb84AoOIUnIvVn7A8UqQDZB/e7Wyoy3xpYscF
         qJ16L4/uUzp3DDPazc6RDBJdQuwu7OP/ou6FNxLVcCG6X58TR/7tAm0Oj7txYS27XjMz
         RgNA==
X-Gm-Message-State: AOAM531cU4vL0l0R5143K7/VGBXChFNHTAjt6pVboAsyneL0Dt/gz9wn
        sX7/WYyKP+hHDvFgOoanNAN/bPd9wCVv2M5xif1JzZO1gm/P
X-Google-Smtp-Source: ABdhPJzufh//1PVuwVrfuDTWElRbB/yoft2jeVe5nBbH5NqAs9/D5YUHM9f7VmGeWMyqibCEQfErzyE0dcz0
X-Received: by 2002:aca:a8d4:: with SMTP id r203mr169651oie.3.1606761807333;
        Mon, 30 Nov 2020 10:43:27 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id z21sm1909069ooe.19.2020.11.30.10.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:43:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v8 12/13] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Mon, 30 Nov 2020 10:41:59 -0800
Message-Id: <20201130184200.5095-13-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130184200.5095-1-scott.branden@broadcom.com>
References: <20201130184200.5095-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a34b25ecc1f..2ce6adcff41d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3716,6 +3716,13 @@ L:	netdev@vger.kernel.org
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

