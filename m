Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2235F22AF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgGWMZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 08:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgGWMZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDE0C0619E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so2012111wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zt4gQ5fBquDOsunevc+xn2q97qXGNvH/uHrfGiyo69A=;
        b=Phg9qHMV73qlHdXhbakwTt6Vb+7ozqNYazBc72hJL/WdpwWv+ovB7Llu1p8IIVxpt3
         qSeAXsvji3rtYgDMJT+kESSiOxr/HYE8PLq4UpveLCEf2NBvWTmCHkuSWVgH34e5NXpn
         nxhFDKkQptRrXCFT7j1+Fpcf3CG6/cQAi9S5fJJlhJW1GbU37o5rT6rGyx44X4pnH1iE
         kYn2fVn0+Jfa74Qvn/Cl+jYSqWly6gPiel27OMYykJ1EkP7rciIe0IOOBaMHYoJxyF+b
         ShVbMaJVKAJNpjzXMgMZtwTzmdYTKYk+rqBSpG+EDKiIm3IIVmoA0/ONF2nflNJIHgjs
         5K0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zt4gQ5fBquDOsunevc+xn2q97qXGNvH/uHrfGiyo69A=;
        b=ecOUp5b/66HxO9JXk3CzouXNhQLahDHBWp3xPvSJYU701KUtaNkzUd/S5n2N546Blw
         FL5ChjXa4ItbloeQaRAq2HOYcz+4l4COxwd77lLQMg6BHhGAiIwVcP0rx6is+m1LTtS2
         EVn+QSwTGuo2s7TXXlC2xNDBk4xrnOEfgeUpXRSUrcvt+pQr+mjJPPYpb/M5ZsxM/w8+
         EM4CoV+OiYHThD3Fy+jt3FFKMN1DofTaO9mOuZCdRsG/KytOoj/MQ8stxmKkDXYWIiyv
         7D2NgyfYpsf5y7fFi1W8cQmVNuZE2FEHfb5B+OeObsQdkcj/MYcRaketEyUiV2eS2/IK
         CoYw==
X-Gm-Message-State: AOAM531BWIR1bcG7eLWd/bNUpQww1GW/oMf0c5m6P92Y6XzOcz8dgf5X
        zRWbrxFfpJ3BjvwWOpOjXzy+yaZKLkc=
X-Google-Smtp-Source: ABdhPJyfTicJl5ewFF503iUoLLoflgMDe4eIajSk2w6TXoQayLk/F7If1jxpAb/Ef4jZheNv4PAA4Q==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr4146529wrs.124.1595507137010;
        Thu, 23 Jul 2020 05:25:37 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Subject: [PATCH 38/40] scsi: bfa: bfa_ioc: Ensure a blank line precedes next function/header
Date:   Thu, 23 Jul 2020 13:24:44 +0100
Message-Id: <20200723122446.1329773-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch warning:

 CHECK: Please use a blank line after function/struct/union/enum declarations
 #129: FILE: drivers/scsi/bfa/bfa_ioc.c:6913:
  }
 +/*

Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/bfa/bfa_ioc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/bfa/bfa_ioc.c b/drivers/scsi/bfa/bfa_ioc.c
index be48a7e31e803..dd5821dfcac2d 100644
--- a/drivers/scsi/bfa/bfa_ioc.c
+++ b/drivers/scsi/bfa/bfa_ioc.c
@@ -6910,6 +6910,7 @@ bfa_flash_read_check(void __iomem *pci_bar)
 
 	return 0;
 }
+
 /*
  * @brief
  * End flash read operation.
-- 
2.25.1

