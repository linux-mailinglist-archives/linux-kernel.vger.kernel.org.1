Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F54D26CD5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgIPU6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgIPQdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:33:15 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADA5120795;
        Wed, 16 Sep 2020 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600265694;
        bh=bqb9nEnlPu902pTm0s2ZgPXSNYuC1CrIiyMquhk5AYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f56xT//OlHO4sXCZK9bN2re3PYowqLzF5g8rVsDf5/pymxVyW79KZh5DozEZ5W10w
         nxvgiE08DQB1QqRjecxgIXh5rBeJQ/4wrgh5XJqSctYIKG5adxj/2MBKsXbG2ZlnAg
         +nYSYgslq9UVGtZr/6hVssiYhqQAyXHy0a7V6lR8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kIYCy-00CMOJ-Pt; Wed, 16 Sep 2020 15:14:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Sep 2020 15:14:52 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Subject: Re: [PATCH v3 08/16] irqchip/gic: Configure SGIs as standard
 interrupts
In-Reply-To: <CACRpkdbqiUye3fcLSdtNB2WffsKp-tmpV64RtWm_kwkqiz2+7w@mail.gmail.com>
References: <20200901144324.1071694-1-maz@kernel.org>
 <20200901144324.1071694-9-maz@kernel.org>
 <CACRpkdbqiUye3fcLSdtNB2WffsKp-tmpV64RtWm_kwkqiz2+7w@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <9d3c8d2de29618797568e3d4e325b10b@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, saravanak@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 2020-09-16 15:03, Linus Walleij wrote:
> On Tue, Sep 1, 2020 at 4:44 PM Marc Zyngier <maz@kernel.org> wrote:
> 
>> Change the way we deal with GIC SGIs by turning them into proper
>> IRQs, and calling into the arch code to register the interrupt range
>> instead of a callback.
>> 
>> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> Hmmm apart from Exynos this crashes the Ux500 too... I don't
> even get the crash dumpon a LL UART, it hard hangs.

No output whatsoever? That's really odd... Or do you see the kernel
booting and locking up when starting secondaries? If the latter, it
would indicate that we haven't properly deactivated the SGI...

         M.
-- 
Jazz is not dead. It just smells funny...
