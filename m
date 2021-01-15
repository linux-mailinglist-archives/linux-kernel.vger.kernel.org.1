Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED82F76F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbhAOKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbhAOKrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:47:21 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA254C061757;
        Fri, 15 Jan 2021 02:46:41 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id n8so1076721ljg.3;
        Fri, 15 Jan 2021 02:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HFix5lhrDvWuvTYP+J9B23RG/cixkCW5Vh+giTcORR4=;
        b=IfKiigvw7rabeBypXKMIk+HUS/nn4+nBWb+Q5dVSfhEH0O2Slqb2RczTz+6MU7p9wm
         ttWhUOu3v8cUhJJan0fmOqejf2/w7xcZhoqkR46tyE0l1mMP86tSgW1q4Z31Wdj+fy3R
         nuyrVHpgPaCdn+Losuyyk78q+NtJEcOrLE0rDEi4CMWChYeI+rq7VHIrOX7vZ32PiZNb
         9m5ErrMvG2Qg7KcXOiWUY4rqNJWh5fizktu81DF7iCbKBb6l0y4k5Z1X/Rq19m6B3FEZ
         vvnGMOcnhr6xu1cOBHQY7EPi32fZ6wCvOmBe7PUlJSXppDAefemAFo7hXsZBdoP+hljP
         k5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HFix5lhrDvWuvTYP+J9B23RG/cixkCW5Vh+giTcORR4=;
        b=GDRFXxA8NbfcPMpB3IFejh6mo3IoM86VWvp343nF8tXCedF8qiPaYqRZ8qoz0qIu8h
         LdEkkse03SZalducvksDUJ7bm0GvDzcqtIL2NKaTppRXrN7O7Hc1nuD2v1NPKCLEtPWz
         IcjRTjNmR3/q5YxPYtBaj21pXZjDrJGTrf2c6r+ClszvhVWAQdR7Wk29fvbasAC8y7Pu
         nRCFx/2Hsk7vZ0OgLeGo/wO5lqs7bxWoeib9n6RhIZl2NHHAIuRMgk/EjO4mBfBUnEk0
         yM0iOfhHfbNXoploypBMs+PIPmKHG0JEEhTe12PJgxj3Pba9b1gXNVmj5u7gpOeXmwpd
         dY6Q==
X-Gm-Message-State: AOAM533f37LHgSbrCDxbi8FyUbNMW/ilb6QVSFdlA5ohBb+wsEdbc+ce
        VqdjdSRMaP7LW43KS6x8AeM=
X-Google-Smtp-Source: ABdhPJywQNSylPcjzVHIN5StuUgLOe9rq9AjfMuFfjtSMpvP39Hjj4VxWqmJJF0xcw/sff47Y2cGHg==
X-Received: by 2002:a2e:a377:: with SMTP id i23mr5424974ljn.103.1610707600305;
        Fri, 15 Jan 2021 02:46:40 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 12sm853414lfm.235.2021.01.15.02.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 02:46:39 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 10FAkao0004477;
        Fri, 15 Jan 2021 13:46:37 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 10FAkZc3004476;
        Fri, 15 Jan 2021 13:46:35 +0300
Date:   Fri, 15 Jan 2021 13:46:35 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Ernesto Corona <ernesto.corona@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v29 0/6] JTAG driver introduction
Message-ID: <20210115104635.GA2971@home.paul.comp>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413222920.4722-1-ernesto.corona@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a multi-part review of the series, with general notes inline
in this message, and specific points raised as replies to the
individual patches.

On Mon, Apr 13, 2020 at 03:29:14PM -0700, Ernesto Corona wrote:
> We propose to implement general JTAG interface and infrastructure
> to communicate with user layer application.

Working with a Tioga Pass server platform I needed to use the JTAG
master controller of an ASPEED AST2500 SoC to configure a Lattice
LCMXO2-4000HC CPLD. I'm mentioning these fine details because that's
the only proper runtime testing I performed, but my review is not
limited to that.

Being a long-time OpenOCD community member, I got familiar with many
different facilities and protocols offered by hardware JTAG adapters,
and of wide range of usecases as I was providing end-user
support. This is my perspective when looking at these patches.

I have to note that the current v29 version of the series is broken in
several aspects:

1. The aspeed driver fails probe(), see the driver review for details;

2. The uapi include header is unusable;

3. The offered userspace implementation wasn't updated to the latest
API, but even with the changes to make it compile it's still a mess
too horrible to be used in production;

Points 1 and 2 will be addressed in separate mails. To workaround
point 3 I prepared a recipe with an additional patch[0] so that
mlnx_cpldprog can be at least compiled and used for some minimal
testing.

The shortcomings of mlnx_cpldprog are numerous:

1. It doesn't consistently choose between hardware and bitbang modes;

2. Even though it checks TDO it doesn't print any errors on mismatch
and continues playing back the SVF as if it's all right;

3. It has JTAG speed hardcoded;

4. It doesn't implement RUNTEST so with the CPLD I'm using it's always
_not_ working properly, failing silently;

5. It is just awfully slow, taking about 40 minutes to play back a
file that takes 1.5 minutes with OpenOCD with the same hardware and
kernel driver.

So I added support for the proposed API to OpenOCD: patch that applies
to the version in OpenBMC[1], patch for the latest version[2]. And
since it can do much more than just playing back SVF I hope this can
highlight some essential API shortcomings if it's meant to be
generic. My impression is that in its current state it's not adequate
for the purpose.

[0] https://bitbucket.org/paulfertser/mlnx_cpldprog_bitbake
[1] http://openocd.zylin.com/#/c/5976/
[2] http://openocd.zylin.com/#/c/5975/
-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
