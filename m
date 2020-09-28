Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FE727AA15
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgI1I72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgI1I71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:59:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42AE220E65;
        Mon, 28 Sep 2020 08:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601283567;
        bh=eEsC+7Z7kR14qvJJw+13j0Oy+Eemha+IV0JTD40rtPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hmVsET+ZS28yoa4xr2LE2sIGl7sWu7ZKKeMWKUEh8ui4sQMEU7LEMEFyxzAPQ1p2x
         QtDFIKlMq83r0cmptSQSZf1fMJ/3rega77F2aQGVYjhdo6Zrcq8BWwXl7v52Wkks6p
         Na0Z62SMnb1o1R+i0kNGYFUG40+bV9JGvJFy6HM4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kMp0H-00FQrC-5T; Mon, 28 Sep 2020 09:59:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 28 Sep 2020 09:59:24 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     ito-yuichi@fujitsu.com
Cc:     sumit.garg@linaro.org, tglx@linutronix.de, jason@lakedaemon.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
In-Reply-To: <OSAPR01MB42279E9BFA43419F49231ECE8F350@OSAPR01MB4227.jpnprd01.prod.outlook.com>
References: <20200924044236.1245808-1-ito-yuichi@fujitsu.com>
 <OSAPR01MB42279E9BFA43419F49231ECE8F350@OSAPR01MB4227.jpnprd01.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <498b10b51f5c961f00b3d18e17c52e94@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ito-yuichi@fujitsu.com, sumit.garg@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-28 03:43, ito-yuichi@fujitsu.com wrote:
> Hi Marc, Sumit
> 
> I would appreciate if you have any advice on this patch.

I haven't had a chance to look into it, as I'm not even sure I'll
take the core series in the first place (there are outstanding
regressions I can't reproduce, let alone fix them).

> 
> Yuichi Ito
> 
>> -----Original Message-----
>> From: Yuichi Ito <ito-yuichi@fujitsu.com>
>> Sent: Thursday, September 24, 2020 1:43 PM
>> To: maz@kernel.org; sumit.garg@linaro.org; tglx@linutronix.de;
>> jason@lakedaemon.net; catalin.marinas@arm.com; will@kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org; 
>> linux-kernel@vger.kernel.org; Ito,
>> Yuichi/伊藤 有一 <ito-yuichi@fujitsu.com>
>> Subject: [PATCH 0/2] Enable support IPI_CPU_CRASH_STOP to be
>> pseudo-NMI
>> 
>> Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
>> 
>> This patchset enables IPI_CPU_CRASH_STOP IPI to be pseudo-NMI.
>> This allows kdump to collect system information even when the CPU is 
>> in a
>> HARDLOCKUP state.
>> 
>> Only IPI_CPU_CRASH_STOP uses NMI and the other IPIs remain normal
>> IRQs.
>> 
>> The patch has been tested on ThunderX.

Which ThunderX? TX2 (at least the incarnation I used in the past) wasn't
able to correctly deal with priorities.

         M.
-- 
Jazz is not dead. It just smells funny...
