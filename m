Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DA81CDBDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 15:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgEKNxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 09:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730179AbgEKNxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:53:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4375C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:53:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so11043378wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=FE5d1H+JCXwrPfWWVUSjdCEORrTF5KH5QEwN0eKZ5RekgQ9yCjVJRgfUBSKFVvI0kk
         IQDaQaLZECPBBUD1IEuB//5mRQ5kDvCw+yZuWq78HFJ/AQnA/PcdMKnAFS8nxzDq7gk7
         bUfIsRuqNr5F2CwE8s8BLhDJ3y/Bkdz5o+0esyL2lnasdMYxIUY0YemT4ZDCkgZM5iD3
         MYcETM3NiBlFLnHlUAtcnPL8OCctyMZmTu0og9i5DB6UCg0OoZrfhrbyyFFdgU3VPhsC
         xBWwu/kllU39dID7325H2WRqDuFMFIlSOH19oM3WtmRfISXMJu6PL++RT1d6oDehHbNH
         KkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=fzjfmAqcMFS7BD/xGbUBCIIvwK/eZ2F4PxRBw3w8JIG+QohRDih4ab7b3Igka6/Ts4
         P0m94MrHHV7ecHrga0DBzA5mr5tjN5t2jxGiv2m3lx9uZzFzgy1OtfrtiadgEwsj9Vuq
         qVSpIrLHSjOSZv9trrpgjPoYZPuCb32cIuwz8NiQM+F5iy9aopGnjrwUKHDpLDrNWXVg
         mwyB65DClp4c7xhYXUfB04Ijlf0yI5ZjKYN5fWm7uTJFBR6EC/0q6JITOk4saOWBNbd4
         A0RNf87A1p3Sk12VDrZUxqTaSnhbfmmdKgSJB2UKVX5xNROnHvy2AWRFfaceJBfSRFHb
         ORjw==
X-Gm-Message-State: AGi0PuZdE985Aj+M5IW/AteFuxy8kSDgiV0VX/ZfG6O4SHcK09SMkRlj
        nUPfcH/hFKD8HZKV0i4JRSMz
X-Google-Smtp-Source: APiQypKLR7w5vtkQydqOzRJhjmHfs8vunCC7k4wUj/rDfBqhz40FPYcftWjvftN1NJnhpSr26EDm0A==
X-Received: by 2002:a05:6000:1045:: with SMTP id c5mr4880337wrx.31.1589205186193;
        Mon, 11 May 2020 06:53:06 -0700 (PDT)
Received: from dkxps.local (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id v205sm9220018wmg.11.2020.05.11.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:53:05 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v15 01/25] sysfs: export sysfs_remove_file_self()
Date:   Mon, 11 May 2020 15:51:07 +0200
Message-Id: <20200511135131.27580-2-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
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

