Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4013A23060D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 11:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgG1JCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 05:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgG1JCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:02:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12990C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:02:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so11484446pgg.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59sn0tR0bp5U2+QkacPtoAEGR9oCMwRmABhD/l+q8Ro=;
        b=fW73WAPrC11Tn8CNHEmWOe0NHXFV5wudVLVXWHVHhSzD3cJbnMAXkFjzyOXdts2jLb
         AcKUducjuZxw6uQLXFf2nvtY5loqE8Ml8LZZpam6rzePnm8JJccbanUWs5vORBacu9fa
         hzDGdQ62f2pwSxdpc/N0+0doyvQkzVUe7rwGszZ23LP//r7D+EynZOYLewLXSxNq+LA8
         vXqmkTx+V3eQlRee7Z5VTw2NAg+wXzds2iImFyw2cyOVsRanYklt+ve4IlXlP6/9EmiH
         ikHCs86Bwcw1rGO6bJ6FHERaTYuxDxOVOfsMdVbeWd8++pJF9rZFA+hnuv3yNyxWnzFJ
         nDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59sn0tR0bp5U2+QkacPtoAEGR9oCMwRmABhD/l+q8Ro=;
        b=YGVrmCM72yU6btWz88gez3L/1B8FBtINdHxIuKSJi+XdVDL7ICX5B+MhVunqn6dLv4
         tVAQQwVBWQFbDN+O2Mh/wN4s3gUEBqACBB3N7XmJGMmT26Mx6fXfUwjIRKdAG+zvm1eB
         v+VeDzcVBK3suZkgqdy6cm4J8F/AVG3TzkE/UTFrStWkh4Pz8kHzE6GDAZSK8Rd1M2Ac
         lXMprSExSWEcLlWALfzfz/JXxQTMsw3f51MrgV3AIvsV/fTN4WVcX/9WJsnOoI6roApp
         ea0j3xD/qrKX5bEVEo4v7AOMz/X0PuTAo8gcbUXpLbsycjiYkc+0ekGIUUcYhgXjNyE1
         Mmbg==
X-Gm-Message-State: AOAM531NflKQZPY3hTUY+SNcg8aG++DPI5/vSz1yqBRy5NgmdV0/aV5k
        y5yYt/z+/JECD4go+/QE6V3+3w==
X-Google-Smtp-Source: ABdhPJzCpi4NS0EBVejZo/d91v2CZZOKRi5X1CDwV/Ex0WfnLblyStcErbkHCfEUlaxNh8jq0rEbKQ==
X-Received: by 2002:a63:6c1:: with SMTP id 184mr24299771pgg.262.1595926970553;
        Tue, 28 Jul 2020 02:02:50 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([47.31.2.226])
        by smtp.gmail.com with ESMTPSA id x20sm1120549pjp.3.2020.07.28.02.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 02:02:49 -0700 (PDT)
From:   Ankit <b18007@students.iitmandi.ac.in>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, b18007@students.iitmandi.ac.in
Subject: [PATCH v2] Staging : media : atomisp : fixed a brace coding sytle issue
Date:   Tue, 28 Jul 2020 14:32:21 +0530
Message-Id: <20200728090221.25284-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728084341.GA1795795@kroah.com>
References: <20200728084341.GA1795795@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankit Baluni <b18007@students.iitmandi.ac.in>

Removed braces for a 'if' condition as it contain only single line & 
there is no need for braces for such case according to coding style
rules.

Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>

---
 Added extra description and added space before '<' in above lines.

 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 8ea65bef35d2..28b96b66f4f3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -4981,9 +4981,8 @@ enum mipi_port_id __get_mipi_port(struct atomisp_device *isp,
 	case ATOMISP_CAMERA_PORT_SECONDARY:
 		return MIPI_PORT1_ID;
 	case ATOMISP_CAMERA_PORT_TERTIARY:
-		if (MIPI_PORT1_ID + 1 != N_MIPI_PORT_ID) {
+		if (MIPI_PORT1_ID + 1 != N_MIPI_PORT_ID)
 			return MIPI_PORT1_ID + 1;
-		}
 	/* fall through */
 	default:
 		dev_err(isp->dev, "unsupported port: %d\n", port);
-- 
2.25.1

