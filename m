Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B032EB41F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbhAEUXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:23:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbhAEUXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609878095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MOxye5B0xRpCyzwF8z9vUvxQiwEx40pS01MW13zeLxA=;
        b=h8Kb6D8ILj/F/7iOB5oBLAyAJes9lJmYg4xi27aXUB3W/u4LIG7wu5MaTiWVVKThz5oDPf
        uG5xI5wiDI2R/VPpp3yuqFLOPzDfnDy0fUm5ECv+pmplQHL59qtn6pYitq3xVkQCqR8M88
        h0ZLA2vKFRRyX31eV/bDbvRqu1NhCxc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-4TzOwKhVP9qy_XmQjIBWbw-1; Tue, 05 Jan 2021 15:21:33 -0500
X-MC-Unique: 4TzOwKhVP9qy_XmQjIBWbw-1
Received: by mail-pg1-f197.google.com with SMTP id w13so266605pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 12:21:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MOxye5B0xRpCyzwF8z9vUvxQiwEx40pS01MW13zeLxA=;
        b=QgF5HUd9pFWGkbXLRT/It+RRikmBjDX6KLxvAKcitg1vyHAc6YBSlDTJ+oddlbTYFI
         PVneVfSql14vq/vKSfBbB63d0XKymjn8jXGPS7B0cnsFgw40HYSzWO6iB8POI8tDkIRE
         ZSIDT9w6l/lA15FQ+Jnw/p8I1o65pMgzNlGbz3pql5mewech42V+kRKFejV1IRBf6pvn
         2TQCQ1sFVXyJiXCMfxbrAa8QlH3Rg1Kz9BRvTqPOZtjXcvXDZX/7HRJiKVwdceVjDKiV
         l5tB+hnaeEQfCxn9eEYsNu7+AEUeTOwR4stq3lNOHHwK33A0ft/9cE/LvkAy07Ea3M8c
         iE8Q==
X-Gm-Message-State: AOAM532VDnuvzDP3sBsgIr2786ac9ozJjdZqNPkqP/HyOnS9zp/3MmwD
        NqfjQxiMWG/IjHBUs4V+/kiQ31tmkNVY+K39GGLUN0x1S8/Lafe3SN/c25Gnr3nMauyd3K0Y6Jr
        knrBrE3z1eP282gzqeRi3JLmr
X-Received: by 2002:a17:902:7449:b029:dc:bc:65de with SMTP id e9-20020a1709027449b02900dc00bc65demr825399plt.79.1609878092723;
        Tue, 05 Jan 2021 12:21:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSCA1TziBhfZbpw9kQ4ZJomdu0NlSOVGWB0ZiQQ4WYKC/eOIbFu+WMfWAXp5cnbDbZ8WYVPw==
X-Received: by 2002:a17:902:7449:b029:dc:bc:65de with SMTP id e9-20020a1709027449b02900dc00bc65demr825384plt.79.1609878092509;
        Tue, 05 Jan 2021 12:21:32 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u189sm225398pfb.51.2021.01.05.12.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 12:21:31 -0800 (PST)
From:   trix@redhat.com
To:     sfrench@samba.org, natechancellor@gmail.com,
        ndesaulniers@google.com, aaptel@suse.com, palcantara@suse.de
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] cifs: check pointer before freeing
Date:   Tue,  5 Jan 2021 12:21:26 -0800
Message-Id: <20210105202126.2879650-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

dfs_cache.c:591:2: warning: Argument to kfree() is a constant address
  (18446744073709551614), which is not memory allocated by malloc()
        kfree(vi);
        ^~~~~~~~~

In dfs_cache_del_vol() the volume info pointer 'vi' being freed
is the return of a call to find_vol().  The large constant address
is find_vol() returning an error.

Add an error check to dfs_cache_del_vol() similar to the one done
in dfs_cache_update_vol().

Fixes: 54be1f6c1c37 ("cifs: Add DFS cache routines")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/cifs/dfs_cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 6ad6ba5f6ebe..0fdb0de7ff86 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -1260,7 +1260,8 @@ void dfs_cache_del_vol(const char *fullpath)
 	vi = find_vol(fullpath);
 	spin_unlock(&vol_list_lock);
 
-	kref_put(&vi->refcnt, vol_release);
+	if (!IS_ERR(vi))
+		kref_put(&vi->refcnt, vol_release);
 }
 
 /**
-- 
2.27.0

