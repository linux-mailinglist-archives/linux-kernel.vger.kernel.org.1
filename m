Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3BA2EA0A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 00:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbhADXT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 18:19:56 -0500
Received: from ms.lwn.net ([45.79.88.28]:39968 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbhADXTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:19:52 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2E9DD299;
        Mon,  4 Jan 2021 23:19:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2E9DD299
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1609802352; bh=vr4+/CdkTwvjIbxz7/3OOQr7VIBAjm5rmXtBg8jiavA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cq4scu1DWbN+bNnjv3eReCO9RkAbn4s+Ni4OX4Shab2/15832BuWrMDQV/m02mLFF
         UqeV2jtIbT+bptFSM/x7auYcISciC2vwBB+AZ3tzEqYNwdWcBEIqfhI5PhOO9d803q
         UbxY/dLdUNWAV5f2kJPG1pBSJVtsYDw85/CrNwFBNBMFghhg/uLapuCG+X9Qj0fud2
         u/ypYpAV+hOWSF6WQ4eqnVfY8Qnr7kdOOxhqx9AhpPuM+5+XvJMgBq3JqaJpLcNSDB
         JM03f8fK1MNeZrC6qhoN+o8UdqesaGjdk+WlWXTJuExoca5eur+ggwEvlo4VlAxE5p
         PVfJe6RxTss9g==
Date:   Mon, 4 Jan 2021 16:19:11 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Add blurb about
 backtraces in commit messages
Message-ID: <20210104161911.38eb3e1e@lwn.net>
In-Reply-To: <20201222130555.GA13463@zn.tnic>
References: <20201217183756.GE23634@zn.tnic>
        <20201221095425.6da68163@lwn.net>
        <20201222130555.GA13463@zn.tnic>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Digging out from under the pile of mail...]

> From: Borislav Petkov <bp@suse.de>
> Date: Tue, 22 Dec 2020 13:58:22 +0100
> 
> Document that backtraces in commit messages should be trimmed down to
> the useful information only.
> 
> This has been carved out from a tip subsystem handbook patchset by
> Thomas Gleixner:
> 
>   https://lkml.kernel.org/r/20181107171010.421878737@linutronix.de
> 
> and incorporates follow-on comments.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  Documentation/process/submitting-patches.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 5ba54120bef7..0ffb21366381 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -679,6 +679,26 @@ generates appropriate diffstats by default.)
>  See more details on the proper patch format in the following
>  references.
>  
> +Backtraces in commit mesages
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Backtraces help document the call chain leading to a problem. However,
> +not all backtraces are helpful. For example, early boot call chains are
> +unique and obvious. Copying the full dmesg output verbatim, however,
> +adds distracting information like timestamps, module lists, register and
> +stack dumps.
> +
> +Therefore, the most useful backtraces should distill the relevant
> +information from the dump, which makes it easier to focus on the real
> +issue. Here is an example of a well-trimmed backtrace::
> +
> +  unchecked MSR access error: WRMSR to 0xd51 (tried to write 0x0000000000000064)
> +  at rIP: 0xffffffffae059994 (native_write_msr+0x4/0x20)
> +  Call Trace:
> +  mba_wrmsr
> +  update_domains
> +  rdtgroup_mkdir
> +

So I have some questions, I guess...  How often is a backtrace *in a commit
message* really helpful at all?  The value in problem reports is clear, but
I'm not sure how often having a backtrace in a commit message will really
help the reader understand why the patch was written.  But perhaps I'm
wrong?

If we do want this advice in our already-too-long submitting-patches
document, we should perhaps give some advice as to what is "relevant
information" and what is not?

Thanks,

jon
