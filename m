Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BD22186B9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 14:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgGHMD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 08:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgGHMDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:03:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDAAC08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:03:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so2759150wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERoz3fkdfBzQNDlM4+cYEX1ahP8otbMKTg0c52YoDQM=;
        b=BQfkrIMLhcq2bpyg8GI9z9uvky9LxtnORcYZhT+HkKw3ytxk/0Ay4nbGD7kwBmp1o6
         N3fxA9DiSNExlEt2oSAxsnQiJkkxThmoA6m7fFYCEu4hI3GrEo8XPwyw/a1Se1oHPz7B
         eHmAxZnQvSXjYkWZ8xLqfBCeE0BYZTDzM/wnaRamU/If4Or6GkR+V+kR2lznDPNqvYPW
         91Tyg4okajt6CHPVTLyJ5mjmPV0YNdivt77C2OUVYNqZy6H0sBNFZCVbOOfzq0uwO3o/
         JTK4tmuz2+WFCkAg3US1BBmXBHYNTM59CcMm+uKePPWUBkA1L9RL0UbMTvL0AHRda0FL
         qhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERoz3fkdfBzQNDlM4+cYEX1ahP8otbMKTg0c52YoDQM=;
        b=m2Wx4IkyoTU3vwoHpBnYIeJe8/rQOBYPeGXS1e4vh4Yo83JFAJuc7RxXYSDH3B2akb
         C9QRp+Nlgss4LCZvphz8hpl4IXQIAuHlAdxhuhb0ZJ8x9Dne9vdXlChdsXJqy/dHOiai
         F2GXgAyNOfi/TkL31t0vy5243dv/G5jSuFNtK0tHpsRdmCMtHboj0brNrdT3EgHd/031
         cyOML8LZZPFdFGOR2SwgqFWwwyrHVB/8Boy0s5d0V+b9pZsMs+ZrXYksnD+S50EkyOi6
         Ne8oTvkt+ok5KnFaVh53nxNLxHhrUF/XXM43WRjAMqrXje8wv/Qxj9w5datyJ79ektov
         wxNA==
X-Gm-Message-State: AOAM5327EHzWvfBVSmK8Ke8M/kqyh89NRvM8bLqGbweXiYkegc+Qo0Xp
        VNUrLnV+Rtx5wZVOsXaj8n2K3tAFbsk=
X-Google-Smtp-Source: ABdhPJzT8YdDaUodEHbCCXJeTOYOV4BqAXnxN0Y2LVKcQ+xGvSsmtq2rXCJSexfhZNek8Wi4fPWdBg==
X-Received: by 2002:a1c:4d04:: with SMTP id o4mr8741190wmh.132.1594209784342;
        Wed, 08 Jul 2020 05:03:04 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:03:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Luben Tuikov <luben_tuikov@adaptec.com>
Subject: [PATCH 26/30] scsi: aic94xx: aic94xx_init: Demote seemingly unintentional kerneldoc header
Date:   Wed,  8 Jul 2020 13:02:17 +0100
Message-Id: <20200708120221.3386672-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of kerneldoc in the sourcefile and no
descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic94xx/aic94xx_init.c:538: warning: Function parameter or member 'asd_ha' not described in 'asd_free_edbs'

Cc: YueHaibing <yuehaibing@huawei.com>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic94xx/aic94xx_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index bef47f38dd0db..a195bfe9eccc0 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -530,7 +530,7 @@ static int asd_create_ha_caches(struct asd_ha_struct *asd_ha)
 	return 0;
 }
 
-/**
+/*
  * asd_free_edbs -- free empty data buffers
  * asd_ha: pointer to host adapter structure
  */
-- 
2.25.1

