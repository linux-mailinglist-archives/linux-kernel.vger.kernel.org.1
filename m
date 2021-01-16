Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5052F8E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbhAPRUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbhAPRUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:20:33 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26875C061573
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 09:19:53 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i7so8163632pgc.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 09:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CStLKt4XFMfuxZea2+GjDkCtdNe09x7PTfiHnBFMo64=;
        b=Rxi/VSvmtr3Dd4fQJwZfow2M1tDFpF8ahyHG/rYNe2rHWVb5f6/3yj6kFrgX2Ld5VQ
         JkypfrqZcdZ7vC8VOT6/vWQBSDwlUqsxPu1F+fur1FA9iZVVZ2nEclZHVzkA7HuAFYc9
         i6mRMUOaKDzcL7/g9QGEih1kYzYl9Rpl52GJ3Lp/dqkJjBv9Fuo6m6Dw9UcehzFqS3i2
         GymWSrIdfDYIZYFQbvdjWEWth1Ao6PIhPhOD1606Z35nfUzJuDvR6/Z8mNI2mVqMctSJ
         EwXuAEnTiMbxzd6jbBD29iBwAdpu06gywvzR7gwuKIkZ/97aTi1Od3Zqbk7h8x4gdGV1
         BYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CStLKt4XFMfuxZea2+GjDkCtdNe09x7PTfiHnBFMo64=;
        b=N7svaLLzc7WQozLjmdkNuNCS6uMHe9Ffq5yFqT4RS9er+a7C0D1ji+xyAdhS57Tp8D
         aKFYhKLQbIiPgQrLu94j1SXP1G7HIVINtL2xzpixZ/3q0hFTT18ilpIsGg6d252DyKcR
         4gUFxf1SX0IaTWSzk2aV1FpQk/rgraAbFfwbG/dbnuEUfwcexFj6nmEOSfI7KHXOSTaZ
         SQ6Soe7r7K5bjNlw+xGdZmJ0tRXcOcxCraT1ZtsTJaVOb+mFhdx3aQVC6egLD/2v5UP1
         F9tC+rQnSgX7/k8UTrivgexhM6l/AXXtcBhz7teM2HLFFmpZgMw836Q+Az6uz95byGWx
         hgXg==
X-Gm-Message-State: AOAM533NNiaOnY4p/+avDdKG19DD1Htphlc3Ny1ut6QuvepF6QAvj7NO
        5TS+SO5AfPxxkK/Zy/DV3uftFiQ+ryQ=
X-Google-Smtp-Source: ABdhPJyo7761B5w4B4vQfwBuVUXl25lFhlurW44tLF2LNRFIprjV3m66mGLfjyYpheFF4xathBy7VQ==
X-Received: by 2002:a62:d5:0:b029:1b4:144c:f217 with SMTP id 204-20020a6200d50000b02901b4144cf217mr7439883pfa.13.1610817592533;
        Sat, 16 Jan 2021 09:19:52 -0800 (PST)
Received: from localhost.localdomain.localdomain ([115.156.140.39])
        by smtp.gmail.com with ESMTPSA id v11sm11515456pju.40.2021.01.16.09.19.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jan 2021 09:19:51 -0800 (PST)
From:   HongweiQin <glqinhongwei@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     HongweiQin <glqinhongwei@gmail.com>
Subject: [PATCH] In the current implementation, should_check_rate() returns false if ddir_rw_sum(td->bytes_done)==0. Therefore, a thread may violate the rate if iodepth*bs > rate.
Date:   Sun, 17 Jan 2021 01:18:43 +0800
Message-Id: <1610817523-6789-1-git-send-email-glqinhongwei@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses the issue by not checking td->bytes_done in should_check_rate.

An example of the issue:

[root@localhost test]# cat fio_randwrite
[global]
thread
kb_base=1000
direct=1
size=28GiB
group_reporting
io_size=16384
ioengine=libaio
iodepth=2
bs=4096
iodepth_batch_submit=1
iodepth_batch_complete=1
filename=/dev/qblkdev

[fio_randwrite]
rw=randwrite
rate_iops=,1
iodepth_batch_submit=1
thinktime_blocks=1
rate_cycle=1000
thinktime=3s
rate_ignore_thinktime=1

[root@localhost test]# fio fio_randwrite

blktrace output:
259,1   11        1     0.100550729  6135  Q  WS 3541608 + 8 [fio]
259,1   11        2     0.100552183  6135  G  WS 3541608 + 8 [fio]
259,1   11        3     0.100560373  6135  D  WS 3541608 + 8 [fio]
259,1   11        4     0.100570436  6135  C  WS 3541608 + 8 [0]
259,1   11        5     0.100599816  6135  Q  WS 43470024 + 8 [fio]
259,1   11        6     0.100600513  6135  G  WS 43470024 + 8 [fio]
259,1   11        7     0.100601579  6135  D  WS 43470024 + 8 [fio]
259,1   11        8     0.100612750  6135  C  WS 43470024 + 8 [0]
259,1   11        9     3.101034407  6135  Q  WS 49511928 + 8 [fio]
259,1   11       10     3.101036067  6135  G  WS 49511928 + 8 [fio]
259,1   11       11     3.101054487  6135  D  WS 49511928 + 8 [fio]
259,1   11       12     3.101068699  6135  C  WS 49511928 + 8 [0]
259,1   11       13     6.101267480  6135  Q  WS 27599368 + 8 [fio]
259,1   11       14     6.101269216  6135  G  WS 27599368 + 8 [fio]
259,1   11       15     6.101277050  6135  D  WS 27599368 + 8 [fio]
259,1   11       16     6.101287956  6135  C  WS 27599368 + 8 [0]

Signed-off-by: HongweiQin <glqinhongwei@gmail.com>
---
 fio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fio.h b/fio.h
index 4d439d9..f5b3990 100644
--- a/fio.h
+++ b/fio.h
@@ -767,7 +767,7 @@ static inline bool should_check_rate(struct thread_data *td)
 	if (!__should_check_rate(td))
 		return false;
 
-	return ddir_rw_sum(td->bytes_done) != 0;
+	return true;
 }
 
 static inline unsigned long long td_max_bs(struct thread_data *td)
-- 
1.8.3.1

