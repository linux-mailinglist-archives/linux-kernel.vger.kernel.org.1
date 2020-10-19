Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6D529300C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgJSUsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:48:25 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:39964 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgJSUsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:48:25 -0400
Received: by mail-oo1-f67.google.com with SMTP id w7so267436oow.7;
        Mon, 19 Oct 2020 13:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fxa3uzHmULeVmNdtF5y01CM2QpDZ2ApdIjLlwOHG4sY=;
        b=Va2X7wBuu+NBS4fj2JxIadcxzkqIo8mUISO+Oyy57HAI9+lxrvx2mgsdyiwlPrSw8s
         nwEuNG8gFhb1wRtOBTg/Wv2shnk1OWm4xQ6nDykpYlxE/dfQlJxKxLTfG+OVePf6EOjc
         JKqXwolpGT7Bj1ZZjhV+r1m021AdaycW7G4sEYtAeZoosnw0a3dCP7Xx2tLOQmDbqnox
         P3vfxqms48sq0rrbnvcWb+hrGI6KAf8H8RfHzDJ5tpRhrsi+L5984atDO5tzNaU5T1mU
         mdm+nvKwCj+y/EUmYeTT+SzWauwnOqVytnKs14cms1E0kIOLUP5u3pVbwYfRbN3PEOZd
         ftzw==
X-Gm-Message-State: AOAM532Gvt87raJf2QMrhNAlIUzPE3dX97mjhIWD57jJx/8IVSuaAgF3
        lClEwTMhUVJXGAKcnZCsRdcDfVQ6Ew==
X-Google-Smtp-Source: ABdhPJwl/iQfkO5suixU4PBWEHxz8p2fHudaNaiDXdTvQ5KBbgmlpr2GV9/HQXy//V7q3Emcotkdtw==
X-Received: by 2002:a4a:dc0d:: with SMTP id p13mr1278563oov.2.1603140504163;
        Mon, 19 Oct 2020 13:48:24 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j191sm237505oib.52.2020.10.19.13.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:48:23 -0700 (PDT)
Received: (nullmailer pid 3577895 invoked by uid 1000);
        Mon, 19 Oct 2020 20:48:21 -0000
Date:   Mon, 19 Oct 2020 15:48:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, nsaenzjulienne@suse.de,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] Add dts for Rpi4 + Cirrus Lochnagar and codecs
Message-ID: <20201019204821.GA3569507@bogus>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
 <20201014185632.GD4580@sirena.org.uk>
 <b3376cd4-010f-cf72-8c81-1f5d22cb6454@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3376cd4-010f-cf72-8c81-1f5d22cb6454@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 02:30:08PM +0100, Richard Fitzgerald wrote:
> On 14/10/2020 19:56, Mark Brown wrote:
> > On Wed, Oct 14, 2020 at 03:54:11PM +0100, Richard Fitzgerald wrote:
> > > This set of patches provides support for using the Cirrus Logic
> > > Lochnagar audio development platform plus Cirrus Logic Madera/Arizona
> > > codecs with the simple-card machine driver and a Raspberry Pi4. The
> > > ultimate aim is to provide the dts file but some updates are needed to
> > > the simple-card machine driver.
> > 
> > Why extend simple-card and not the more modern and flexible
> > audio-graph-card?
> > 
> 
> I'm struggling to understand how to use audio-graph-card where there are
> multiple alternative codecs. The host I2S endpoint has to point back to
> the codec endpoint, like this:
> 
> 	cpu_i2s_ep_cs47l15: endpoint {
> 		remote-endpoint = <&cs47l15_aif1>;
> 	};
>
> But obviously that depends on which codec node was enabled. Listing
> multiple endpoints makes the whole port node disabled if any remote
> endpoint is in a disabled node. I've tried adding status="disabled"
> to endpoints or multiple port definitions with status="disabled" but
> I haven't figured out a solution.

Multiple endpoints is what you should do. And 'status' goes in the 
device nodes (not the graph nodes).

Rob

