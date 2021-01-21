Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5032FF11D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbhAUQy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733272AbhAUQyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:54:10 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CA8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 08:53:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 029373FA60;
        Thu, 21 Jan 2021 16:53:22 +0000 (UTC)
Subject: Re: [RFC PATCH 4/7] irqchip/apple-aic: Add support for Apple AIC
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-5-mohamed.mediouni@caramail.com>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Message-ID: <d15d3853-9ef5-9fee-4a89-3f9f2e5bf7d4@marcan.st>
Date:   Fri, 22 Jan 2021 01:53:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210120132717.395873-5-mohamed.mediouni@caramail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2021 22.27, Mohamed Mediouni wrote:
> +		irq_domain_set_info(d, virq, hw, &apple_aic_irq_chip,
> +				    d->host_data, handle_level_irq, NULL, NULL);

The AIC automatically masks IRQs on reason fetch, which means the 
handle_level_irq flow is redundant. Using the fasteoi flow, as in [1], 
should be more efficient.

[1] https://github.com/AsahiLinux/linux/commit/d4cb18c93

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
