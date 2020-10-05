Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC1E2835F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJEM7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJEM7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:59:54 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE5BD20756;
        Mon,  5 Oct 2020 12:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601902794;
        bh=f3Gi+VtWFwk+VdDk4hz/N+rcjPMKX4KsgkpEvF8IBVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ItECm5qNh+RNP4lNCHN5fPVoZukbPJmat7pqlbKaPj2S/ywNV00VC4SH30LHec9sS
         oZyuChr+Kx0YvbxbMS0i2IDlctS6hfb+5Tu2rjVP5Jk7KDKZ3x/GCgzDGrVGOeCa1S
         QM2h2l6j1K3XP4AhI81dLcuGcASouYuTGthCy73s=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kPQ5o-00HN64-2i; Mon, 05 Oct 2020 13:59:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 05 Oct 2020 13:59:52 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: Re: [PATCH 2/3] soc/tegra: pmc: Allow optional irq parent callbacks
In-Reply-To: <20201005112755.GS425362@ulmo>
References: <20201005111443.1390096-1-maz@kernel.org>
 <20201005111443.1390096-3-maz@kernel.org> <20201005112755.GS425362@ulmo>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <62586cc041b513240fba252f0b256e30@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jonathanh@nvidia.com, digetx@gmail.com, skomatineni@nvidia.com, vreddytalla@nvidia.com, tglx@linutronix.de, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-05 12:27, Thierry Reding wrote:
> On Mon, Oct 05, 2020 at 12:14:42PM +0100, Marc Zyngier wrote:
>> Make the PMC driver resistent to variable depth interrupt hierarchy,
>> which we are about to introduce. The irq_chip structure is now
>> allocated statically, providing the indirection for the couple of
>> callbacks that are SoC-specific.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  drivers/soc/tegra/pmc.c | 65 
>> ++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 54 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index d332e5d9abac..9960f7c18431 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -439,7 +439,6 @@ struct tegra_pmc {
>>  	struct pinctrl_dev *pctl_dev;
>> 
>>  	struct irq_domain *domain;
>> -	struct irq_chip irq;
> 
> Did you have any particular reason for pulling this out of the struct
> tegra_pmc and making it a global variable?

The main reason is that it really isn't per-PMC. You can do everything
with a single one that is used even if you have multiple PMCs of 
different
types (not sure that's possible with the current HW, but still).

         M.
-- 
Jazz is not dead. It just smells funny...
