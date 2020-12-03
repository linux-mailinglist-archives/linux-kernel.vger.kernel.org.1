Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1E2CCF99
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgLCGjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgLCGjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:39:22 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C907C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 22:38:36 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d8so1152147lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 22:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDbVCUYC5fALwRpDFoDkF3ggntqlVa1OHX/vjw8Vu3w=;
        b=DKQvbXQ3vycdLb0N8T0Mj+y89yj1lu/0nsZmZUYAD+3ZGXZEIqRUbD2+yAKtJf4Wj2
         YsZdVWdDXMSXvTrJikjMQdDTT9uYJFW26t555nnGEM17+jSQh0d78oAEJJPsTBsXlhnB
         +Z74LNDVGBq0TIse1iu3nXtNXyXInFiHNwNNKsUVngZ/GNQ5xEs3TdDdO8AbzDqqabyq
         W0goBbbV2QsJwctunXVSDb0ZcxQcp+3J8mXB2fKj5SLS6TcM8MQj3t5wP0CNzYGSgh5O
         /8lwkZBDNgOj0fm3xUXKv6rSgvR5iiB9/R5yqZgpbtT4S5pGNLjDRGOjlb9SlxPilBDS
         0HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDbVCUYC5fALwRpDFoDkF3ggntqlVa1OHX/vjw8Vu3w=;
        b=p7xW66k6OvUOB+i63OweDewPNuOMQ5Id/TlNvSmdUuzPY/Wr02P+NYBjtkLDTdVJlg
         ZO3+0ocTypJ5GTCqiJnBEevR8FfvYVPTxHMD+3jns9SqN5G4kUpgv+gtCKJmB2vwroSF
         d9MzQ4gecq71RYiHIJtdQw+2EoZk8pX6kxAhw49oPnRUDCVSXgCQSKjbH7RYad8aNj0d
         g1leBa99lg/9oUHfn1maSB8/AHdPTtv5K8VykbbjfqL8Q9OIkY8eyewyzXWoRZ6r/HOK
         8W3Deo4YVksoKHuuXBzSP+vo44lXgkFLaByVjZ8WQ2QlEdmyj2K+j4kzopnDVefxsByd
         TN0g==
X-Gm-Message-State: AOAM53253ZuwsZd3vvMuKd3k4oSwL0OTRDBqVmGJybOINxZLAoFmk0w9
        b8/9jr9n+B7HPI00V/w58a70mxa8aLzXdRZm3Vk=
X-Google-Smtp-Source: ABdhPJxvEBm0NUQiKXCs26+PXQDs5qrQj/UR0q4opvcWF6Sg2gtKN8Wiar+MrTMhsnUpYVMwdEMqm10aYze2P6Sx4bQ=
X-Received: by 2002:a19:be58:: with SMTP id o85mr721997lff.346.1606977514631;
 Wed, 02 Dec 2020 22:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20201202145837.48040-1-foxhlchen@gmail.com> <X8fc+LYtRkPa6ZGg@kroah.com>
In-Reply-To: <X8fc+LYtRkPa6ZGg@kroah.com>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Thu, 3 Dec 2020 14:38:22 +0800
Message-ID: <CAC2o3D+okRbs222hnd5j3Pba8dqVQJifXg=2Py0fyRiEx62P7w@mail.gmail.com>
Subject: Re: [PATCH 0/2] kernfs: speed up concurrency performance
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 2:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 02, 2020 at 10:58:35PM +0800, Fox Chen wrote:
> > Hello,
> >
> > kernfs is an important facillity to support pseudo file systems and cgroup.
> > Currently, with a global mutex, reading files concurrently from kernfs (e.g. /sys)
> > is very slow.
> >
> > This problem is reported by Brice Goglin on thread:
> > Re: [PATCH 1/4] drivers core: Introduce CPU type sysfs interface
> > https://lore.kernel.org/lkml/X60dvJoT4fURcnsF@kroah.com/
> >
> > I independently comfirmed this on a 96-core AWS c5.metal server.
> > Do open+read+write on /sys/devices/system/cpu/cpu15/topology/core_id 1000 times.
> > With a single thread it takes ~2.5 us for each open+read+close.
> > With one thread per core, 96 threads running simultaneously takes 540 us
> > for each of the same operation (without much variation) -- 200x slower than the
> > single thread one.
> >
> > The problem can only be observed in large machines (>=16 cores).
> > The more cores you have the slower it can be.
> >
> > Perf shows that CPUs spend most of the time (>80%) waiting on mutex locks in
> > kernfs_iop_permission and kernfs_dop_revalidate.
> >
> > This patchset contains the following 2 patches:
> > 0001-kernfs-replace-the-mutex-in-kernfs_iop_permission-wi.patch
> > 0002-kernfs-remove-mutex-in-kernfs_dop_revalidate.patch
> >
> > 0001 replace the mutex lock in kernfs_iop_permission with a new rwlock and
> > 0002 removes the mutex lock in kernfs_dop_revalidate.
> >
> > After applying this patchset, the multi-thread performance becomes linear with
> > the fastest one at ~30 us to the worst at ~150 us, very similar as I tested it
> > on a normal ext4 file system with fastest one at ~20 us to slowest at ~100 us.
> > And I believe that is largely due to spin_locks in filesystems which are normal.
> >
> > Although it's still slower than single thread, users can benefit from this
> > patchset, especially ones working on HPC realm with lots of cpu cores and want to
> > fetch system information from sysfs.
>
> Does this mean that the changes slow down the single-threaded case?  Or
> that it's just not as good as the speed of a single-threaded access?

No, It won't influence the single-threaded case. I meant
multi-threaded case is still not as good as single-threaded one.

> But anyway, thanks so much for looking into this, it should help the
> crazy systems out today, which means the normal systems in 5 years will
> really appreciate this :)

thanks :)
