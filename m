Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A592F89B1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbhAOX6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:58:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727954AbhAOX6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610755016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8BoaeYSbnhYHGMsWAgpt+dfteZsuHNcO9/b1daInITU=;
        b=K70WOXeZt2i1kmzbT8UV22ZdT1J+578ub6L5Mhmd9BsWoobKt3YUi8zRB/Shab8oMOeCkn
        aBu3LvxeEz4ftGAHlf6Gl5tqXIBEDSQsGms8Zb2H4wrQO85QifdWw+2Vqd54kQBFVxD/Yc
        q19qPUVX8y4jk9OYTS6L00ucAtIidNE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-UiJxA8bdOoSwUtFjtGkVUA-1; Fri, 15 Jan 2021 18:56:52 -0500
X-MC-Unique: UiJxA8bdOoSwUtFjtGkVUA-1
Received: by mail-qv1-f69.google.com with SMTP id l3so9259052qvr.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8BoaeYSbnhYHGMsWAgpt+dfteZsuHNcO9/b1daInITU=;
        b=rZ3DzkD+QsinaNcd4A4e33WG4AYSPSJQULg6p9aYts4+1Ny5mBqxjqAai/WV7bqhkf
         jydptYuEnKiiyvQ3Jae+FWJm/pHmlj+CW5GtXk4XnWprap7q/W/VU/n4vGiO+FNNDmMU
         JJpuv0TkpKvBKgConaxZAyelcSdaWejYms5LPfwj0IcINW0D2e/EthMPBSKyqLHx8AAo
         xmx6gciALVQVLCKCIQQxud2+9DO8t3Trw2cXoZFJFaqTx0lrKamoF0sCDiNVRIvJWogT
         aEZn8Tg6iAcNCG9bRHttEb/001XS9fHplTgY8pS60YHN7/+BVr/4OPUkOt5T2stXpGMD
         DGGA==
X-Gm-Message-State: AOAM531yazNT/f+GfCiYPioC3FgMdKD6PK+2gE4E544bQGXc4ipQL2Fc
        V+Er4x9diZ+hVGjnMIIMHavDGOUPf7VkuJJf6OPzpog7EOmywboxV72pgHvq/43Y6F0kc3CUIvN
        MfDs62JfCjIQ9qCZkPq9R7r/z
X-Received: by 2002:a0c:d403:: with SMTP id t3mr14890951qvh.4.1610755011962;
        Fri, 15 Jan 2021 15:56:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjKSLexl7Fp6MgKjz16sscMkGaxTgQOsQ1o4HAxGadnjYl7TlbGw+xYpjqr7eylu8ADlekUg==
X-Received: by 2002:a0c:d403:: with SMTP id t3mr14890942qvh.4.1610755011823;
        Fri, 15 Jan 2021 15:56:51 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m64sm6010151qkb.90.2021.01.15.15.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 15:56:51 -0800 (PST)
From:   trix@redhat.com
To:     jacob.jun.pan@linux.intel.com, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] intel_idle: remove definition of DEBUG
Date:   Fri, 15 Jan 2021 15:56:46 -0800
Message-Id: <20210115235646.290819-1-trix@redhat.com>
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
 drivers/idle/intel_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 28f93b9aa51b..3273360f30f7 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -37,7 +37,7 @@
  */
 
 /* un-comment DEBUG to enable pr_debug() statements */
-#define DEBUG
+/* #define DEBUG */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-- 
2.27.0

