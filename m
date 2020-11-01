Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0882A1F17
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 16:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgKAPcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 10:32:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbgKAPcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 10:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604244760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=0Wj7ZfVzgf7VEzrGzNTq9aHl9BBDX910MMyPyWdtJRA=;
        b=SM0aJkHklkDuZYcNe2MgK5OMusdUbSSLg2IZsf5JsFnK7QLEEO07llr1hR9ACrUm6pOu+9
        PAyn+Ae88PRtWqclEufNlhlp68jODS0A9fPDAi+5qY4pO6IETc4XzNvwMkBptMF68JRvXJ
        hVxyPdeUjQUOZlysjS2CbHuuDIS9p68=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-yfYF8U4-NzKa079UWITQnA-1; Sun, 01 Nov 2020 10:32:39 -0500
X-MC-Unique: yfYF8U4-NzKa079UWITQnA-1
Received: by mail-ot1-f70.google.com with SMTP id k26so4624642otb.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 07:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Wj7ZfVzgf7VEzrGzNTq9aHl9BBDX910MMyPyWdtJRA=;
        b=oF5SNP7CkNGKXCYBHK41/dfMxk+OoWftqqlhWE8KDnRPR6rmoZVLALck4ef/DoFlTj
         knoqn1AzZMNjXQWSUOSFpvnY2ShXYH4MXN967G7165bQhb1d+CuevktGp9yVM1rAGtMI
         q0RH7cioGq7n9seNoX73DA52oVDyr50jWhYr+7etjBNQQnF2Ka3n5noANCGWCVqqoWEo
         Kf+45mPHiu8A2kneW53A30bR57/HLr5YgYTNgvQ2VSqW6dM4srNATEIPFKP+dsStsb7Z
         uiXon79vJJm2x6WlD08s9xCUPnbetElE6jxkAIQkP8gAZytYABbvuZIsxmtSK0oLfjux
         QddA==
X-Gm-Message-State: AOAM533r7kwZGsvjk3oLLjtg5gLTDSQL5wBJA9weY1OIK3ExpikBqmhM
        889O6YbeBnZe8YJekXTxGtjpuMl8ou4pNIJ374xI9NOGerS5U4fyNDj6wocmcTwf6o2vGhvvowU
        tSthWAzYeqmoc6ttOvgD3iTCL
X-Received: by 2002:aca:ddc6:: with SMTP id u189mr7588023oig.59.1604244758892;
        Sun, 01 Nov 2020 07:32:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+yaDR+vmXW5TAdApQPiTp1L9iVD3d3dVF5lgdSEQY1at+uccJHMDpFE73E8hFXGFGVz0ZHw==
X-Received: by 2002:aca:ddc6:: with SMTP id u189mr7588015oig.59.1604244758770;
        Sun, 01 Nov 2020 07:32:38 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x25sm2943778oie.17.2020.11.01.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 07:32:38 -0800 (PST)
From:   trix@redhat.com
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nfsd: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 07:32:34 -0800
Message-Id: <20201101153234.2291612-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 259d5ad0e3f4..6020f0ff6795 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2558,7 +2558,7 @@ static u32 nfs4_file_type(umode_t mode)
 	case S_IFREG:	return NF4REG;
 	case S_IFSOCK:	return NF4SOCK;
 	default:	return NF4BAD;
-	};
+	}
 }
 
 static inline __be32
-- 
2.18.1

