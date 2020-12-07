Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E772D0D36
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgLGJla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:41:30 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:49452 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgLGJl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:41:29 -0500
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2020 04:41:28 EST
IronPort-SDR: /GNf1k3r6g7zoHSmda2y1LZxQcHJt6cExAwV83bn+BKevUYrwKA10mUYYcqWLDpk/fDuAsEi1s
 EPreFuhzTL5kM4Hk+SnLdVlRS+ZikwK0OB52dFThTdhRiFUHENna46ma8NSTrJxYOeVEB5U/b0
 5QKQvL7WzImc0BgG4Q0RRJq8OkE1iLNKkdUdRg4e0H0ouqu8LIbmJXN+iI2u4veUtDnew79Bw3
 urSwvx8aPQo0yDG7g03DhDlcbfWDXuGe9ZplSlnSC3q1TVVbEi/33/BdGL5kRmjGDxFI8LvVEo
 d70=
X-IronPort-AV: E=Sophos;i="5.78,399,1599516000"; 
   d="scan'208";a="15063546"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Dec 2020 10:31:38 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Dec 2020 10:31:38 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Dec 2020 10:31:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1607333498; x=1638869498;
  h=from:to:cc:subject:date:message-id;
  bh=UOXhKhew792DWKPSXP/HOL6B6naG2LvvyuBO86TcfZ0=;
  b=XrcG6Z+NcqbRETfHmZjiIdN0c4S18UKNWAtY+uU1zOyHdU9dTintlcHb
   cZ/+dmRUxynV434l0Vl3yH49a0tiIjLUHvlpnzoglK3ISQLYGOHk85szp
   JDRX2wnBOd2ngoCfbcox7ti8/Iq7Ze5SviZC+SN11Fd+qAg979tSSrFFs
   JrF/S4PTFRsTpfYQhJTfJhyphRp+ZZNMzhh4myfrxNlzR3fuBmdyDMIxj
   b6OFHLIVcP/WwUipwkbyn2mOdO1Wn4VEKKTutJbhiCiYVUonD30+f+Ew4
   LrVe2xyZwX/uLrgdvx3C0vDqQivMg4kqEm3UhHlRb7DhoRvcl8gH8jGc7
   Q==;
IronPort-SDR: +KrO04IhMcntlV/SorEtNQjgbqKO7kerxS37C3XzN4K8lfM8o7Yohvvxn76AUIFagbzd+yK0Gw
 C/UxVVFC3EQlCjyxPAjbhF7KZDXCfmoWs2N9J7QAPAFdCPI8n3iBEsTndFzD5vjNjxd5Iq+E9S
 2z1JAll47sxNvyovCseIJ/tki4SB1/ygpWUPOuj+NXAEy0ZIuH00KT5tdUhlCkBKqNiqkFpvyU
 SxNB8wbrutwOOUYtRfwGOBAxKEs3SR6f3dGOSVG8oNkrhXCF/kT6BTvEu3VBXvfQHla5J/i6rX
 4e4=
X-IronPort-AV: E=Sophos;i="5.78,399,1599516000"; 
   d="scan'208";a="15063545"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Dec 2020 10:31:38 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 98E69280070;
        Mon,  7 Dec 2020 10:31:38 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: vendor-prefixes: correct the spelling of TQ-Systems GmbH
Date:   Mon,  7 Dec 2020 10:30:36 +0100
Message-Id: <20201207093036.29824-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Merchel <Max.Merchel@tq-group.com>

"TQ-Systems" is written with a dash, as can be seen on
https://www.tq-group.com/en/imprint/

Signed-off-by: Max Merchel <Max.Merchel@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 3a76c226771b..5b7ee0e059a2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1125,7 +1125,7 @@ patternProperties:
   "^tpo,.*":
     description: TPO
   "^tq,.*":
-    description: TQ Systems GmbH
+    description: TQ-Systems GmbH
   "^tronfy,.*":
     description: Tronfy
   "^tronsmart,.*":
-- 
2.17.1

