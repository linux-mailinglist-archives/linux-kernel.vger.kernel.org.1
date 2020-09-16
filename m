Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1404326C842
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgIPSoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:44:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39436 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgIPSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:44:18 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GCHxrx021539;
        Wed, 16 Sep 2020 07:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600258679;
        bh=+1DhbG8Idme2HwVduZLQbbMrlIUjr/zU9AX0qPhimO0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=w8EFoSz7mXr4kbhXwZ1EyRXVTYx/ShT25/Hoy0NDZhH+VRDZ8ADBetb3Cn8xiFdEP
         GWu7OoqMy1Eyc5KsgPJ3ZUzxsO/HcAAhL2n8ODAeOM+CCBatuo3AV7L5i8HoLQ1KXQ
         jH7qBXfwBsrU9m3WIrw1Zd8lruH8f4VQGJ8QIt5s=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08GCHxFV058206
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 07:17:59 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 07:17:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 07:17:59 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GCHtUQ101755;
        Wed, 16 Sep 2020 07:17:55 -0500
Subject: Re: [PATCH v10 1/3] dt-bindings: drm/bridge: Document Cadence
 MHDP8546 bridge bindings
To:     Swapnil Jakhade <sjakhade@cadence.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <Laurent.pinchart@ideasonboard.com>,
        <robh+dt@kernel.org>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <yamonkar@cadence.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>, <praneeth@ti.com>, <nikhil.nd@ti.com>
References: <1600087715-15729-1-git-send-email-sjakhade@cadence.com>
 <1600087715-15729-2-git-send-email-sjakhade@cadence.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <37aacded-72e3-eaa9-f97e-488733da98ba@ti.com>
Date:   Wed, 16 Sep 2020 15:17:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1600087715-15729-2-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil, Yuti,

On 14/09/2020 15:48, Swapnil Jakhade wrote:
> From: Yuti Amonkar <yamonkar@cadence.com>
> 
> Document the bindings used for the Cadence MHDP8546 DPI/DP bridge in
> yaml format.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../display/bridge/cdns,mhdp8546.yaml         | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
I was testing this on J7 EVM, and looking at the dts files and DT bindings. To
get rid of the warnings from dtbs_check, I made the following changes.

I think the interrupt one is clear. The driver needs the interrupt, but it was
not defined in the yaml file.

For phy-names, we had that in the out-of-tree dts file, so I added it here. The
driver just looks for the PHY via index, but I guess we should require it.

The power-domain is not needed by the driver, but if I'm not mistaken, has to
be defined here.


diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
index a21a4bfe15cf..c5f5781c1ed6 100644
--- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
@@ -46,6 +46,16 @@ properties:
     description:
       phandle to the DisplayPort PHY.
 
+  phy-names:
+    items:
+      - const: dpphy
+
+  power-domains:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
   ports:
     type: object
     description:
@@ -114,6 +124,8 @@ required:
   - reg
   - reg-names
   - phys
+  - phy-names
+  - interrupts
   - ports
 
 additionalProperties: false

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
