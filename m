Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D8B2AEF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgKKLNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKKLNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:13:01 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9302FC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:13:01 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id h4so572126pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YdWbQxLp33RHckc2JoEQGpXMvb3tuTAMWWCBXTDZb1I=;
        b=JuDF7nBPQRf+64Qc5df/moSzxjU99amA4md4JdLy29/1jUkS11Yf81cg/YchuMmXY1
         GlD9nbfJ5qs9g9znlyY1n/ux187XAB/tu2pco4r7TAv5EBBN4aEXKovdZ661Z2KmYTeh
         QhqZCAZPW8DdsPhnEXBcXlxB/WW21OoMUzlt4CegCAtJT/MmWLkVtBP802b7cPUXleD4
         hn/zx1f5RaL1yDaaDIoSTObds9DCdetfnpnD3Y1tz1StzVD285uwfTp0KXaKbF5tX3gF
         mRAJYnDTKPlkTNvPfTHYQexg3ovzz30ZI0jx8JK7hvFbk8ZOBUoFNnbfvcRihx61kU8D
         yIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YdWbQxLp33RHckc2JoEQGpXMvb3tuTAMWWCBXTDZb1I=;
        b=tRV6Yk1HFwXtgCEy8R2gt7ib1DIeuiF1i9vuVf7Ckc4uB3qNLlB70Mni4L47FcCsG9
         77SOJFD8T7CmbhD0J6qH1nZeIj157gismTrKtfwyc/o4zvMyBcL4StDVU73IDm/O5Ri0
         FHM/e75hDRl955yN1ARSuKT8Kf2N3mdD70xYFqXyDWHyv2la/futYCz2MnCoq6ue2Fj9
         I850revGemzd7Jj4gt6F7aW4vsWaqOzhBWzLfa5VCVOrL7f/Ph27Jd94lLw8q3nqKp1M
         ms16glvHPoM675/xyynDxae/UWuIH1HBGmHGExg+CldcSWoW8ESF3Tv3BQQcmyhLdJnE
         VPag==
X-Gm-Message-State: AOAM533N5zgAEO22JAqapFqYsLfKir2MVvkyXLpBgkrAtTicXlDCn4kq
        c/ZV1z/v+wc2b5tm+mVDz5w=
X-Google-Smtp-Source: ABdhPJxZj8WCNLIFvRpP7qEdocBsTXy/bhof4EulxC7la2b+e54Knoo4vOZUfhW2td9upsS4XdBvtw==
X-Received: by 2002:a17:90b:b18:: with SMTP id bf24mr3324753pjb.193.1605093181110;
        Wed, 11 Nov 2020 03:13:01 -0800 (PST)
Received: from adolin ([49.207.192.155])
        by smtp.gmail.com with ESMTPSA id i2sm2024649pjk.12.2020.11.11.03.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 03:13:00 -0800 (PST)
Date:   Wed, 11 Nov 2020 16:42:56 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: coccicheck: Correct usage of make coccicheck
Message-ID: <20201111111256.ea5l7slw4cc2fggm@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command "make coccicheck C=1 CHECK=scripts/coccicheck" results in the
error:
        ./scripts/coccicheck: line 65: -1: shift count out of range

This happens because every time the C variable is specified,
the shell arguments need to be "shifted" in order to take only
the last argument, which is the C file to test. These shell arguments
mostly comprise flags that have been set in the Makefile. However,
when coccicheck is specified in the make command as a rule, the
number of shell arguments is zero, thus passing the invalid value -1
to the shift command, resulting in an error.

Modify coccicheck to print correct usage of make coccicheck so as to
avoid the error.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 209bb0427b43..b990c8a60a94 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -63,6 +63,18 @@ if [ "$C" = "1" -o "$C" = "2" ]; then
 
     # Take only the last argument, which is the C file to test
     shift $(( $# - 1 ))
+    err=$?
+    if [[ $err -ne 0 ]]; then
+	    echo ''
+	    echo 'Specifying both the variable "C" and rule "coccicheck" in the make
+command results in a shift count error.'
+	    echo ''
+	    echo 'Try specifying "scripts/coccicheck" as a value for the CHECK variable instead.'
+	    echo ''
+	    echo 'Example:	make C=2 CHECK=scripts/coccicheck drivers/staging/wfx/hi_t.o'
+	    echo ''
+	    exit 1
+    fi
     OPTIONS="$COCCIINCLUDE $1"
 
     # No need to parallelize Coccinelle since this mode takes one input file.
-- 
2.25.1

