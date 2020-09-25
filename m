Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35678278D49
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgIYPz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729426AbgIYPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:55:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 276D221741;
        Fri, 25 Sep 2020 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601049327;
        bh=ZOaMTpjmL0zyawSe6TesNRPIJMd8LiPQDHGoQQoPA9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpbfOezwca7Q+jKjYXy+IngxuRfB2l0oJhJKOipIgoZOtqTejdpCrvavFmfJwutm2
         KZTJj6kpqa3YmO4PvwT0wae57xcvfMuiYRCU99FvmQ4sAE7KEPtpaQVL/LL6IFru5D
         qWCpCdhGHRc9kV9UmRc1vfxy+hkfWPGWXV5Ta7co=
Received: from [185.69.144.225] (helo=localhost.localdomain)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kLq4D-00EuVG-7e; Fri, 25 Sep 2020 16:55:25 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        linux-snps-arc <linux-snps-arc@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Haoyu Lv <lvhaoyu@huawei.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Libin <huawei.libin@huawei.com>
Subject: Re: [PATCH v6 0/6] irqchip: dw-apb-ictl: support hierarchy irq domain
Date:   Fri, 25 Sep 2020 16:54:50 +0100
Message-Id: <160104911402.38543.3098076840902954515.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924071754.4509-1-thunder.leizhen@huawei.com>
References: <20200924071754.4509-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.69.144.225
X-SA-Exim-Rcpt-To: vgupta@synopsys.com, thunder.leizhen@huawei.com, robh+dt@kernel.org, abrodkin@synopsys.com, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jason@lakedaemon.net, tglx@linutronix.de, wangkefeng.wang@huawei.com, lvhaoyu@huawei.com, sebastian.hesselbarth@gmail.com, huawei.libin@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 15:17:48 +0800, Zhen Lei wrote:
> v5 --> v6:
> 1. add Reviewed-by: Rob Herring <robh@kernel.org> for Patch 4.
> 2. Some modifications are made to Patch 5:
>    1) add " |" for each "description:" property if its content exceeds one line,
>       to tell the yaml keep the "newline" character.
>    2) add "..." to mark the end of the yaml file.
>    3) Change the name list of maintainers to the author of "snps,dw-apb-ictl.txt"
> 	 maintainers:
> 	-  - Marc Zyngier <marc.zyngier@arm.com>
> 	+  - Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>    4) add "maxItems: 1" for property "reg".
>    5) for property "interrupts":
> 	 interrupts:
> 	-    minItems: 1
> 	-    maxItems: 65
> 	+    maxItems: 1
>    6) move below descriptions under the top level property "description:"
> 	description: |
> 	  Synopsys DesignWare provides interrupt controller IP for APB known as
> 	  dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs
> 	  with APB bus, e.g. Marvell Armada 1500. It can also be used as primary
> 	  interrupt controller in some SoCs, e.g. Hisilicon SD5203.
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/6] genirq: Add stub for set_handle_irq() when !GENERIC_IRQ_MULTI_HANDLER
      commit: ea0c80d1764449acf2f70fdb25aec33800cd0348
[2/6] irqchip/dw-apb-ictl: Refactor priot to introducing hierarchical irq domains
      commit: d59f7d159891466361808522b63cf3548ea3ecb0
[3/6] irqchip/dw-apb-ictl: Add primary interrupt controller support
      commit: 54a38440b84f8933b555c23273deca6a396f6708
[4/6] dt-bindings: dw-apb-ictl: Update binding to describe use as primary interrupt controller
      commit: 8156b80fd4885d0ca9748e736441cc37f4eb476a

I have dropped patch 5 as it doesn't have Rob's Ack yet (and is not that
critical) as well as patch 6 which is better routed via the ARC tree.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


