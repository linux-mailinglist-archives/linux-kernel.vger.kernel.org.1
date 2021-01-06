Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6422EC417
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbhAFTis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbhAFTir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:38:47 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2DAC06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 11:38:07 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id f14so2066505pju.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 11:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rNVThrRd928+urBFZGa67u3QgtAeF4Xf4w1X5CEeniU=;
        b=bOqBpI28xlsTLKlnaG3L62KI7GH/lVVJWaq8sN8uwT1iZ5JyHuL987SBUQKIRc0UeI
         LSr4cXlAAfhpVAFa1sjR+SVo2APgeJrh/9XzZjlvpeEcnicCdRhkrgbDRE9yRCL3bZcc
         Hn/ndb1Zz2Qrj86GxOhlxCbHm7rAiIKzJq+GCuVariyqsb25/QSVw6HIEmOVWaePB3aP
         F9YbjfP9mW1RKeuQB5Xg8T+Mia8sCOCoeko/lih8ij2L5Ak1kTtMSO8NZDQEIIe9yvh9
         Oz3dnzB7tojJW8Ph10u6f9WFFgZ0sp9DTFrzsVDUbT58HW/KOQDNKCQNi5QBHAa2Y5s2
         NXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rNVThrRd928+urBFZGa67u3QgtAeF4Xf4w1X5CEeniU=;
        b=bgmZgUd/nINXkJN4LxnDiwT/hHBTuXGud5/MCb5ge15kAG1cD2eSafSxpA0UJyf3Yp
         aHfK4QHOwefLaS7NiOrSv+LweJjJ/EWui/zdTwjBYzriUFpZeI+VrK8v86VIA567syva
         6nEax/XGuo2MvS1+u1uWX9HF5hSpHMY/fxZeGTVEdxgsCih+RNQqtNo0FDELeEzZSoJm
         en/JI3HVBg7q8e+VK106hzexlQ8H8wX5Ddg+eVbKwDuPofhTlElS/m9P7S2Xm7GhfwL9
         taPmOZsrR1DYuL6E0dA5bU7JyfSs36HqCq+H5EkYNHasBdBiPu2P2DTrSA/kYV7NGHMq
         7amw==
X-Gm-Message-State: AOAM5313pb9il7jOVWAjyp2dbnBW/SA6/6UP1Vdl0+lfAqrT0Tz0r1Z3
        TKb6CM2sOg7TlsqCXkoE9UMUuN5ejRqIYA==
X-Google-Smtp-Source: ABdhPJx6ZiXEfjXuphk1V7aSimwv3bBSwoGJ+OInNXx3IsU5rLui4Ig6Db4FVaW94WpfVReYHHNDpQ==
X-Received: by 2002:a17:90a:bf88:: with SMTP id d8mr5836965pjs.102.1609961886960;
        Wed, 06 Jan 2021 11:38:06 -0800 (PST)
Received: from [192.168.0.4] ([122.164.82.190])
        by smtp.gmail.com with ESMTPSA id k3sm3659933pgm.94.2021.01.06.11.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 11:38:06 -0800 (PST)
Message-ID: <4474633bf649e93f3292d8d248b352066c063a20.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.10 00/40] 5.10.3-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@denx.de>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Date:   Thu, 07 Jan 2021 01:08:01 +0530
In-Reply-To: <X/Kz4KHxoU/YYEvu@kroah.com>
References: <20201223150515.553836647@linuxfoundation.org>
         <1b12b1311e5f0ff7e96d444bf258facc6b0c6ae4.camel@rajagiritech.edu.in>
         <X+dRkTq+T+A6nWPz@kroah.com>
         <58d01e9ee69b4fe51d75bcecdf12db219d261ff1.camel@rajagiritech.edu.in>
         <X+iwvG2d0QfPl+mc@kroah.com>
         <c7688d9a00a510975f115305a9e8d245a4403773.camel@rajagiritech.edu.in>
         <20201228095040.GA11960@amd>
         <356ddc03-038e-71b6-8134-5b41f090d448@roeck-us.net>
         <aa62485a757305b46df190e6f90dfbd6bc31a144.camel@rajagiritech.edu.in>
         <X/Kz4KHxoU/YYEvu@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-01-04 at 07:21 +0100, Greg Kroah-Hartman wrote:
