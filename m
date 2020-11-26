Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623DD2C5539
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389942AbgKZNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389886AbgKZNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:25:20 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54520C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:25:19 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id u19so946065edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDLtXgPRYNIU5KZqUuEFJ0xjYJUrkaixe/B85a0AE60=;
        b=Pn+ccC80nw0FBsnlF2fafDplri0xDFXypitGFO6yJ6emiiAEd6RqLlta6WV7gXLO6i
         lHDBp951G1lo+zMU8zuoP3b6dnzf1LdwHysUYW6GT6ENshSW5QEQ+eiRe6cdZGtrDNV9
         +b56tbtwLu2a5CamdQPxHtRRa9c6/G7eoTS0JHFV8BdIottjJNQTRCbaj7CjPNHzsTkG
         3hVezh2hvagWUyxuwjTHNpstvFUc6dPvS3WqvouIJb364234s2DU8fgal78fbnhFmoH6
         OqXpn9xUq5qUneD9qA0li1LdQbFITHjEeaIsprOMF1qWQyscXrc6ijJVzsDBpQn4gR1y
         YJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XDLtXgPRYNIU5KZqUuEFJ0xjYJUrkaixe/B85a0AE60=;
        b=qmHGaqD2CA+yvQ1SoKXVXJ3Y30oiqhP2NRBuAXKfV9rVh4EC2gUPcSaWVj7N9W5JzH
         2bXlkk9V8QfE01AvCuZ2IUpE+E4bt3CHmuLTRpPac9UXaLn5d6Zh9UjyeREOkUao98qp
         rnHE+0uXD7NyPA2DRJsLW21nlAAWooQSUEzlrgUJl3VfdQy0sH5rdF1M0cYBj8Mfs2Hr
         0GA9LLYyYSNtiZMgTEvG2wNlZUz+JEnvTwALoL6jbwKSd/1tuUmUfb1BzX5JeMfh9cNQ
         lDQQWVO6zAS4gwVTfCKGuCywJ4Jr2yNEH6/203H8BE39RcslAuggZFcmxgfGBgn2hs/g
         y2yA==
X-Gm-Message-State: AOAM530/Od4e04E4iQarz+LEFqCMJMMgoL3JUxins4U5pfaIKjBwrn8G
        FIAZk7hVYXTSqrExfIlfs68Hd0NebW4kj/Jx
X-Google-Smtp-Source: ABdhPJyzjPfF/wr0GrS7baTxzErm7feMQhebOrdLeWeYARQ6AOMcnChD5z7GkRAyPodGsIxkFssIIw==
X-Received: by 2002:a05:6402:143a:: with SMTP id c26mr2164024edx.131.1606397117830;
        Thu, 26 Nov 2020 05:25:17 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id 65sm3303650edj.83.2020.11.26.05.25.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Nov 2020 05:25:17 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] ARM: zynq: Convert at25 binding to new description on zc770-xm013
Date:   Thu, 26 Nov 2020 14:25:04 +0100
Message-Id: <be2c1125d98386033e182012eb08986924707a76.1606397101.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606397101.git.michal.simek@xilinx.com>
References: <cover.1606397101.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit f8f79fa6bb25 ("dt-bindings: at25: convert the binding document
to yaml") converted binding to yaml and 3 deprecated properties pop up.

The patch is fixing these warnings:
.../zynq-zc770-xm013.dt.yaml: eeprom@2: 'pagesize' is a required property
.../zynq-zc770-xm013.dt.yaml: eeprom@2: 'size' is a required property
.../zynq-zc770-xm013.dt.yaml: eeprom@2: 'address-width' is a required property
From schema: .../Documentation/devicetree/bindings/eeprom/at25.yaml

by converting them to new binding.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-zc770-xm013.dts | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-zc770-xm013.dts b/arch/arm/boot/dts/zynq-zc770-xm013.dts
index 4ae2c85df3a0..38d96adc870c 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm013.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm013.dts
@@ -63,13 +63,12 @@ &spi0 {
 	num-cs = <4>;
 	is-decoded-cs = <0>;
 	eeprom: eeprom@2 {
-		at25,byte-len = <8192>;
-		at25,addr-mode = <2>;
-		at25,page-size = <32>;
-
 		compatible = "atmel,at25";
 		reg = <2>;
 		spi-max-frequency = <1000000>;
+		size = <8192>;
+		address-width = <16>;
+		pagesize = <32>;
 	};
 };
 
-- 
2.29.2

