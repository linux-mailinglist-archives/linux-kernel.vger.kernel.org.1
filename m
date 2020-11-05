Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E62A7F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgKENMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:12:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKENMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:12:05 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83769206B5;
        Thu,  5 Nov 2020 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604581924;
        bh=LoJs6Ajpgkoa1d4J5100B28bAt2yqYcf8MoOlau7Gus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CVtD9Jj8cPqy92kij5uQnGJjS1PZCtvFBCQfO+ya2GWbvZkw1m3z+4R/pXbJTeYEc
         eMZvlIpbJ+yhTCqsDqckeeO9BpFUc7s7Fj+xMER2r+xkPsmYOFnPYDuMPQ67aAFn8w
         MEke+PXTt240Pvz7NUG+AAG1Ar6mnGRtYNjiGl7Q=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kaf3a-007q65-Cr; Thu, 05 Nov 2020 13:12:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Nov 2020 13:12:02 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     "xuqiang (M)" <xuqiang36@huawei.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rui.xiang@huawei.com
Subject: Re: [PATCH -next] irq-chip/gic-v3-its: Fixed an issue where the ITS
 executes the residual commands in the queue again when the ITS wakes up from
 sleep mode.
In-Reply-To: <8395dfbb-a90e-6903-abe9-cd6f7c48f441@huawei.com>
References: <20201103081123.119969-1-xuqiang36@huawei.com>
 <87imamtiav.wl-maz@kernel.org>
 <8395dfbb-a90e-6903-abe9-cd6f7c48f441@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <11f4143b4ef55739ff1441e848c1f66f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: xuqiang36@huawei.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, rui.xiang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't top-post.

On 2020-11-05 11:54, xuqiang (M) wrote:
> The kernel sends three commands in the following sequence:
> 
> 1.mapd(deviceA, ITT_addr1, valid:1)
> 
> 2.mapti(deviceA):ITS write ITT_addr1 memory;
> 
> 3.mapd(deviceA, ITT_addr1, valid:0) and kfree(ITT_addr1);
> 
> 4.mapd(deviceA, ITT_addr2, valid:1);
> 
> 5.mapti(deviceA):ITS write ITT_addr2 memory;
> 
> In this case, the processor enters the sleep mode. After the kernel
> performs the suspend operation, the firmware performs the store
> operation and saves GITS_CBASER and GITS_CWRITER registers.
> 
> Then, the processor is woken up, and the firmware restores GITS_CBASER
> and GITS_CWRITER registers. Because GITS_CWRITER register is not 0,
> ITS will read the above command sequence execution from the command
> queue, causing ITT_addr1 memory to be trampled.

This cannot work. By doing a memset on the command queue, you are
only feeding crap to the ITS (command 0 simply does not exist).
Consider yourself lucky that it doesn't just lock-up.

What needs to happen is the restore sequence that is already in the
driver, so that the command queue is in a sane state before re-enabling
the ITS.

         M.
-- 
Jazz is not dead. It just smells funny...
