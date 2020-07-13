Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23002219C56
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgGIJb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 05:31:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgGIJb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:31:56 -0400
Date:   Thu, 9 Jul 2020 11:31:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594287114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tuvfl4lp33mBSrKFJ/WLHd+knY1GDMg47O2dd0IKQZE=;
        b=3VV0Yy2WZ5KQ0MWtljWkVUa4AKf/Ua4rWCCtmsqoO4Gt+KopdJ4HHaUSiPE0Hl9wpAXcmV
        JbSwavg1LDn5jE1t/e5R4KFhtG72UiikOvT963BcCc9oXoboQvVvjgIk1JigHHSXpC5qfh
        VqTUlZQI3nHdyW33g/XX5keagaLWeSZTOC0r9QLX4C3JiJ7r7rSbl2BaIMF31X2WqT/XlT
        S1GNaz4x4kfOX/N5Zhfa1lNNI8VdY6h86LtGNsxdkxidmOTAkd7AESeCnrP9NGTuG4IEcJ
        +md1GawMYIhVrqMObROCqkY5BkrvvBrodNKIi6vOCuMGbzsyT02kH98PBxdxdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594287114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tuvfl4lp33mBSrKFJ/WLHd+knY1GDMg47O2dd0IKQZE=;
        b=oNat9XoYL5AZf51a+7Yod57UPOska9x7/QETpTN2n3+SvV+hH3nHuznkSK2w4LGXgTIUgR
        pPGyLBXIeQCO/ADA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.4.229-rt200
Message-ID: <20200709093151.o6ea5lqc753pxdr7@linutronix.de>
References: <159423384250.24491.10602573106875114227@beryllium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159423384250.24491.10602573106875114227@beryllium>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-08 18:44:02 [-0000], Daniel Wagner wrote:
> I'm pleased to announce the 4.4.229-rt200 stable release.
> 
> This release is just an update to the new stable 4.4.215 version.

Your template is off here.

> Note: This update required dealing with a conflict in net/core/dev.c, where
> devnet_rename_seq was moved from a seqence count to an RWSEM and renamed
> to devnet_rename_sem. If you encounter runtime issues that show tracebacks
> in net/core/dev.c, please let me know.
>
> Patch "net: Add a mutex around devnet_rename_seq" dropped in favour of
> 602c47fbf46b ("net: core: device_rename: Use rwsem instead of a seqcount")

Yes, this was the intention of the exercise :)
 
> Known issues:
> 
>   sigwaittest with hackbench as workload is able to trigger a crash on x86_64,
>   the same as reported for the v4.4.220-rt196 release. The crash seems to
>   be triggered by a BPF program. IIRC, BPF was never supported in v4.4-rt
>   and I just forgot to disable in my configuration.

In v5.4.3-rt1 there is
    fe18e9e08e25d ("BPF: Disable on PREEMPT_RT")

so maybe backport this across the stable kernels. Fixing it is a way
larger queue. If the intention is to keep it disabled it could be
enforced via Kconfig so it is not enabled by accident (or by using
oldconfig on a distro config which has it enabled).

> Enjoy!
> Daniel

Sebastian
