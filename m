Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47101E7A39
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 12:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgE2KOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 06:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgE2KOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:14:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D4CA2074D;
        Fri, 29 May 2020 10:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590747240;
        bh=oyhdQW9cIbfnJ/qwKWo1/Gl7kem52k5eaQQ+dV0o2iI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UKpxbVYGJL7ly+4PPTwH0NsqZkpIkVtzoD8ZpttgPxS9tWaceje5MhSL4cvK20rFT
         ooRYDIPPCkQbzKBY6sU5a6ypc5XCqKDBpJuMJKxaNqSzSGq1E1Yti4ypNA83pw5ncH
         Opo7OGtCn/1zETWcMVYAn6Pw6ZjQn58LEPHAW+MI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jec1W-00GExt-MU; Fri, 29 May 2020 11:13:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 11:13:58 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] New RISC-V Local Interrupt Controller Driver
In-Reply-To: <mhng-72b70f0c-28d7-425b-b45a-a132cf27e894@palmerdabbelt-glaptop1>
References: <mhng-72b70f0c-28d7-425b-b45a-a132cf27e894@palmerdabbelt-glaptop1>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <aeea0ade066fa0fcb4985b860a2ae322@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: palmer@dabbelt.com, Anup.Patel@wdc.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, daniel.lezcano@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, Atish.Patra@wdc.com, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-27 19:47, Palmer Dabbelt wrote:

[...]

> I think it's best if this all goes in through a single tree, as it 
> seems more
> work than it's worth to split it up.  I'm happy to take it through my 
> tree if
> that's OK with the irqchip folks?

This still needs some fixing on patch 3 (the exported symbol is pretty 
awful),
but this should definitely go via the RISC-V tree.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
