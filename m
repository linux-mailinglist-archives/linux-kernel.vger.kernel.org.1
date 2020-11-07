Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31832AA345
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 09:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgKGILz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 03:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgKGILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 03:11:55 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941F2C0613D2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 00:11:53 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id 97so2241496plb.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 00:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=zIepqu5/kHd0BQ24VYrLjVuZ9zG/2BQ74NYjRDAUWZk=;
        b=h9pkFZyLB00WFqfhQWIrex8QbgyMxv2aGiLaAQD6RWUvp1KCihBehoqFvRhmzkEaLz
         +PMY8hbu+9mOTcmczSVH2lXRLMEvG/LaOcKj2vY5XdvrXzqJrQJDabu9lm2kCONypsBU
         BDnF7HEiG1hiWUdyhCJnoS6m5qenuZhyLMA6QGUIh553vIK0g7R2zVKGNl8cJ1ILoKGm
         WkD3bf65biqhtohrgQssuBKC1UN/6Xujs1QE2LoJ+EZo8BXdZPtp8cNgt/xo0ZfC93t3
         n+VJvZJMgu5CPZ101GTYuLwvUBeipGzdk+5ZUIi9Xisn+jRa3M/k51/DD+Dg3RPdfAm4
         5SGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=zIepqu5/kHd0BQ24VYrLjVuZ9zG/2BQ74NYjRDAUWZk=;
        b=DN1XZSPPDqT+7+0DoYHyeq/Rt307Rcvsi4JpVetBuBttpT2FygOP0gRsYV1k6vNkOQ
         h/LJ7oDwshuClsE8YhIXWxZ0BiQhRbjqfo5v8OJg8M6PQo4wNa2C3uNLIp7xC08bR+ZN
         by0ZaKjEsHtEQ3d3PNoL5MwhMNCNEWyylXoSoPQDxxY41RD7qMMlMTpcOihlVaXuU1TR
         o4O+pVrpN0Ed71uYuV4si6IJo5+B2Do56Y0r3gFNIhv5Yi8hHfuBCzJQbGh1+yuLYODd
         9dXpYgZbofu23AurDdLy8328csogAT9WMkvy9291Mut/IRalPS2rWTJ4z1MlxupROTTu
         mqUg==
X-Gm-Message-State: AOAM533e2KM9RhcZLgqtKvzI+oBeg0O7qBDLKNDQzruG/xgHM12vizuJ
        /BzTSfgNwVO1ahFnJvB8bbIdG2mPtPWe3OI/JKE=
X-Google-Smtp-Source: ABdhPJwEL7T+O1e2iauW1GrgFhIHR8xYyqNtRH+/uGQ1qGcXanxqYu0SYiKnNOYEtcAGNqjtw9KtVJba8Qd+Nr5eYio=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a17:90a:9dcb:: with SMTP id
 x11mr3322415pjv.132.1604736712313; Sat, 07 Nov 2020 00:11:52 -0800 (PST)
Date:   Sat,  7 Nov 2020 00:11:32 -0800
Message-Id: <20201107081132.2629071-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] scsi: core: fix -Wformat
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang is more aggressive about -Wformat warnings when the format flag
specifies a type smaller than the parameter. Turns out, struct
Scsi_Host's member can_queue is actually an int. Fixes:

warning: format specifies type 'short' but the argument has type 'int'
[-Wformat]
shost_rd_attr(can_queue, "%hd\n");
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                          %d
Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/scsi/scsi_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index d6e344fa33ad..b6378c8ca783 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -370,7 +370,7 @@ static DEVICE_ATTR(eh_deadline, S_IRUGO | S_IWUSR, show_shost_eh_deadline, store
 
 shost_rd_attr(unique_id, "%u\n");
 shost_rd_attr(cmd_per_lun, "%hd\n");
-shost_rd_attr(can_queue, "%hd\n");
+shost_rd_attr(can_queue, "%d\n");
 shost_rd_attr(sg_tablesize, "%hu\n");
 shost_rd_attr(sg_prot_tablesize, "%hu\n");
 shost_rd_attr(unchecked_isa_dma, "%d\n");
-- 
2.29.2.222.g5d2a92d10f8-goog

