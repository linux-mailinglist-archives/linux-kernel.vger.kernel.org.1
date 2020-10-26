Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2633E2988C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772260AbgJZIxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1772253AbgJZIxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:53:24 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3CE4223B0;
        Mon, 26 Oct 2020 08:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603702403;
        bh=BN1CJvXBWrhfQmD3H1MNkc/u7KBp/bYmj7nVgj9rSEE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GKqVAAn3+Fm/53b6hlK+WHRR0degozeoSsGef08f7hJI15hw/JaS3p46XrQF0stfU
         oLeB007ziiD+uiKwMz/hPhyNDa6BdG35yPcG8OgbxlaqlazAEyxl0bob8C5+/ONbbD
         dKMwblE+5XKp1b7NqtmhX34Y8ee4LSBUVSRBf3m4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kWyFl-004Gtp-EU; Mon, 26 Oct 2020 08:53:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Oct 2020 08:53:21 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        will@kernel.org, alexandru.elisei@arm.com
Subject: Re: [PATCH 1/3] KVM: arm64: Check if 52-bits PA is enabled
In-Reply-To: <333451bd-4730-4ebb-f76c-28fa5d0e1f7d@redhat.com>
References: <20201025002739.5804-1-gshan@redhat.com>
 <20201025002739.5804-2-gshan@redhat.com> <871rhmpr92.wl-maz@kernel.org>
 <333451bd-4730-4ebb-f76c-28fa5d0e1f7d@redhat.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <a676f540d19fba2468fd1a801948826a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gshan@redhat.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, will@kernel.org, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-25 22:23, Gavin Shan wrote:
> Hi Marc,
> 
> On 10/25/20 8:52 PM, Marc Zyngier wrote:
>> On Sun, 25 Oct 2020 01:27:37 +0100,
>> Gavin Shan <gshan@redhat.com> wrote:
>>> 
>>> The 52-bits physical address is disabled until 
>>> CONFIG_ARM64_PA_BITS_52
>>> is chosen. This uses option for that check, to avoid the 
>>> unconditional
>>> check on PAGE_SHIFT in the hot path and thus save some CPU cycles.
>> 
>> PAGE_SHIFT is known at compile time, and this code is dropped by the
>> compiler if the selected page size is not 64K. This patch really only
>> makes the code slightly less readable and the "CPU cycles" argument
>> doesn't hold at all.
>> 
>> So what are you trying to solve exactly?
>> 
> 
> There are two points covered by the patch: (1) The 52-bits physical 
> address
> is visible only when CONFIG_ARM64_PA_BITS_52 is enabled in arch/arm64 
> code.
> The code looks consistent with this option used here. (2) I had the 
> assumption
> that gcc doesn't optimize the code and PAGE_SHIFT is always checked in 
> order
> to get higher 4 physical address bits, but you said gcc should optimize 
> the
> code accordingly. However, it would be still nice to make the code 
> explicit.

Conditional compilation only results in more breakages, specially for 
configs
that hardly anyone uses (big-endian and 64K pages are the two that 
bitrot very
quickly).

So if anything can build without #ifdef, I'll take that anytime. If the 
compiler
doesn't optimize it away, let's fix the compiler.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
