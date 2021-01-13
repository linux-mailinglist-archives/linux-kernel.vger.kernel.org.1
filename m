Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A1D2F4961
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbhAMLBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:01:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38835 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbhAMLBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:01:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3914823443;
        Wed, 13 Jan 2021 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535570;
        bh=02hqnGTUS5YhTP2z/VCY76S2cwZbqzkUNrtVW3wWscw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bp76ErEzNtCVNA+AIn8Z5iSWYV2oQEYfmmQxRzFhjkznZtI6dq9SDiA+kDekUSB1h
         V1yRM6pIcQu6161UiruJwjsd55ACNbY85D+lP2P3LLOnAprb9dPlIHoewlm7ZspwPd
         6pBJnfeMWAGMncgrEv9bMjcpawP07RsG6MEdiRUu/arWspnrrHunBE3z2ajn+34ePg
         oSwl0dYGuB2roaecBwIQeX4DSFtmFHdtjy7n2DaTYNpcEMTZGqdb3B0t7iOL14Cj8V
         yyDHv84cIxlY+Z5WhkbwR9CrjL+ZNDKbHKUOdMUkvrh0HEwmMClB/4dKq6zHfkr6UM
         /xVKFJu+YmU5A==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpGn-RR; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 21/24] dt-bindings: display: mediatek: update mediatek,dpi.yaml reference
Date:   Wed, 13 Jan 2021 11:59:22 +0100
Message-Id: <3bf906f39b797d18800abd387187cce71296e5eb.1610535350.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 9273cf7d3942 ("dt-bindings: display: mediatek: convert the dpi bindings to yaml")
renamed: Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
to: Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../devicetree/bindings/display/mediatek/mediatek,disp.txt      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 33977e15bebd..865e1e1b88ac 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -23,7 +23,7 @@ connected to.
 
 For a description of the display interface sink function blocks, see
 Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt and
-Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt.
+Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml.
 
 Required properties (all function blocks):
 - compatible: "mediatek,<chip>-disp-<function>", one of
-- 
2.29.2

