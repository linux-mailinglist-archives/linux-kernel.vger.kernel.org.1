Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0882F57E3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbhANCKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbhAMWVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:21:02 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39868C061794;
        Wed, 13 Jan 2021 14:20:22 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c5so3765562wrp.6;
        Wed, 13 Jan 2021 14:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtEEhUaxTt8j5XfHcvBkIaxKk170L8EAq3Kc5q2BKFw=;
        b=t2jAY3yHico/ObRfDdy7xiLEy9mjYFcAcL/gAph7CoyHxUC7C6iSneBTYJCWSK0L+N
         6bKDXxfWT//cIz83xyNFSICbRqgiEu7BkKecYaLyFEB9zGtyYr0imp5vCcVIPb92F+p/
         JhhkIyxKMdZFl9w0w79l0qh78PlGJCZ9WVWQIetfhX3LlnRaZ4snHueKOflrfqyX9ID6
         O+ZG3UCmwc6ktmBuM5QgL5EK757SwPglpNfEQQdC6EP9biCHOFmC+1GgTMeXR+8Lu8AB
         DviiZDxcdDxBLkT3Pn/iEDj61UfWbUPkRGBeeYYmnW32cfw7zKCY6X3lMms2by1GKBl9
         nlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtEEhUaxTt8j5XfHcvBkIaxKk170L8EAq3Kc5q2BKFw=;
        b=UbqtG/5D2DQ/YUcndiglJMfK6LK+Zzjk5i1a9++Z3LqPxOXH0n6rr8hdWbzwfFYMhL
         Fj2y+UyEloIg2DgoVE5Ott5j0DF49qKsHdfCcFtn3ep6T197F6ua79vV3INeTZzW68gw
         sv+zDfvft1A7ScbAto0BhvFyDlx4P5ydIeZ50eW5FNki8C1EdDJeme1Jjp5NULigomDO
         nEiJ9N5/zYeccLtEob7EkimFv1b/ksBICOgwxTb9RIjYcOeWVp9lwU3pqqy39PVd8/O9
         jQX+lY0HGg+IfY6Sv+iuRRXmxu6lci9WtSYOBUhZRQtDneNgNE+MYtFB6OsDTm1FSTyL
         tZvA==
X-Gm-Message-State: AOAM533g+ix3/YUfKbwoxV/P3IYiHwvl5bOS9m/oYgCxMspZ6k8lk0Up
        KbeG23LUNFQoVYpA9WZ8OTQ=
X-Google-Smtp-Source: ABdhPJytCseclbg+Aop+UVkMZhYXTGwL3POsB79+AAQXrCkjdyRDJ3wkk9zFQNdTn31DdrLEslQ5OQ==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr4639636wrq.75.1610576421030;
        Wed, 13 Jan 2021 14:20:21 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27000d88c7723353ad1a.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:d88:c772:3353:ad1a])
        by smtp.gmail.com with ESMTPSA id t1sm5594929wro.27.2021.01.13.14.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:20:20 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/6] regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
Date:   Wed, 13 Jan 2021 23:20:12 +0100
Message-Id: <20210113222016.1915993-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113222016.1915993-1-adrien.grassein@gmail.com>
References: <20210113222016.1915993-1-adrien.grassein@gmail.com>
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

