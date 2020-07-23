Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7183222B384
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgGWQb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 12:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGWQb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:31:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128E4C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 09:31:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so1599990wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AOR9CWeJuwlfcC0ivw1l00zq41D7Ws4IJqmIaQTlIjE=;
        b=aZTM8s034VEPV3IZTwcmgbP+Hfo6KRWNFN2fNY5wOilJpaIpIZZVBXNt5974xhVK5w
         xkAuP1Sj59ZlJWXrg7D4ABuINLuIlZGf2RISF++y6l6hOVFmcKZlO4mLIwLc1IhoUjQN
         nJTJuVVIzLXQlcuqEyvPRPlF5Y9PCHNWO6JJ1ZGFCY6BsSsoRPICtlAWBnIXDqTI+dc8
         N+xbO3a2Rn62SvTHL2/EjePjZReOc1wHCiqeb/8yGHk+OrKj3POEE+93k1oaXj427wNs
         C6Nriv6kwYGeZAX4TlhKCOG0B6djIswDl6tEkuqF9q0fRNFW+DuA/Ad5y+tCnrNeUaHE
         v3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AOR9CWeJuwlfcC0ivw1l00zq41D7Ws4IJqmIaQTlIjE=;
        b=hAMOq8zo4sFfEucGUH7TccucqOg9HaNyb444wfSJ/DLqtmQz/3bU5Ol3VkFCJgnsMq
         TPM7R86GEFADQeTixmfTangJbTxQkENvobdX66HYfX36/W1M4djZM5QxeQ3xsg+iJDpE
         Kss6B2pnBFBK3G+CVbXv7uvbS+F2GKO7fgYcS652vVgpEPBTvHizFIuF83SIdFyowhWC
         cTTSGJnT+ye0OehJ71+vGyEVAK7ZdzXGeqq5nThRkuYvjHHwDK5lQfazMBuC+76HJ5Ci
         dnAwcXA6DoFnA1yvqtTTnIjBO+1w8dqG8LPQGu75i6L/dV4TWJvolJ7AtbSiFeA91C1Q
         vOFw==
X-Gm-Message-State: AOAM532j6+C+KLeC2ZRf/uTY7mSOTSSd1avpc91g/pW0C82vQCOfNVMN
        U5IaTElgmwxbiNSueSLIqs8=
X-Google-Smtp-Source: ABdhPJw9jobW8joAQpGFg2mEwGlf+Nou+0YtHulyia4rcCKeaQHc+ebdoHrw1Obs1Un/nUEKUPg7xg==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr4712375wmg.17.1595521916786;
        Thu, 23 Jul 2020 09:31:56 -0700 (PDT)
Received: from musamaanjum ([103.150.154.211])
        by smtp.gmail.com with ESMTPSA id t15sm4051221wmj.14.2020.07.23.09.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jul 2020 09:31:56 -0700 (PDT)
Date:   Thu, 23 Jul 2020 21:31:50 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     musamaanjum@gmail.com
Subject: [PATCH v2] staging: octeon: Add the license identifier
Message-ID: <20200723163150.GA10505@musamaanjum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:
WARNING: Missing or malformed SPDX-License-Identifier tag

Add a the SPDX-License-Identifier tag on line 1

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
Other files in this folder have GPL-2.0 license. So this file should
have the same license which was missing before and checkpatch.pl was
giving the warning.

 drivers/staging/octeon/octeon-stubs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index d06743504f2b..3f8e5713b8a8 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #define CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE	512
 
 #ifndef XKPHYS_TO_PHYS
-- 
2.17.1

