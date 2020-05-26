Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AF21D4CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 13:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgEOLru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 07:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgEOLrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:47:49 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64EAC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:47:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h4so1876860ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4IC6ZZPGRIJnMH9sjYkXLAR8FAlAKMWG/aSqy+lxhBM=;
        b=pmMhLVmkms/aEGFPJaqTEzygKog4VD8tObWpypoVdOZbhsrCwDKQrPinYp59/uxTKP
         zGuZIpjD1i7IUJhqX5R9d2MSMtlGGBnsZ4L0qss5FlqTQsBvwr7fiM/XjHcxPmwefTOV
         wqpuata5/4BoezQCy+jOF2t4rF76nrWwDh54RvPkldtR8/qpFhgjObh+Kd1x3RmfD9Jv
         S5ya21CwVF+QqXAeDh9Jh1eldSNXW3IyVKzqNA1iNPn4FF5wO2bipeJAVugQvkQodNf4
         C7tVqIthUY7GKPExScs/DJEG8M8DYUkgz2Y5Cs0ZmmAYBwOv5w/UJQ3XT2ObLbKKHNwD
         da6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IC6ZZPGRIJnMH9sjYkXLAR8FAlAKMWG/aSqy+lxhBM=;
        b=QcN89MbsRWzpKpgGDJ/BYNf4cBkKGCMaLPsmmr/bRqXYiqlq/drdNU1VFHGhKKEHTW
         PN2e2guHy43PWh7p76ekJHD723pJhJg0bK9kEPtPBR5YEWA/ZNFbIeenZo0XrCujy1CJ
         sQUUtF6YqQSmK1kQ3XL6LOqKIEsCG80zf7kSb+Y4OwcBMdyorepzAQkLDi8PPKOf4rRI
         M/6U4iFcg7aCH37k/ZE/YtAo8IOCzxG0beoPDMLBB86B7KDRdmIwEb3aDDYFL78vijpp
         UUP7KyT5Hfmd3MB3+LxjMEv3LTDNZ4PPhUkph6fthSbYFcOl+5rjwQpUxHiR8DjhsiSW
         Y8ag==
X-Gm-Message-State: AOAM5324b2GSSPY4LyEbwLWsn3bmI7LiVRFVaUcne46/errtTGUyV/c4
        IGUTn7QMIpVSBRQyheyA5XbuHeRJ2ZDdW+xGuV+5sA==
X-Google-Smtp-Source: ABdhPJxlcrIIyOso2g7s236yDsj3eCaQNX1y1jEmp8ycfcvQ+aR7VvmzOgIaBmXDgANWhN0eJ6z38fiT668MMvwWeHc=
X-Received: by 2002:a2e:9d5:: with SMTP id 204mr1116745ljj.168.1589543267270;
 Fri, 15 May 2020 04:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200514204901.3199-1-xc-racer2@live.ca> <BN6PR04MB06603F08B010828F7CBFB610A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB06603F08B010828F7CBFB610A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 May 2020 13:47:36 +0200
Message-ID: <CACRpkdZPpF=Zi-tvDGVDoh4beNTC+LEm6QROd1-CFZXjQ1D0zQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] iio: accel: bma180: Rename center_temp to temp_offset
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:49 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> The bma180 driver is being extended to support the bma150.
> Its temperature channel is unsigned so the center_temp naming
> no longer makes.
>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
