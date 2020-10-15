Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741BC28ED0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 08:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgJOGXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 02:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgJOGXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 02:23:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9BAC0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 23:23:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q21so1222670pgi.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 23:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie-ntu-edu-tw.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=rOybbcG2gzRHb5Bvm5WG6KUjxX79ZyS3rQJBpiyljFo=;
        b=uH9p+ldiS0oDncC2bwZRnT3A6Ev/GJNL626t90SqFCGv+rK8+O2TF3TfmDy/nBTUHd
         rBLxXzPbuUsxIzvVeK6KT4IeA/iBkq9p+kEOxcHLeKAKebLY/RUo5sh0kd7s+Y+MPJlz
         3D7sviFfgC4s7dyJWiNYvGYWcNpwFlu12uRpoB84X2mwEcOIYXH8AgAi8DJ5vEyJPnm4
         F3moBcG7VSlkCux3fX9LkR8rws1YvC4ObQXhMNxjbLk6jhzSEWWnq3IA+eLZ80+Nx6ta
         OlZRqCiLHOz13KXBbt98Xb5+LFE70BFiPSm6J1Hr7TEpmWFNGxDbclEJCKLyGRFC+uYC
         Wl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rOybbcG2gzRHb5Bvm5WG6KUjxX79ZyS3rQJBpiyljFo=;
        b=e921aJJZ71pJaB+/yvbiQnQx6rxdHaXBUvQ+evR7ZXwof1tVRAHKX+bwhRp/2jFWoh
         ZK1rdN3+5ZV2C2Ew+kW9Wfco5puVZXQtWsdD0hWy6lMnnMaWiruWMyHYt3Otv/71MnW0
         SmfvegVJhHWm3IVccdBXsQL8Wof0gw74XkBVxhJvc/NeamHzFRb1LG6rZEvLH+I8lwne
         6fw3xLz/02NcXDT9od5AZD1NsiAc1nfOb7B+NQPcdSl1MdTViBPSKnWLpQKGLxwFkt75
         U99G7TxP7UfNOC7kaWqNq/SZTP3lowzeRkYNsk87ZVtW4+p5iQoK/nk2tPFx1gAOfCSq
         HcSA==
X-Gm-Message-State: AOAM532OP7Y89LombZ26yJWd+q10aBwSqfmN+gJlHefl6WOVGv3X0F4I
        6qncbDyAlU8YRyfxY2zKZ28Nfd5vlsDowmhaY+8ZKZD2Dq4dc6EOtc6JoOoj6yeFQAnj5PPEsgO
        1lIrySyC3lWcs6aseCelUbhq1l3vT5cklxvvFiIC50o2YIewG1M2h/OBtTKAe4Xqh21kl4aZeRx
        6MAj0EGYWRpLTUPFKicLB/Db5ntDA=
X-Google-Smtp-Source: ABdhPJwv6rRAJ77SdeNtpkBHlMRfLSwZQZSBPwXGuDk/FwwmlCigBkmh/ALTQyhN+00BMiFkHBx0HA==
X-Received: by 2002:a63:d80e:: with SMTP id b14mr2139631pgh.114.1602743034692;
        Wed, 14 Oct 2020 23:23:54 -0700 (PDT)
Received: from localhost.localdomain (2001-b011-3803-1d24-853c-8d4c-9ff6-b9e6.dynamic-ip6.hinet.net. [2001:b011:3803:1d24:853c:8d4c:9ff6:b9e6])
        by smtp.gmail.com with ESMTPSA id x23sm1787195pfc.47.2020.10.14.23.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 23:23:54 -0700 (PDT)
From:   Wei Lin Chang <r09922117@csie.ntu.edu.tw>
To:     corbet@lwn.net
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Wei Lin Chang <r09922117@csie.ntu.edu.tw>
Subject: [PATCH] Documentation: x86: fix a missing word in x86_64/mm.rst.
Date:   Thu, 15 Oct 2020 14:22:42 +0800
Message-Id: <20201015062242.26296-1-r09922117@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.17.1
X-Gm-Spam: 0
X-Gm-Phishy: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a missing word in x86/x86_64/mm.rst, without which
the note reads awkwardly.

Signed-off-by: Wei Lin Chang <r09922117@csie.ntu.edu.tw>
---
 Documentation/x86/x86_64/mm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
index e5053404a..ede187571 100644
--- a/Documentation/x86/x86_64/mm.rst
+++ b/Documentation/x86/x86_64/mm.rst
@@ -19,7 +19,7 @@ Complete virtual memory map with 4-level page tables
    Note that as we get closer to the top of the address space, the notation changes
    from TB to GB and then MB/KB.
 
- - "16M TB" might look weird at first sight, but it's an easier to visualize size
+ - "16M TB" might look weird at first sight, but it's an easier way to visualize size
    notation than "16 EB", which few will recognize at first sight as 16 exabytes.
    It also shows it nicely how incredibly large 64-bit address space is.
 
-- 
2.17.1

