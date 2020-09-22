Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566FF273F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIVKRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgIVKRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:17:35 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B03C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:17:35 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h17so15133359otr.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4wv3gq4jH4kXiqr9HoaHT5g3RKprwq2Zsckomw6Mug=;
        b=xAunoLiwJSD85u4GcMCZTb0HaWVBYP1IeHYBuva/rKcEz3d3wWA/5kTAsufc1NslLJ
         o7v06wwMgFZU9BgjZwgixvTaDaw9cX9CyfyGqAMEYtKoPek2D/naJuGpywMav20paRna
         fXavgDKykj++zR90Bp6tRmje1Iv/FELpQnO1VX5w+ePKHG/Qi6UDt7hUoVDgiOXpNlWo
         DAdiDPtHMRRefQQCEfG3iUyJBYzQ9+tDT2CwXKj8sSAVujd+T420gzKE/JaLa6z6Clf4
         tMl4MEImzwiBK9+P9oR+lZtfn8OH8oqsRAjTMqJ64nU1O26++/5dVg8BP2M7dHnevOXF
         Xcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4wv3gq4jH4kXiqr9HoaHT5g3RKprwq2Zsckomw6Mug=;
        b=I1uJPwpY8xNhMlxJEnzHEZE4lN5clmjqSy39JvSbEgkp2OCGM2fFEMBm+0FfR3ltOR
         cerGzRy2v+02rQzrWXxXtGUeXR/UyvvpmwLE3iCZTMwWfU0EZlY41T5JXgPGAdVKDSWK
         GGNlo/VlmGKS2Y93vU4cLcAj5Y5nd7IzGHJI9scmvBWLXDhaObjk7G+QWe1uc3p2b0kU
         cywrpsANUBffibA9QWnNguPpz78n5F4n/m0aE2/1yRbPAbEqD3rwRbKYjLbJTrYj9Ijh
         boy3qP1uWPsdnGOhl7TJjCdogiFOeRi9txcwyhT62/Y5ShnE07CzZLKsjMqwoX2CCUC+
         RroA==
X-Gm-Message-State: AOAM530lNsI9Q9N+tX5Hh+F637OVvaPtzm5sUdlT+1oAVbhnkU/ZdZfN
        ihd5uhrMJ11nvA1KDTLS4pbHwQII5NclvekF06cjuw==
X-Google-Smtp-Source: ABdhPJxbwFx7g1eBM13nl+6wdUDexN4d6NL/JJklai3ilHkBZyhnBiqx8SgS8+AYox+Ug4Xo6oK5X3hqXwdsPr3reDM=
X-Received: by 2002:a9d:ecc:: with SMTP id 70mr2347123otj.66.1600769854529;
 Tue, 22 Sep 2020 03:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200920141653.357493-1-robert.marko@sartura.hr> <20200921.144841.1356454980970038338.davem@davemloft.net>
In-Reply-To: <20200921.144841.1356454980970038338.davem@davemloft.net>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 22 Sep 2020 12:17:23 +0200
Message-ID: <CA+HBbNFdPkkL-gtAsTFww7bWjLADbXQuEfaTa-YGT6cbzN3btw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] net: mdio-ipq4019: add Clause 45 support
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:48 PM David Miller <davem@davemloft.net> wrote:
>
> From: Robert Marko <robert.marko@sartura.hr>
> Date: Sun, 20 Sep 2020 16:16:51 +0200
>
> > This patch series adds support for Clause 45 to the driver.
> >
> > While at it also change some defines to upper case to match rest of the driver.
> >
> > Changes since v1:
> > * Drop clock patches, these need further investigation and
> > no user for non default configuration has been found
>
> Please respin, in the net-next tree the MDIO drivers have been moved
> into their own directory.

Done,
I completely missed the commit moving them to MDIO subdirectory.

Regards
Robert
