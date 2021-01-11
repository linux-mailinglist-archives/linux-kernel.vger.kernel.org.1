Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E47A2F17FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbhAKOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:21:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbhAKOVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:21:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DC5A2242A;
        Mon, 11 Jan 2021 14:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610374852;
        bh=lRhzRu5y4+MceKt6vK/qDXTv1oaK7iwXlndeq3cc600=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFji115mDcl1gtX+XC2CFqcklpyblJlnLg+sAOKBIybrr5ATHHjfg0hOlH8GzVpHA
         /aOkR5ICzC35xufnLjxzu15zrIPs/jbwmvSSr9quMYAUHIluDaWAnnGxdK+Nh5tbpm
         H4z5KvSLtFKg4J0kv/2o3RPFs7XcNe6Kfot//k7/pfDPgittnqfYxacFfTsX9qVzNH
         rGV8CBpEaZ7aQHgnT5VLYxjfRQ3DsKHnJYKEDORm7D2N6Ospcmv0V++YAZe42FaFcG
         KIdOgaEEAS+G22dVfnYFAYiBAjiOZb6EsPRfU4Mi70ce/c7sXpSZxC9eTOxyYf9HAT
         hUQ/RuFVFha4Q==
Date:   Mon, 11 Jan 2021 15:20:48 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Adam Zabrocki <pi3@pi3.com.pl>
Cc:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Solar Designer <solar@openwall.com>
Subject: Re: Linux Kernel module notification bug
Message-ID: <20210111142048.GA27038@linux-8ccs>
References: <20210110175401.GB32505@pi3.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210110175401.GB32505@pi3.com.pl>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Adam Zabrocki [10/01/21 18:54 +0100]:
>Hello,
>
>I believe that the following commit does introduce a gentle "functionality
>bug":
>
>"module: delay kobject uevent until after module init call":
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/kernel/module.c?id=38dc717e97153e46375ee21797aa54777e5498f3
>
>The official Linux Kernel API for the kernel module activities notification has
>been divided based on the readiness 'stage' for such module. We have the
>following stages:
>
>        MODULE_STATE_LIVE,      /* Normal state. */
>        MODULE_STATE_COMING,    /* Full formed, running module_init. */
>        MODULE_STATE_GOING,     /* Going away. */
>        MODULE_STATE_UNFORMED,  /* Still setting it up. */
>
>LIVE means that the kernel module is correctly running and all initialization
>work has been already done. Otherwise, we have event 'COMING' or 'UNFORMED'.
>
>In the described commit, creation of the KOBJECT has been moved after invoking
>a notficiation of the newly formed kernel module state (LIVE). That's somehow
>inconsistent from my understanding of the kernel modules notifiers logic.
>Creation of the new objects (like KOBJ) should be done before notification of
>the stage LIVE is invoked.

I'm confused. We're not creating any kobjects here. That is all done
in mod_sysfs_setup(), which is called while the module is still
COMING.  What that commit does is delay telling userspace about the
module (specifically, systemd/udev) until the module is basically
ready. Systemd was basically receiving the uevent too early, before
the module has initialized, hence we decided to delay the uevent [1].

>This commit breaks some of the projects that rely on the LIVE notification to
>monitor when the newly loaded module is ready.

Hm, could you please explain specifically what is the issue you're seeing?
What projects is it breaking?

Thanks,

Jessica

[1] https://github.com/systemd/systemd/issues/17586
