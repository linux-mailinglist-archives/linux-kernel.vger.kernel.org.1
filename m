Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62B4297330
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbgJWQGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465065AbgJWQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:06:33 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F3C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:06:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d3so2247890wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=memsql.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=euExVQPA72xd2lVFnWoLuf29tkwnJwV+/7v1rKWYMoY=;
        b=YMf/AuBQZJeprX8rwYV8MDjzl85nrWVVMNJunVFNRYNF4FCk7xxBQlyC2mRlclOvls
         ibOxrcWwN5G9tfh4dsMkXZ2Dnf+3T6hwt53ke5ZFPOui4Jo5oOdF9iyexc3Pv5/gKUpX
         8RKl65IEYsaEzyTbGnvRPP4qkLyYdPMfntS+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=euExVQPA72xd2lVFnWoLuf29tkwnJwV+/7v1rKWYMoY=;
        b=OahSnf58ywR58klOWoh2xZ0WeGoq+/bcqZWiMy2cVel52h8f9ldXM1qlq32BdVmPWH
         93mcT2p9gZjrXzNea/iaTp301qAT45RJAGGwxkHQdu84sLh2he4mAAQADigMdYAbXAJ4
         fRohPR5R6WZNYUoc/1LrHw6c4OP0LpexXkhO9MtZUxq4R9aWxirAyfADke4EqGBqkX4M
         FeWlN4WRmPkrJGLophJCFFH3xW8nleWPdAUOHOc6T7Hm8pSVX0CWia9PywPDr28RwUlO
         LmnGkiQId+Q9HUIoemnCW1ZqI0fWe1FyaIY7MMKfjJpebcRDpNakmZLZi9TnGKj3gARH
         CrFA==
X-Gm-Message-State: AOAM532o5po8tZJXJfz/ofOsVIPNlMb2/hilJq0Yw0sas0hmB6+Wa8PW
        mmnJHF5DWApnXEFHo5RTLI0UCA==
X-Google-Smtp-Source: ABdhPJwisw9TKSCnTKqraDv49s4Pd+yLYGAqVzYvIyPs4/IEZFdmeyxiVttF1HObyY9e0sZk50btVw==
X-Received: by 2002:a05:600c:216:: with SMTP id 22mr2889313wmi.149.1603469190929;
        Fri, 23 Oct 2020 09:06:30 -0700 (PDT)
Received: from rdias-suse-pc.lan (bl13-26-148.dsl.telepac.pt. [85.246.26.148])
        by smtp.gmail.com with ESMTPSA id n62sm4501175wmb.10.2020.10.23.09.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:06:30 -0700 (PDT)
Date:   Fri, 23 Oct 2020 17:06:28 +0100
From:   Ricardo Dias <rdias@memsql.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tcp: fix race condition when creating child sockets from
 syncookies
Message-ID: <20201023160628.GA316690@rdias-suse-pc.lan>
References: <20201023111352.GA289522@rdias-suse-pc.lan>
 <CANn89iJDt=XpUZA_uYK98cK8tctW6M=f4RFtGQpTxRaqwnnqSQ@mail.gmail.com>
 <20201023155145.GA316015@rdias-suse-pc.lan>
 <CANn89iL2VOH+Mg9-U7pkpMkKykDfhoX-GMRnF-oBmZmCGohDtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iL2VOH+Mg9-U7pkpMkKykDfhoX-GMRnF-oBmZmCGohDtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 05:56:07PM +0200, Eric Dumazet wrote:
> On Fri, Oct 23, 2020 at 5:51 PM Ricardo Dias <rdias@memsql.com> wrote:
> >
> > On Fri, Oct 23, 2020 at 04:03:27PM +0200, Eric Dumazet wrote:
> > > On Fri, Oct 23, 2020 at 1:14 PM Ricardo Dias <rdias@memsql.com> wrote:
> > >
> > > ...
> > >
> > > Note that normally, all packets for the same 4-tuple should be handled
> > > by the same cpu,
> > > so this race is quite unlikely to happen in standard setups.
> >
> > I was able to write a small client/server program that used the
> > loopback interface to create connections, which could hit the race
> > condition in 1/200 runs.
> >
> > The server when accepts a connection sends an 8 byte identifier to
> > the client, and then waits for the client to echo the same identifier.
> > The client creates hundreds of simultaneous connections to the server,
> > and in each connection it sends one byte as soon as the connection is
> > established, then reads the 8 byte identifier from the server and sends
> > it back to the server.
> >
> > When we hit the race condition, one of the server connections gets an 8
> > byte identifier different from its own identifier.
> 
> That is on loopback, right ?

Yes it's on loopback.

> 
> A server under syn flood is usually hit on a physical NIC, and a NIC
> will always put all packets of a TCP flow in a single RX queue.
> The cpu associated with this single RX queue won't process two packets
> in parallel.

And what about the loopback interface? Why couldn't the loopback
interface also use a single RX queue?

> 
> Note this issue is known, someone tried to fix it in the past but the
> attempt went nowhere.
