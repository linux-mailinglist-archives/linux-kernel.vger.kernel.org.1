Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714012944B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 23:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438796AbgJTVpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 17:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389512AbgJTVpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 17:45:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C06C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 14:45:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gv6so35446pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 14:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EKYiVVRrzVkrErxQtSxcT+GQiEsMi07e5G3dENOaLqw=;
        b=Z+FcLcaod/VZGPF2GtdVfd0ALicaU6PfKQMIhxY8thzaR7yDLW/wBn+0EwPHXpxygS
         QUwn/eL4hpdRn11PtPysOCZL+pRr3Y1/b6afuHE4xT0J4eomenZztUwxZuumvpk/yhI9
         Ma6663KynXN6D6yUUv+Vktd+Hgl11C5TUv8YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKYiVVRrzVkrErxQtSxcT+GQiEsMi07e5G3dENOaLqw=;
        b=GU+z3HtFO19EMgIG/lzyyfXtnqwLaXZR5AXEQGsXE/bTwxPfaQ4yjL2lA9qd6xBO/y
         jYEgdy6rNlGAV0S0hzOmRz6V4jRS+YjHexTShbeXF1FTLwiAkxAnQVLc5eKRf8ttJBRZ
         Ujk+PNgcXT9riXLbngT36r/exLBnyGg4cq1ud9n6STmSYrvnbK986UDBae9rEWHigU1P
         UjPjGNWWK0+6itrPUDyJHvPPCjdsrAwDnsAxST3dNJ8ZOHOXIfcReu17O1Pn2eROl2Dm
         ir+CkkCCDKWezjzVqQ0H0zrH4HvpC/cNBA5Fk+sXcLCtWacuX35PfRlMWLSEUDI81UV4
         dR1w==
X-Gm-Message-State: AOAM533O37uZziey6EhYIm75Ylos5VwCn1+fwhOtBxrZrxZWBJ92q5ks
        EzMv9h71raPhvZhocnhQEtrrIpaTJqJ9qw==
X-Google-Smtp-Source: ABdhPJwrpZMCxZrhVgdpeQPdj7AT2MuT2CD7S+OE320FHWa0arI8QRP8nB8sE113IHQNMou+gtQVqA==
X-Received: by 2002:a17:902:6b07:b029:d3:ebaa:d028 with SMTP id o7-20020a1709026b07b02900d3ebaad028mr4941341plk.11.1603230349052;
        Tue, 20 Oct 2020 14:45:49 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id j23sm130751pgh.31.2020.10.20.14.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:45:48 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 2/2] arm64: proton-pack: Update comment to reflect new function name
Date:   Tue, 20 Oct 2020 14:45:44 -0700
Message-Id: <20201020214544.3206838-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020214544.3206838-1-swboyd@chromium.org>
References: <20201020214544.3206838-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function detect_harden_bp_fw() is gone after commit d4647f0a2ad7
("arm64: Rewrite Spectre-v2 mitigation code"). Update this comment to
reflect the new state of affairs.

Cc: Marc Zyngier <maz@kernel.org>
Fixes: d4647f0a2ad7 ("arm64: Rewrite Spectre-v2 mitigation code")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/kernel/proton-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 00bd54f63f4f..106857685145 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -203,8 +203,8 @@ static void install_bp_hardening_cb(bp_hardening_cb_t fn)
 				   __SMCCC_WORKAROUND_1_SMC_SZ;
 
 	/*
-	 * detect_harden_bp_fw() passes NULL for the hyp_vecs start/end if
-	 * we're a guest. Skip the hyp-vectors work.
+	 * Vinz Clortho takes the hyp_vecs start/end "keys" at
+	 * the door when we're a guest. Skip the hyp-vectors work.
 	 */
 	if (!is_hyp_mode_available()) {
 		__this_cpu_write(bp_hardening_data.fn, fn);
-- 
Sent by a computer, using git, on the internet

