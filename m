Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726CD2FD2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390659AbhATOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:39:25 -0500
Received: from foss.arm.com ([217.140.110.172]:37580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390099AbhATOid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:38:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E574D6E;
        Wed, 20 Jan 2021 06:37:47 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.36.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 032F63F66E;
        Wed, 20 Jan 2021 06:37:45 -0800 (PST)
Date:   Wed, 20 Jan 2021 14:37:43 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: rcutorture initrd/nolibc build on ARMv8?
Message-ID: <20210120143743.GB77728@C02TD0UTHF1T.local>
References: <20210119153147.GA5083@paulmck-ThinkPad-P72>
 <20210119161901.GA14667@1wt.eu>
 <20210119170238.GA5603@C02TD0UTHF1T.local>
 <20210119171637.GA14704@1wt.eu>
 <20210119174358.GB14704@1wt.eu>
 <20210120120725.GB73692@C02TD0UTHF1T.local>
 <20210120124340.GA15935@1wt.eu>
 <20210120134511.GA77728@C02TD0UTHF1T.local>
 <20210120142500.GB15935@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120142500.GB15935@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 03:25:00PM +0100, Willy Tarreau wrote:
> On Wed, Jan 20, 2021 at 01:45:11PM +0000, Mark Rutland wrote:
> > There's still some latent issue when using nolibc (compared to using
> > glibc) where the init process never seems to exit, but that looks to be
> > orthogonal to the syscall numbering issue -- I'm currently digging into
> > that.
> 
> OK! Usually for me it does as in my preinit (which uses nolibc), if I
> exit I instantly get a kernel panic. In addition if I launch it after
> boot, it immediately exits and shows no issue. But maybe you're observing
> an artefact related to something else (process session, opened FD or
> anything else maybe).

Luckily this was nothing to do with nolibc -- the build system wasn't
regenerating the initramfs to use the correctly-compiled init, and
things were blowing up because the kernel couldn't find an init process.
With that regenerated it worked as intended.

I'll reply separately for the rest of the nolibc bits shortly.

Thanks,
Mark.
