Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFC4273FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIVKbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIVKbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:31:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0DCC061755;
        Tue, 22 Sep 2020 03:31:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so12034844pfd.5;
        Tue, 22 Sep 2020 03:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/HgkdPfwvx9hh+ecBAVGHQ12vx6oJVsY/D1hoj+iSw=;
        b=dDn/CygKuT/cyzJ653BoeDbc8tMs8JGPl9cJTnkBnqPrn6KD6JuIcd6Z6R6j7Tcbwq
         gfHocxme2l0h+bH/3F6E8Xe8DEbH8IuCkksDDXWeHkzgufezRBnoaEL/l3hKdeQZZdSj
         2OnTLrSVqugDqWGU0C1N+dI+nOeMo832g+xP1LplaZ4+0aOj93QpMsK9Ydb6I56oMoZf
         3BVrWn/3vH3BfyG6/F6Nxq2cwwtSwB3mNQFVTmzJaz8B9QtjsE+0nXgAHYFT7FwdtPFZ
         9OWzllYjuRsj+7P1935RxKgrug3NthNuRjO79LWaDIgR/b6GtTYHgYBoJ+U4oJQlABJR
         iWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/HgkdPfwvx9hh+ecBAVGHQ12vx6oJVsY/D1hoj+iSw=;
        b=mQU56x8T42rJU0QxeG7WxgLbiqTCmx0tS8GiNGr1N2ta0gbZj0bAbv++9zDk0jsvsz
         C8i+7FzKO+iyiRdv1nTsG5Mc+wL4rc1CoisWsWa+mKOKrb9tvfgDvmmwEdUC+1spqyMw
         V/jhllYm96foUzhALBcpoefl1kuogJ8uN3tb2zZkOaBMoyKWztpfrgBOxINzks6AgWq/
         nLO3fhX32M3K7mYegJYrUMveSfFi7DpQLaQAH9jhQXlK9pk14e1oNQHlsSUgKhF9BU38
         X1YIcf8JAoXqWtCtvrbb7MWhS5hK+uMV/qIQUWxpIYwkVSpRb0xHEVARHwg45miEBnI7
         eR3A==
X-Gm-Message-State: AOAM532Pwd+HtEKb4ABxlmhLNTKtcEmx6yyc9V7Kka/FUBorNzTQmPqN
        zs+j3k4BMt6ZH6Uf9p+mu/BgaJHMGFM=
X-Google-Smtp-Source: ABdhPJwQBJ0OLn099skCFqE66FhmGKV43joXIdjsjthd+TU3R3U+LSfgsRocpGip6qE2yNgSKtZQ2w==
X-Received: by 2002:a17:902:a413:b029:d2:1fde:d2af with SMTP id p19-20020a170902a413b02900d21fded2afmr3855104plq.56.1600770676596;
        Tue, 22 Sep 2020 03:31:16 -0700 (PDT)
Received: from ZB-PF0YQ8ZU.360buyad.local (f.a4.5177.ip4.static.sl-reverse.com. [119.81.164.15])
        by smtp.gmail.com with ESMTPSA id 203sm14589028pfz.131.2020.09.22.03.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 03:31:15 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     freude@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        linux-s390@vger.kernel.org,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH] s390/zcrypt: Fix a size determination in zcrypt_unlocked_ioctl()
Date:   Tue, 22 Sep 2020 18:30:59 +0800
Message-Id: <20200922103059.859-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With new ioctl(ZCRYPT_PERDEV_REQCNT) introduced, kernel use dynamic
allocation for the 256 element array of unsigned integers for the number
of successfully completed requests per device. It's not a static array of
64 elements any more.

Fixes: af4a72276d49 ("s390/zcrypt: Support up to 256 crypto adapters.")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/s390/crypto/zcrypt_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 4dbbfd88262c..5c3f3f89e2f3 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1449,7 +1449,7 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		if (!reqcnt)
 			return -ENOMEM;
 		zcrypt_perdev_reqcnt(reqcnt, AP_DEVICES);
-		if (copy_to_user((int __user *) arg, reqcnt, sizeof(reqcnt)))
+		if (copy_to_user((int __user *) arg, reqcnt, sizeof(u32) * AP_DEVICES))
 			rc = -EFAULT;
 		kfree(reqcnt);
 		return rc;
-- 
2.25.1

