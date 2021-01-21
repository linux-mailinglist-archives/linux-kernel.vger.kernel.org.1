Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB182FEAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbhAUNDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbhAUNCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:02:45 -0500
X-Greylist: delayed 1689 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jan 2021 05:02:04 PST
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A40C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:02:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9052641F12;
        Thu, 21 Jan 2021 13:02:00 +0000 (UTC)
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
To:     Arnd Bergmann <arnd@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com>
 <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
 <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
 <CAK8P3a3g888Rn=FRaYB80d5ehHA8b9GUZfa0J+D1nXPKkzcpig@mail.gmail.com>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Message-ID: <4998cb40-8e9b-f08d-c093-304c0e6355b3@marcan.st>
Date:   Thu, 21 Jan 2021 22:01:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3g888Rn=FRaYB80d5ehHA8b9GUZfa0J+D1nXPKkzcpig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2021 22.00, Arnd Bergmann wrote:
> Ok, makes sense. Does fast-ipi mean you cannot use the other mode at
> all, or is it just faster as implied by the name? If so, how much faster?

The other mode still works, as the AIC IPI registers are still there on 
M1 and work properly. I don't have performance numbers though.

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
