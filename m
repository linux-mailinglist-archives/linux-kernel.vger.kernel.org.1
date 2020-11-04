Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2CD2A64DB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 14:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgKDNJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 08:09:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49276 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgKDNJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:09:33 -0500
Date:   Wed, 4 Nov 2020 14:09:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604495371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pUT3uWTWS+WaUcpywiImqmcAM26B6YI8G5nOropHTLE=;
        b=vGqRLl3kdzJ0VBAYZFytSpYWS3EaBPEfmNkriNVWNinm4e0fPO699W6v1n/mXZEx2wXPqF
        0ucYTlSXf4576CB+11L1u0kjIffQj2q+439XzPAzFwXASBUWt2zpuWhkcXBnt7fvEyKGHs
        FRebNPDX43EaUm7YK0/kyu8BAf22MTV9aI0rSWGbVa6zlPc8wrWl14y9WxkMzBXC0b9+qu
        osrQqMUEUMlw5vw1MuR8YU7XnGGIiCqsKiYG4dC5b1Bg0MAX31uGGoDkNy49Xr7NEV89Gt
        WIIY94fAsHJm8rdMWjcqyk9L4VqyyWpYJfY/UVR9vZ60OeMDWEszUcF0CAYBow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604495371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pUT3uWTWS+WaUcpywiImqmcAM26B6YI8G5nOropHTLE=;
        b=iR0YpjXokOD5/8GM1QfsMVPrLDVy2mLWutKikHsdiyTTheDMc47LTc/b4T28Idk/ghpjyG
        cQ3DnTGb8b645aBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201104130930.llx56gtqt532h7c7@linutronix.de>
References: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
 <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
 <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
 <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
 <20201104124746.74jdsig3dffomv3k@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104124746.74jdsig3dffomv3k@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-04 13:47:46 [+0100], Daniel Wagner wrote:
> On Wed, Nov 04, 2020 at 12:19:48PM +0100, Daniel Wagner wrote:
> > Yes, Just fired up signaltest 5 times for arm64 and x86_64 with the
> > latest release. Keep you posted.
> 
> arm64
>   1184  0_signaltest         t0-max-latency      : fail     386.00
>   1185  0_signaltest         t0-max-latency      : fail     417.00
>   1186  0_signaltest         t0-max-latency      : fail     350.00
>   1187  0_signaltest         t0-max-latency      : fail     360.00
>   1188  0_signaltest         t0-max-latency      : fail     339.00
> 
> I noticed that also the last view 5.9-rt releases have higher values.
> For example, version 5.9.0-rc8-rt12 has only 217us.
> 
> x86_64
>   1189  0_signaltest         t0-max-latency      : fail      50.00
>   1190  0_signaltest         t0-max-latency      : pass      46.00
>   1191  0_signaltest         t0-max-latency      : pass      45.00
>   1192  0_signaltest         t0-max-latency      : pass      47.00
>   1193  0_signaltest         t0-max-latency      : fail      52.00
> 
> Same thing for version 5.9.0-rc8-rt12, the max value was 40us.
> 
> I'll work on getting these reports more useful, the performance trend
> seems to be an interesting metric.

Could you figure out if the arm64 thingy started with -rt4 or was
already in rt3?

Sebastian
