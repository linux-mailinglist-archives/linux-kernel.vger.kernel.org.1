Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F171A2D163F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgLGQem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:34:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbgLGQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1fH8U2k617dM0XyiEykpCNbr+LOxy6e2jOJ7NB6sW0=;
        b=e/IrhDUJ5UrOemjndxXNFPZmGb7mXxAU0pfvFO+r/z7baK7qRDUQtjf+duM+5n97kB+LGo
        v5bne3pj1lyf4eB4hl8O0gn6iDzVYB1xM746YdsGk7dyP8iAp6e/VVFVuZSWA+k0yLSO4F
        PfRyxIR+p2Vnh80+IwBKQ2qXyPRq1Lg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-BImS6SKiMi-SA6Xx6wvIkA-1; Mon, 07 Dec 2020 11:33:12 -0500
X-MC-Unique: BImS6SKiMi-SA6Xx6wvIkA-1
Received: by mail-ed1-f72.google.com with SMTP id c24so6005155edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1fH8U2k617dM0XyiEykpCNbr+LOxy6e2jOJ7NB6sW0=;
        b=ep+t03G+j4z3GGCWJAeoJ6CDGGWfJjClew0YXkx/5Ru/IHUrMViS3v6K9O+buwK1eZ
         G2+7nRrNg4ldku71jBmrn+fT9euCzjtQUljyb5Zj3sqwhJm7D24p6UI0cSBps+YSZcib
         EpJTZiqzQpc1YSTFhYKt9SzGyZKort+qAIyyyF/LSNp8g4c6qZAwpsJpbYs0C6urqb0x
         +u87Pfk41crUd0Dut3AyS2qt4eMyWoF09i6d7yov5TTGFAMcwNGVDHLglYA+iBKfo4E8
         oWygaEn6R1ko+lki8PRyelq/OChZW8HUBaL2vDZUWYRI/DslSw2NpAezGzHQM4IrNGE2
         B6wQ==
X-Gm-Message-State: AOAM532EhHod/12qFUZsALO+DWxLvin9iLhlXL7K01guni0rI+s/CkzT
        EFqWT7JJKOtxT7gwrxNug3P8sfmwMLQRzumMZHqAT/hadf3C/lLO4mGjW2YJXPG271U+q1F4f5i
        MYVl1BfAQeNk1NO4ne7SNeW2Z
X-Received: by 2002:a17:906:a2d0:: with SMTP id by16mr19156480ejb.207.1607358790895;
        Mon, 07 Dec 2020 08:33:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweaIFgMC09TO4pnW1Q9E6ePGnwgJZA2DaWMFT2e+UPWDLsluzpW5Ef28/5k5tUJJKQ0PR7fA==
X-Received: by 2002:a17:906:a2d0:: with SMTP id by16mr19156470ejb.207.1607358790718;
        Mon, 07 Dec 2020 08:33:10 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:10 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] ovl: do not fail because of O_NOATIME
Date:   Mon,  7 Dec 2020 17:32:53 +0100
Message-Id: <20201207163255.564116-9-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the file cannot be opened with O_NOATIME because of lack of
capabilities, then clear O_NOATIME instead of failing.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index dc767034d37b..d6ac7ac66410 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -53,9 +53,10 @@ static struct file *ovl_open_realfile(const struct file *file,
 	err = inode_permission(realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
-	} else if (!inode_owner_or_capable(realinode)) {
-		realfile = ERR_PTR(-EPERM);
 	} else {
+		if (!inode_owner_or_capable(realinode))
+			flags &= ~O_NOATIME;
+
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
 					       current_cred());
 	}
-- 
2.26.2

