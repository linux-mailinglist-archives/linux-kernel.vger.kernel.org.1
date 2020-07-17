Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FDA22439B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 20:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgGQS6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 14:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgGQS6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:58:22 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B66C0619D2;
        Fri, 17 Jul 2020 11:58:22 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 11so252629qkn.2;
        Fri, 17 Jul 2020 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59rqpmjw9MP9oZcVaGfVDuXgQuXi1NkPGYERrH5JizY=;
        b=KIn3yRo2+WdESGNcAvIqKxkjlroVuHxEgjLr2EWMa+sLpXLxdetHxr0C6+SFgz9I1J
         mzT4SV5Wroc52hW5SncxJq5X4i9smcprxrGqfBc/9cmXdh9wc39qbeBRzMAeiQlZ5C19
         aOTVIYjYDhMI8UapO6FZB2WUY+XRTmGuEPqNTr5uSN4gTVtlA+9rR4lPoPZ3Zjwjldys
         NCX+hqG86qQTwsL5Ygdaip9F+E0VT6eOBfvpRE7xTlgl89tg/R8rJbyPlPXBtzb0Qo00
         v4ig8GqtTHFI0QmB/qx3SR+281AKcT6vVTpXxz1IJscC3SCdA9Mws44sPomiJtOOkr9t
         Cx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59rqpmjw9MP9oZcVaGfVDuXgQuXi1NkPGYERrH5JizY=;
        b=nmiIsZQ/LReOxaZiwBiXLD8QbdZJ5Mfnwe1WDKngJDCr7gkHltCCe3Wsa+yp1seHfv
         E0J7Q1XL66R1AAT+j/4oL0JESm6OHvjDUIjKsheAezQ2Ur/4eECw62pBXSGItBkpZAAL
         ykrdfiE8j/MmzPpj+Pj+UWTQqPla8eF4/sK5+mENx4snFFyTRcdW71G2aCz4SR2z03RA
         dHcb6Oo4Dok0ZBFJ4m9gdoXyOngdvlXFEPkuh52LJ4E4LatS+P+VjLoP0zHzg3l5PSRz
         G3P4Ocfo/nyj2y7QjtIXv7HC8PGlS/p4zJ6gmmkDDF9VtrKhXXgtxBR2jwovkenrFeph
         vZ/w==
X-Gm-Message-State: AOAM533jhsjwdAMRG4H6KJ9+8+WJZ1syRIf9AOJ/76uWdnVVMdYHBPVN
        /NJ3sb5Qc7XiQn7SI2teSwI=
X-Google-Smtp-Source: ABdhPJzYposdprAS2cpXyzFL9GrN7o/hmI7BvStRSdhZsj03ZuOCFDfs9iNyS82TlHXP+rtXUPNQvA==
X-Received: by 2002:a37:6191:: with SMTP id v139mr10291862qkb.213.1595012301723;
        Fri, 17 Jul 2020 11:58:21 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:58:21 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/25] Documentation/admin-guide/device-mapper/dm-ebs.rst: fix sphinx warnings
Date:   Fri, 17 Jul 2020 15:56:19 -0300
Message-Id: <20200717185624.2009393-20-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warning:

/Documentation/admin-guide/device-mapper/dm-ebs.rst:
WARNING: document isn't included in any toctree

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/device-mapper/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/device-mapper/index.rst b/Documentation/admin-guide/device-mapper/index.rst
index ec62fcc8eecee..6cf8adc86fa80 100644
--- a/Documentation/admin-guide/device-mapper/index.rst
+++ b/Documentation/admin-guide/device-mapper/index.rst
@@ -11,6 +11,7 @@ Device Mapper
     dm-clone
     dm-crypt
     dm-dust
+    dm-ebs
     dm-flakey
     dm-init
     dm-integrity
-- 
2.27.0

