Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6DD275525
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgIWKIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgIWKIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:08:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A168C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 03:08:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d15so21418976lfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Ll9U6XrekbR5N3wlwKdoF0YKO9JdUUYPqiXJDeJs4c=;
        b=O6iUG/KN2HvKkUXkbGE3fNwU8S3Rt/ohW6Eyp0wCBl8tY4Q6vMkRKgX8EfgmId2kCk
         tubtFIHXJz9ELsf4Te9Mo+1zHQp+Afx45nyhGoSKThC22xgpifvXKw99W8pEwhqNDf9c
         IqY1OeS5KojgrZonBO4eXIdMiDSgWEEqgOBQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Ll9U6XrekbR5N3wlwKdoF0YKO9JdUUYPqiXJDeJs4c=;
        b=G7PFQ1eH9ayvv/NBCdnFXmY35Pd4NcbvVr+37pM94rEYqS7hsLBGClVkb7/lXjKkET
         7hJihsIy8U5ahiRYnKdjPtrpYcXf/6QZb3s8lzDKydZK7ULcBhSdE24LbsVbIv02nbDL
         XetBNNTdUl7JmpZ2G+7Og1bowjxxIyM5rnzgSZWvhTvfRiW3KtHEdHeoBGhDp8+j9EaF
         sAdR3XZv+5UZRBzFr1ftONaokue///QDSLYOjF0SVuzFyrNpS5IdXZ7ysFngO8q65jd3
         FZsaTYuMnMPA3ZwZafIrPeqpWp+CAt7PrDiTnlIcbVT2K4Ld5Vjc6oMQNOTrtjQeDDMy
         sz3w==
X-Gm-Message-State: AOAM533NDncvKLTLGE105NTAEmFPodI8DiPmFAGZuCEv+fLUWxh+OTDZ
        RdWYpqLckadrO/231dYO2gDCTQ==
X-Google-Smtp-Source: ABdhPJykDnr4AHhFLrBFZZTYH/AlZyw2KDRT9Q4hNGss2vPY67UUrpL5j/7cloUMalVS83MiVnQSnA==
X-Received: by 2002:a05:6512:1090:: with SMTP id j16mr2867180lfg.3.1600855729829;
        Wed, 23 Sep 2020 03:08:49 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id b13sm4569584lfa.92.2020.09.23.03.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 03:08:49 -0700 (PDT)
Date:   Wed, 23 Sep 2020 12:08:43 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: [PATCH v11 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20200923120817.1667149-1-mholenko@antmicro.com>
References: <20200923120817.1667149-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923120817.1667149-0-mholenko@antmicro.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filip Kokosinski <fkokosinski@antmicro.com>

Add vendor prefix for LiteX SoC builder.

Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    No changes in v11.

    No changes in v10.

    No changes in v9.

    No changes in v8.

    No changes in v7.

    No changes in v6.

    No changes in v5.

    No changes in v4.

    Changes in v3:
    - added Acked-by tag
    
    No changes in v2.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..9aae6c56d7a3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -571,6 +571,8 @@ patternProperties:
     description: Linux-specific binding
   "^linx,.*":
     description: Linx Technologies
+  "^litex,.*":
+    description: LiteX SoC builder
   "^lltc,.*":
     description: Linear Technology Corporation
   "^logicpd,.*":
-- 
2.25.1

