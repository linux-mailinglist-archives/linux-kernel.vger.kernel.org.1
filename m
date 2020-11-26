Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D794B2C58BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391476AbgKZPyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391426AbgKZPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:54:45 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05B3C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:42 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id g25so837283wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZrCAS9ygWkC2ufXbj2Wobao4dQO/5x9OhapFi6lV40s=;
        b=aDvl7dClV2uddSkR11BaXY3pN+uz5HABtJLBS7EVNJEKoJNZV0iBk9o8D59nUGH/+a
         3B7FnrMyxDa9I5WhiMmMzlAgUJydOA7B1ixiCwBNjGHS2f23ntZe758HSRDydqFfNx0G
         AqoHtivWbZj+IUF4KFbqnve9WibgLTwyw/zq0e3ULZgspz4+L2SoR4O0BzQb0HfNfyP+
         VYu7VHGair8YbXPnsqfj10NbpQwbS+RfY/5HLENNvh3lTrEkIqim4RFcHVQKoZZ6IQRB
         oNuaz8WBT941Oa80szhb6hkSCeWKRh0zO+o7NbC2ztdnZAqmYks//F5Q/aWEttvKUeYa
         +CyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrCAS9ygWkC2ufXbj2Wobao4dQO/5x9OhapFi6lV40s=;
        b=EUVpjtOsQsvORKCFRTNg+OUpt8VhVcrnXPgHJ9P3ZnR9OPvjOtQByiasfAhdRtrS1B
         5w8rwGd36pQexjYSUTy8a24i2dNfPMDlkdGejjAbeETDK4RprLoJjLkDb7QH7OccwQr5
         3y6NRbbiLpN/3wfoMTqrSfZAvtwWkyi8cNsC2v4D4o45u98JJPD+p8y3PS3GetERtZkw
         fD/pM4MJ9Hb9dczTRBfjRquSGjqCVnpgRmGo0zVaWGrYZd0M5ozpQmOxpxw1uPOLXOCa
         rp8eSjge9RrOwvrY47tP0r/phd2oBjlL8Uo/xE6A15K4I9VzMUWYjAZT20Y8dhTn7abj
         F6YA==
X-Gm-Message-State: AOAM5300TC1I1BWMAWUzBifh2A/6268n8Zb3ldXmNhNsoeFx6bhDy4s8
        8iu/8DNbd1F1npOF4Mm/wp5vTQ==
X-Google-Smtp-Source: ABdhPJzjuSUApvEOEPjZQvj0RwSRQkwjvpqFgqkQbvkP2wAo7cyRvkYNRsvgHC/RhJaCaStDd8X2AQ==
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr4043009wmk.125.1606406081513;
        Thu, 26 Nov 2020 07:54:41 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id s2sm9141206wmh.37.2020.11.26.07.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:54:40 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 07/23] kvm: arm64: Initialize MAIR_EL2 using a constant
Date:   Thu, 26 Nov 2020 15:54:05 +0000
Message-Id: <20201126155421.14901-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAIR_EL2 is currently initialized to the value of MAIR_EL1, which itself
is set to a constant MAIR_ELx_SET.

Initialize MAIR_EL2 to MAIR_ELx_SET directly in preparation for allowing
KVM to start CPU cores itself before ERETing to EL1. In that case,
MAIR_EL2 will be initialized before MAIR_EL1.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index b11a9d7db677..17b58dbc3a2f 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -111,7 +111,7 @@ alternative_else_nop_endif
 
 	msr	tcr_el2, x0
 
-	mrs	x0, mair_el1
+	mov_q	x0, MAIR_ELx_SET
 	msr	mair_el2, x0
 	isb
 
-- 
2.29.2.454.gaff20da3a2-goog

