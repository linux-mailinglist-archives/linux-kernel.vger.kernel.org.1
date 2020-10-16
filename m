Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B4829056D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407820AbgJPMqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405095AbgJPMp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:45:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F147C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 05:45:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u3so1447293pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 05:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1evu/uCI+QRNY7SsK/no8njk1hcUqNItCkuJRC3dLc=;
        b=xCglPQVh3uc2/EcXbuONJAMpl3eRtAkldgrib6XbBiKmiqFboP4mrxqB3XKvmyML2t
         L9QK5x65jCp7F9T7lv7UfCAznFLwlyTRfJt2fM03kdhw1JI6DH6TVr5Lx6nBw5nljyTN
         OdCnpsw2/yC6Ty1P8Muc2ds3bUZXgimXWmXi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1evu/uCI+QRNY7SsK/no8njk1hcUqNItCkuJRC3dLc=;
        b=gGTslwfwkcOP/AwimSYZFGUtE9GnTGA2kRUF3NiN7vCo1y9AcieXnDUlBr4etff8Pl
         ubL7sVtBVLw+0oViAdHk6ha4FAzGJNeR6mRR5dBcZwHTtO65RDAoY8eJyjhVc97HK+Is
         YvMjJ77Jl5M4ssGaGkWAhWvzdhaFz5OSpzKpu+AmCGPMdUn6i7JgdK52zrPxONiK1Ylf
         Ht8saFCavuo0MJpm6XOOqym+eC+4168m5uyFA24qsVFsCcWja3+eocEOV7CIR1C2byeN
         YKtdXqj1smbW9dkL4QyxiUcdI8/8RrYFfeqGqv/GHtRH3OiEqrXn55+C8kT/48JviE5z
         rn/w==
X-Gm-Message-State: AOAM532zWmBhIdXu1jr3S/GTKVHGpMcTJa9GBzN5xiqXAoQf+7hA/YYe
        CgIdseJjP2DO482DFMmuTvStdw==
X-Google-Smtp-Source: ABdhPJxo4t9bHKXFNNwhW4adl1rskGMnIohne6crnWi1t7gHuVBHRDAwqYw4qmZN/etpvhxC+f1MSw==
X-Received: by 2002:a17:90a:318d:: with SMTP id j13mr3920577pjb.209.1602852355655;
        Fri, 16 Oct 2020 05:45:55 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id q123sm2906732pfq.56.2020.10.16.05.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 05:45:54 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 0/3] NFS User Namespaces with new mount API
Date:   Fri, 16 Oct 2020 05:45:47 -0700
Message-Id: <20201016124550.10739-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds some functionality to allow NFS to be used from
NFS namespaces (containers).

Changes since v1:
  * Added samples

Sargun Dhillon (3):
  NFS: Use cred from fscontext during fsmount
  samples/vfs: Split out common code for new syscall APIs
  samples/vfs: Add example leveraging NFS with new APIs and user
    namespaces

 fs/nfs/client.c                        |   2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
 fs/nfs/nfs4client.c                    |   2 +-
 samples/vfs/.gitignore                 |   2 +
 samples/vfs/Makefile                   |   5 +-
 samples/vfs/test-fsmount.c             |  86 +-----------
 samples/vfs/test-nfs-userns.c          | 181 +++++++++++++++++++++++++
 samples/vfs/vfs-helper.c               |  43 ++++++
 samples/vfs/vfs-helper.h               |  55 ++++++++
 9 files changed, 289 insertions(+), 88 deletions(-)
 create mode 100644 samples/vfs/test-nfs-userns.c
 create mode 100644 samples/vfs/vfs-helper.c
 create mode 100644 samples/vfs/vfs-helper.h

-- 
2.25.1

