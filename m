Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0160F2F65F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbhANQ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:29:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbhANQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610641672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8yD75pF/vAk1haO4n/osk173tkGjcYRvPVR8KdRHqlg=;
        b=b4O1+Zgc55R9MJRcukUn67Hp5iU1bMV5Dn7UvO9sgzXw+nFuZ0OYxW+CHcGejg9NXIC3Rq
        BNFxvG6h0lm9oObV8Hwgu8582plkFFqUjirZROETg8hzbmV7VA/j9+R7djHjlWtiryzPze
        0nnUY11WYjIKopxviIUBkim43F0d/js=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-ujX69XcYOAaAg2Y3XgQyTA-1; Thu, 14 Jan 2021 11:27:50 -0500
X-MC-Unique: ujX69XcYOAaAg2Y3XgQyTA-1
Received: by mail-qv1-f72.google.com with SMTP id bp20so4985115qvb.20
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yD75pF/vAk1haO4n/osk173tkGjcYRvPVR8KdRHqlg=;
        b=YQOKzqs3BstvXNQvYO1HR/aKhZscifdqGg7QqC1HX+5HU+n4vq4pk8e2z/5Y5YrbcG
         S7OH2pmikXCTjTas5vZQlBRbGFhjxZ+owDNhc9rw1zRK8dQpFgPfynvlaKf7oY90bdRG
         cQEeVl4B4yCW/qXkSkWYVphxRTKFDIwexQv06EbmzRfx0Q0XMJKS15BCcDeZFr5mBGAr
         MiunstygjFvIzSQtqDo85oCWIP4KyGF8eZ/KRMJ6PnWbijLTkYoVHmyQn+TGCePhNwOX
         xG/MVIqLpdAbE5zD4fKJCUHZCsb8LoIWjFiGlrKW0qf7YB3edgu7xEpx66aaCLku9Uhw
         +FFw==
X-Gm-Message-State: AOAM533gLlJDLnROVQ4YF324TArVOaqcKcJzEMrUypfDhWFa89f27oz+
        zJAImG/9RP+6eXnoZA3piTvbSpB5/6sQS/25JG3nxZyR7APDhtaE/xksOlWZdGDzdxADURKfGWw
        tfezQDnBYDE1WZ+l+64xZTPJ7
X-Received: by 2002:a37:bc07:: with SMTP id m7mr7847442qkf.438.1610641669695;
        Thu, 14 Jan 2021 08:27:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5euUzUV4d9tsF+Wpb4qh3Cp6/M0KuGoKj6fB+AUMM0dwmZPsDlXVQaEubKU9wxlXK5Liyzw==
X-Received: by 2002:a37:bc07:: with SMTP id m7mr7847429qkf.438.1610641669525;
        Thu, 14 Jan 2021 08:27:49 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e11sm3151555qtg.46.2021.01.14.08.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 08:27:48 -0800 (PST)
From:   trix@redhat.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ying-tsun.huang@amd.com, peterz@infradead.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] x86/mm/mtrr: remove definition of DEBUG
Date:   Thu, 14 Jan 2021 08:27:43 -0800
Message-Id: <20210114162743.20737-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Defining DEBUG should only be done in development.
So remove DEBUG.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/kernel/cpu/mtrr/generic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index a29997e6cf9e..b90f3f437765 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -3,7 +3,6 @@
  * This only handles 32bit MTRR on 32bit hosts. This is strictly wrong
  * because MTRRs can span up to 40 bits (36bits on most modern x86)
  */
-#define DEBUG
 
 #include <linux/export.h>
 #include <linux/init.h>
-- 
2.27.0

