Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867EF28F4BF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbgJOOaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388410AbgJOOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:30:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD13FC061755;
        Thu, 15 Oct 2020 07:30:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m16so3370234ljo.6;
        Thu, 15 Oct 2020 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YWj6b+v4A4nDHvFR3J/ATINzPrOIqZfn4UXHHwCDC/4=;
        b=Byds2iHC/6Lvi5c2pk+8NB/fAEqs4wSyTpHl++pGBQXkDgQg6Lb5R7OK1lJkKyghT1
         5c3LHhGq1aBOofZSoHUoGD2W6ixDV6BlI56WiK5C0eDwi5HTDHRRuYPvOrobsvsnTKiW
         Q8Q07UsezAgFkzzAi1fYhttcWoW9zXhetBv9+EHULQjUS17MUYDWvi6CKEkLPjxktg3C
         0D46923PXeWG/s4dlNUajn1CIkqrs13FkF50aiZO4L3dm+oH4kQvMOysvzHa8VM0Wpc1
         A58UrW4X7XPwGTAP8B6suaG6u3Dcz/uHN09fhWNyPJm2jWgxze+kioVgBC6Be6KkT97q
         6Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YWj6b+v4A4nDHvFR3J/ATINzPrOIqZfn4UXHHwCDC/4=;
        b=tyEYIsSjxdjBsonO36QcHmoajuW70iP/ikfwoz9sQsPuc4+x7zIlBliQrCM+CCff+d
         SkMMjtNtO2K4pSYKrP8MUnjnlURBYDCUU32YgaQDP4E+9n6VEYNc6udVBmfjnmsm3i2F
         crpjpeKRL3inGlFpFmmqprT2l27lLcub6oaqtFE3jTw2wn/U1Xg2w2iPomi/HaIsF1tT
         hXcZJfQ+UMjLJbJ+GVUTo/LNjZmErQBUgOLuH8BoVUr/htLcPp6THKwMt3biedQ7U9aS
         i/b8DWdbhKHvx8LiOlhohalOVegwxzepvEj04Na7NHMXlcuyGiodZslVrZSdPFuKylyQ
         77PA==
X-Gm-Message-State: AOAM530cOYmcaJ3V0bRrLQuiSQlEcSy1RiUYBRy/pHnvJA2ETQ/H5GzR
        88D64zYEhfD1n1NbwffQlTk=
X-Google-Smtp-Source: ABdhPJyYGmf/5fGb0/i566F0u9IYo1CUHDznvu1JtXqPmwtBaaeroxaW3KuNo+wdl5aREYwHnBx9yQ==
X-Received: by 2002:a2e:874c:: with SMTP id q12mr1342241ljj.148.1602772211252;
        Thu, 15 Oct 2020 07:30:11 -0700 (PDT)
Received: from laptop ([156.146.58.201])
        by smtp.gmail.com with ESMTPSA id s14sm1350043ljp.92.2020.10.15.07.30.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 07:30:10 -0700 (PDT)
Date:   Thu, 15 Oct 2020 17:30:04 +0300
From:   Fedor Tokarev <ftokarev@gmail.com>
To:     rostedt@goodmis.org, acme@redhat.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        ftokarev@gmail.com
Subject: [PATCH] tools: net: traceevent: Fix 'snprintf' return value check in
 'tep_filter_strerror'
Message-ID: <20201015142959.GA18281@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'snprintf' returns the number of characters which would have been written
if enough space had been available, excluding the terminating null byte.
Thus, the return value of 'buflen' means that the last character
was dropped.

Signed-off-by: Fedor Tokarev <ftokarev@gmail.com>
---
 tools/lib/traceevent/parse-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index c271aee..dccdbf2 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1374,7 +1374,7 @@ int tep_filter_strerror(struct tep_event_filter *filter, enum tep_errno err,
 	if (strlen(filter->error_buffer) > 0) {
 		size_t len = snprintf(buf, buflen, "%s", filter->error_buffer);
 
-		if (len > buflen)
+		if (len >= buflen)
 			return -1;
 		return 0;
 	}
-- 
2.7.4

