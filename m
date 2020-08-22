Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05FD24E8B7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 18:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgHVQXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 12:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgHVQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:23:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DD2C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:23:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b66so2254703wmb.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=IPB8O5eIYAyz+38AjAQyrxTyKnCLQB5VvQ5apakLrVk=;
        b=Dl473/kX7KLgZGYbfJJl3uQVl/CUqU1aKj30y71RNpxCvdGxwrDrHGl70rTlw7jCOQ
         N5WtyOfK4OioB8D0LvRyLCxvI7DVl3PVw7fmX1PIMghOYABlQhiRO7JkfeBoU6gHdLeK
         91T/ogw/6txrwK9ivDWiPyv22f55a2Ar9AZnzTevl905zypq1oeSeY5+A4Do10oAe5wk
         5vawJUg1mG4abgzbtgpasbxOt850NZxi9zkatZTm53L9pCr2ox1qgojIkMOcTi1LW00v
         hjb810/H4qrTfCpBQL1zg9pYjg+rKCCSEMC/mZTx0anXV25BDiDlQzCk37x8j7sNbcDP
         Xhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=IPB8O5eIYAyz+38AjAQyrxTyKnCLQB5VvQ5apakLrVk=;
        b=kpDcSmNetHSC77PTfv815QHgAVG+xHK8fKYBvDHPGorH0+LChQRbE+9eW+Z8TtCvBT
         4pqeA7BjaY3KY2VUjtvyxnOInjhLeYxw00EVc7p1LsSzVPI5BEbPV3q9KZhYFP80NvZV
         2Y/8npbu8gV3dNFZVhLMDbEu+TFGhlGK0K0dTRpnp6bjhIzIWX9EL9wlLLBUl+FplZcp
         GQwNX2ymcej9fGAAU70VMadQNgTDrAa9zrm7aysd+42nYdIFOdeZ3R/2QN6VWqwSwdDS
         fxBdNnuf2nwUgpEI9IVfMRA3tLtsctfABM1uQ5RsmZI9LMakrw9RZGkBRv+gl9PAxI6V
         tR5w==
X-Gm-Message-State: AOAM533eLBSM2VBkhFqWFWhxKOMTTS6tci5rOiVx6YGT5nHxnURA6Szz
        s28p3EZKlZM908URaw9ToLApqvUYdw8=
X-Google-Smtp-Source: ABdhPJwuzQQ1ZnxnBggUo6IqsXypC4i/l4f5/tw0jMK/JNEGGKMB/yDC47Ybz0MnNJS/vxZbGqi7OQ==
X-Received: by 2002:a05:600c:2512:: with SMTP id d18mr8080667wma.171.1598113420840;
        Sat, 22 Aug 2020 09:23:40 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id n205sm1359227wma.47.2020.08.22.09.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 09:23:39 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 2/2] habanalabs: update GAUDI hardware specs
Date:   Sat, 22 Aug 2020 19:23:35 +0300
Message-Id: <20200822162335.21295-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200822162335.21295-1-oded.gabbay@gmail.com>
References: <20200822162335.21295-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add define for the 2 MME slave engines.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/include/gaudi/gaudi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi.h b/drivers/misc/habanalabs/include/gaudi/gaudi.h
index 8829891d3eef..f9ea897ae42c 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi.h
@@ -44,6 +44,8 @@
 
 #define MME_NUMBER_OF_MASTER_ENGINES	2
 
+#define MME_NUMBER_OF_SLAVE_ENGINES	2
+
 #define TPC_NUMBER_OF_ENGINES	8
 
 #define DMA_NUMBER_OF_CHANNELS	8
-- 
2.17.1

