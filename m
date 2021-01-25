Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F6130275C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbhAYP7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbhAYPue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:50:34 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32582C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:49:54 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c128so11525201wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-powerpc-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=It4AKC/1LgMluJkIF4Rxerhljl96iqpqFZ1n3C8wBp0=;
        b=c32YHNj4kWZxvS9lrPFa4ahqB8ubYx3V48YuMsZe3rurWlI+y1sJmmraLjYbSAqDPr
         2nW97On+s058SIZGzhVQ3BRX/a0g8qHIESAM6OGH/8TwenwDKSk0MOclXNCK44noVQv0
         EkktJtNYx5QMAPbJGQOhpdrSXNlRmTQqbCHNwCzqATlUVFRe62clPjyXmT5/mf7BYTBC
         G8d2QAVF8FJWpz5jO0WwnOsBFrynYtUlM/rZTXfy+3L/PhsUmnF/nhynPV2wNRw4iwYn
         ZNHFWBHMGqhoNaSfxftoVh0mssMp8mQlGOxOk4bfdYEsNt0VDfrLbe+DnvmeuWXq6XYl
         OntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=It4AKC/1LgMluJkIF4Rxerhljl96iqpqFZ1n3C8wBp0=;
        b=HWp0qfkXNIAwhfKzsML+dIHNdgyMuc3ANPGWUyHX6yuj54VHe9KkYhB9ZZislaN+lh
         A9bAhvW6GRwvuD41Wa4f3qQRfCC9SFOccbTUUsvX5PYEaTcbzt646JtUHCyAIBKc9vrk
         jAZ5eIaZMXOLzHXSN3HD8AIG0d6/iXXbfKBBnTdp8SQmSta5IvraLNGyIDyLMo134e1P
         1EUu8ZnBSuP6/QT7bsFKuseYAWA1L6ARm4TthL6QO8MTchhxRx6fjYpN+pQroWmnOcdc
         e9r2ypaHAx8TIg7xSC/Zgi5KFdDsvBZvOLd8JglGS/MS+r17CpJG8IkpITWwH77q1o9q
         lEOg==
X-Gm-Message-State: AOAM532Ae33U41FYptu1uIeC88Bwm1x3W2zfpxZrkxM+lCO68XZRcP/n
        EPnsAby9LDO+gAiHiYh5ubeqkv+GXCxLmk6HMJM=
X-Google-Smtp-Source: ABdhPJwpHvp3T7QlTivtE5nnKQKPGyArOFvCZBBeQswNQMsXOe+7u5ot2ou9qQf9NjS2SntU6UDyRw==
X-Received: by 2002:a05:600c:4e88:: with SMTP id f8mr738722wmq.6.1611589792841;
        Mon, 25 Jan 2021 07:49:52 -0800 (PST)
Received: from localhost.localdomain ([5.35.34.67])
        by smtp.gmail.com with ESMTPSA id q7sm24624599wrx.18.2021.01.25.07.49.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 07:49:52 -0800 (PST)
From:   Denis Kirjanov <kda@linux-powerpc.org>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, kuba@kernel.org
Subject: [PATCH] fs: export kern_path_locked
Date:   Mon, 25 Jan 2021 18:49:37 +0300
Message-Id: <20210125154937.26479-1-kda@linux-powerpc.org>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the function is used outside and we have a prototype
defined in namei.h

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 fs/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/namei.c b/fs/namei.c
index 78443a85480a..3de3b3642302 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2450,6 +2450,7 @@ struct dentry *kern_path_locked(const char *name, struct path *path)
 	putname(filename);
 	return d;
 }
+EXPORT_SYMBOL(kern_path_locked);
 
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
-- 
2.16.4

