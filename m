Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2051D2F6817
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbhANRsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbhANRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:48:00 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1551C061757;
        Thu, 14 Jan 2021 09:47:19 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id h17so5069388wmq.1;
        Thu, 14 Jan 2021 09:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtEEhUaxTt8j5XfHcvBkIaxKk170L8EAq3Kc5q2BKFw=;
        b=IE0vkRJiE0+WN8RvyDPbgW5cDvdQvp5UUSenmzo7NtbV8afQUXFWfl2KBMTl6MD+Ws
         0giuWeq8PzD89lAWeARvRjUzJnodn2lxuKRrPeLCuzNEbUgrUHmBMCh74hJCCtc/QVzk
         Tg8EE9nDX+x26R5rj03ext/GvhCcYULdreU21Gol7r6w1a+HLm87YplC7L72mCvGNT15
         yb6VKQMRDtSsEgVuoEEqKipe5hPGgqHNKAxb5wAYaK3rZ7iFqj/CURaOXaM9YesUg7Jc
         Lp839mlZJbHYXHF/W3Rxz5/Mk8sA7YdKWkCXvhzMs2NAS+oUG/If7IQ6jGOj+XsJBKhE
         rGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtEEhUaxTt8j5XfHcvBkIaxKk170L8EAq3Kc5q2BKFw=;
        b=eADmsXOUz/HxbYq7EBRYTHLTUL/M6iTFryR9NiVM4M7L4BbyXgl3ABC9W15tyINzg+
         Pe+L3i9A1CL1HmFlaqSR+6547D9QY0hXffdRKHWjklLyh3qCrXpGJh9aQ1ht6brWAC/E
         453jSbgHgg7nPIhK+kbJxB5CErH198wZQr0+ULjkve5NTJ8njjgHa+ujXTDgfMSRqeUN
         Mx9CvMw22f8dRF31tiOKp5EYTPBkgkxOWhCVm+jHF8DFGdxTqrbtlweQE0usXaZrJBR+
         udsN0KCLbiZLABl76NB+g80oNGexgckjSF0dtOV7oTTIaXGgi+Rt3t/yIdTQpkYqcCkU
         499Q==
X-Gm-Message-State: AOAM533LkJYbtxCjH8QkbbmYW46Iy3bESpKXP2j11tVrMPuraJi3PJJf
        trux/LmcQ6PTiby2FUkYN2A=
X-Google-Smtp-Source: ABdhPJzQnRwVvO7ej+aEeds+fRWVRNqY+5rduGQMyjoAgFjCV2mE2WK+4RQ+lW0F6u/cvfj8WqtXdw==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr4993076wmb.76.1610646438729;
        Thu, 14 Jan 2021 09:47:18 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700adae03a5d647a4d0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:adae:3a5:d647:a4d0])
        by smtp.gmail.com with ESMTPSA id g18sm5120663wrw.61.2021.01.14.09.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:47:18 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/6] regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
Date:   Thu, 14 Jan 2021 18:47:10 +0100
Message-Id: <20210114174714.122561-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114174714.122561-1-adrien.grassein@gmail.com>
References: <20210114174714.122561-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nxp,phase-shift is an enum so use enum format to describe it.
Minimum and maximum values are also wrong.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/nxp,pf8x00-regulator.yaml   | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
index 956156fe52a3..095cfdae7b67 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -73,21 +73,11 @@ properties:
 
           nxp,phase-shift:
             $ref: "/schemas/types.yaml#/definitions/uint32"
-            minimum: 45
-            maximum: 0
+            default: 0
+            enum: [ 0, 45, 90, 135, 180, 225, 270, 315 ]
             description:
               BUCK regulators phase shift control in degrees.
 
-              Listed phase shift control values in degrees are,
-              45
-              90
-              135
-              180
-              225
-              270
-              315
-              0 (default)
-
         unevaluatedProperties: false
 
       "^vsnvs$":
-- 
2.25.1

