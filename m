Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B292A9F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgKFViT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbgKFVhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:15 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8EEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:14 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so2741655wrf.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaSgExpL1nCtBP1Xc6kSLtHGXCrLErSmtz6Y4QPAfFg=;
        b=aNVC/iF54xkzO7atep0e+rHrJs5H8vdttLCxQgziSDzLUa32WiOQ8huCGi8lAShbNF
         1Yaw85GeA4HE3QUJerIxjFqiTZ/wNriR/RNO0dDgOnn7EL+k2V709I6RbVXVdTtqMN6Z
         HSo1v992TIEiQanj21vvgS7yw0LleNcyKWUy2ohMzI9Y6v7sQ2n7pH1ER96gq83QlE5q
         6gqd8A0tamr6kPYlM5QTjQVxtP5sIkbNTcqutvabpV87c0eefSkyHSAGkqhPVW8J+1tJ
         0SLAgkYeAhj7OxE84gc/yYK4e+VN3KR39yx2SETPxrxjOlBr4nVDJyVh9oFHQM99N1WK
         l8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaSgExpL1nCtBP1Xc6kSLtHGXCrLErSmtz6Y4QPAfFg=;
        b=EkzDLNWr3LSDLbB+NqzzBCSfh7NT4yE00+CJbCxltmy00jXjWiAVkcVV96w8XM2ZII
         ydNVbnQRyDaz2ZeH/dzpXLyFUakyg6W+bgQC3OpYfe6W6OEGR/gANqQPHJoiWEbJeDBE
         3lcFpwec/EwzXhf+KDidaACmQgIPGvBvaDtGz2gIIgls/z9OS767+CGLSs1HFF/9visX
         PSEc+UM+7nnaPqMmxaMkjgqvA/V/NsCDDEzbPwVnP7m1gimQGIUDkesErPe20pGrvyEf
         8ghYy4SeaX6GEVzK/tOebi7AjhfdYPy2FNx1OJ7Y1BqMW2VauNrUTm6kTR4Eov6epkCA
         nzlA==
X-Gm-Message-State: AOAM531yaBo4Ej1Xpd8p+PeR6/1LrxMafpPczr2r5Iy7Q+CUZ5yL+ml2
        3pGOtcsXTHOE5rDclj4DgflScQ==
X-Google-Smtp-Source: ABdhPJxuW6c6hva5Qax31KQzZv2lyQK5NzLtARwyRUuo7ykdcZ3ZVGCORJ5BMc7Be37NKczsp3Ea0Q==
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr4999613wrn.188.1604698633540;
        Fri, 06 Nov 2020 13:37:13 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 10/23] mtd: ubi: kapi: Correct documentation for 'ubi_leb_read_sg's 'sgl' parameter
Date:   Fri,  6 Nov 2020 21:36:42 +0000
Message-Id: <20201106213655.1838861-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/ubi/kapi.c:464: warning: Function parameter or member 'sgl' not described in 'ubi_leb_read_sg'
 drivers/mtd/ubi/kapi.c:464: warning: Excess function parameter 'buf' description in 'ubi_leb_read_sg'

Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/ubi/kapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
index 9718f5aaaf694..0fce99ff29b58 100644
--- a/drivers/mtd/ubi/kapi.c
+++ b/drivers/mtd/ubi/kapi.c
@@ -450,7 +450,7 @@ EXPORT_SYMBOL_GPL(ubi_leb_read);
  * ubi_leb_read_sg - read data into a scatter gather list.
  * @desc: volume descriptor
  * @lnum: logical eraseblock number to read from
- * @buf: buffer where to store the read data
+ * @sgl: UBI scatter gather list to store the read data
  * @offset: offset within the logical eraseblock to read from
  * @len: how many bytes to read
  * @check: whether UBI has to check the read data's CRC or not.
-- 
2.25.1

