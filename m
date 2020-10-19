Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC70292D23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgJSRw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728712AbgJSRwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603129943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=1rEftUQf/7Jy+J88LXeoBCQ82ZWczV2fVgKUL/vZ8vg=;
        b=XDBAbgMHImDwkHD6fmeqCZM4pEHK7cXks8dsWYaFGc9qnzcfP+T8P4mLPa2e36mmB8SinH
        SNP0J6bv4uB3HeczMz9g7ZYK51cdzciSgnVnEyy5xJuDVtwrzh3xDlf5nLIw+6NVfK1uaW
        PIeGthLpFsKy3Vh5Ffy2cXTQx3KXTQc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-KAtI_DoLOqOYY-CIXVNcSA-1; Mon, 19 Oct 2020 13:52:22 -0400
X-MC-Unique: KAtI_DoLOqOYY-CIXVNcSA-1
Received: by mail-qt1-f199.google.com with SMTP id i39so474982qtb.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1rEftUQf/7Jy+J88LXeoBCQ82ZWczV2fVgKUL/vZ8vg=;
        b=Z7VwZseT5j/VGRwDG1FCQWBjitHdhjyJ6IWEewMuJyMeC0Vb8aJKF8DHsa3n+L7Hvu
         QipRr/QigFdKvBnfGDCgFBgJ2P7+QfwpJhx+8AB7s7trLY5S4zRNG11JQS0MK8/BAEwF
         xVymBjYMkexOIgGJp/gFA6blw+ahlRiOIjO2gZokC0sAUQGKnmyDsa9sycFIzWJ3Fa3d
         LdA3cVtK5rKXaKtDs/8pYLKXyeQG13MmcCtow8fl0tFRue4SvA16E65Bi/8r/FdIcJuC
         NGeMkdxUAK3mvEdmG0D/QfGwIKkZhhZDP9I4JkhdFaIyE3Xv4rmU2LAjEhz0qZ4H+TN4
         7GUA==
X-Gm-Message-State: AOAM53399tvX/yN4AxCha7ZJtgqy8MsJq+Oq4xacj5wbh86v/C82j5eS
        mfamPxvB76Xg6pLABvosjVYFt440YI6u0iEaSKDQl1EpD1rzAApJkbdwjt42bEf7OY6p7efEUXd
        6KWA4hrrPm8VCr2m0AYsOqirn
X-Received: by 2002:a37:7185:: with SMTP id m127mr793765qkc.246.1603129941370;
        Mon, 19 Oct 2020 10:52:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhsAue4y6qUuYrwWoQG00RGuFBLPHfhcyHNIxwMVlpoPdRfJ2W7ZKYrVEdVKFRc7dB1NLf3Q==
X-Received: by 2002:a37:7185:: with SMTP id m127mr793741qkc.246.1603129941165;
        Mon, 19 Oct 2020 10:52:21 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 79sm316123qkl.42.2020.10.19.10.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:52:20 -0700 (PDT)
From:   trix@redhat.com
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        davem@davemloft.net, akpm@linux-foundation.org,
        willy@infradead.org, alex.shi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] fs: ocfs2 remove unneeded break
Date:   Mon, 19 Oct 2020 10:52:16 -0700
Message-Id: <20201019175216.2329-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a goto

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/ocfs2/cluster/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 79a231719460..3bd8119bed5e 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1198,7 +1198,6 @@ static int o2net_process_message(struct o2net_sock_container *sc,
 			msglog(hdr, "bad magic\n");
 			ret = -EINVAL;
 			goto out;
-			break;
 	}
 
 	/* find a handler for it */
-- 
2.18.1

