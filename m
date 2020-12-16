Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35302DC8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 23:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgLPWOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 17:14:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgLPWOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:14:55 -0500
Date:   Wed, 16 Dec 2020 22:14:10 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        pr-tracker-bot@kernel.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: make _TIF_WORK_MASK bits contiguous (was: Re:
 [GIT PULL] TIF_NOTIFY_SIGNAL for all archs)
Message-ID: <20201216221410.GA27159@C02TF0J2HF1T.local>
References: <701d4747-bbbb-dbb4-d828-63d096fcc22a@kernel.dk>
 <160815345901.27795.2544235487408028611.pr-tracker-bot@kernel.org>
 <20201216220422.GA19075@C02TD0UTHF1T.local>
 <CAHk-=wja217nCNOAS_bYB35kJRSgnv29fUAUGSGMCpf-aqeycg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wja217nCNOAS_bYB35kJRSgnv29fUAUGSGMCpf-aqeycg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 02:06:46PM -0800, Linus Torvalds wrote:
> On Wed, Dec 16, 2020 at 2:04 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > Unfortunately the merge resolution broke the build for arm64 -- could
> > you please apply the fixup below? IIUC that matches what we did in
> > linux-next, and builds fine locally.
> 
> Oops. That was a bit too subtle. I didn't realize that the bits really
> wanted to be contiguous, and it wasn't obvious at the point of
> conflict.
> 
> Will apply your fix asap.

Thanks Linus for applying it and thanks Mark for the quick fix. I
noticed it in -next before and gave Stephen my conflict resolution.

-- 
Catalin
