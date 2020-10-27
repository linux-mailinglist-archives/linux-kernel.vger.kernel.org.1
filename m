Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCEC29C805
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371342AbgJ0S7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S371330AbgJ0S7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603825182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=sfTbKiw+jeF8w3EzHE/NJ0fzZGcPzRXq1w6rKzCOzNQ=;
        b=AYFbW21QJHv2mZHoVbI6L6zXNYPL71ai5R8RxoK/ixWMT8H/GgEgftvj8o8RbA2RXL0E58
        ZsJphKyE+1ts0nGk/ga5QmL2sP/IXk/dxmwEjK8LWcuF6updZFSC2ELtuiAWeskWfivhcm
        KvoCN34rgF+Gj76h6/l2NjIOkRHleF0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-E0W7VSHjPDG4aqzRWxc9jg-1; Tue, 27 Oct 2020 14:59:40 -0400
X-MC-Unique: E0W7VSHjPDG4aqzRWxc9jg-1
Received: by mail-oi1-f199.google.com with SMTP id c198so1116438oig.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sfTbKiw+jeF8w3EzHE/NJ0fzZGcPzRXq1w6rKzCOzNQ=;
        b=J2Z51n3Md2FZoaD9SimWXwe0tEyeV3O+vWBhbGadDP6suzSYhBc1F72oda0RFNzCNC
         CQyZXtcvHwUc34/LQl76QnKtg09Kjn0EVFWHG5b3NJWkvKRu2m08JyrqSTr0wYRqeZjs
         lG0bRZ778BGu7o4dJdRmU0fSn4bSmGUnsn4P46K3rJdUvGq8v8o6Ix23dIO7PhwweyKT
         HFF/BXJ8bQQakGLE672z8n4SJ/i+nJNcjKS/tfznCLWHxFjPQtY2yoJpJ9z+VJL5mZri
         Qiq4QhDEJuDnBN/+U9FFOJBdt8yvDu301OsTlUt+tuUgdcLr1bGkWz7jPthYyanU3ydK
         w1Qg==
X-Gm-Message-State: AOAM533Q3zpDUIuMf1D+gDJbDKe30sju/qWDMvUAuDmHEH3/JmlCP6hE
        2Nh50ng6A8MBksRcVcUVSZbjLoat1mU8dgn8TGNeoF3v6xLN76Wa50A5KZDcZLTjXTC8y9wzZ5G
        yxUZfae+Ueo5gosR4pAp6biWa
X-Received: by 2002:a9d:604e:: with SMTP id v14mr2407291otj.234.1603825179150;
        Tue, 27 Oct 2020 11:59:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWlj7rFomA6Zy2XUfPuGp7CTLGBrS2ZZd4sxN3Xe36Gr6sYTM4EsopH4vRTx8gFR+VXXcwpw==
X-Received: by 2002:a9d:604e:: with SMTP id v14mr2407284otj.234.1603825178972;
        Tue, 27 Oct 2020 11:59:38 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c128sm1891974oob.23.2020.10.27.11.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:59:38 -0700 (PDT)
From:   trix@redhat.com
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] cpufreq: speedstep: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 11:59:34 -0700
Message-Id: <20201027185934.1586984-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/cpufreq/speedstep-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index a13a2d1e444e..0b66df4ed513 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -240,7 +240,7 @@ unsigned int speedstep_get_frequency(enum speedstep_processor processor)
 		return pentium3_get_frequency(processor);
 	default:
 		return 0;
-	};
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(speedstep_get_frequency);
-- 
2.18.1

