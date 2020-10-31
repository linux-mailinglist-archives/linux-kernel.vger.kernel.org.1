Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A082A1884
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 16:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgJaPXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 11:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgJaPXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 11:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604157793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=/pSbDKA3NkOJTxeIT+wqNFcqFgPstuS5EsTG3/3jClk=;
        b=LNB/n20ZseZqTsI63RIYDbgdkYUTpRE87lK08vH+4YBPQNMqUUbF+36tsezi5LXIVS1YWO
        lpP2CiCXWWJKWV6Zxn+aNRWAXBzFG0vpMO+43rptZrLJiU8jjZr5YuArBEg8qAlNkxs9lX
        7GZHvxMHqs6fj1AMCzsDwoDObQdCNkc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-NZUGs6XRNN2Sq7SaoyjUjQ-1; Sat, 31 Oct 2020 11:23:11 -0400
X-MC-Unique: NZUGs6XRNN2Sq7SaoyjUjQ-1
Received: by mail-ot1-f71.google.com with SMTP id a1so3883421otb.14
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 08:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/pSbDKA3NkOJTxeIT+wqNFcqFgPstuS5EsTG3/3jClk=;
        b=OUOkCKnEDqkXEcxNP+3o5JjGO2E4Cb1JzXrKqgOYaGHmSFQeNivpvMdsu7D7qUDElz
         7dOs0hydSS57FUqeZI82IgEeM2NV+nMjeAbHfRy2xunwbH7b9ifjGc3gTGS9LFc3j7F+
         vW3ZuZbJPZ04j7ycs3xaWiYrGcAaG5YxFKJYkDXEbjZqVwCv7mAitywuJTSDv8OdhKyi
         T3F6OPhdKqEsmNChFo3afLfaFrsdAI/s/iMjpVMSFqlyAehM7wOEpuMwTSjpWXowHAnO
         9o6g3YjFsfNzCth24u06HGYkcvmPpsHjcf+8NlqgAlV4S/ygBaOXzmWDek/jf6ET26rw
         Hl8g==
X-Gm-Message-State: AOAM531Qx+fXiL2Qcy7YAxBx5ZHR3ZHCIiO11AFNg3iPiTrKSLOSFnPW
        cF9HQHRyjUU/L1rFxstccWVKEkg9eMf/XwUL3AMoFJV4pyW9GPv/rARh/jjEukcCFPMX9VYmhfh
        WbcSU+s75DhsEh4k18NVQIr4D
X-Received: by 2002:aca:cf87:: with SMTP id f129mr4958182oig.62.1604157790965;
        Sat, 31 Oct 2020 08:23:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpBCOrgw2CnAf1M6TaOSeEDj45EdQ4zqge2NjSarB8M4pmZ1dB1Ez2DgxHxihLB0cE62codg==
X-Received: by 2002:aca:cf87:: with SMTP id f129mr4958178oig.62.1604157790771;
        Sat, 31 Oct 2020 08:23:10 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p10sm2246842oig.37.2020.10.31.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 08:23:10 -0700 (PDT)
From:   trix@redhat.com
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, qiangqing.zhang@nxp.com,
        sherry.sun@nxp.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] mic: vop: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 08:22:58 -0700
Message-Id: <20201031152258.2145680-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/mic/vop/vop_vringh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 7014ffe88632..3ef8c63e5cc6 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -1010,7 +1010,7 @@ static long vop_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	}
 	default:
 		return -ENOIOCTLCMD;
-	};
+	}
 	return 0;
 }
 
-- 
2.18.1

