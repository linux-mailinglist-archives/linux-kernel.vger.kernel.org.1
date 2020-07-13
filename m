Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243F921D764
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgGMNkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 09:40:19 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:57350 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbgGMNkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:40:19 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id F01BBBC0FD;
        Mon, 13 Jul 2020 13:40:15 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     mdf@kernel.org, robh+dt@kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] fpga: region: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 15:40:08 +0200
Message-Id: <20200713134008.34635-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 Documentation/devicetree/bindings/fpga/fpga-region.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 8ab19d1d3f9a..e811cf825019 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -493,4 +493,4 @@ FPGA Bridges that exist on the FPGA fabric prior to the partial reconfiguration.
 --
 [1] www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug_partrecon.pdf
 [2] tspace.library.utoronto.ca/bitstream/1807/67932/1/Byma_Stuart_A_201411_MAS_thesis.pdf
-[3] http://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
+[3] https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
-- 
2.27.0

