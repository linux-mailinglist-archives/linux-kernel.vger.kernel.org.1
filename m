Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACCC2FE7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbhAUKdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbhAUJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:47:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C1EC061386
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m4so1047654wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mYxGBsvkYUdjpbxW8TKZG60qwkP74ogfKinwU5RJVJA=;
        b=EooXLJ4bOpjkR5CtIpeQZ2w6CNSMVbTuRRhXL64htl1YGJ2pycdRJiXyrsWpncl3j7
         1lqqQPLJDOLGsfWV8sS6CzMuBamqOSSe+eYRZxLp5vocSwE+qCZJEP0tlIq5Dr0Gyu+X
         P9B1geDhwj4Kt685ercxvfWYQEdj1I7rc9kpleUh7eBIcoPcwICVvDTRvZMT10y9vcrx
         yabwINV1l91iZ0qPchPcQiEdaSK3R19fd2Psjabgm8LlVuyTHup9NYDkWOxfjl4dIMpJ
         BTvVJczl30cydx+craf8EnfkIseI2FWTXs51KLoN7a4M2RE14bNBj7WksaqxRvpvdT9l
         pq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mYxGBsvkYUdjpbxW8TKZG60qwkP74ogfKinwU5RJVJA=;
        b=RJLZCans0cz6GdP41wE5DhPH/iekkwh29iqM3w66Subx9p2IhQmiEd7oXURN0uSae3
         CZWDKnNCcHv4Symp8RNHZBNh6DrirgHokhLdJbjMyiq2tw0SPBENE9liHkph+LUVHy+P
         ij+++KVreIxyU7qLLrxKal7+nI36umiPjeKa3vNGGmSVfroGV96rpTie35va68knPcfO
         hcOSSp//VCSsm3vlmVNbPoCuGrP0ftZzr8Vxlv48J+DU7i48FY+Rq80K1KSJLbcsKLzP
         d3APdFwqTOj2LhsoEtgt5Rh18jZGM9TmzuFMgklRla+bNDMT7bmF9i3dXEX97WLJGsJx
         VzNQ==
X-Gm-Message-State: AOAM533jHzHKY/r/6EMOWUl5BLqSwOn8pceiGSJme1fCOEymNqFcjFw/
        UB5ZxXuaChbvv0I1U2bzVJjF0g==
X-Google-Smtp-Source: ABdhPJyo43uNNkEn2GWYNHsQer8mv01MlSt6TGU3/jQ6NIDMP2IdH2ZrYuTrOCRPHz8tGaN+VlSxtg==
X-Received: by 2002:adf:a319:: with SMTP id c25mr13595220wrb.262.1611222350474;
        Thu, 21 Jan 2021 01:45:50 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 22/30] RDMA/sw/rdmavt/mcast: Demote incomplete kernel-doc header
Date:   Thu, 21 Jan 2021 09:45:11 +0000
Message-Id: <20210121094519.2044049-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/sw/rdmavt/mcast.c:195: warning: Function parameter or member 'rdi' not described in 'rvt_mcast_add'
 drivers/infiniband/sw/rdmavt/mcast.c:195: warning: Function parameter or member 'ibp' not described in 'rvt_mcast_add'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/sw/rdmavt/mcast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/mcast.c b/drivers/infiniband/sw/rdmavt/mcast.c
index 5233a63d99a65..951abac13dbb4 100644
--- a/drivers/infiniband/sw/rdmavt/mcast.c
+++ b/drivers/infiniband/sw/rdmavt/mcast.c
@@ -180,7 +180,7 @@ struct rvt_mcast *rvt_mcast_find(struct rvt_ibport *ibp, union ib_gid *mgid,
 }
 EXPORT_SYMBOL(rvt_mcast_find);
 
-/**
+/*
  * rvt_mcast_add - insert mcast GID into table and attach QP struct
  * @mcast: the mcast GID table
  * @mqp: the QP to attach
-- 
2.25.1

