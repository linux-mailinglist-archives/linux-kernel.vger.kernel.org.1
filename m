Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0AE2F1D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389924AbhAKSEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732662AbhAKSEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:04:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211ADC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=a5fVlDIRGDkfpBVFh+Is+SLiOkwkapO+PazwXN5JJkw=; b=RY9Oy9WyAsaW+tAPs2Ai9IKpB/
        4ZOSRY5kpQCPbHGbt3zoAZ6FZUbaBZGFGJTFxbrDWjGyG1cW+JAu8N72HkZg+TscaRLFSNFzxedXn
        E3De5LtCf5QBbUeClREBp0uVxl5/DqoLuYcWYdrg5SH8tKabMG9tsPC8jJmWDYIzZxVpcniohIzrL
        9Jf/MGwYJrxq5b6+8hxIKO50bB5AkgiMfhtNE+wX7lohLg5RWjhQNkH7dZLGbAXTnz52yN2av2M/C
        Pa5tlywqqn9fx47Pchq+mQ/mK/ZSNzZuSmgN9RVOVjZr13wGSuvm7gYoyj+yTUWqCONNqn0CSh8jG
        i2ZncgyA==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kz1XH-0001b9-Rm; Mon, 11 Jan 2021 18:03:24 +0000
Subject: Re: [PATCH] arm64: Kconfig: Increase NR_CPUS default to 512
To:     Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, patches@amperecomputing.com
References: <20210110053615.3594358-1-vanshikonda@os.amperecomputing.com>
 <20210111105636.GA7071@willie-the-truck>
 <20210111175741.ldifmv7uhdekbq5d@con01sys-r111.scc-lab.amperecomputing.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fb9542df-19cf-4db7-d112-0917e5b65e9f@infradead.org>
Date:   Mon, 11 Jan 2021 10:03:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111175741.ldifmv7uhdekbq5d@con01sys-r111.scc-lab.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 9:57 AM, Vanshidhar Konda wrote:
> On Mon, Jan 11, 2021 at 10:56:36AM +0000, Will Deacon wrote:
>> On Sat, Jan 09, 2021 at 09:36:15PM -0800, vanshikonda@os.amperecomputing.com wrote:
>>> From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>>>
>>> Increase the default value of NR_CPUS to 512 from 256. This will
>>> enable the defconfig kernel to support platforms that have upto
>>> 512 cores.
>>
>> Do we already support such a platform, and what is it? I'm fine with bumping.
>> the number, it's just nice to be able to say specifically _why_ we're dong
>> it.
> 
> I'm not aware of any publicly available systems that run into the 256
> core limitation. At Ampere we have internal systems that would benefit
> from this change as they support more than 256 cores.

But what does that have to do with the default value?
Do you expect to run defconfig kernels?
I don't ever expect that.

-- 
~Randy

