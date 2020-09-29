Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418DC27B8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgI2ANl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgI2ANg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:13:36 -0400
Received: from mail-pf1-x462.google.com (mail-pf1-x462.google.com [IPv6:2607:f8b0:4864:20::462])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B26EC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:13:36 -0700 (PDT)
Received: by mail-pf1-x462.google.com with SMTP id o20so2761614pfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v8C+xMzu19xnyurAfDoVjIHgPVGUTo7XJO7a449p2G0=;
        b=MovkRQBtL/tNV3fIf3ankic9DBfFJUByxasiosgcYeaFj6dQEUxT73H4SFCkSJXv7+
         avczY6kEXjEjZZqCvJC97Ed4UA6JpjHQI1RUDm37eXKzR3MeLjNYoRxSttjFGTbznRkv
         fpY6nPLEEc+L7g1QJvEGibE9IF6nkAy+80Jek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v8C+xMzu19xnyurAfDoVjIHgPVGUTo7XJO7a449p2G0=;
        b=Chri6HkjnG3kfAbgDgnM09m+bRLeDzyvLUepUd9RREbn71fwXU6j8Tng+yBrn9Bagw
         nJAC/Hh/tLgO5FVvw5JQefkbuswFTl4050WunAPg39dSiRA/RPldwMjPtnZlaG0k+I7+
         DxpRi2V9dGiZl1LYZJhaoxzr4eVcQFS8N7ydkQHqCupk9HlyQZthsCOJtKIsnkeoTwSi
         6S5S82pyeLy/pLQnvf3Ociojab/KoccxxCBCKYaYrrXxe1jRTfRKZtJ5a7PJz5RjzSpc
         o6G/mpwDjRyYv6zbfZX1MCc1bgKCybMnSbHpDD0vIVxMA4dU4fQCYVHAqMKgsMjagp+W
         yqvw==
X-Gm-Message-State: AOAM533+UW7PfpB76P7R3Tqh1kX1tsI07zoJkGJ5sd1DMJbd1tF1ZPTc
        tn45AgGs0dp+BkD277TiH84L5LS8lMgQacSvJzvItGxzNhVa
X-Google-Smtp-Source: ABdhPJzW/Bkrn0gWfR4ty688ubCzcIFwGQTBOOnI2erPINtzBOdJKEVbfqJwyeE5qBVMErl1vX5Zup3WvdQn
X-Received: by 2002:aa7:8612:0:b029:142:2501:3967 with SMTP id p18-20020aa786120000b029014225013967mr1712367pfn.44.1601338415963;
        Mon, 28 Sep 2020 17:13:35 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id t1sm1047973pjr.8.2020.09.28.17.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:13:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v4 16/16] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Mon, 28 Sep 2020 17:12:09 -0700
Message-Id: <20200929001209.16393-17-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929001209.16393-1-scott.branden@broadcom.com>
References: <20200929001209.16393-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 190c7fa2ea01..ce88e423547f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3714,6 +3714,13 @@ L:	netdev@vger.kernel.org
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

