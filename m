Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5EA23F38C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 22:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgHGUKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 16:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:10:16 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5024C061757
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 13:10:14 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id s190so662691ooa.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 13:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5taqwMO9fu02Eq/oSradLpdwhpBHOZ6HATVQFj48PwQ=;
        b=o+RLkgiWcKpcUvk2Tf5HX3mwUcwZMaE8ojwafEAc5BGvxDc1PPCM2L2pnU6qktkJgw
         M9bcEGDCTL8TPb1z6EQBJdQsfFA1vl1+3VSo5jY9iocb4muw4AzFODmQCQUqjhmPFSdS
         r8qYJfAD4h2FXFI31Clr4IcubakwzP8Wt5gQR5f/O9GByWCAKhbqMlmZ2mB5v7lHWn+n
         Yndh1Eo2hGetellv5wkaEaooWttKZyWOlpLB2m6DUs/IXTpGACHnHhYEjtF93t5pauZM
         UYfyGMQKnC6LWFt9ujtAF/3TLhlw2Bj9Za98hFWWvkBAJ8CmJkGc4XAMAC9CpUyLi7jc
         SXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5taqwMO9fu02Eq/oSradLpdwhpBHOZ6HATVQFj48PwQ=;
        b=LycYgFZRl8gY2YV5NOCootEDo7kq00AWvlDZZ1/sQaDiFm0P8g8GldTHECUfCMOPuI
         SdaNAMZUqgG31CtqjNH7DSLCy88fdKuZIpmth9MTj6E9D0xs1c3zC6W7fkvj2eOfeKTf
         iYUGMDDQ7LGt98k40ivN65aednM7adzt+sLYUD9UuPS4RtwT7fDlqKBwzvI1j5pwkSAP
         S/5/QapUjkJTXlT5Hv7IHLTWG86bhPE9B5cQAcXePTKZBB/dDcr4whDlzuWHnqiYZIQ0
         7pwtl3uyORvcUfv3A1XIadp/3Utm/NOy+uevRpdDkW/b5BS+zonZ474FgWmCrtNh3qG5
         wh6w==
X-Gm-Message-State: AOAM530m+OQ6DeJt2MI5b6ULCshAngQ4JK4dASva8RUp1uYbxWh9oCRz
        KndlF62QRxT4KbaWaUJ36aw5HiB9jkE=
X-Google-Smtp-Source: ABdhPJyz32khtmCydKoxgCn/Skg4kS3eCD4Bs2kx9il4fiuJXkz9yEip16I5TowqS31SpS8DybilFw==
X-Received: by 2002:a4a:4083:: with SMTP id n125mr8260745ooa.42.1596831014054;
        Fri, 07 Aug 2020 13:10:14 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::af38])
        by smtp.googlemail.com with ESMTPSA id s6sm1835794otq.75.2020.08.07.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:10:13 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/7] dyndbg: give %3u width in pr-format, cosmetic only
Date:   Fri,  7 Aug 2020 14:09:48 -0600
Message-Id: <20200807200957.1269454-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807200957.1269454-1-jim.cromie@gmail.com>
References: <20200807200957.1269454-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the print-width so log entries line up nicely.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1d012e597cc3..01b7d0210412 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -947,7 +947,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	v2pr_info("%u debug prints in module %s\n", n, dt->mod_name);
+	v2pr_info("%3u debug prints in module %s\n", n, dt->mod_name);
 	return 0;
 }
 
-- 
2.26.2

