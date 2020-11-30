Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0EB2C8372
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgK3Lqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:46:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbgK3Lqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:46:39 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54E33206C0;
        Mon, 30 Nov 2020 11:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606736758;
        bh=Krtww9Pc3dyFLVs/ZzWwRxmRLXRV8pdUOWtwJ4m5orE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wot4XbfKdNCDGe6aDrfoM5jDGngUVcjoKT+i71oiX8WI2Y+oVaRoSdCMnmjFw2LAy
         DU7qAowqz6c306IUz1BWzxd8NbY40BiQ+lk8jLv3HOc00DGtbhH8wLzk5jQ2bXVWOW
         zCJNO/T6cl9C3jCwBt7PXgHtzW5p55n7HPeLByJo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kjhcy-00EfyS-6v; Mon, 30 Nov 2020 11:45:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Nov 2020 11:45:56 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] genirq/irqdomain: Don't try to free an interrupt that has
 no mapping
In-Reply-To: <20201129135551.396777-1-maz@kernel.org>
References: <20201129135551.396777-1-maz@kernel.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <88f1748b95169e79bb84f852dbea8fce@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-29 13:55, Marc Zyngier wrote:
> When an interrupt allocation fails for N interrupts, it is pretty
> common for the error handling code to free the same number of 
> interrupts,
> no matter how many interrupts have actually been allocated.
> 
> This may result in the domain freeing code to be unexpectedly called
> for interrupts that have no mapping in that domain. Things end pretty
> badly.
> 
> Instead, add some checks to irq_domain_free_irqs_hierarchy() to make
> sure that we don't follow the hierarchy if no mapping exists for
> a given interrupt.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

A for a good measure:

Fixes: 6a6544e520abe ("genirq/irqdomain: Remove auto-recursive hierarchy 
support")

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
