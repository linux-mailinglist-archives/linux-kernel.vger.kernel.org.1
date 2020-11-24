Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190F22C258A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbgKXMTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:19:06 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5543 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKXMTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:19:05 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbcfa390000>; Tue, 24 Nov 2020 04:19:05 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 12:19:01 +0000
Received: from moonraker.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 24 Nov 2020 12:19:00 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <treding@nvidia.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] dt-bindings: Correct GV11B GPU register sizes
Date:   Tue, 24 Nov 2020 12:18:42 +0000
Message-ID: <20201124121842.1037035-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606220345; bh=0es/aNpBtueAk7MF62Z8gKogQAxyP9ER3IPb5yeGyeE=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=f2Sjkdyz77IXprxPGWnt9BobXFk2bzY75hV8CZ6Srn26g2k+DRT42qEj4FOph9lI8
         uTqYUm1Z8ESip3QrxYnoTlGhrVgyyn3DXPnf/3ABeO8fMNbod6aza2DsS0mcrAF+va
         twPkhFyrHfIdDN4ZdJ7MpmkaDrHTjXYqLaZ8+L4XOV8+IEVu8L/e1rqRQtuA2Ca+b6
         oqPdy8g41kO1VavTKz7P4oFa6UWGwzbzX0HFa/SBS8EgTJDAuEG6IR47qm3fLaUogt
         jr3phQThY3sUqRBcoYOPxNSJkZWiytF+BdRUF8id3yg4AuK03l/E+ABed5asZ42wUK
         JYvNBCj22Yyxg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 90a09178f309 ("dt-bindings: Add documentation for GV11B GPU")
added the GV11B GPU device-tree bindings information but incorrectly
added an additional 0 to the size of the addresses in the example.

Fixes: 90a09178f309 ("dt-bindings: Add documentation for GV11B GPU")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt b/Docum=
entation/devicetree/bindings/gpu/nvidia,gk20a.txt
index 662a3c8a7d29..cc6ce5221a38 100644
--- a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
+++ b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
@@ -97,8 +97,8 @@ Example for GV11B:
=20
 	gpu@17000000 {
 		compatible =3D "nvidia,gv11b";
-		reg =3D <0x17000000 0x10000000>,
-		      <0x18000000 0x10000000>;
+		reg =3D <0x17000000 0x1000000>,
+		      <0x18000000 0x1000000>;
 		interrupts =3D <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names =3D "stall", "nonstall";
--=20
2.25.1

