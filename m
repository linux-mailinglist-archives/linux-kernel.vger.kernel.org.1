Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E5D269141
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgINQRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgINQKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:10:39 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 071E120759;
        Mon, 14 Sep 2020 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600099839;
        bh=WZ3JO5Gd7EBYVjMMbhMOeo4vejDSPos4qMJKMNgdJhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L2cp9WOY8OMlxcWyMB6/2Xux4VfzP5E1xNev/ZN7trDJc3NSgtgugN4ERhnPz05Bq
         7xo0thR5WiEtxEFW2LlpkSuEPJwkjKOesdACNGrP2lO71Rq2ZD4a2swKN2rK8Ctog5
         7ykEHXgRIsc7jFSMyyJpnhLobJO4MHfex73CmSnU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kHr3s-00Bjzy-Vu; Mon, 14 Sep 2020 17:10:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Sep 2020 17:10:36 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Saravana Kannan <saravanak@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 10/16] irqchip/bcm2836: Configure mailbox interrupts as
 standard interrupts
In-Reply-To: <3e52be78-1725-a3a2-c97c-625d46017a4b@samsung.com>
References: <20200901144324.1071694-1-maz@kernel.org>
 <20200901144324.1071694-11-maz@kernel.org>
 <CGME20200914143236eucas1p17e8849c67d01db2c5ebb3b6a126aebf4@eucas1p1.samsung.com>
 <3e52be78-1725-a3a2-c97c-625d46017a4b@samsung.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <e99cc81b24475c54e173e6dd0d9d827b@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sumit.garg@linaro.org, kernel-team@android.com, f.fainelli@gmail.com, linux@arm.linux.org.uk, jason@lakedaemon.net, saravanak@google.com, andrew@lunn.ch, catalin.marinas@arm.com, gregory.clement@bootlin.com, tglx@linutronix.de, will@kernel.org, Valentin.Schneider@arm.com, linux-rpi-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 2020-09-14 15:32, Marek Szyprowski wrote:
> Hi Marc,
> 
> On 01.09.2020 16:43, Marc Zyngier wrote:
>> In order to switch the bcm2836 driver to privide standard interrupts
>> for IPIs, it first needs to stop lying about the way things work.
>> 
>> The mailbox interrupt is actually a multiplexer, with enough
>> bits to store 32 pending interrupts per CPU. So let's turn it
>> into a chained irqchip.
>> 
>> Once this is done, we can instanciate the corresponding IPIs,
>> and pass them to the architecture code.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> This one also fails. It breaks booting of Raspberry Pi 3b boards (both
> in ARM and ARM64 mode):

Damn. This used to work. Looks like I was eager to delete stuff at
some point. Can you give this a go and let me know if that works
for you (only tested in QEMU with the raspi2 model):

diff --git a/drivers/irqchip/irq-bcm2836.c 
b/drivers/irqchip/irq-bcm2836.c
index 85df6ddad9be..97838eb705f9 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -193,6 +193,8 @@ static void bcm2836_arm_irqchip_ipi_send_mask(struct 
irq_data *d,

  static struct irq_chip bcm2836_arm_irqchip_ipi = {
  	.name		= "IPI",
+	.irq_mask	= bcm2836_arm_irqchip_dummy_op,
+	.irq_unmask	= bcm2836_arm_irqchip_dummy_op,
  	.irq_eoi	= bcm2836_arm_irqchip_ipi_eoi,
  	.ipi_send_mask	= bcm2836_arm_irqchip_ipi_send_mask,
  };


Thanks again,

         M.
-- 
Jazz is not dead. It just smells funny...
