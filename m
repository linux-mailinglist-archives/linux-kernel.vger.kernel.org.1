Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC2A2DAEEA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgLOO0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbgLOOZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:25:28 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71E9C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:24:47 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id r5so21176435eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLpk+0c6FuyfGY/ZPM8JLqZ7uOu3TenhRTPoyAvYEGM=;
        b=bABxRUzF+8ZxeFd1UT+nifMCe3/bsD9P1eGnnGbiecDth0Z+o1KFOGVsOSoJ/piXIE
         XuPG61GuEQqe6Aj6eaw2SVpZksUBg/Lwlnn6cj3T3k4/vYkSc4lQ9aS0MaleRSWwJxzZ
         YN1WSdUWqWQ9ZF1GQZr3iWhRwlLS8GC/VMBnStAjmbf6tVtHOVzlEXIG5fbMs3KNOeWx
         Bhe27fsPeeGf3azCz14n3Ffgo6h9BzitvM30sWW/KDyLWI25oguqYTE/tAmntQSV8I9H
         c86KYGKniC3UIEXndhgW+GbHFhdYDLiWcrNDYijoLsQnGwSDgskTvdztQpUm7lF4HjJu
         unZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLpk+0c6FuyfGY/ZPM8JLqZ7uOu3TenhRTPoyAvYEGM=;
        b=tdFIaapms6LwUJGg5auXbbkhlwptypk1Bq1W4Ewlssi1ZfGyw2HrO7jRyYukAjNAl+
         tMb2EOLnFwZ8H/MhXKmviy9QxFWN4iV43YZ3c5cqsUV9tEc2l/Cj/4lyrIQkNeH4WhK/
         WN1Gp8Tq15tnq5eEdHvlDMVtnE84T9sQ6Mow7YjAU80Z98l3NsKirt8hY39z3DhkgzQB
         Deo+bvw2VL797LNqItCwTqj8mOC8nLX1ob6ctrN6UL0miZMYQFNe+55vdI9+KhZ4N1dS
         suDktyL1E24oSZ2gV65SQBhFXINzQYw+e2ZinKk9InurJ/8mn7BwqkRAPYdwA7+nSAho
         D0Mg==
X-Gm-Message-State: AOAM530Y5M+w5Y++yoUg4m3nQhiklLLLbXj9F55x8G8kbY3U6SsPwhBJ
        jcBm/0So9QU1VxXBGx+qcpgQl/r+5uG9h9ZkpM4n3pu+aW9ipot9
X-Google-Smtp-Source: ABdhPJzHxKob1ssLVm6vrZLfegboHmbPniBwBbz7OSz4o9b90xXM3Bo0HfSHJ1jAtKSRAuumlFWY6EGplsEYfGteu/g=
X-Received: by 2002:a05:6402:229b:: with SMTP id cw27mr29522993edb.23.1608042286116;
 Tue, 15 Dec 2020 06:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20201126130606.2290438-1-anders.roxell@linaro.org>
 <8affd609-f037-8b21-853a-8b87299db044@gmx.de> <CADYN=9+pSK2SHY4ncFaseT9qz6BoTCUxi0e3poTDao4v=S_84g@mail.gmail.com>
 <CA+G9fYtNgeOgymsVwj423eXOFP1B=mS4KKvy+1Bu3tUapXyxDA@mail.gmail.com>
In-Reply-To: <CA+G9fYtNgeOgymsVwj423eXOFP1B=mS4KKvy+1Bu3tUapXyxDA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 15 Dec 2020 19:54:32 +0530
Message-ID: <CA+G9fYtgKFUsiY2x8Ue-cnO2Jr1+teQZ_3TbKC+eD9c6OpkPGg@mail.gmail.com>
Subject: Re: [PATCH] parisc: signal: remove _SA_SIGGFAULT
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Helge Deller <deller@gmx.de>,
        James.Bottomley@hansenpartnership.com,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anders,

On Wed, 2 Dec 2020 at 13:31, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Anders,
>
> On Fri, 27 Nov 2020 at 04:10, Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > On Thu, 26 Nov 2020 at 15:46, Helge Deller <deller@gmx.de> wrote:
> > >
> > > On 11/26/20 2:06 PM, Anders Roxell wrote:
> > > > When building tinyconfig on parisc the following error shows up:
> > > >
> > > > /tmp/kernel/signal.c: In function 'do_sigaction':
> > > > /tmp/arch/parisc/include/asm/signal.h:24:30: error: '_SA_SIGGFAULT' undeclared (first use in this function); did you mean 'SIL_FAULT'?
> > > >  #define __ARCH_UAPI_SA_FLAGS _SA_SIGGFAULT
> > > >                               ^~~~~~~~~~~~~

I see these build failures on Linux mainline.

ref:
https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/jobs/911416687

Steps to reproduce:
-----------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.


tuxmake --runtime docker --target-arch parisc --toolchain gcc-9
--kconfig defconfig


- Naresh
