Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0782FFBFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 06:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbhAVFGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 00:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbhAVFGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 00:06:08 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96872C06174A;
        Thu, 21 Jan 2021 21:05:28 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q1so8750706ion.8;
        Thu, 21 Jan 2021 21:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lahaIHRrNL60/+aroPUgLnMzQ3P0dsmaC2hv6/9gxHU=;
        b=BQ3fIhHlZuIGRLHUfcLCGcr6PzwzB1+PdSfEhs6JHS39XN36Gyglz21sz6dBS0MPUY
         EBJIgjuizVnuj3QN+sNHqzj4Am7h3SeAzJ1ZNe3f0PRq2/jTgzFfsjgV3PGADaX5jFVN
         tcIZj58eMWKvBLARyElMI9OLQd5lSkrZG5Ac1pFjkreMxmWbNFU9pevjGXT7El1okbTD
         lmSN9YucSAhccv8vvQCfv5lun5VLrcHMZ3JU09oRTH7b1Q0a2RTGzobfhDlEc/KNShmA
         vg9sfpId1aR0V0Ur9HlI+GjumfYx+u/u8CLVzFuL0XQffg8bmVgJngFVNNej0KvEgyWx
         kqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lahaIHRrNL60/+aroPUgLnMzQ3P0dsmaC2hv6/9gxHU=;
        b=SmAe0Xlp6W+UMafDB8teSUYHlaT/WNnreCYbO2o4jwB3ZgbX7q7K52aKwPPxvJkGhI
         Yl0jg8/cMsJSXCjNjnr6LH5f8WzXX4B80xvmuHcsHX+ggV/y9z0zwrJm+FxtfIVxGTTj
         /HmeoxfK9lIR+Upmk2OyWiHFAEDlW8tbI2Kt9xIXPXIMJ+gXlx2xr/UKKKJe2on15RXO
         ctFeUNJSgvL3w4DNjCSl8SB7P8ONEtRb/DRa78QiRepsQI+8L0OpOujafqL/5aTbEdDU
         ynM3bahPE38klc41IbspWJqQ8h14th+0MSKeVPVXFuGqhc/v41aTIytAuAP2adlI3Iqa
         3kCw==
X-Gm-Message-State: AOAM5328B8y+LVVSxngdNtfaBXz84GQHKbIrPiJa3sXAwP9+KyeTFLNf
        mIx7XqPGQn6LiEX/9Yu61B+tzVsIPNDscjyvvrg=
X-Google-Smtp-Source: ABdhPJyIRCQ3wHacOdebj1xQyQi0f3EALmC62NZRM5UngeLXChYpf+8EkG+gVLTRNhYpljSsdwCf5F6KA2BgoxXR8u4=
X-Received: by 2002:a5e:850b:: with SMTP id i11mr2216317ioj.42.1611291928082;
 Thu, 21 Jan 2021 21:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20210117042539.1609-1-alistair@alistair23.me> <20210117042539.1609-3-alistair@alistair23.me>
 <20210118123519.GF4455@sirena.org.uk> <20210118124213.GA10975@sirena.org.uk>
In-Reply-To: <20210118124213.GA10975@sirena.org.uk>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 21 Jan 2021 21:05:02 -0800
Message-ID: <CAKmqyKNNMgY=qR0gGnffXhuTD+ekQjmvqXMbrTu7O4CMX95P4A@mail.gmail.com>
Subject: Re: [PATCH 3/6] devicetree/bindings: Initial commit of silergy,sy7636a-regulator.yaml
To:     Mark Brown <broonie@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>, lee.jones@linaro.org,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 4:42 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jan 18, 2021 at 12:35:19PM +0000, Mark Brown wrote:
> > On Sat, Jan 16, 2021 at 08:25:36PM -0800, Alistair Francis wrote:
>
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - sy7636a-regulator
>
> > Compatible strings should be in the form vendor,device.
>
> You should not have separate binding documents for MFD subfunctions that
> don't have separate compatible strings in DT, include the documentation
> for the properties used by those subfunctions in the main MFD binding
> document.

Thanks for the review. I have updated the patch and will send a v2.

Alistair
