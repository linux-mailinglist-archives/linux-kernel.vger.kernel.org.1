Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187192FEA92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbhAUMri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:47:38 -0500
Received: from marcansoft.com ([212.63.210.85]:41290 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731345AbhAUMpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:45:33 -0500
X-Greylist: delayed 632 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 07:45:31 EST
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5D94441F12;
        Thu, 21 Jan 2021 12:33:49 +0000 (UTC)
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-3-mohamed.mediouni@caramail.com>
 <b30f1d3a-3a74-b562-afb6-da88a547468b@amazon.com>
 <94C20F55-D3B8-4349-B26F-9EA8AAEBF639@caramail.com>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Subject: Re: [RFC PATCH 2/7] arm64: kernel: Add a WFI hook.
Message-ID: <ed4a0329-c623-f8ea-9cb1-3e11a22344f4@marcan.st>
Date:   Thu, 21 Jan 2021 21:33:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <94C20F55-D3B8-4349-B26F-9EA8AAEBF639@caramail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I already mentioned this privately, but for the benefit of the ML:

On 21/01/2021 09.48, Mohamed Mediouni wrote:
> If we explicitly use the hardware override registers for this, then
> we'll be unable to use the deep sleep support provided by wfi on
> Apple SoCs later on without touching Apple-specific MSRs.
> 
> Our current policy is to avoid having those modified inside the kernel
> at all costs, considering it to be a job for the bootloader instead.

I don't think there is any particular reason to do this; the bootloader 
should be responsible for setting up all the chicken bits that make the 
CPU work properly, including doing so for all SMP cores before entering 
the kernel, but that's not the same thing as power management bits.

It seems entirely reasonable to me to configure WFI as clockgate only 
(so it keeps state), not touch this part of kernel code at all, and then 
in the cpuidle driver (which can come later) just do:

- switch to powerdown mode
- save state
- wfi
- restore state
- switch to clockgate mode

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
