Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4532A2A07AF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgJ3OSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:18:43 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52246 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgJ3OSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:18:42 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id D858920B9C34
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:18:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D858920B9C34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604067521;
        bh=7UykXxKuhXvnD0pPPledPURv1zD8fsOWW1uVdnm6m4c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JyYHfDBTp4HVSAwxv9gSd6JlMT9P6X/4ZnYIt1E5up8xqXhWJpj/gHQa0r36NqVvj
         NUjVS5DmsytzujpWE+gPvIcrSUWUsmGNlTcDwRNd1tXD59+tdHELbUib051eIRcSGM
         rrUMBJp2AoHEJ9QRPwtyTADXwcWojlOzfkPmPnwk=
Received: by mail-qt1-f177.google.com with SMTP id h12so4137300qtc.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:18:41 -0700 (PDT)
X-Gm-Message-State: AOAM5307vatV4wBCoDLYffxgP3MWvVLrYcTaRqHtApCXwAhh0th4TqbR
        qg66dSS+BWMfvHuHObR5XbMuxzIc+mLU3Xx66JE=
X-Google-Smtp-Source: ABdhPJxf44vFdPqblAg8m63rmdMWM6RRnMj2t589nY8TpfmmG5Bi2apIVDg6uHrfKyRocCvrb9b4TKUbcX3Q6sWZ0XU=
X-Received: by 2002:ac8:7408:: with SMTP id p8mr2204569qtq.320.1604067520927;
 Fri, 30 Oct 2020 07:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201027133545.58625-1-mcroce@linux.microsoft.com>
 <20201027133545.58625-2-mcroce@linux.microsoft.com> <20201027134243.GC991306@kroah.com>
 <20201030141324.GD1602@alley>
In-Reply-To: <20201030141324.GD1602@alley>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 30 Oct 2020 15:18:04 +0100
X-Gmail-Original-Message-ID: <CAFnufp3sSb6_puAUpCdp9v2Kzw77-dtSAZrmzEwQpUeu6rRAUw@mail.gmail.com>
Message-ID: <CAFnufp3sSb6_puAUpCdp9v2Kzw77-dtSAZrmzEwQpUeu6rRAUw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] reboot: fix overflow parsing reboot cpu number
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>,
        Fabian Frederick <fabf@skynet.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 3:13 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2020-10-27 14:42:43, Greg KH wrote:
> > On Tue, Oct 27, 2020 at 02:35:44PM +0100, Matteo Croce wrote:
> > > From: Matteo Croce <mcroce@microsoft.com>
> > >
> > > Limit the CPU number to num_possible_cpus(), because setting it
> > > to a value lower than INT_MAX but higher than NR_CPUS produces the
> > > following error on reboot and shutdown:
> > >
> > > Fixes: 1b3a5d02ee07 ("reboot: move arch/x86 reboot= handling to generic kernel")
> > > Signed-off-by: Matteo Croce <mcroce@microsoft.com>
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> > <formletter>
> >
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> >
> > </formletter>
>
> The best way is to add the following line before Signed-off-by line:
>
> Cc: stable@vger.kernel.org
>

I see, sorry for the noise. Should I resend, or I eventually write to
stable@vger.kernel.org after the merge?


-- 
per aspera ad upstream
