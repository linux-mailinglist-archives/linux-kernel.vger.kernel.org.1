Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8133928D091
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbgJMOpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388932AbgJMOpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:45:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37C6C0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:45:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a9so22406407lfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jlIMHmRJzRdhdiHnj8E8zCbvxaVzpiEGp2QpRRia+RU=;
        b=vJzCHeggFHVLBcDajiEGnH9kPwV0axI0dKUEtK3EgLI6EdXYAU7/mWGlFLi/H3QNp5
         c1S6oWHuRfxPHqyx4h0B5PNAWE1l5mBOG1M7gQYT+fcdE/T8IG2b1JliGtCbKIejTHcq
         Y5K9wAQNgHBeCrceN3NBoKgcDzcjBr9O3JGkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jlIMHmRJzRdhdiHnj8E8zCbvxaVzpiEGp2QpRRia+RU=;
        b=Um56rxkJgbAQq1EOkoP2vUAJ5ZE9DG4qkXBHVARGFxLtw5gBrK8wHA/AXWW2kbdGTj
         eSE8wBjnPEREPfOV2PlPLBESJ1AFpK0PNlqcL5kaBU1gFj6JKxZYLXccbd47XFKaXQLc
         TYR9d3Kc+TE8+WUYEsIzlwvMGyb+hh5z+/691uvNaRJ+HRDViKSDb6E5N1zjGjwKSFM/
         UjdXXgtjkLBUtrgs1L+FE1l9vHZpIAqMr86Gc9kIdoANOp2Kx12y4y4BxRnn3Aye4Qp9
         hLgF4FQT3NIH1m6Z7XZ0y8eslu9XXpMlrMsjqV6JFVIrf3fzGmgppmOdDBXXiWDLZEhX
         37rA==
X-Gm-Message-State: AOAM530HQ9T6lzpYgkbnut/BFWz+oXTaalIvO7g7kPTbKM2QvKfKBADD
        DgFdG8QQffsdb9yGxvOXt+BmIQ==
X-Google-Smtp-Source: ABdhPJw7dq7jgtXKc/GuCVJ2dgz7UjE/8XjamhQlnHEOveKXv/uAZKy91+OxOuQ0PmgFc/JNiH0p4Q==
X-Received: by 2002:a19:3859:: with SMTP id d25mr11166271lfj.179.1602600332185;
        Tue, 13 Oct 2020 07:45:32 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id l129sm4452924lfd.191.2020.10.13.07.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:45:31 -0700 (PDT)
Date:   Tue, 13 Oct 2020 16:45:24 +0200
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
Subject: [PATCH v12 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20201013164454.2002023-1-mholenko@antmicro.com>
References: <20201013164454.2002023-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013164454.2002023-0-mholenko@antmicro.com>
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
    No changes in v12.

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

