Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479642F5AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 07:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbhANG0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 01:26:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbhANG0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 01:26:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11602238E7;
        Thu, 14 Jan 2021 06:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610605567;
        bh=bK/dLNM7Vog121qYXM4GcqzdLhmfDEMXzDwUKOT9i8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fu0n6AhEZS3CUyI4s4FezlFOCXRCeJjSndghs/fTZHZZSgaa1slZdnVerlYCrd8cx
         I7Tj1PBwAkU0zTinpU4lWnkyNl1IA95WVtgx8twEcKVJJd6nR9maJpnvvR47GrzmhJ
         kePJZAMn0u1/b+7nixf+Lcpee7/Z40Byp//fpXeHsailaBlJMJ6uS4vOLnPZrXitW/
         ceStgLL99LqD/x+g5Hm5vkvducRcdnFp30Ip38esLsYkd4qlFVWYszisHTMb/rCeks
         53BbozoUrWa2hPU3rLBWU+ujfNx97QcT/CfC3eDbir8cEdd+l6v+1hFac7coSUJrzC
         oqe/575nTujmQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzw56-00EJ7G-Ht; Thu, 14 Jan 2021 07:26:04 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/3] Documentation/devicetree/bindings/usb/dwc3-st.txt: update usb-drd.yaml reference
Date:   Thu, 14 Jan 2021 07:25:59 +0100
Message-Id: <43d5049a8ed688980bee12ecf18ef9937981de39.1610605373.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610605373.git.mchehab+huawei@kernel.org>
References: <cover.1610605373.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset b0864e1a4d9d ("dt-bindings: usb: Convert generic USB properties to DT schemas")
renamed: Documentation/devicetree/bindings/usb/generic.txt
to: Documentation/devicetree/bindings/usb/usb-drd.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/usb/dwc3-st.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-st.txt b/Documentation/devicetree/bindings/usb/dwc3-st.txt
index ad526e76f2a8..bf73de0d5b4a 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-st.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3-st.txt
@@ -37,7 +37,7 @@ NB: The dr_mode property described in [1] is NOT optional for this driver, as th
 is "otg", which isn't supported by this SoC. Valid dr_mode values for dwc3-st are either "host"
 or "device".
 
-[1] Documentation/devicetree/bindings/usb/generic.txt
+[1] Documentation/devicetree/bindings/usb/usb-drd.yaml
 
 Example:
 
-- 
2.29.2

