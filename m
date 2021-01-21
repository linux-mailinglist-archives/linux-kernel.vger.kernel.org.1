Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F4D2FEBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbhAUNZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:25:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731699AbhAUNXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:23:21 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D84722202;
        Thu, 21 Jan 2021 13:22:39 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l2Zv3-009CPd-7s; Thu, 21 Jan 2021 13:22:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 21 Jan 2021 13:22:37 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
In-Reply-To: <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com>
 <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
 <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <71e94b48857cbdd21c5d6bdadf148621@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mohamed.mediouni@caramail.com, arnd@kernel.org, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, catalin.marinas@arm.com, marcan@marcan.st, linux-kernel@vger.kernel.org, will@kernel.org, stan@corellium.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-21 12:50, Mohamed Mediouni wrote:
>> On 21 Jan 2021, at 13:44, Arnd Bergmann <arnd@kernel.org> wrote:
>> 
>> On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni

[...]

>>> +       aic.fast_ipi = of_property_read_bool(node, "fast-ipi");
>> 
>> Where is this property documented, and what decides which one to use?
> It’s getting documented in the next patch set.
> 
> This property is there to enable support for older iPhone processors
> later on, some of which do not have fast IPI support.
> 
> On Apple M1, fast-ipi is always on.

Then please focus on a single implementation. Additional features can
always be merged later once something is up and running.

Also, there sysregs can be detected by matching the MIDR, so I don't
think we need a DT property for that.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
