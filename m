Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7692A11B6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgJ3Xnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJ3Xnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:43:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C6CC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:49 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p22so4272468wmg.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7e0bJaET19S6NiwsiKrSw9DA5X8tfkfCtJ3heEXMJA=;
        b=ZnksZC2NcbPUkfq+vaUmU21dq+/4Y1DE8Zbtb7hoemUajpaoQC3eAGY8vy3EkJd+xV
         v+MW5pz5mm+BRQ6DHP9M0uIvVrk7OPjiVcVlMz9exJp1n/+/Kuy35gyCamrFhuyS+/st
         KoLi7dWl3ebt+Y/ry4+ImVwE2ELmh3f4kZv+XqhshovXujZXALkIzEa/ei/gsINFHrVS
         HRX8SxLY5gZTHjVNtdj69ZqGXjqxZQk+ZsCR0OZ7sW00XwfIDH5Y/d6Pm6cSRN6qP7Fk
         GnoSS9xYkzCpulmzUSObtP6QKNM9ZG6LGGxLxLipnEbonN8kMKVnopoYZCyskDeipo1L
         pjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7e0bJaET19S6NiwsiKrSw9DA5X8tfkfCtJ3heEXMJA=;
        b=oXDtIXDx0T+ZAewJ1q5uApfI7UrAwasjCesvUyEaNkdRkl3bgaKGcRb3mFfZh5+sax
         UGtAUTEsnBTqbjkIaFrEYxCF4j0cpaAfLsmUWSabDvs1rJpTFk536Eh53ewmnvsu1NN4
         dBVMRrl6I6N1TE/jYlnq19Wi+HgHURffC8yGmdhVR+jbvZGXqFz7TdRjw2nrocZ4dvrj
         7UByhKsfzzBlCxd6i0x31qcmDmubWSyD8LFW/0qBEH3VIXuHPKSEsqX+lKxSy4xWblrp
         4k8wdAG2TUmmMqU39Ra0yA2khV8v6J4AfNWCi6zzT99YV5pKXjw6sI30eU8FeAOg/8Ou
         S6DA==
X-Gm-Message-State: AOAM533CHF4QYArBshagRErFZcwzndKc39TJKVUWFHRsnd5hI65GGudp
        s1BqAMgSv4GRBQrBfxBOT5c=
X-Google-Smtp-Source: ABdhPJwFlQ3R7He2sZ3b0qQ5qI4v49bO+mdccseT2upD1AqY1rd5chBEI/gWnSOE5NcevCuVt5Gr1g==
X-Received: by 2002:a1c:a514:: with SMTP id o20mr5511890wme.73.1604101427571;
        Fri, 30 Oct 2020 16:43:47 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id z10sm4702381wrp.2.2020.10.30.16.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 16:43:46 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v2 1/6] dt-bindings: vendors: add Elimo Engineering vendor prefix
Date:   Fri, 30 Oct 2020 23:43:20 +0000
Message-Id: <20201030234325.5865-2-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add elimo as vendor prefix for dt bindings, since we are adding a dtsi
for a SoM and a dts for an SBC

Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2735be1a8470..b877a3516277 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -319,6 +319,8 @@ patternProperties:
     description: Elgin S/A.
   "^elida,.*":
     description: Shenzhen Elida Technology Co., Ltd.
+  "^elimo,.*":
+    description: Elimo Engineering Ltd.
   "^embest,.*":
     description: Shenzhen Embest Technology Co., Ltd.
   "^emlid,.*":
-- 
2.20.1

