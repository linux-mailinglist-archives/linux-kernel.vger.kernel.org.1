Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673282AB535
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgKIKnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:43:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgKIKnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:43:12 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 036DB206C0;
        Mon,  9 Nov 2020 10:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604918592;
        bh=UN5DFU3rdMJCIaReBwqTwKxADgDjxQxTnQGZedooZz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=flgZwkPj5d9z2D2ezB3f6vHm4lIU9CNOSFqEL3+tllBu/1qMvtVNsKhWfOmhjRQKM
         pEGuveoYzFkRUqXyDgKm4ZRfT8NaaBoQQTs1LWqnEpu8XFbuGOG/JML8pdcPoxoSpV
         TZE5GBerXsERkbW+/WKrGS3flUBiwHxVP2N/2gAM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kc4dh-00917p-Ok; Mon, 09 Nov 2020 10:43:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 09 Nov 2020 10:43:09 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     "xuqiang (M)" <xuqiang36@huawei.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rui.xiang@huawei.com
Subject: Re: [PATCH -next] irq-chip/gic-v3-its: Fixed an issue where the ITS
 executes the residual commands in the queue again when the ITS wakes up from
 sleep mode.
In-Reply-To: <32592d73-9800-f420-eb00-474d9ded6155@huawei.com>
References: <20201107104226.14282-1-xuqiang36@huawei.com>
 <b278ce4baea0cf79403f793721d16a8b@kernel.org>
 <32592d73-9800-f420-eb00-474d9ded6155@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <338d65dfeac0cc026c74d9e78ec6f0c1@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: xuqiang36@huawei.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, rui.xiang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-09 03:05, xuqiang (M) wrote:
> 在 2020/11/8 0:54, Marc Zyngier 写道:
>> [dropping Jason, whose email address has been bouncing for weeks now]
>> 
>> On 2020-11-07 10:42, Xu Qiang wrote:
>>> On my platform, ITS_FLAGS_SAVE_SUSPEND_STATE is not set,thus do 
>>> nothing
>> 
>> Which platform?
> Hisi Ascend platform
>> 
>>> in its suspend and resuse function.On the other hand,firmware stores
>>> GITS_CTRL,GITS_CBASER,GITS_CWRITER and GITS_BASER<n> in the suspend,
>>> and restores these registers in the resume. As a result, the ITS 
>>> executes
>>> the residual commands in the queue.
>> 
>> Which firmware are you using? I just had a look at the trusted 
>> firmware source
>> code, and while it definitely does something that *looks* like what 
>> you are
>> describing, it doesn't re-enable the ITS on resume.
>> 
>> So what are you running?
> 
> I am using ATF. Since ITS_FLAGS_SAVE_SUSPEND_STATE is not set,ITS
> driver of OS will
> 
> not re-enable ITS in th resume. To make ITS work properly, we changed
> the ATF code
> 
> to re-enable ITS on resume.

I don't think the words "work properly" apply here.

The kernel didn't do what you wanted, so instead of fixing the kernel, 
you
introduced a bug that results in memory corruption from the firmware.

What are you plans to fix your firmware? Because from an upstream ATF
compatibility PoV, all there is to do is to fixup the command queue and
enable the ITS.

         M.
-- 
Jazz is not dead. It just smells funny...
