Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6197422AF31
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgGWM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgGWMZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F8FC0619E4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so1406500wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=euKwHTd5nmGQirdNec0wmJhbD/rOPWNyEyTyNJ+qI+A=;
        b=JuFdS5y710xg7RFc7xoZiCn3DzeYwplfD9eeT3fvU2DpPlQMshxBMlcev/VDriTtJJ
         lKufu0zDWWI/ezb59IYeT/E+7wBz15on/r6th+k5L/Za/YFBwe9mI6wtT3PSaU+s2T4G
         myg2wIS9618YPDyhloZNL2Shbjd+1eEqJswxvbHS0/zjY7xN5toWF1RZNhmbgURGYfQx
         kw6ANS46TLW3b31RdSdoX6gKzbPQ0T0n4/1CWWeM9GPx31A5eNNnvRyK+AHP8ml3YamA
         6yAD7+vqbH+BOwdtHWk3Jbm36PhITyiTmBYNHVleZfKr/ZjjTHFRPNqhR1fS3xHhDtm/
         pvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=euKwHTd5nmGQirdNec0wmJhbD/rOPWNyEyTyNJ+qI+A=;
        b=QPJWlGmiI8p6bijQC7xhIkMMa+RJCZ2IB2VOypgNgMKAelq+TsQSFJEMBI37OxTc21
         grSJnt7uGjV7LeBKM7OMs64z+aoSE2l+VJupcmFCucv5jD0RqRt1cWGF4H3If2GDaSXm
         bSLjK+hvSbaEVCF4Zq0vkSXquPF3lc7O7n5ZdvUSERJmy8CPstDZjlC6r8IkivzIbtqX
         VONomJDe/ZQm1Mx3Q6HWDmW2Tg+Ca0BEJw8UKUTYAce/3Hi3udxaidHXbz11jkFYm7FS
         fvErsQdUYyROwnKe1/YegI2WYD5WdKTWd0amMOh4SUKzp7E1vIs5bpu3HYifc4dYqzGu
         EKgA==
X-Gm-Message-State: AOAM5300hoacqw9h/xwYySzSTGfMBrjAetWzQgul7Jca3H4uwMXajZw1
        LzdLGhGY1OlCy8phpc94+DFYiw==
X-Google-Smtp-Source: ABdhPJzSBVHJ88f6m8bQEuFIRyRwgvryu7g4a5wAFl3g7lEWHef74sdfGzIDj1FOc+h2tgj3hX3Itg==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr3736372wrn.51.1595507118682;
        Thu, 23 Jul 2020 05:25:18 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 24/40] scsi: csiostor: csio_rnode: Add missing description for csio_rnode_fwevt_handler()'s 'fwevt' param
Date:   Thu, 23 Jul 2020 13:24:30 +0100
Message-Id: <20200723122446.1329773-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/csiostor/csio_rnode.c:869: warning: Function parameter or member 'fwevt' not described in 'csio_rnode_fwevt_handler'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/csiostor/csio_rnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_rnode.c b/drivers/scsi/csiostor/csio_rnode.c
index e9c3b045f5875..713e13adf4dcc 100644
--- a/drivers/scsi/csiostor/csio_rnode.c
+++ b/drivers/scsi/csiostor/csio_rnode.c
@@ -862,7 +862,7 @@ csio_rnode_devloss_handler(struct csio_rnode *rn)
 /**
  * csio_rnode_fwevt_handler - Event handler for firmware rnode events.
  * @rn:		rnode
- *
+ * @fwevt:	firmware event to handle
  */
 void
 csio_rnode_fwevt_handler(struct csio_rnode *rn, uint8_t fwevt)
-- 
2.25.1

