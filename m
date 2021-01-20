Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0EC2FC71A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbhATBsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731273AbhATBp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:45:56 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71782C0617BC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 17:43:54 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id o18so5610378qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 17:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BKUj/6ZsJWAx+ypUtR8qlYsn81/heEPy52GNTY6EKsg=;
        b=oDhucAFFl5fFLBbUP6N7kYGPCWSid4rOxZEuV/K3xSEXxC+4t38NIYKbPweeJkN8y5
         0GqeWh662ZXEMhO81KR9IWGunuueM9R+TVXGrAKGPQY3/OpzYHXKsc7+IsWTeXUJKmhW
         uCG28rVcS09zX6wS2pt3JMesiEscQKi02L5+KN1POzu7GF4y+nKX4qWMxy1R5xDNYUux
         XxfepHhMK2sKBzZ2a3Xe6hIlNRm677mF9W9S7S81+wMhl/djsa2IRYo+fPYOibYFCU5b
         5/0FVlix0iE3DR+ayWoKmNXjF1/tlD0e0i/LSC1K1Cn50CPVGOxvVf3iObZ7fjoxUtI1
         kw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKUj/6ZsJWAx+ypUtR8qlYsn81/heEPy52GNTY6EKsg=;
        b=OP6wl2X9Kiz/1Z6rQVUw14MLaSFQ7rLHJGLb+9dyV5A+CwA1vvaDCpV0Xq5NMZeEgC
         wXb6X/wZeRHcMFlSt4VTyPdEW+/cCqnPZBvYBPBxO/g0w/6vPi2JHCx8YUsTn60zOFOm
         26AejBPgYgNTQKoduJRm8iSuxgQNNN9B0o8y+IFrgPbVL36OFQGF0pYeJSoKM4tW4l+4
         WghVwThPLYZcCJWXUEEttaleD79Tfs6LUGxz+1ESs1DnojgQOladWX/B/D9AwvKU+ZeJ
         ju+cooBnp5wlDzRBPHqEU7Wg+sSzmCra1ye+Twyogb+e0p2lc6t/Ndr8NmnVHfnBQVi3
         3pDA==
X-Gm-Message-State: AOAM532eavwwWowWv6TBXvNWdaBImUkFwYuwaXbSUsME+PrmCLG70BE5
        BbK1FRaZ2c6dbFXNYSp8IzYqpw==
X-Google-Smtp-Source: ABdhPJwGbcj3jYzIBgMMxo+ssO/F9JFenmluHPBNAtzaOONj3R/BAwlfKcVGPIBE5qq3N+6LdmcxGQ==
X-Received: by 2002:aed:3aa8:: with SMTP id o37mr6814179qte.239.1611107033730;
        Tue, 19 Jan 2021 17:43:53 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id a9sm391871qkk.39.2021.01.19.17.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 17:43:53 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 11/14] mm/gup: change index type to long as it counts pages
Date:   Tue, 19 Jan 2021 20:43:30 -0500
Message-Id: <20210120014333.222547-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120014333.222547-1-pasha.tatashin@soleen.com>
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __get_user_pages_locked() i counts number of pages which should be
long, as long is used in all other places to contain number of pages, and
32-bit becomes increasingly small for handling page count proportional
values.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 668795e5a816..c7abd5b37150 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1479,7 +1479,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 {
 	struct vm_area_struct *vma;
 	unsigned long vm_flags;
-	int i;
+	long i;
 
 	/* calculate required read or write permissions.
 	 * If FOLL_FORCE is set, we only require the "MAY" flags.
-- 
2.25.1

