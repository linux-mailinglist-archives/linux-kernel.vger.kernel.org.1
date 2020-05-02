Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C321C2549
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 14:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgEBMa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727029AbgEBMaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 08:30:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A39FC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 05:30:25 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b12so7421928ion.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 05:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uQvbmBtPfau0c36fVvnAuHUvWsyQdwrd424BAs7J+Y=;
        b=UXBFXl71pOYoRRRS+69JMI7kA/Bv6mS1Yx+8Xjs48McZ4AtgCisNneooKsURx+qMF7
         Z+Ip8/VkFZrYl9mSllXS27y8/l7stxnKMnQIkg3V+0at2HAPkOAn0ubBy0qTwQcfNWmq
         c1rTKavWivbWGyjxRL7erEIvFW8NNEoL8VipSxHt8aBnhoMrFVpNWndaMbuaSUJDEDnx
         4EryewuRfShz3kyrMYL/8f8DLxsPShSc0ikmbJi2zNTZXhAB2q4/zWbFr9SRr12T1CfD
         vjbm49l37Dea5S76BW66SYUWH6UpWFanaAL3lff4eM7zokC/NDBCy0iT4t+J9tHcBklB
         o/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uQvbmBtPfau0c36fVvnAuHUvWsyQdwrd424BAs7J+Y=;
        b=RqYsS00BGTv7BrHcT/NyCgntmtu2UocMGFqH8AoPeAb1J3J/ps6pJto56c1vZ/bhiU
         bDQrNycJnnL1lQVbM7zDhKHgunN6XhUv1mBjcmED5Zy0hBfUapGauwNJ8LvhWQfk75Ed
         WnVfDERBuYw91pouVigh6khWGlFUMUnTWl6scePgKw6Q4m9W5BKJL8MfDhDynqn5QAt4
         6nik/O1UaDlWr2011UqolOXR7htQhKK0ax7rgmiSLXXfeDG2qo/r3BmI8XcOVdI8uDX8
         rUqOM+GsV3QM2Bourq4pE5aAkXHWr1QwEY3tERlIO8ydzip2jokaUxyTKhoXb6HrGCD8
         PfvQ==
X-Gm-Message-State: AGi0PubE5ByFYvIWggnOs//C2W6H+paf+B513mZ0TgyuL1veFmhCnFNU
        DMqOew4bDxzA3y4QWoUTXTMctH94Ek+XbZDP/+Pu1ZNB
X-Google-Smtp-Source: APiQypKjQEJr50SSD+wZTKC4UtIKG9oBaPBilJhbM81K49d+oej84dCFNh0SFdsE2H8POwnSgGZvyGv9VRtL6QGheUo=
X-Received: by 2002:a5e:8203:: with SMTP id l3mr4649643iom.35.1588422624364;
 Sat, 02 May 2020 05:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200306103839.1231057-1-aford173@gmail.com>
In-Reply-To: <20200306103839.1231057-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 2 May 2020 07:30:13 -0500
Message-ID: <CAHCN7xJ+3kvkt2TGe3j2JC6YVbxgsOzrSrDN6jaae2TZskOu4Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable IMX27 PWM controller
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 4:38 AM Adam Ford <aford173@gmail.com> wrote:
>
> The i.MX8M Mini and others use the i.MX27 PWM controller.
> This patch enables it as a module so various boards can use it.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

I don't know who the right person is to ping for this, but it's still
awaiting approval.

>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a8de3d327d03..d19ca82b3c40 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -830,6 +830,7 @@ CONFIG_MPL3115=m
>  CONFIG_PWM=y
>  CONFIG_PWM_BCM2835=m
>  CONFIG_PWM_CROS_EC=m
> +CONFIG_PWM_IMX27=m
>  CONFIG_PWM_MESON=m
>  CONFIG_PWM_RCAR=m
>  CONFIG_PWM_ROCKCHIP=y
> --
> 2.25.0
>
