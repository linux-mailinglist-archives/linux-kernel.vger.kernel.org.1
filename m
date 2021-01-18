Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1496F2FAD68
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 23:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389231AbhARWlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 17:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389009AbhARWlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 17:41:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82223C0617A1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:39:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l12so12684505wry.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cwzNP5kyHoQeZRxeZSVY+m4WgCNHmZim89Aex+bzV3M=;
        b=DE6emldwpqG09140iU8DJVIgEVttWIINr5Lyz4ugvS4DsV0dLBfNxYlSnC0vczze2C
         9Ld7waXjDpfvS+Ez0w90iivhrKe0y8nE9y4gDBEjvdrmswkfS6jnIB54//9B2j0rc826
         j4nTGlxxPOdqnaxA8TofEn7/nsnwnN+/A3S/nE4ZBscU5SwDeKpTj8PtK3JHOtJsFwja
         KGNOMeHXDalpBDCos7sMEQ4mN9RV57pN4MAPuc5LA9h4dAcjOxy979wHnVUrDxVb31po
         b+rV+pTXCFvW6YkCBNzIk5gH+RnHBBoxZEBiPRvS/VOeH1SiPjtu013xXZa26F3uo75n
         lrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cwzNP5kyHoQeZRxeZSVY+m4WgCNHmZim89Aex+bzV3M=;
        b=M1UqCtVqOB2Q2/fStVVz/ZzkQl95H7qIUHWoKNO0xpQKPxmrDGjsrELY0t4/3wDbS+
         AjjPUUmFdIzCIXKOfXDL5acOH+UTpCJ/7BzNFgZp1qnvLuwPmG323i4K3SSnLkG97/wI
         +gpXqWzh4ZiN5dp29bwTQVCDFCb59lMTi+9QVC1Eg5pqXjqoTr2GDyBfjS8EVPBwL4wt
         2/UMgtTnHmSvQw58hMrty4Qk/tqsMvXllWknfULecSSIEbiS/v/1tomG9GHy8CjP3xiF
         C7W8g0fYohVAZm5bv186nQycXNQcyR3WguV4zuTxv6Vcp2+0XOoOX/HEjby1gZjVBn5m
         SOiA==
X-Gm-Message-State: AOAM531cP0Hbvq66OGjv8eoSwyiJnX1nLhM3WAw9AhA2/tYVST70lRlY
        aQo9HR1JTUIoKXpL5n+UTBJFhg==
X-Google-Smtp-Source: ABdhPJywvIwmt0EOck4Pbkb+KtkE7KXOTIlpGFAE9ml3JcVB5KSkZ2lIFh8jLT1cKdtTrG5XBxeluQ==
X-Received: by 2002:adf:9d42:: with SMTP id o2mr1408439wre.135.1611009585324;
        Mon, 18 Jan 2021 14:39:45 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 11/20] RDMA/core/multicast: Provide description for 'ib_init_ah_from_mcmember()'s 'rec' param
Date:   Mon, 18 Jan 2021 22:39:20 +0000
Message-Id: <20210118223929.512175-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/core/multicast.c:739: warning: Function parameter or member 'rec' not described in 'ib_init_ah_from_mcmember'

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/core/multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/multicast.c b/drivers/infiniband/core/multicast.c
index 740f03ecc05d7..57519ca6cd2c7 100644
--- a/drivers/infiniband/core/multicast.c
+++ b/drivers/infiniband/core/multicast.c
@@ -721,6 +721,7 @@ EXPORT_SYMBOL(ib_sa_get_mcmember_rec);
  * member record and gid of the device.
  * @device:	RDMA device
  * @port_num:	Port of the rdma device to consider
+ * @rec:	Multicast member record to use
  * @ndev:	Optional netdevice, applicable only for RoCE
  * @gid_type:	GID type to consider
  * @ah_attr:	AH attribute to fillup on successful completion
-- 
2.25.1

