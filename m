Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E1F2942ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 21:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438082AbgJTTSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 15:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438061AbgJTTSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 15:18:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A271C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 12:18:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w21so1731405pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhB4D3Qqks0KHT6wFulg0fVFOaiWDpRKJPkxF+EjUPY=;
        b=B7i2YxzQiX4ywyIQ7T2IluxWtdSzbMHDa7gjsTvpnwiCmX/zVEnzH0+Zi0DMEBnVwQ
         PFqs4GQSDMqkpZXfOQ+wQT3i1MR7BVH0bDQygYEZn3UopGZRsYU0jSbhPu9FoKMoaQOK
         R8/yZdGPnVkb9RsyMKUZbJLN1SvfBTz2gnhpMvoQkz+aM9U7ARA/dTMAT/bs/2TsfT3q
         sCSMMI9/sMP03LgEVwuNOlEe2ySrWYraI2bHU6T94VKrQ1X5S43qxqmV03MchyqqfhsC
         gxAjGIS4Ao/3u7zz9qVEG4G+Qt+bbFsd6dgZm4Ml/yrFU1Ajy5wUKv9Bs43UF0DET7bP
         owhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhB4D3Qqks0KHT6wFulg0fVFOaiWDpRKJPkxF+EjUPY=;
        b=bNp+1Emu1Y/CMQcW6RoRqpSLElFm9Sdjo2wXqNn3uwf74R4/zAA+X0G9eFuL9ywZXd
         FjSqgZtKCS2kBfO4yplVfwSrLMj/Wia5muRS/4S1NfgY9psKnSIVRa4u+smyEXoOy0Fx
         z42/JvcgX5js/xP9efJlWuYZIhhTnmtqG7WzuC4bfz+B3NSq05FwDwVa/6GoDlv1iym+
         PKi9YO3sajw1LXqONeMH2QjG7iYpQkaC+ktrGaxgcu9D0Zt16OIpEuJUkBWEtmAh0Wd4
         7iEv2fRuNcFgtpPS5ADnUXr0d7vEOuV/NZKgT0qK/CaaMR6az0aeWBnG7iNj9pZ6l6Yg
         zbqg==
X-Gm-Message-State: AOAM532/Z/+vi+YBYIHCQkNFOrOT31ZritaZycEmvl1PIjrW/yYKsLAe
        Q0RxHyOxCllsG9/OuvcL7RfaL2ASN6/l3A==
X-Google-Smtp-Source: ABdhPJweqU78LH8AyiJYMHFlFTspVNfLD1dRowEZwySv0syk1hVhU7wNYb+7SLKhooDpuEc82uDo2Q==
X-Received: by 2002:a62:8348:0:b029:152:9d3c:c67e with SMTP id h69-20020a6283480000b02901529d3cc67emr1355225pfe.65.1603221479830;
        Tue, 20 Oct 2020 12:17:59 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:4a0f:cfff:fe35:d61b])
        by smtp.gmail.com with ESMTPSA id 204sm2855995pfz.74.2020.10.20.12.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 12:17:58 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v17 4/4] overlayfs: inode_owner_or_capable called during execv
Date:   Tue, 20 Oct 2020 12:17:32 -0700
Message-Id: <20201020191732.4049987-5-salyzyn@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020191732.4049987-1-salyzyn@android.com>
References: <20201020191732.4049987-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using old_creds as an indication that we are not overriding the
credentials, bypass call to inode_owner_or_capable.  This solves
a problem with all execv calls being blocked when using the caller's
credentials.

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Fixes: 05acefb4872da ("ovl: check permission to open real file")
To: linux-fsdevel@vger.kernel.org
To: linux-unionfs@vger.kernel.org
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com

v17 - rebase

v16 - introduced fix over rebased series
---
 fs/overlayfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index b1357bb067d9..9ab9663b02d8 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -53,7 +53,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 	err = inode_permission(realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
-	} else if (!inode_owner_or_capable(realinode)) {
+	} else if (old_cred && !inode_owner_or_capable(realinode)) {
 		realfile = ERR_PTR(-EPERM);
 	} else {
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
-- 
2.29.0.rc1.297.gfa9743e501-goog

