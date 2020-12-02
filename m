Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04C02CC51A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389445AbgLBS2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:28:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389417AbgLBS2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:28:43 -0500
Date:   Wed, 2 Dec 2020 19:29:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606933683;
        bh=djKBr+k0zdd49EoaBtuwC9mnSXlOnntgTk2YtxofPnA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfKJqIepmWOa5OQrWeeLXZP5O/ZoS1Cz6wChtaIuU/2imkxtJFCks85r7itCdid/F
         1oXizAEPQzV+Zgv/jsECUJ24Ap6feEWxTgH5PbbY/J4yb7chedwGik8YP3cog/q7wi
         rB1QQgHRlKrvQyShKYwHsXj2atmS3TZLbe273BfY=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kernfs: speed up concurrency performance
Message-ID: <X8fc+LYtRkPa6ZGg@kroah.com>
References: <20201202145837.48040-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202145837.48040-1-foxhlchen@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:58:35PM +0800, Fox Chen wrote:
> Hello,
> 
> kernfs is an important facillity to support pseudo file systems and cgroup. 
> Currently, with a global mutex, reading files concurrently from kernfs (e.g. /sys) 
> is very slow.
> 
> This problem is reported by Brice Goglin on thread:
> Re: [PATCH 1/4] drivers core: Introduce CPU type sysfs interface
> https://lore.kernel.org/lkml/X60dvJoT4fURcnsF@kroah.com/
> 
> I independently comfirmed this on a 96-core AWS c5.metal server.
> Do open+read+write on /sys/devices/system/cpu/cpu15/topology/core_id 1000 times.
> With a single thread it takes ~2.5 us for each open+read+close.
> With one thread per core, 96 threads running simultaneously takes 540 us 
> for each of the same operation (without much variation) -- 200x slower than the 
> single thread one. 
> 
> The problem can only be observed in large machines (>=16 cores).
> The more cores you have the slower it can be.
> 
> Perf shows that CPUs spend most of the time (>80%) waiting on mutex locks in 
> kernfs_iop_permission and kernfs_dop_revalidate.
> 
> This patchset contains the following 2 patches:
> 0001-kernfs-replace-the-mutex-in-kernfs_iop_permission-wi.patch
> 0002-kernfs-remove-mutex-in-kernfs_dop_revalidate.patch
> 
> 0001 replace the mutex lock in kernfs_iop_permission with a new rwlock and 
> 0002 removes the mutex lock in kernfs_dop_revalidate.
> 
> After applying this patchset, the multi-thread performance becomes linear with 
> the fastest one at ~30 us to the worst at ~150 us, very similar as I tested it
> on a normal ext4 file system with fastest one at ~20 us to slowest at ~100 us. 
> And I believe that is largely due to spin_locks in filesystems which are normal.
> 
> Although it's still slower than single thread, users can benefit from this 
> patchset, especially ones working on HPC realm with lots of cpu cores and want to
> fetch system information from sysfs.

Does this mean that the changes slow down the single-threaded case?  Or
that it's just not as good as the speed of a single-threaded access?

But anyway, thanks so much for looking into this, it should help the
crazy systems out today, which means the normal systems in 5 years will
really appreciate this :)

Some minor comments on the individual patches follow...

thanks,

greg k-h
