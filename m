Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00802F57E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbhANCKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbhAMWVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:21:09 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2746CC061795;
        Wed, 13 Jan 2021 14:20:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 3so3021967wmg.4;
        Wed, 13 Jan 2021 14:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EIeFCYJ0DLGf3Q0pQGTEuf3nHXG+YCy6iHntm2rbSr4=;
        b=KfW9lfxRIGsL3tqNOJ3zKDRWXD8V1A9W9mIVJP5czKpyVxm7HIQv959kN5qEWQn9yj
         BrqoXcY1hsyHcfAA3YZUJwR589gVhiGyD//4TQ17xUclwtyyvG0JcL3tmDoKEdlD/Uln
         ZBg3pkG2WUl9VKIYXsM+1QUiEBXfakuzsBV6pKaYGS9YJkcam7jWOdY7/e2ziQThtRSk
         dKW8rcu0J/6/jGtcBt+EEUTExTL3sP+eQNtjyho8DTrD1+gAAg9Jxp8aDcFwkLtI2Iox
         V9+tulU3S5TiRbdBpaYiQQ9Onib7CRALWRpCxoNbyJ5GXh1qC7DdihWfAUuPBfsO6DNH
         eF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EIeFCYJ0DLGf3Q0pQGTEuf3nHXG+YCy6iHntm2rbSr4=;
        b=TF5SBoesgYySJm5AiCkcfIobPXnu+B4zYQfXMClNzi7mIMCmRqHE5EBd/TXwTHZZb4
         NQ2jX7E+7ZEE7UtipoywlKPzDtpxZz5z6fubwHTAl6fgR+yaUfRe2hpiMf9kPpriF2Ru
         c8+1Kda9SAXtWCuBAOi90dNCORP05lhYJtlbYLzu8kR7fkG5gQuWeLuKYnxWoJwYkFDi
         WgwQqVf0W5aShQgwlGIaJuU8hz1AmZuEPlhP6JKQs7A2oaLyQ+wSl/mVam5bd5Kklu+i
         vKPub+J9I81H7lZELtV/WmIgMtW1URaZmaNpth74YSqeyGd2ABNU+gw33wKSEkCHY16k
         1/fw==
X-Gm-Message-State: AOAM530Vw89mkr2PIJtfi1Vx+Ty4url6fIB7fng27V0+2O60ZZb9G6jl
        wocFLy+fDDMWkedl+IyT0buhCrQjmzg=
X-Google-Smtp-Source: ABdhPJzBowBGUXukqJI1Ja5gGFyaG8qBJFePHkyT6PLx6lsgqkRXgX5m//q4TCC3d6qwoqnx8bSMYw==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr1137481wmu.105.1610576421827;
        Wed, 13 Jan 2021 14:20:21 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27000d88c7723353ad1a.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:d88:c772:3353:ad1a])
        by smtp.gmail.com with ESMTPSA id t1sm5594929wro.27.2021.01.13.14.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:20:21 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 3/6] regulator: dt-bindings: pf8x00: mark nxp,ilim-ma property as deprecated
Date:   Wed, 13 Jan 2021 23:20:13 +0100
Message-Id: <20210113222016.1915993-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113222016.1915993-1-adrien.grassein@gmail.com>
References: <20210113222016.1915993-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property seems useless because we can use the
regulator-max-microamp generic property to do the same
and using generic code.

As this property was already released in a kernel version,
we can't remove it, just mark it as deprecated

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
index 095cfdae7b67..5b76bbba8fe0 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -64,6 +64,8 @@ properties:
             maximum: 4500
             description:
               BUCK regulators current limit in mA.
+              This property is deprecated, please use
+              "regulator-max-microamp" instead.
 
               Listed current limits in mA are,
               2100 (default)
-- 
2.25.1