> On Sun, Jan 03, 2021 at 06:37:51PM +0530, Jeffrin Jose T wrote:
> > On Mon, 2020-12-28 at 12:41 -0800, Guenter Roeck wrote:
> > > On 12/28/20 1:50 AM, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > > > > > > > https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.3-rc1.gz
> > > > > > > > > > or in the git tree and branch at:
> > > > > > > > > >         git://git.kernel.org/pub/scm/linux/kernel/g
> > > > > > > > > > it/s
> > > > > > > > > > table/
> > > > > > > > > > linu
> > > > > > > > > > x-
> > > > > > > > > > stable-rc.git linux-5.10.y
> > > > > > > > > > and the diffstat can be found below.
> > > > > > > > > > 
> > > > > > > > > > thanks,
> > > > > > > > > > 
> > > > > > > > > > greg k-h
> > > > > > > > > 
> > > > > > > > > hello ,
> > > > > > > > > Compiled and booted 5.10.3-rc1+.
> > > > > > > > > 
> > > > > > > > > dmesg -l err gives...
> > > > > > > > > --------------x-------------x------------------->
> > > > > > > > >    43.190922] Bluetooth: hci0: don't support firmware
> > > > > > > > > rome
> > > > > > > > > 0x31010100
> > > > > > > > > --------------x---------------x----------------->
> > > > > > > > > 
> > > > > > > > > My Bluetooth is Off.
> > > > > > > > 
> > > > > > > > Is this a new warning?  Does it show up on 5.10.2?
> > > > > > > > 
> > > > > > > > > Tested-by: Jeffrin Jose T <
> > > > > > > > > jeffrin@rajagiritech.edu.in>
> > > > > > > > 
> > > > > > > > thanks for testing?
> > > > > > > > 
> > > > > > > > greg k-h
> > > > > > > 
> > > > > > > this does not show up in 5.10.2-rc1+
> > > > > > 
> > > > > > Odd.  Can you run 'git bisect' to find the offending
> > > > > > commit?
> > > > > > 
> > > > > > Does this same error message show up in Linus's git tree?
> > > > 
> > > > > i will try to do "git bisect" .  i saw this error in linus's 
> > > > > tree.
> > > > 
> > > > The bug is in -stable, too, so it is probably easiest to do
> > > > bisect
> > > > on
> > > > -stable tree. IIRC there's less then few hundred commits, so it
> > > > should
> > > > be feasible to do bisection by hand if you are not familiar
> > > > with
> > > > git
> > > > bisect.
> > > > 
> > > 
> > > My wild guess would be commit b260e4a68853 ("Bluetooth: Fix slab-
> > > out-
> > > of-bounds
> > > read in hci_le_direct_adv_report_evt()"), but I don't see what
> > > might
> > > be wrong
> > > with it unless some BT device sends a bad report which used to be
> > > accepted
> > > but is now silently ignored.
> > > 
> > > Guenter
> > > 
> > hello,
> > 
> > Did  "git bisect" in  a typically ok fashion and found that 5.9.0
> > is
> > working for bluetooth related. But 5.10.0-rc1  related is not
> > working.
> > 
> > some related information in bisect.txt  attached.
> > 
> > -- 
> > software engineer
> > rajagiri school of engineering and technology - autonomous
> > 
> 
> > $sudo git bisect bad
> > Bisecting: 0 revisions left to test after this (roughly 1 step)
> > [194810f78402128fe07676646cf9027fd3ed431c] dt-bindings: leds:
> > Update devicetree documents for ID_RGB
> > 
> > $sudo git bisect bad
> > Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > [3650b228f83adda7e5ee532e2b90429c03f7b9ec] Linux 5.10-rc1
> 
> That's really odd, as that commit only has a Makefile change.

i will try to work on it again

> Also, why run this as root?
> 
there may be some problem in my sudo configurtion or the way in run
sudo.\
when i run "make modules_install" and "make install" using sudo typical
files 
ownership changes to root.

-- 
software engineer
rajagiri school of engineering and technology - autonomous

