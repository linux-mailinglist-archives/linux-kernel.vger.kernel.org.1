Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5900427C2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgI2Kyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgI2Kyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:54:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19719207C4;
        Tue, 29 Sep 2020 10:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601376891;
        bh=TsXfKdPzMyQ6L5OpU3cZdfk/rowKCpYM+fXLO67j8Ng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LyvXpsNWayTtEoONSEtw+dSq2ZKj4+3V+YsP02/1v09h7mfMQeXPQ2cL1JhAZmyxe
         qeUwG7lbUHSKjGj3F1i7uv6RJOJqFJDoLHuDTe5gaotffANRt3GyWwBH1uM0HeSWfN
         zMkfXesAzdH+l2YtKphVaCvS+bvTQDwS+niV4F+8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kNDHV-00FlNL-AK; Tue, 29 Sep 2020 11:54:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 29 Sep 2020 11:54:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     ito-yuichi@fujitsu.com
Cc:     sumit.garg@linaro.org, tglx@linutronix.de, jason@lakedaemon.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
In-Reply-To: <OSAPR01MB4227204DB45A285761B520998F320@OSAPR01MB4227.jpnprd01.prod.outlook.com>
References: <20200924044236.1245808-1-ito-yuichi@fujitsu.com>
 <OSAPR01MB42279E9BFA43419F49231ECE8F350@OSAPR01MB4227.jpnprd01.prod.outlook.com>
 <498b10b51f5c961f00b3d18e17c52e94@kernel.org>
 <OSAPR01MB4227204DB45A285761B520998F320@OSAPR01MB4227.jpnprd01.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <74f6c812041970cb8f5e8c0da22fca92@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ito-yuichi@fujitsu.com, sumit.garg@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-29 06:50, ito-yuichi@fujitsu.com wrote:
> Hi Marc

[...]

>> >> The patch has been tested on ThunderX.
>> 
>> Which ThunderX? TX2 (at least the incarnation I used in the past) 
>> wasn't able
>> to correctly deal with priorities.
> 
> I tried it with ThunderX CN8890.
> If you tell me steps to reproduce the problem of TX2, I will
> investigate it with TX as well.

PMR_EL1 reporting fantasy values, non-uniform priority support across
the interrupt classes, and generally prone to lockups. The original TX
is a very different machine though (TX 1 and 2 only share the engraving
of the manufacturer on the heat-spreader).

         M.
-- 
Jazz is not dead. It just smells funny...
