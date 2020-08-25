Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B19251A02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 15:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHYNqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 09:46:03 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:40528 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgHYNpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:45:53 -0400
IronPort-SDR: EWepCS+1mazOO+d5eLqNjy3LCf4T4rGNVIZfE5RnWj3/mC2fy6VwcCarTx4PlRW7xqYxs4CTPD
 x80tyrxo8qkNz+DY8xVh2QFvDzdlAhbVa43SSt5g6n1B6UTgYOhmw21wQeYNGe1KMsRjejO8Fb
 d9d8RwdDrPJz5AxUt3C6NrZ3yU/gNET2YTixcYyHJjYgwOtC2GEdHiMED8760kPj6RmZnhjpjG
 O6Vj+s51HhXAvLFL4atetCaB0RusqjKtnML2e9MoWcTREqNWpj2LLoPRNCjPIdJC8KzJoIGj7g
 QIs=
X-IronPort-AV: E=Sophos;i="5.76,352,1592863200"; 
   d="scan'208";a="13592257"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 25 Aug 2020 15:45:34 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 25 Aug 2020 15:45:34 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 25 Aug 2020 15:45:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598363134; x=1629899134;
  h=from:to:cc:subject:date:message-id;
  bh=fUqsPE/ZO4LWYoE8Q40E9k79iF8jdqLY6H5vK/D03uU=;
  b=N1MxhvFBkHSgLoGTAkYNUnrzhNL2SLQIPQaUmt1EpiBJhtMP9HiTRPto
   Y2qbpaWRZKtKM1AkgGNdZlFOLRQeGH6Z9MwW/yq6A7wi3JJ/Mn7Jx2JDX
   loGCItdOZnJwfy5hEqp6WsTWpg5kp+jir/k+a2vp7PvcrQpGfmVfdmpQd
   pueFlhDZQ7oPL5gQCLH/HNp9+LlOaJyd9QVtsHDRvAUkXBKYdD0mpRpIP
   CsebwOAEMcEpWeVsPapwvKn2LyFEEEhsUOEF9GCfmSH2pTz8WWZdKjx8Q
   pY+6+HAkdLJvjd7Y2q5ydTvpgbze+6rqZPE8KIBfH5mIGTzuVydzhU4bR
   A==;
IronPort-SDR: T2F+3bqy5rZURdVPnteiUoZlsLwR7+OAK9TaRMfSCf3g99BUQOIVMLEFNQBnxLRx6covkVmJ8F
 L8fSAClNtpW+amrJ7JA80xz0KKAV3tt0JhPKdVKMSg44qp6BuxD+GWJGilfNGUbiqlxCxuREGK
 pG6y41bO1TUk51ontoPE7lywW2c9TJZKKS+utz39F5e3QcnFF/VoaIkU7S8vptiXampI1z1DXd
 nHm1qawYEaVwD/yGWA8vbcksMGTJQxiW2IyUiw8PKStaM+6Y4o14+eWSYzN9Qe3ospvV07VwsA
 zKY=
X-IronPort-AV: E=Sophos;i="5.76,352,1592863200"; 
   d="scan'208";a="13592256"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Aug 2020 15:45:34 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 7E1E9280065;
        Tue, 25 Aug 2020 15:45:34 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH mmc-next v3 1/2] dt-bindings: mmc: add alias example
Date:   Tue, 25 Aug 2020 15:44:40 +0200
Message-Id: <20200825134441.17537-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for I2C and SPI, it now is possible to reserve a fixed index for
mmc/mmcblk devices.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v3: new patch

 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index b96da0c7f819..22ed4a36c65d 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -367,6 +367,14 @@ examples:
     };
 
   - |
+    /*
+     * Optionally define an alias to reserve a fixed index for the
+     * mmc and mmcblk devices
+     */
+    aliases {
+        mmc0 = &mmc3;
+    };
+
     mmc3: mmc@1c12000 {
         #address-cells = <1>;
         #size-cells = <0>;
-- 
2.17.1

