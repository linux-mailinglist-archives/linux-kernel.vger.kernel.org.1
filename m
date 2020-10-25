Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA112981C2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 14:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416169AbgJYNGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 09:06:48 -0400
Received: from foss.arm.com ([217.140.110.172]:45730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416161AbgJYNGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 09:06:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C581812FC;
        Sun, 25 Oct 2020 06:06:46 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D00D3F66B;
        Sun, 25 Oct 2020 06:06:45 -0700 (PDT)
Date:   Sun, 25 Oct 2020 13:06:42 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH] smp: Add bootcpus parameter to boot subset of CPUs
Message-ID: <20201025130642.yurgta7s63aecgrj@e107158-lin>
References: <1603404243-5536-1-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1603404243-5536-1-git-send-email-eberman@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot

On 10/22/20 15:04, Elliot Berman wrote:
> In a heterogeneous multiprocessor system, specifying the 'maxcpus'
> parameter on kernel command line does not provide sufficient control
> over which CPUs are brought online at kernel boot time, since CPUs may
> have nonuniform performance characteristics. Thus, add bootcpus kernel

Are you seeing boot time issues on big.LITTLE systems that's why you need this
extra config? If so it'll be good to elaborate on the problem. Scheduler should
place the heavy tasks on bigs. It'll be good to understand what's failing in
here as this might not be addressing the root cause.

Thanks

--
Qais Yousef

> parameter to control which CPUs should be brought online during kernel
> boot. When both maxcpus and bootcpus is set, the more restrictive of the
> two are booted.
