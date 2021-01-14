Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D262F66FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbhANRJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbhANRJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:09:16 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6290C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:35 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id t16so9206999ejf.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ce8RufGMICYlYAlJYGaB3yXNKzg7CcYfFFZ8BIcUQJw=;
        b=O2ZntgG/u2SXmGsgEuTbVgSoURznSbLDgJ/fE544Bbl7Y6Q9FUJ0XNT5ZLqe/kAhxk
         ADFUS+fYTdXOsI4lhMCMUCLHJm9zQMyohze9jA6u06/m53GAbkrURxE7LxxomaThuEfK
         8BW/hqpztVNW1tFLaml/AFnPZGXK18h0aQ6J0E+SWAUel+YE3jiocSdkOHMp7O31keCm
         Quuvdppo+vUNURU2wmB7bhmhH38PbBoIhkGhaCe0LIRorFQiVSrOJ5ZBJQeN0jrgT6GL
         lcLMMC3h7BAKqnwPFRCv1zFnqUqoHNOpHAWH5AbitFqRx+O3C80UskTvZXQizeTxilUq
         rEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ce8RufGMICYlYAlJYGaB3yXNKzg7CcYfFFZ8BIcUQJw=;
        b=rm5M22qkLlhABAoU/GPvSW4lYJvK3Xu6EhMYy3vCY1v9OI4JnUiTDoqeLluYGRKfSG
         81y+MNJlmgJVyautRO0jJp4T5tHxrLZ6AVLpkJmyMc8A4ZZvFkTrFGxQfeuc/BY3Y0mp
         SUW92hd1UBw30CPSws10BvgwOqsyzm5mYwmksz6ooEh3GbYENPwCqlzi+5F8mU2T0Tkw
         6ZiYYCs8NahBsYacAMZ0c1ojspT/cDsaEe7Dy/F39C0E0Z90lq7ntcEf0beS9ZKqmEK7
         rZ0sTXgi2XaFykr1ek4VS+9H98NftwKGuUuNOhVizcid2iDXwK62ZP+KSDI36gSUc8oM
         GlLQ==
X-Gm-Message-State: AOAM5311dL3riVF/6+Rq7j1/QtwCTUxs2uWkBJCE1hOZp7Clzc7EQamg
        yEQ5J2rtANYNXNqD5OAIMsw=
X-Google-Smtp-Source: ABdhPJwmFc8HOZhYoVSr5RcjGOXYrcrO5ppgAhHbfRNn9RPox7aY8YQP+C5ruGNuvA8DzGpUtNe/lg==
X-Received: by 2002:a17:906:350b:: with SMTP id r11mr6182628eja.143.1610644114615;
        Thu, 14 Jan 2021 09:08:34 -0800 (PST)
Received: from yoga-910.localhost (5-12-227-87.residential.rdsnet.ro. [5.12.227.87])
        by smtp.gmail.com with ESMTPSA id be6sm2397644edb.29.2021.01.14.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:08:34 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/5] bus: fsl-mc: export mc_cmd_hdr_read_cmdid() to the fsl-mc bus
Date:   Thu, 14 Jan 2021 19:07:49 +0200
Message-Id: <20210114170752.2927915-3-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114170752.2927915-1-ciorneiioana@gmail.com>
References: <20210114170752.2927915-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Export the mc_cmd_hdr_read_cmdid() function to the entire fsl-mc bus
since it will be needed in the following patch.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-private.h | 2 ++
 drivers/bus/fsl-mc/mc-sys.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index c932387641fa..be686c363121 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -612,4 +612,6 @@ void fsl_mc_get_root_dprc(struct device *dev,
 struct fsl_mc_device *fsl_mc_device_lookup(struct fsl_mc_obj_desc *obj_desc,
 					   struct fsl_mc_device *mc_bus_dev);
 
+u16 mc_cmd_hdr_read_cmdid(struct fsl_mc_command *cmd);
+
 #endif /* _FSL_MC_PRIVATE_H_ */
diff --git a/drivers/bus/fsl-mc/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
index 85a0225db522..b291b35e3884 100644
--- a/drivers/bus/fsl-mc/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -35,7 +35,7 @@ static enum mc_cmd_status mc_cmd_hdr_read_status(struct fsl_mc_command *cmd)
 	return (enum mc_cmd_status)hdr->status;
 }
 
-static u16 mc_cmd_hdr_read_cmdid(struct fsl_mc_command *cmd)
+u16 mc_cmd_hdr_read_cmdid(struct fsl_mc_command *cmd)
 {
 	struct mc_cmd_header *hdr = (struct mc_cmd_header *)&cmd->header;
 	u16 cmd_id = le16_to_cpu(hdr->cmd_id);
-- 
2.29.2

