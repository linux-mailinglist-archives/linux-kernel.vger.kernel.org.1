Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98B72AA0F6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 00:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgKFXWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 18:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgKFXWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:22:04 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2957C0613CF;
        Fri,  6 Nov 2020 15:22:02 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 12so2702170qkl.8;
        Fri, 06 Nov 2020 15:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9kgi0XFLYWD6SBPla2WObtfMjgECeVYCZRoQd1futD0=;
        b=HTj0zMH1IJDsOOrRiedp+5luIkjzzA3oO6+2Di7/2QwarPAUQbSQMnjFB/+6BEqA8G
         3WxkdJ2hKJrQtq0BGVLiA/KY9+5tkTrMt1yNey7ELX3Ke/+Tdf89PqkbECUBN6ORBz9+
         D42lzaAiHwN84PphlafQmYxF7COHaemXRzUPJgN58GiWItn2jlORW0nUmY3lxZEjXCaJ
         9XBkp58yN8pQQPeETTidCfGrWDgahpu/RomYIxpHfP1Q32Di/r9LYp/JEXUpcg4uutir
         Up8Lz0kWdixZkW9mmolP9z/k0Mj+vF20ygCvlUI2395UXghmlJ5r+HA3iqHDbdoVWBNP
         fxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9kgi0XFLYWD6SBPla2WObtfMjgECeVYCZRoQd1futD0=;
        b=Mc/6tTA1Gm0CGzNwl2+ALzSuh1wcV5x3mLfWAed0FfSUpH+8c2SFGII4BLW9PQO9L4
         B4lcrppcv/JuWMmU6RIUHcb1GA9TbSpPvYqT0LG6GwKNvl9Dq/cLrtYlmvRtenBFz52u
         Z7BgZeIXEJ63ZyrgZmW1kYk8VGT2drel/D4xU0GfKMI65HsJhmjzeO9sxndHskwhQYmt
         33UtOuC97xlkw4M1wDkFZ1hDtoFCVH6HVvfN4ThRltGXABQ/ldo0cA7TAXkaHAD/JBLo
         nVuwRY38fIfFAZL3kl94WPV9QJTjIgCPCY8dead2g3jXsqoFfTF+UKR7FUo0gX0tg075
         QOAg==
X-Gm-Message-State: AOAM532pgvpRM9Gzi+2z+3b/lKJrQvc8DCzcSPrt48nLtNCTdchD2nc7
        PfW0V6I1adksxvGiAm9ek6A=
X-Google-Smtp-Source: ABdhPJwbx8GpfjJuXp8KFROGysEGuq3/hzTzMj+TuJrIFAVmgzGFdP165EopHlyVzHZxQtGDIBgy/w==
X-Received: by 2002:a37:d0c:: with SMTP id 12mr3931626qkn.418.1604704921837;
        Fri, 06 Nov 2020 15:22:01 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id m2sm1577647qtu.62.2020.11.06.15.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:22:00 -0800 (PST)
Date:   Fri, 6 Nov 2020 16:21:59 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Richard Fontana <rfontana@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] hwmon: applesmc: avoid overlong udelay()
Message-ID: <20201106232159.GA3586073@ubuntu-m3-large-x86>
References: <20201106231710.GA29287@macbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106231710.GA29287@macbook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 06:17:10PM -0500, Matt Turner wrote:
> On my late 2013 Macbook Pro, I have a couple of scripts that set the
> fans to auto or full-speed:
> 
> fan-hi:
> #!/bin/sh
> sudo sh -c 'echo 1 > /sys/devices/platform/applesmc.768/fan1_manual
>             echo 1 > /sys/devices/platform/applesmc.768/fan2_manual
>             cat /sys/devices/platform/applesmc.768/fan1_max > /sys/devices/platform/applesmc.768/fan1_output
>             cat /sys/devices/platform/applesmc.768/fan2_max > /sys/devices/platform/applesmc.768/fan2_output'
> 
> fan-auto:
> #!/bin/sh
> sudo sh -c 'echo 0 > /sys/devices/platform/applesmc.768/fan1_manual
>             echo 0 > /sys/devices/platform/applesmc.768/fan2_manual'
> 
> Running ./fan-hi and then ./fan-auto on Linux v5.6 works and doesn't
> cause any problems, but after updating to v5.9 I see this in dmesg:
> 
> [Nov 6 17:24] applesmc: send_byte(0x01, 0x0300) fail: 0x40
> [  +0.000005] applesmc: FS! : write data fail
> [  +0.191777] applesmc: send_byte(0x30, 0x0300) fail: 0x40
> [  +0.000009] applesmc: F0Tg: write data fail
> [  +7.097416] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> [  +0.000006] applesmc: FS! : write data fail
> 
> and the fan controls don't work.
> 
> Googling turned up this [1] which looks like the same problem. They said
> it began occurring between v5.7 and v5.8, so I looked and found this
> commit.
> 
> After reverting commit fff2d0f701e6753591609739f8ab9be1c8e80ebb from
> v5.9, I no longer see the errors in dmesg and the fan controls work
> again.
> 
> Any ideas what the problem is?
> 
> Thanks,
> Matt
> 
> [1] https://stackoverflow.com/questions/63505469/cant-write-data-to-applesmc-error-after-upgrade-to-arch-linux-kernel-5-8-1
> 

There is another thread on this regression:

https://lore.kernel.org/lkml/20200930105442.3f642f6c@aktux/

Looks like Brad Campbell has a patch that has some success in fixing the
regression (although others are saying it breaks their setup...):

https://lore.kernel.org/lkml/3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com/

Might be worth giving it a shot and jumping in so you get CC'd on
further revisions.

Cheers,
Nathan
