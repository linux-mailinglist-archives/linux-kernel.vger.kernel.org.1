Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C03A26B39E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgIOXGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIOOsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:48:06 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F39A2206B5;
        Tue, 15 Sep 2020 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600181280;
        bh=/Ih9Q9LFpNYQb5rd5+kkp5D5ZIJCRM32IkfUCRCnZXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P3hiW55Y3br8favtF6qN0GrOzxeUQbBd7GsgDc1chSm9MrmsZW/IrsiLDwa8d9XT+
         9HZNLFIADi7GEgoVzb2eRqlVd0b+i8iP8ttWUE0HEaHS9pyAO7pUtDI26BWm4f8dAV
         CvhnJ8p1Bh4nQQMcSdVdmgonZFlWL21cATTl9E5A=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kICFR-00C2Mf-U7; Tue, 15 Sep 2020 15:47:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Sep 2020 15:47:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     lushenming <lushenming@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        yuzenghui <yuzenghui@huawei.com>
Subject: Re: [PATCH] irqchip/gic-v4.1: Optimize the delay time of the poll on
 the GICR_VPENDBASER.Dirty bit
In-Reply-To: <343E0E168479F04FACCB176989D12DE7EE1D2D@dggemi522-mbs.china.huawei.com>
References: <343E0E168479F04FACCB176989D12DE7EE1D2D@dggemi522-mbs.china.huawei.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <a87d26bc52b25247dd23e5cb1cd56bad@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lushenming@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-15 15:04, lushenming wrote:
> Thanks for your quick response.
> 
> Okay, I agree that busy-waiting may add more overhead at the RD level.
> But I think that the delay time can be adjusted. In our latest
> hardware implementation, we optimize the search of the VPT, now even
> the VPT full of interrupts (56k) can be parsed within 2 microseconds.

It's not so much when the VPT is full that it is bad. It is when
the pending interrupts are not cached, and that you don't know *where*
to look for them in the VPT.

> It is true that the parse speeds of various hardware are different,
> but does directly waiting for 10 microseconds make the optimization of
> those fast hardware be completely masked? Maybe we can set the delay
> time smaller, like 1 microseconds?

That certainly would be more acceptable. But I still question the impact
of such a change compared to the cost of a vcpu entry. I suggest you
come up with measurements that actually show that polling this register
more often significantly reduces the entry latency. Only then can we
make an educated decision.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
