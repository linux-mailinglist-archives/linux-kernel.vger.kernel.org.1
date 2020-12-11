Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8FE2D788B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437132AbgLKPAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436801AbgLKPAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:00:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78832C061282
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:58:49 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VRidoR0CBI7e0J3J9oePrS23G09flEif4i1ptGPFkSw=;
        b=19zxv1kSjC+J5ujR/baRZzNtDhI+ERewmUPfnlH/dTjarkb6LwxYy12ifOXKtpt4eof5oj
        pED+0Lx4kKa4976q+qfPmEIhcebEdAlU1SMLJDHp5j/q8iNqikxx5skdBziir700d0iSNs
        D9IMj5Q6bamIk89BCFgT8bN8O3JFlwfd0FkYkRqgity28OEGcWsG3usxPOt8nApIsadd5C
        fiRyYFsfcBjKfK/HnkY1DuCQxiGUfP5P39iMOY3s6/GBVasbCxL0LfHJIBk6A+yrA4OiKv
        HB77ZCpMaxI/1zjfH/KKRUvYd116fW6K1l159x+k73lQTMtlQmnOFYdPcWukqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VRidoR0CBI7e0J3J9oePrS23G09flEif4i1ptGPFkSw=;
        b=IuqO7kDqT4feB4IvRU7ibVSc80LmiJIgMb/PUgPJrClBcCVFmCx9U3NhVS6Xd6w8fhTz7q
        i86o4u2pUewpftCw==
From:   "irqchip-bot for Gregory CLEMENT" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: Add
 binding for few Microsemi interrupt controllers
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20201125103206.136498-3-gregory.clement@bootlin.com>
References: <20201125103206.136498-3-gregory.clement@bootlin.com>
MIME-Version: 1.0
Message-ID: <160769872510.3364.3492349576431923814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     b307ee828f61bc65d918e820a93b5c547a73dda3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b307ee828f61bc65d918e820a93b5c547a73dda3
Author:        Gregory CLEMENT <gregory.clement@bootlin.com>
AuthorDate:    Wed, 25 Nov 2020 11:32:02 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:49 

dt-bindings: interrupt-controller: Add binding for few Microsemi interrupt controllers

Add the Device Tree binding documentation for the Microsemi Jaguar2,
Luton and Serval interrupt controller that is part of the ICPU. It is
connected directly to the MIPS core interrupt controller.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20201125103206.136498-3-gregory.clement@bootlin.com
---
 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
index be82920..27b798b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
@@ -21,7 +21,11 @@ properties:
   compatible:
     items:
       - enum:
+          - mscc,jaguar2-icpu-intr
+          - mscc,luton-icpu-intr
           - mscc,ocelot-icpu-intr
+          - mscc,serval-icpu-intr
+
 
   '#interrupt-cells':
     const: 1
