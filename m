Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF72C2F681D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbhANRsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbhANRsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:48:01 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C63C0613C1;
        Thu, 14 Jan 2021 09:47:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r4so5435144wmh.5;
        Thu, 14 Jan 2021 09:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88PJilJPUmCioVbW/4bjwv5wSt9qwPSJ9TKxxvO9lk4=;
        b=GjKuuwgbh7KiCrLVqLeHpZ1Nkk9F3q/HiEfpzRMGsVLLgurZ0FLtPuC5yq87VPF+Ot
         XlbkyMHWKowPeQmnoVQpKkyIv20vJ2Lc0/KDUUWg3wYnqvENW82Y6WF+rnUNAeUmIoKK
         spuOu75LZrUEIq1jjmJ4TjuLLJ1bB5tZ14SmsPnspKExUrwBQNljf7EotWRnl9s7pG9R
         fCzafy7bcafAEHiqT07dzHvOBMWtMzWcvFfF5xH31U5zlwYZumHOr738fnr9QQxfEcyH
         W7fmKxoHLuj1djTRARtkawhBk9x5Vjfgk51Iqsf2lNzE0ktnB5lGUJHRR4Y/3HJ/KN23
         5VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88PJilJPUmCioVbW/4bjwv5wSt9qwPSJ9TKxxvO9lk4=;
        b=t4zQigQhWasxRlCcnI/aEDSu1sRetMAmjSM14z1I/4K4FXKXR+UcGoicKKEceb4pOr
         idYME1hTyCuWrlYeo9U8ei46XI2zrrUvU8XvOKX4bXZUY/maz8EpUq9ZxITjqnIid4U/
         KBf+fPxyEtZ8B5Z1EqWzJf+XdM5Zhd8XVDWHDkx/GXrNd4dEKTyAHz86r2iEdYGNyyHJ
         6tI+yrmQx7QBiYk1n/TEjCnImu8M8BvFK82gVs+g5F3p64K13rG/tZTHHTZH+4rgzRRd
         8uZuFI8qtF6CBaSpuvSdSmEPfyUaXJ4i8O0Q601wuqdz+eUDL65A3PgM/8rfGJKJNTns
         CNgg==
X-Gm-Message-State: AOAM532aePzjINZdYKPKsHzzQaiaIPUCjce4b/3aDQC2pZJQmHnvU7XQ
        YhQZBp7iMU6wrDDAOUc9EgI=
X-Google-Smtp-Source: ABdhPJwuKBUkZsTgygITotPoFgUQ+4AmoXivqWqt7idxqoxoQYDajWBpG5xIULGgRIODw/lhd3auVQ==
X-Received: by 2002:a1c:bd09:: with SMTP id n9mr4890565wmf.32.1610646439475;
        Thu, 14 Jan 2021 09:47:19 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700adae03a5d647a4d0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:adae:3a5:d647:a4d0])
        by smtp.gmail.com with ESMTPSA id g18sm5120663wrw.61.2021.01.14.09.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:47:18 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v5 3/6] regulator: dt-bindings: pf8x00: mark nxp,ilim-ma property as deprecated
Date:   Thu, 14 Jan 2021 18:47:11 +0100
Message-Id: <20210114174714.122561-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114174714.122561-1-adrien.grassein@gmail.com>
References: <20210114174714.122561-1-adrien.grassein@gmail.com>
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
 .../devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
index 095cfdae7b67..8761437ed8ad 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -62,8 +62,11 @@ properties:
             $ref: "/schemas/types.yaml#/definitions/uint32"
             minimum: 2100
             maximum: 4500
+            deprecated: true
             description:
               BUCK regulators current limit in mA.
+              This property is deprecated, please use
+              "regulator-max-microamp" instead.
 
               Listed current limits in mA are,
               2100 (default)
-- 
2.25.1

