Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F13D27019B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgIRQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRQHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:07:37 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB23D206A4;
        Fri, 18 Sep 2020 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600445256;
        bh=9dixanff130eaXiQ/oKff1vm5kBZz8PrkSFuCp87TdE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cJRspX+gs4ekjAWEiL+MdJyJ1KLF/sfTO5eqRi+/u3M/ruwYrajsk898cgAaI5g7s
         pkwYIyfppu9842J2xhEZaHx24yEFNh4cfckHE+NtFynBZrWd6RRzDfvcTTc6nAcYWo
         Lzl418l+fGjnzFyweH4hiLW4xNOVLe65rOpCHhwE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kJIv8-00D3Qo-Ty; Fri, 18 Sep 2020 17:07:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Sep 2020 17:07:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ipi_teardown() should depend on HOTPLUG_CPU
In-Reply-To: <20200918154125.GB31676@willie-the-truck>
References: <20200918153548.836986-1-sergey.senozhatsky@gmail.com>
 <20200918154125.GB31676@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <bcd145134c399f10baf6d51d77133026@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, sergey.senozhatsky@gmail.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-18 16:41, Will Deacon wrote:
> On Sat, Sep 19, 2020 at 12:35:48AM +0900, Sergey Senozhatsky wrote:
>> ipi_teardown() is used only when CONFIG_HOTPLUG_CPU is set.
>> 
>> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>> ---
>>  arch/arm64/kernel/smp.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> I think this is a duplicate of:
> 
>   
> https://lore.kernel.org/r/20200918123318.23764-1-yuehaibing@huawei.com
> 
> which Marc is aware of (and I'm assuming he'll fix it in his series).

Indeed. Applied and pushed out. Thanks though!

         M. (about to fix the same issue with arch/arm...)
-- 
Jazz is not dead. It just smells funny...
