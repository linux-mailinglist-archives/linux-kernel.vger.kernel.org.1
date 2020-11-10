Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B40B2ADDB8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgKJSFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:05:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59972 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJSFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:05:21 -0500
Date:   Tue, 10 Nov 2020 19:05:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605031519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c5kUx/vmnIfAtfqkSPxpHH83jR5Jo7p5HtOWi7vET0Y=;
        b=EDLQvQUtJqa75L5Nnt82N2On3bFPK4mf3Jjal/PZq7QjeKxxdZZZhdl21aTty1HjUTrDs4
        1XU/VVIu3oFt9uOdrSwF1xOcA5bCm8jAiQBddu+DjGWK/ohx74IJV06IDTdW9/LQWAvC/T
        zv2goN7d3zVFjk8tcaWas3oXK3WVhu+BOdIQEnSe3viGQHSE1sbwhOx63REXQyvFyWmhQy
        w/M6oKrRFSNOoAwbSKlUIfm2sHnTjmRGx/2nU7uj/lsC2qgAR9L563qKVfli8W2NT0a9tI
        mtxXmb9tuakuemuTW1S3ji0jP0aiaxUskT0IlYv39JdsK3qsL6rd12T7L9QpAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605031519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c5kUx/vmnIfAtfqkSPxpHH83jR5Jo7p5HtOWi7vET0Y=;
        b=UYohQ7mATa3j2MBKWIG8rJoK3xwwsHe360VYd6mvfvpeA4XWGWF9NMXEsFJvV3wWwzY1Dw
        qFbMHx91zlDWLXBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201110180518.miuxa25j7lnn7f2q@linutronix.de>
References: <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
 <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
 <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
 <20201104124746.74jdsig3dffomv3k@beryllium.lan>
 <20201104130930.llx56gtqt532h7c7@linutronix.de>
 <20201104160650.b63zqof74wohgpa2@beryllium.lan>
 <20201106105447.2lasulgjrbqdhnlh@linutronix.de>
 <20201106161413.7c65uxenamy474uh@beryllium.lan>
 <20201109124718.ljf7inok4zakkjed@linutronix.de>
 <20201109143703.ps7gxhqrirhntilr@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201109143703.ps7gxhqrirhntilr@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-09 15:37:03 [+0100], Daniel Wagner wrote:
> > I've been staring at the code of signaltest on Friday and I might need
> > to stare longer to figure out what it does.
> 
> I hear you. Anyway, I gave the current head a run with lazy preemption
> disabled as you asked for.

I just sent a few patches your way regarding signaltest. It should help
you with tracing. I've been playing with it on a juno box and I didn't
see anything odd. My max value was below 200us. I added a few tracing
bits. With sched, signal and hrtimer events you should be able to see
what delays the RT thread. I didn't see anything odd.

Sebastian
