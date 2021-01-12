Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CE82F2D22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbhALKrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbhALKrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:47:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FAE0222B3;
        Tue, 12 Jan 2021 10:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610448419;
        bh=LF14sBfNBSl94pggkqnlnA7pe2NKw2VA5pU0Mec5zfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSRR0xJEqbLFtE6o58p/RtA9dAwhp5JhSqtWSWLeidNcBXOEUxc24GRvveNOfIanU
         pPySJGyAscseShPAhN6gcD+uQWabszFozziYt+r56238QPFVuug/jIprqGI1H/wbkk
         yF/bwRpUNvke1pHvEF6+3xnkTcn2M06q20xQGuuO3zi5iu1uWGhQCkS1XxUYKy9EA7
         lJtJoeeXr/88FYNyEiEd7e4U2YdtwRv2gZIBXXkRPOEHlQf7ucPwzI6fBUnp203zCv
         7N909H8KOcKUF2wOl/yuQkB5X9gIRIX88HlDEaFmNY1sTVvhb/bzjvXQ/zhXTVIBx5
         UXeDLQ1qJueHw==
Date:   Tue, 12 Jan 2021 11:46:55 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Adam Zabrocki <pi3@pi3.com.pl>
Cc:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Solar Designer <solar@openwall.com>
Subject: Re: Linux Kernel module notification bug
Message-ID: <20210112104654.GA26122@linux-8ccs>
References: <20210110175401.GB32505@pi3.com.pl>
 <20210111142048.GA27038@linux-8ccs>
 <20210112001559.GA20073@pi3.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210112001559.GA20073@pi3.com.pl>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Adam Zabrocki [12/01/21 01:15 +0100]:
>Hello,
>
>On Mon, Jan 11, 2021 at 03:20:48PM +0100, Jessica Yu wrote:
>> +++ Adam Zabrocki [10/01/21 18:54 +0100]:
>> > Hello,
>> >
>> > I believe that the following commit does introduce a gentle "functionality
>> > bug":
>> >
>> > "module: delay kobject uevent until after module init call":
>> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/kernel/module.c?id=38dc717e97153e46375ee21797aa54777e5498f3
>> >
>> > The official Linux Kernel API for the kernel module activities notification has
>> > been divided based on the readiness 'stage' for such module. We have the
>> > following stages:
>> >
>> >        MODULE_STATE_LIVE,      /* Normal state. */
>> >        MODULE_STATE_COMING,    /* Full formed, running module_init. */
>> >        MODULE_STATE_GOING,     /* Going away. */
>> >        MODULE_STATE_UNFORMED,  /* Still setting it up. */
>> >
>> > LIVE means that the kernel module is correctly running and all initialization
>> > work has been already done. Otherwise, we have event 'COMING' or 'UNFORMED'.
>> >
>> > In the described commit, creation of the KOBJECT has been moved after invoking
>> > a notficiation of the newly formed kernel module state (LIVE). That's somehow
>> > inconsistent from my understanding of the kernel modules notifiers logic.
>> > Creation of the new objects (like KOBJ) should be done before notification of
>> > the stage LIVE is invoked.
>>
>> I'm confused. We're not creating any kobjects here. That is all done
>> in mod_sysfs_setup(), which is called while the module is still
>> COMING.  What that commit does is delay telling userspace about the
>> module (specifically, systemd/udev) until the module is basically
>> ready. Systemd was basically receiving the uevent too early, before
>> the module has initialized, hence we decided to delay the uevent [1].
>>
>
>Sorry for the confusion on my side. I was referring to the internal state of
>the KOBJ itself which is being actively modified when uevent is sent. During
>the module creation KOBJ_ADD modifies 'kobj->state_add_uevent_sent'. Until
>recent commit, kernel didn't modify KOBJ after sending LIVE notification.
>
>> > This commit breaks some of the projects that rely on the LIVE notification to
>> > monitor when the newly loaded module is ready.
>>
>> Hm, could you please explain specifically what is the issue you're seeing?
>> What projects is it breaking?
>>
>
>I'm specifically referencing these projects which are tracking kernel modules
>for integrity purpose (e.g. anti-rootkit tools) like Linux Kernel Runtime
>Guard.
>It is possible to modify these tools to adopt and take into account
>modification of KOBJ after LIVE state notification. However, from my
>understanding of the kernel modules notifiers logic, KOBJ should be fully
>formed at this stage.

Ah I see, thanks for the clarification. I was under the impression
that kobj->state_add_uevent_sent is an internal field interesting
only to lib/kobject.c, and did not know tools like you mention are
implicitly tracking that.

In any case, I think your suggested change doesn't affect the
systemd/udev issue we were trying to fix, as long as the uevent is
sent after module init(). Would you mind sending a patch? (with a
Fixes: tag and including the explanations you've provided in this
thread in the changelog)

Thanks!

Jessica





