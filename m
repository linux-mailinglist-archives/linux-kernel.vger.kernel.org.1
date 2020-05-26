Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624801BA5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgD0OLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgD0OLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:11:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05E3C03C1A8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:11:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i10so20719801wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=bAHQyR+2H/NT4ao1Xoqb0ve9bvBgahVQhsQG5LSWK1DAXQYhtdVnqI3RX0dPBtsDNm
         ZwAMhxkrV0oTCnGPizYLnCjimAuEtU4QPhMFy5lquTKUod1H7i16YRRtvGboI3VM9VPT
         aj7JTeBhw3oHjb3e/3dmRv98h2YU8Mlqex6FfUGMFRCOLoKxtWyFvVtKV7xVzO+HyDlj
         /n/ngBxN++bGUpzLQtCdn96ktXsHDdXtGMx8gc30dsbAfrtG4jzYvpV/TykcyviJ1MGO
         tqsRhtWTDwmiREzQalYaF3t6mH/OVb9yqw3WMOWzPafa3iiSspasH2wfqIKJg3imzAYA
         QNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=nFkW8PvVWeHYBwsOW8FsGvB05moQ0MTaM1hfGKqgw1jAYEY3Ircdm96368xZBkKC2/
         xfSq7qD8k+ARfyVFf04324MPeZi38+CzJPh99zyKKcfXtiPS6h6hVvM8tGLVG1LFZkhX
         N8ZorCoqUQsul9e6BXeAvRYKEUi77mP5HOGQu0GZe8besSQ+ePu4zKzeuaeSU9HVgd4g
         iNpeDHOIJJVPOzIXPFJkNYxNqFb11A5Ons2Ywiiuk1ntX5mefucT+DpEq3ZA7Q8x/t8i
         I2dqSFmxX7/Fgq3cUVHHhfv9a8pReHWys/h66cjtfGNWcV8EFzcLdliCdDcQFzKK/HFX
         hwlg==
X-Gm-Message-State: AGi0PuYm2QsUswYpdXbMAuSALJ1bnNoP6Rxx7yEhxc6u7gadDG/JFIPp
        +Tdl0ukvvOAEjpOrdau6vzut
X-Google-Smtp-Source: APiQypIdxbPq0Ip/4hH9CimyOIVNg8ufwRVZbjlJSM8QoQPnqNM+moQJCpFRUWi9Z4DN1ONvw4LiLg==
X-Received: by 2002:adf:df8d:: with SMTP id z13mr27551882wrl.304.1587996668573;
        Mon, 27 Apr 2020 07:11:08 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id o3sm21499756wru.68.2020.04.27.07.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:11:07 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v13 01/25] sysfs: export sysfs_remove_file_self()
Date:   Mon, 27 Apr 2020 16:09:56 +0200
Message-Id: <20200427141020.655-2-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Function is going to be used in transport over RDMA module
in subsequent patches, so export it to GPL modules.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
[jwang: extend the commit message]
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/sysfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 26bbf960e2a2..d81f9f974a35 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -492,6 +492,7 @@ bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr)
 	kernfs_put(kn);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sysfs_remove_file_self);
 
 void sysfs_remove_files(struct kobject *kobj, const struct attribute * const *ptr)
 {
-- 
2.20.1

