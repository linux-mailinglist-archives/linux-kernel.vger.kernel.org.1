Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F721CD12E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 07:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgEKFDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 01:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgEKFDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 01:03:22 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AAE62082E;
        Mon, 11 May 2020 05:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589173402;
        bh=AEQ5/eHF4mOqL/y16T898LganyocNlGAK0Fzmso4HzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9HiS8pWarfCpH7Ng0cm9R9PYx1ieS/AWHG+N8Y7CCrLII34xmqET1r7qbTQXyGpi
         vDsjQ1tDTzEvSmfFo7kyoo7F2C5ka95CW9qiVZygzfum7+A2L2WZd70FhFiaetZlao
         +6y1HWIgdnjcn7XkeJQOBMBz5/ofGjPIqlE9Dg9Q=
Date:   Mon, 11 May 2020 01:03:21 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, luto@kernel.org,
        tony.luck@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v10 00/18] Enable FSGSBASE instructions
Message-ID: <20200511050321.GO13035@sasha-vm>
References: <20200423232207.5797-1-sashal@kernel.org>
 <5a6a0ef5-4dfc-d0b1-9181-5df4211cfcd9@oracle.com>
 <d7111932-6ba5-1484-4347-210d9e80316f@oracle.com>
 <20200511004842.GJ3538@tassilo.jf.intel.com>
 <20200511005028.GA226400@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200511005028.GA226400@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 05:50:28PM -0700, Andi Kleen wrote:
>> So this is a check that checks if you're running in user mode if
>> you have a debug trap with single step, but somehow it triggered
>> for a user segment.
>>
>> Probably the regs got corrupted.
>>
>> Sasha, I suspect you're missing a mov %rsp,%rdi somewhere in the
>> debug entry path that sets up the regs argument for the C code.
>
>... Ah never mind. Thomas has a better explanation.

FWIW, this series was heavily tested for the past few months to the
point that we're comfortable in enabling it for 3rd party users on
Azure:
https://bugs.launchpad.net/ubuntu/+source/linux-azure/+bug/1877425.

-- 
Thanks,
Sasha
