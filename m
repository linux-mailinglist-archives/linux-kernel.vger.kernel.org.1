Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F1728CA33
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391419AbgJMIZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390218AbgJMIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:25:07 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F5C0613D0;
        Tue, 13 Oct 2020 01:25:05 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id b138so13179581yba.5;
        Tue, 13 Oct 2020 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yb8uf1yPz5kaBwo/Czxv6SGb8eqvWHd/MSZ3XQ2Vi/0=;
        b=QUjOIjM0KrH/aLS1ph9lySWsHWQx1pHFSw1wYRy9z8pn6WVQwNzB1V9aoKeAXVE6CX
         VWGSpt8a0vzTG+LUJypOBnACtBk0Fc56LLMnqqWDrl5B8VEPayx/YtAEBZ38zwbuDMd0
         ed4iN3Amc2mpGFHz004yjbejwN4iwub6dpZR74j0wps7vnTRUR8/r/XtWb56KAdadEJa
         9iEzZfxtKZbVSsNIW0hDW89UdRPxjwmo6KMs6+affBm68FCwfEmpMKsfzVDjE/VK+S7f
         xt18lMJDnyV2I4rZOziUZ1P8NU/UZGccqhG42lEVrbHp8xs9Ybc10Hz03Ld+Y4lbw+C2
         BuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yb8uf1yPz5kaBwo/Czxv6SGb8eqvWHd/MSZ3XQ2Vi/0=;
        b=ryoKjf9HBL1Jl2FSz2IAn8oRF2xDmomwPBNHq+0SHn6WPADRBK+YLRJy4DQOr+7/bj
         gynbfZ3Uw3csxqieFu0N0onSNSs49WivMnlKvabZ6Qf1dAhVoBdgI/EUCnF14wMPTlV7
         qXzloBE8GBc0pttKP4fvrYi4wTHJ7hzstUisKvoyHIohnWW2Tq2HgMnqBHbC2WwRRKt8
         usPq+bIYebdT3peC4BG1ssc1hn9tijT+wLczfPcDq5RadTyDh9SG+DxECwdcO6deqpoC
         Iok062JgUzWsRdIhpvcAmtGqZlDgVoj6EKNZKdxfuEfNsTozCNfyLUDPIAQDhFCCjT8F
         A30g==
X-Gm-Message-State: AOAM531i1iial4gGiZi4fuo/CPXhL5pH9rC6wJZ6GOSnaNsMR8UglUSc
        SlGfeps7WvQKK8GCB8bCzyGCnCLaWWPcYLOqbLs=
X-Google-Smtp-Source: ABdhPJySApp9x9zfOYAVifM5CshLWnRdvhNLRlJpT7ZLNFcQEbmf6GC1o6S1rHaDXsk1JeO08TWzANjnU5JDtt6QRQ8=
X-Received: by 2002:a25:e046:: with SMTP id x67mr36342627ybg.342.1602577504560;
 Tue, 13 Oct 2020 01:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com>
 <alpine.DEB.2.21.2010121550300.6487@felia> <20201012145710.GA631710@rowland.harvard.edu>
 <alpine.DEB.2.21.2010121659040.6487@felia> <20201012151816.GA1559916@kroah.com>
 <alpine.DEB.2.21.2010122022250.17866@felia> <20201013052317.GB330398@kroah.com>
 <alpine.DEB.2.21.2010130725370.14590@felia>
In-Reply-To: <alpine.DEB.2.21.2010130725370.14590@felia>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 13 Oct 2020 09:24:28 +0100
Message-ID: <CADVatmNcUzT6Df4+V7VdwO0AzZ=74Sai7X0aFpYU5SO7b2NVSg@mail.gmail.com>
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Tue, Oct 13, 2020 at 6:37 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
>
>
> On Tue, 13 Oct 2020, Greg Kroah-Hartman wrote:
>
> > On Mon, Oct 12, 2020 at 08:25:30PM +0200, Lukas Bulwahn wrote:
> > >
> > >
> > > On Mon, 12 Oct 2020, Greg Kroah-Hartman wrote:
> > >
> > > > On Mon, Oct 12, 2020 at 05:10:21PM +0200, Lukas Bulwahn wrote:
> > > > > And for the static analysis finding, we need to find a way to ignore this
> > > > > finding without simply ignoring all findings or new findings that just
> > > > > look very similar to the original finding, but which are valid.
> > > >
<snip>
> >
> > Why not fix the things that it finds that are actually issues?  If there
> > are no actual issues found, then perhaps you should use a better tool?  :)
> >
>
> Completely agree. That is why I was against adding comments here and
> elsewhere just to have the "good feeling of doing something" after the
> tool reported a warning and we spend some time understanding the code to
> conclude that we now understand the code better than the tool.

I think you are missing the point here. I sent the comment not because
of any tool, I sent it because the code there was not that simple like
other drivers and at a first glance its not apparent why there are no
error checks. And, afaik, the only purpose of comments is to make the
source code easier to understand.


-- 
Regards
Sudip
