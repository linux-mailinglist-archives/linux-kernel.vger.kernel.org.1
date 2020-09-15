Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9432326B399
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgIOXF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIOXEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 19:04:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B475BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 16:04:46 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d15so4841259lfq.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEeMulAJlc81CxL8jYeAKy63bDJ6gZhYcdxB7EqLKJE=;
        b=fNkMvav0lfQtCVj2Bt3dAtxGCGPFcMgoUEHIjTzrRzC+BNQMHiY/Zev6sKj0MUIbx2
         9IvXtI3z06jmHRE+K/rUebptBUEzMek4Tx4PsrB32IKO5gL/Ji8HEgL0aRG9A7vkXV+1
         22XamtQJlSEuGvaVNSR5KvT2Co0NTueHHbxZpwHEyvLakaqni/uRuooOD7sHv8b5Ny+u
         ZTtEDuUXSQxvvVMXY+wRXADnpzmvvYhbdV0T7LJGcXm753bPZRJkBBTD+qdVReqHMhWi
         HgMnC8zj56WNHdPQHw8sfu6/gK5pacdsoqwZyPQkN9LjBrccg4VA7AojniPyH3/nloGw
         siJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEeMulAJlc81CxL8jYeAKy63bDJ6gZhYcdxB7EqLKJE=;
        b=E/ijZkD6P4pH6gjQAw8TcwGYngQChbFTs+aBgxc2v+gkKwfgdpvZyktwVlEuEhixNA
         wnmPjMyypdI7tU1NkP04Y3LFXmHJENc2zBJjRzpUl4q5aHrLkPYEzPvPdqo5QCT6FJPU
         mCHC6eFpMgNIsWB3xJhjKNARN9hLWdOItZTvED91aof4+hgTIQWqaz/9ZS75jU8c919T
         dsnjJvRMEJqzpV1D8SAgV4+mbU7TC0lrzkPQzDPzs9dZpa4kAoj9ygi1G3FUmFuXBXJY
         tpV5qYFIHN6K8WMzlDgr/IAKmF1h2Gx44v+oRv5q48ncci3dohbXr834jjYAAJHaXNAb
         ZyCQ==
X-Gm-Message-State: AOAM531g022YVEjbw71k5FjK+XEMG+TDBE/CRlSQ+v7Duoz5b+vO4CQW
        jgDLFS5tt873DrFRdtg/hcA=
X-Google-Smtp-Source: ABdhPJyYjLqBWYc1CftrgwJvPN6OW5U8xYCyEGA9xFn2L+w1qPr9ICCcwW62XLCF8STOdiZhtRUa6Q==
X-Received: by 2002:a19:ed17:: with SMTP id y23mr7436553lfy.595.1600211080755;
        Tue, 15 Sep 2020 16:04:40 -0700 (PDT)
Received: from localhost.localdomain (188.147.112.12.nat.umts.dynamic.t-mobile.pl. [188.147.112.12])
        by smtp.gmail.com with ESMTPSA id z6sm4258714lfq.297.2020.09.15.16.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 16:04:40 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Subject: [PATCH] mm/slab.c: clean code by removing redundant if condition
Date:   Wed, 16 Sep 2020 01:03:29 +0200
Message-Id: <20200915230329.13002-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

The removed code was unnecessary and changed nothing in the flow, since
in case of returning NULL by 'kmem_cache_alloc_node' returning 'freelist'
from the function in question is the same as returning NULL.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/slab.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 3160dff6fd76..8f2fd224c1f0 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2301,8 +2301,6 @@ static void *alloc_slabmgmt(struct kmem_cache *cachep,
 		/* Slab management obj is off-slab. */
 		freelist = kmem_cache_alloc_node(cachep->freelist_cache,
 					      local_flags, nodeid);
-		if (!freelist)
-			return NULL;
 	} else {
 		/* We will use last bytes at the slab for freelist */
 		freelist = addr + (PAGE_SIZE << cachep->gfporder) -
-- 
2.20.1

