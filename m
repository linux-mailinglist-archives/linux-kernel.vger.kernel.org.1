Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D84F2D1645
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgLGQep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727798AbgLGQen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RE0m3vgq1/OaRAwZjvKOK2ey/mE38mR/q+wtN6wib9s=;
        b=Eg87k5igU07VVyU7gpntFf3poClRUjMOlw7v0GBPEorMtynYOXsofThHhUeLdb1V6DxNjI
        /JLlV88aynvZQ5Dc5aj3pw0U1aLb3J69TrXmEQScAGoinIL6+JScwpbTn+6XSdKges5l1t
        DaAC9Bu+/wJggHOT4WG4Ej477iq1RCQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-5Xebz-HJNlu29d1tfFK85A-1; Mon, 07 Dec 2020 11:33:14 -0500
X-MC-Unique: 5Xebz-HJNlu29d1tfFK85A-1
Received: by mail-ed1-f69.google.com with SMTP id z20so5971992edl.21
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RE0m3vgq1/OaRAwZjvKOK2ey/mE38mR/q+wtN6wib9s=;
        b=spsLpfDDLjVsthWl0nADf5wXmA1dtyE3TfjOto96KJyDegtgiE8dMlZzQ17KLUKQz5
         3ASUpYY273d/cprX+HdbXq5GH0YlRKbwnbvlX1F9nNy+XBw2ibOOIiPW4SIQuxMdQPm4
         n++gQxoF33OJPFvSJeIXEeG3UAkxtQYKaG1jQJP48gkIFZY/EVKwmcVKZPgauWcqDNY3
         3tvAZVrSbUll6ZN17ZkPzy2gdblv4Fv4pAvgE1aGBRhx3sDPgMukDLOKJ96rk9p4beNR
         dPlBu7LYiIvqdYmpeARwdiKypN4JmqkaT1qZ4S6ZonlK2PQg++OxTIUWMDU0+Ne0OQN7
         cutA==
X-Gm-Message-State: AOAM531wPNuBncv3VUPDipRBrH4YqSXC1CMfLiQHAULkDim4kSpjy612
        vKsvvTfU45cnHixk5FvcOH0TAIyT9jyfKiaiQE3lZrbMY5U5LzBcFtAPMQ/x/RrWTd5Sx4RUwBc
        NRZima0RLiujov3kzXjL5JSzT
X-Received: by 2002:a50:d74c:: with SMTP id i12mr20512776edj.236.1607358793437;
        Mon, 07 Dec 2020 08:33:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZo9cLo2B/sr3LytBzOfhCP7NvepbgDDGPqp8OuSqAKVtWfqlfy6nWwFOViRsEnP4mLzJm9A==
X-Received: by 2002:a50:d74c:: with SMTP id i12mr20512764edj.236.1607358793260;
        Mon, 07 Dec 2020 08:33:13 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:12 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] ovl: unprivieged mounts
Date:   Mon,  7 Dec 2020 17:32:55 +0100
Message-Id: <20201207163255.564116-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable unprivileged user namespace mounts of overlayfs.  Overlayfs's
permission model (*) ensures that the mounter itself cannot gain additional
privileges by the act of creating an overlayfs mount.

This feature request is coming from the "rootless" container crowd.

(*) Documentation/filesystems/overlayfs.txt#Permission model

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 189380b946be..019e6f1834b0 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2073,6 +2073,7 @@ static struct dentry *ovl_mount(struct file_system_type *fs_type, int flags,
 static struct file_system_type ovl_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "overlay",
+	.fs_flags	= FS_USERNS_MOUNT,
 	.mount		= ovl_mount,
 	.kill_sb	= kill_anon_super,
 };
-- 
2.26.2

