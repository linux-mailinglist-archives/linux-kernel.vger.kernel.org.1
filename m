Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F872FEA77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbhAUMor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbhAUMnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:43:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12A0C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:42:52 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j13so2296984edp.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQWNwCc24qdNR5GdkjJcm+92jiSw0doIFDbnYCqaaWg=;
        b=Rpk47Pvaj4wgGKzcM5V4ZqUmt4pzADFZtZQmzg2G706i0Rfw+1aPsZPj+7H8IruIn7
         oLBqSCnBrHUUMPgC9LRhL5wHKi+5nq3umcJLub489RLyp04TjIQyvB9acW+MbT/ln4Mq
         nMItXcOr4O+0UgLxEN/wnTpE906gM+MfIzXq5VCvqipliz1Wfe8kSAxgoszoDkO0XA1d
         SRM8OIMgxSvqCjgBTIaKim/tJnU2blwCrH9pLI7VZYnnh6qxRrc+nUrlsmyWByH5G05t
         WEOmIxKgtoUoGR3LI8ykayVSuHOPdUy+slU7OM9NBuWBeoLAd4XLPee2iTefQhaudX5L
         RoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=eQWNwCc24qdNR5GdkjJcm+92jiSw0doIFDbnYCqaaWg=;
        b=tzrR22Mm7assIYE/i2m7lAmR0KjgROR7lsGYTdVgQ5xJHmZnde2W/ltrbNcnckRD9y
         Y/hbeXE/RHlODBofUH223bt+ANEDuID7H23TvuoCuzsgjX57BjqxuxpiC0beVaWC5dwR
         jxhSO31bpUr6I3gG+RMDPPDK4lpfhKybLEZFHeYadUQY/Drbm/NM+LIn4ieIOjmZHhwu
         fXCzRqkCZUCAlR5qRtyG35y8JGuHve46HcvJ24Te3jOCSnHDH3LGTLNMLBOGl2SJDRkF
         /QO1oeunUXITYQtaddrpTONcv9JYnBdofzgISPCnwOmqhfdwLU+WyXBYDpWZ4jAFETm6
         BUug==
X-Gm-Message-State: AOAM533ZtmSH9sAzqLnVnTIPSqea5Fwpp/osf9rGatGz/AsobxkczbVK
        Pe6SLQVh5MiK5/pSLB45uweM5NYfocKDQrWA
X-Google-Smtp-Source: ABdhPJz+YPxKctu7dUWTI2v4/qn01MOX9Sf1XI71H56FtD5pEb7C+jXZsIDf9X1ycFpJdaYTQh5W/Q==
X-Received: by 2002:a05:6402:1249:: with SMTP id l9mr10393214edw.375.1611232971188;
        Thu, 21 Jan 2021 04:42:51 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id cn25sm2707062edb.63.2021.01.21.04.42.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 04:42:50 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH] dt-bindings: dwc3-xilinx: Add missing comma in example
Date:   Thu, 21 Jan 2021 13:42:49 +0100
Message-Id: <8fa5edcaa6b93859cfda97d080aad378e89c1b44.1611232967.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial example fix.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 Documentation/devicetree/bindings/usb/dwc3-xilinx.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
index 4aae5b2cef56..a668f43bedf5 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
@@ -19,7 +19,7 @@ Example device node:
 			#address-cells = <0x2>;
 			#size-cells = <0x1>;
 			compatible = "xlnx,zynqmp-dwc3";
-			clock-names = "bus_clk" "ref_clk";
+			clock-names = "bus_clk", "ref_clk";
 			clocks = <&clk125>, <&clk125>;
 			ranges;
 
-- 
2.30.0

