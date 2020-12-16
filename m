Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0D12DC1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgLPOJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgLPOJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:09:29 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6360AC0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:08:49 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id et9so5068290qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hw1VUdj7oe+RFhOiOdtGs39fzND3Jk6BzojvG/18LqQ=;
        b=IYJrC+opx3RLldMMxKa+dnCdhBtLbYnq411h7iiYF9ef0/eKjQCrJCFdC/xXxARHVk
         hgZwqhemvIbeEUYojpXPZXFaec6MC4EjE6iifV5CmhRH4Uso7deUtBEcv3C48KwOe2IX
         AotAwfUYy2E0EMxePt6fwTcyKngYQULGVSl4IX7xZ/O/Rwe1FU/L6us/62Sxw6UXoeYJ
         BU8zIp3SVIBnlWZL77U4Oz1DD+DTx9/+ZFjLeDwFau2PJCBAYKnUvJLmK4v1KMzXtZgE
         4sZoG8ojDbjl79lpO6NII5VuzUB9gIvdeUTI1RUvZsA1QGDsIvKZX8O76zWgRA+o8MzL
         7D/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hw1VUdj7oe+RFhOiOdtGs39fzND3Jk6BzojvG/18LqQ=;
        b=A80qWU5gEFihPRTwWT3Edl0q1oOYL2azREJ8Pdl5QtRK3UbqCJkJe6efMgR6+NbvQa
         BOvElK6ejPlvq1AqJ0omTiDkfwfmnxIFXhER0c2ymxeipjmfwnu8plCG7oYdRHwIE8Dk
         +4sXK+XKGTCAXMB5jiHw2BIaNalgHSYA1Q2OP2uWonQbISYsfT/yfZRc4bHQKGX2W0i1
         pi/J3Puog4Ff7UZez6v1yz8co6P+BLBNmAaSbtU9q+68PeRf4uhiXA2IGOlCCQkQohmS
         i7lTY8PgHDY0jU8pwPCYD010mmR5qDuZm79dYSUC3/wAvwawTJWkz3oVDwDdW7+RZSKR
         05pA==
X-Gm-Message-State: AOAM531Zz/aK8bENUPN+kkrYgStoSTrMg3nbfbrZjh42pt39g8BFlX8g
        JVIb7MxdjTQE1Stt6LKGisU=
X-Google-Smtp-Source: ABdhPJx2O7S7enSJUDMETKVJkTVEahKzf1Jq4arGE9gh5ELFFQGqLEFuiPeVji+PzJ9hBGu27Ah8kw==
X-Received: by 2002:a05:6214:1764:: with SMTP id et4mr39801202qvb.2.1608127728273;
        Wed, 16 Dec 2020 06:08:48 -0800 (PST)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:b150:92df:fbb7:5df0])
        by smtp.gmail.com with ESMTPSA id h25sm1113717qkh.122.2020.12.16.06.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:08:47 -0800 (PST)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jason Andryuk <jandryuk@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen: Kconfig: remove X86_64 depends from XEN_512GB
Date:   Wed, 16 Dec 2020 09:08:38 -0500
Message-Id: <20201216140838.16085-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit bfda93aee0ec ("xen: Kconfig: nest Xen guest options")
accidentally re-added X86_64 as a dependency to XEN_512GB.  It was
originally removed in commit a13f2ef168cb ("x86/xen: remove 32-bit Xen
PV guest support").  Remove it again.

Fixes: bfda93aee0ec ("xen: Kconfig: nest Xen guest options")
Reported-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
This fixes Boris's review comment.  I lost track of posting a v2 with it
fixed.
---
 arch/x86/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 2b105888927c..afc1da68b06d 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -28,7 +28,7 @@ config XEN_PV
 
 config XEN_512GB
 	bool "Limit Xen pv-domain memory to 512GB"
-	depends on XEN_PV && X86_64
+	depends on XEN_PV
 	default y
 	help
 	  Limit paravirtualized user domains to 512GB of RAM.
-- 
2.29.2

