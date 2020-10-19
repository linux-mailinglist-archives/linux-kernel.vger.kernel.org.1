Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8598292F29
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgJSUIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbgJSUIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603138091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=KK+mSkHQM5HW+MdXjp7VAFTxoyS91vnFOwsUGhSxPmk=;
        b=eGmPzzv7MXKBFRDcyt1m721D31IZ+sbIG1MzShfBH+AppGeVHR5GbvlMoFNOMuUARXCZec
        UklisL7hTASPdisVIsFnBUR+2dKTYc0PoqofbT3IWyX6pgFB1KCoWlaaJqH2bWyaVwY1O9
        IFaAUKM/OeSzK2mlcTm6DVQIi3HzOj4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-zE5znyafN3m7WKazD1szWQ-1; Mon, 19 Oct 2020 16:08:10 -0400
X-MC-Unique: zE5znyafN3m7WKazD1szWQ-1
Received: by mail-qk1-f199.google.com with SMTP id v186so573510qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KK+mSkHQM5HW+MdXjp7VAFTxoyS91vnFOwsUGhSxPmk=;
        b=OUZzOSZciRN1QVumslEjGvw/a2Fh6o+QN9Mx5YYBq2yZKQ6rubMm8E2IHq77nfWlgw
         oxOlq0AxmxWxJ0qkwWk3f1Qrw7YlHJTgcLqusIMFT5BnRYTpxHYhA6nQL2nwEMgSec+y
         RzI+LhmKwZzG/9Csd7Bu78DCrNhorwUiSW+dD1nRf2T/aQSgdcEcwFvUaPhlREnk0l3Z
         sIedXQosmNU7OGtPVTuFBBAiGOCwn05yfNQ9Ux0D0EjU/mnS8+WmyTpD865+Qjio7869
         KAmx7yCjwMyNE8i9VDCWqffHihlgUH8wV5xZZlGUcQ4VBUCIID1OB+u55OGHf1pa76b4
         EeQQ==
X-Gm-Message-State: AOAM5309hU2plM56YhfmeDx63IlKxhsDHGVpO1Bd6giRJafRKkifuzL9
        SXiyfISz5YCXzZdcjHvG/FYEy4T7mPWc7W5P9UE42OU9Lp6LR61ObrpShjz/e1w0m1mPGybmX88
        KdZpxDs4P9NkCtYZQJzux0BdD
X-Received: by 2002:a0c:85e3:: with SMTP id o90mr1341845qva.46.1603138089416;
        Mon, 19 Oct 2020 13:08:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/B0cMfcKSl+OJKqaoY4gQIekN4uoRC3m2jozT4QZRyFc8HTBa07dDHNkHwR5uD/T2TIbMmg==
X-Received: by 2002:a0c:85e3:: with SMTP id o90mr1341824qva.46.1603138089200;
        Mon, 19 Oct 2020 13:08:09 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u2sm369407qtw.40.2020.10.19.13.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:08:08 -0700 (PDT)
From:   trix@redhat.com
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] x86/mce: remove unneeded break
Date:   Mon, 19 Oct 2020 13:08:03 -0700
Message-Id: <20201019200803.17619-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/kernel/cpu/mce/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 1c08cb9eb9f6..16ce86aed8e2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1811,11 +1811,9 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 	case X86_VENDOR_INTEL:
 		intel_p5_mcheck_init(c);
 		return 1;
-		break;
 	case X86_VENDOR_CENTAUR:
 		winchip_mcheck_init(c);
 		return 1;
-		break;
 	default:
 		return 0;
 	}
-- 
2.18.1

