Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4271B8B74
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 04:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDZCwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 22:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgDZCwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 22:52:45 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0C22071E;
        Sun, 26 Apr 2020 02:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587869564;
        bh=BIkOKEcWv+IB06M0P0fTuKQEF8gCOgIkDGgnL0v0TME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wlKMojDUEUSAwzluVKn1k06s32mLf7evh26qtfKEzaF9kCISji1VgSDTkwIXxWVdL
         IT1hVz6BImbXQ38o/vWIt5uqJbZSO6fFSUA5BJ6FfHQRV3XgTi1YDMR6fnYV+eBRBp
         zsUrdbjY1oDm5SGZB1ohystSMDnBPZEDKmeiqqqY=
Date:   Sat, 25 Apr 2020 22:52:43 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Message-ID: <20200426025243.GJ13035@sasha-vm>
References: <20200421195629.GE608746@tassilo.jf.intel.com>
 <5957D3CC-B54B-4A1A-998A-0E6F58589CF4@amacapital.net>
 <20200421205119.GK1809@sasha-vm>
 <CALCETrUGuvMgvcsUWsdmUr-=6c6BpRpOKC1MN+E16g17U7vyMQ@mail.gmail.com>
 <20200423040850.GY1809@sasha-vm>
 <87ftcrtckg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ftcrtckg.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 12:39:27AM +0200, Thomas Gleixner wrote:
>Sasha Levin <sashal@kernel.org> writes:
>> On Wed, Apr 22, 2020 at 04:00:16PM -0700, Andy Lutomirski wrote:
>>>
>>>gdb and rr are certainly a good start.  If patches show up, I'll take a look.
>>
>> I'm sorry, but what patches are we talking about?
>
>About patches which:
>
>  - Are rebased to current upstream

v10 of this series was sent a few days ago and is rebased on top of
v5.7-rc1:
https://lore.kernel.org/lkml/20200423232207.5797-1-sashal@kernel.org/ .

>  - Addressed the outstanding review comments

I saw a review that Andy has just sent on patch #1 from the new series,
I'll address that.

>  - Have proper documentation in the changelog of the user space visible
>    ABI changes why it does not break any existing usage and having the
>    relevant people who maintain tools which utilize the affected
>    interfaces Cc'ed on submission.

The cover letter has references to mail correspondence with maintainers
of these tools that are affected by this change. Each of those exchanges
goes over what FSGSBASE does and answers any specific questions those
maintainers had.

If you want it out of the cover letter and into one of the patches I'd
be happy to do that. If you want me to go chase down another userspace
which we might be breaking just let me know which.

I didn't want to have them on the Cc line as they have already acked
this change from their end and I wanted to avoid additional noise. I'll
be happy to add them back to the next spin of this.

>  - Made sure that the cleanups I did when merging them initially have
>    been picked up. I'm not going to waste another couple of days on
>    this mess just to revert it because it hadn't seen any serious
>    testing in development.

Based on your revert
(https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/cpu&id=049331f277fef1c3f2527c2c9afa1d285e9a1247)
I believe that we have all the relevant patches in the series.

I'll also add here that several groups at Microsoft have been running
workloads that heavily exercise the functionality added by this patch.
I'd say that it has gotten a solid round of testing for the past few
months.

-- 
Thanks,
Sasha
