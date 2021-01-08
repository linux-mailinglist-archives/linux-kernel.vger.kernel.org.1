Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A599D2EF37D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbhAHNxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbhAHNxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:53:11 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37315C0612F5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 05:52:31 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t22so6289489pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 05:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZriopB/bdJEjTnXaU/KpXNok7U4qP0rkhbQb5Rep6U8=;
        b=G9LZhqtMEc2/AM4ybrAjwFxFPA372JpB4FsOnbrLLKQB6fcwIoOwjZcaATWWbiRpHc
         WMwsaXe0+xn6lWrN+GbF0+psGsaKArhM3SO4/DnHMThypMG1fsURabMyXyNIhqs4hdUM
         M22/ET309DE0SiW3QqUolfWTr798gTmKHk8dWSVd5Q+G6s2DBN8SispckPG+PZGTOqy2
         dUtHjXDN4dgagO3AJdM67LAF6z+IF5PD1nJyzYZA4rRrxzsZUTup6H9oh8mnrlmegIbs
         QOHbdbnUd0Jxr/pSYz5LNC5WhSH8Rqnpv8c33mSV/IXyMN3He3Nou+ZY3sprDEvWjHGS
         stgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZriopB/bdJEjTnXaU/KpXNok7U4qP0rkhbQb5Rep6U8=;
        b=Ak+MsIlMYUf3Ulyysn79JN8Z8Fj9KlDSYrUaVV2735a1l1v6tILSEZiZ5/k4uFSo0B
         DTHdGVkm71yv/H1ZTzwDHJvjlluAHB/7lPnkqvwA2dfxJPW1ltnQ6BZnSIfSy80i9jl8
         3GjJ92FDzR+AwS7nhGsu1vgGxJPMivZaKHz+w4r9wQXTxhPvAERV3L/VXq+QX+WT0Vn+
         efU5Eos4T3knBPmd7B28hldmHsylsan0nKqrpFcgsdXG7e3ZnemewKG9RTKBkkUPL8qv
         QDk8NLH8p3NsjaCwEwFTpdwjgVC1sbgpZ3qVB9XLytyqCmAuF+tdlrVg6eBmYUnSxtAm
         iR3w==
X-Gm-Message-State: AOAM532eLp8eecp7obX4L4osEAJ+D33OLnnizsy7igduVnpKYw6OYE9s
        19xomz5yAC95QGeyp7ZEnrr4uQ==
X-Google-Smtp-Source: ABdhPJyVmuMi5NGZ40cwNsbMW34wCWx+4Sc1t31BpImK7Tns7Bn7YfNORL79bBjKrvUSlewfPSDNxA==
X-Received: by 2002:a63:4b54:: with SMTP id k20mr7275165pgl.290.1610113950832;
        Fri, 08 Jan 2021 05:52:30 -0800 (PST)
Received: from always-libai.bytedance.net ([153.254.110.96])
        by smtp.gmail.com with ESMTPSA id k64sm9401184pfd.75.2021.01.08.05.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 05:52:30 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v3 0/2] misc: pvpanic: introduce capability & module parameter
Date:   Fri,  8 Jan 2021 21:52:21 +0800
Message-Id: <20210108135223.2924507-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
Seperate the function to 2 parts:
    1, use sysfs to expose device capability.
    2, add a module parameter to set limitation by user.

v1 -> v2:
Remove device info log, use module parameter to expose capability.

v1:
The guest sides determines pvpanic capability by RDPT, before kicking
host side, check the event is supported or not.

zhenwei pi (2):
  misc: pvpanic: introduce device capability
  misc: pvpanic: introduce module parameter 'events'

 drivers/misc/pvpanic.c | 45 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

-- 
2.25.1

