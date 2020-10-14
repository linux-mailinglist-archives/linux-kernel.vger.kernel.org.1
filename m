Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5287428E5C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgJNRyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgJNRyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:54:00 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FBDC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:54:00 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k1so193487ilc.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=72uE8HBho6CRDEfq5zUs9af/VZhtVN+A95L9VpNei3g=;
        b=WPYcwYQQ8P4JgmLO9WS1jZolr0Vv2PVTia9WT/lQ7MX5gq+HsgEva9AfGW2FlgkgbM
         HVJwCL5VPEiTqLxbrJJ8A2q6YMODS7ZMAb+ADTjLgyMXIG9zTJC02fhcJE4vdysPzQ+h
         7wOEuIA4KEZYRd4Miv5wes3HRO3QndjWh+xU/zP7xcvds0rqh59kMY4QvTVA/uvaFEnT
         VhgDXyS/LFydlvr3Q2eIXePyc1P8MCdMbaxQEA4wPi7vlq72DYhfiuBpF8QOYHsd1Vnm
         0IQ8wo3SZrNi2vGPELBiHRkH0cJPFOXShMcxHEkloat2A4GQ1WyvAGOOUMdhQUib/HpS
         8FVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=72uE8HBho6CRDEfq5zUs9af/VZhtVN+A95L9VpNei3g=;
        b=ONKvOleyMDeosutfbCDfMs+b42uGWROfWljYD573l2IFp8b7bLFJq/DyxMtcSlOWXU
         ehuxcJpuOJhL8AGts4V+7CPwo2SfVYTDiv/wSkxnfWz1CABB6bAfjf4qZG0Vl09HcvTh
         +FIdSrXNoGadbkdKWwzOHAFy6TGm0QahXqg2ulX69d7PwQ1zcO6pMLGcdv2caEHp8+Wd
         OmHYUxjui7QucE2qsMAOiDdh+SI7qsHEq2w0okHRVzN9XBPkdXZ2QgjxhemU7N4s/RKB
         2Rffsisd7Grfo0PlvTO+/b8Meuy2rBChBiDhcljdElQJQb6jzaS69lGCdtBvsIQgdkcE
         tL2A==
X-Gm-Message-State: AOAM533kSF9v1XBQIofCF3MEGewfzI6m4iTP3U7aWYK1M7CcbvJF8mqs
        98BnOcHwFg6xmHEKlZrL0Ylh17W3g/bCFA==
X-Google-Smtp-Source: ABdhPJwj+vJExjs0I5nCxR1nMrw0GQPeUqeZDyFFqHum+1s5g1WGgg2wXN6N5rYZrkp6aUT3nWYY8w==
X-Received: by 2002:a92:3650:: with SMTP id d16mr262484ilf.29.1602698040294;
        Wed, 14 Oct 2020 10:54:00 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
        by smtp.gmail.com with ESMTPSA id v15sm67765ile.37.2020.10.14.10.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 10:53:59 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Jason Andryuk <jandryuk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] xen: Kconfig: nest Xen guest options
Date:   Wed, 14 Oct 2020 13:53:41 -0400
Message-Id: <20201014175342.152712-3-jandryuk@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014175342.152712-1-jandryuk@gmail.com>
References: <20201014175342.152712-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving XEN_512GB allows it to nest under XEN_PV.  That also allows
XEN_PVH to nest under XEN as a sibling to XEN_PV and XEN_PVHVM giving:

[*]   Xen guest support
[*]     Xen PV guest support
[*]       Limit Xen pv-domain memory to 512GB
[*]       Xen PV Dom0 support
[*]     Xen PVHVM guest support
[*]     Xen PVH guest support

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 arch/x86/xen/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index b75007eb4ec4..2b105888927c 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -26,6 +26,19 @@ config XEN_PV
 	help
 	  Support running as a Xen PV guest.
 
+config XEN_512GB
+	bool "Limit Xen pv-domain memory to 512GB"
+	depends on XEN_PV && X86_64
+	default y
+	help
+	  Limit paravirtualized user domains to 512GB of RAM.
+
+	  The Xen tools and crash dump analysis tools might not support
+	  pv-domains with more than 512 GB of RAM. This option controls the
+	  default setting of the kernel to use only up to 512 GB or more.
+	  It is always possible to change the default via specifying the
+	  boot parameter "xen_512gb_limit".
+
 config XEN_PV_SMP
 	def_bool y
 	depends on XEN_PV && SMP
@@ -53,19 +66,6 @@ config XEN_PVHVM_GUEST
 	help
 	  Support running as a Xen PVHVM guest.
 
-config XEN_512GB
-	bool "Limit Xen pv-domain memory to 512GB"
-	depends on XEN_PV
-	default y
-	help
-	  Limit paravirtualized user domains to 512GB of RAM.
-
-	  The Xen tools and crash dump analysis tools might not support
-	  pv-domains with more than 512 GB of RAM. This option controls the
-	  default setting of the kernel to use only up to 512 GB or more.
-	  It is always possible to change the default via specifying the
-	  boot parameter "xen_512gb_limit".
-
 config XEN_SAVE_RESTORE
 	bool
 	depends on XEN
-- 
2.26.2

