Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4293E2B5406
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 23:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgKPWAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 17:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgKPWAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 17:00:47 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305E0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:00:46 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 74so27283333lfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbM+uzL6L3H+4aTUHFaDKbTwMCquf9JhugqpRvQq5Kc=;
        b=QraJNQ59ICnWgRHulII7yGGgG45c0rZRXw1NZS79Q8Aaj2xvz6mASVe49CmRSMtvmL
         8EIkYCdrUa1Cg64uehUamCxrQO69NjK3QEEkmFd1ZBOJgPLmjCqAhapzR6zXAZa9J2Ew
         l7CA2Y6sdodQAjeGkAraf+U9Zj1LMKn7nKF0meNdjKmHCgxMYrG3LX/iKP2R9gx9baxm
         2FX9XsjxMN0/aOimHSj3dN1kybOmQns5Aw+T6Bjtx6cRqWmPCx4EvTHBpqlYu7U98ttC
         W9W1pUKwstts0spEGsObaO6HdT9w4WuKOFKpLwBH4DFrI490zforVdkwMrlpjHs3BVVk
         UL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbM+uzL6L3H+4aTUHFaDKbTwMCquf9JhugqpRvQq5Kc=;
        b=OtusZNcYdpAxfLPzLUXNzSeJU4NwZLr7ei4svf7LJaRsusPpqO88lF1rwfFt7YSzqG
         TqYT4rZBZO1w2F8W1dqk7UpZwzu95Aa07DPnu5vqdr+msB/LmvzU5RxbrzTPq8mjhldk
         yalBtCYcqr4OxR7TIIHQp33hex7Lwl0zBw0K9b0hTGNmgxSDSWE8DvL6+Au+I5SfE+8v
         oosjWpCPdyvwRs1FcVsceuGZ+E9SFCpFUruurBwp2E1f6bJhQcJwp6b9y2EdAv6GG115
         buB5C619KG5SkkSpIdspYnF2riuccyhUMIcl8SLyDUdQCfXxpB6srXWbJYvrwCbkLRyl
         PBQw==
X-Gm-Message-State: AOAM531uZ2iY9KTKQWK5YSDHBOhpDG0abMpNKEn6vdoyH3S28E5+bjq6
        AC2lTeN5eusXRWWI9kn/0s0=
X-Google-Smtp-Source: ABdhPJx6S9mr+zts/Kn/uWIj3McFpRPnLqpyaeqn6EN5RvapZhu5lx1zaheNt2A2SkPAyCmv+YvG3w==
X-Received: by 2002:a19:3f56:: with SMTP id m83mr473900lfa.381.1605564044598;
        Mon, 16 Nov 2020 14:00:44 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id v130sm2870160lfa.283.2020.11.16.14.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:00:44 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/2] mm/vmalloc: use free_vm_area() if an allocation fails
Date:   Mon, 16 Nov 2020 23:00:32 +0100
Message-Id: <20201116220033.1837-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a dedicated and separate function that finds and
removes a continuous kernel virtual area. As a final step
it also releases the "area", a descriptor of corresponding
vm_struct.

Use free_vmap_area() in the __vmalloc_node_range() instead
of open coded steps which are exactly the same, to perform
a cleanup.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d7075ad340aa..b08b06a8cc2a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2479,8 +2479,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 
 	if (!pages) {
-		remove_vm_area(area->addr);
-		kfree(area);
+		free_vm_area(area);
 		return NULL;
 	}
 
-- 
2.20.1

