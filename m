Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108B12ED483
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbhAGQmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbhAGQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:42:05 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF58CC0612F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 08:41:24 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id d189so7962179oig.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 08:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrZY2i5eprT/l7uYOILT1Kp1DRj8jQxObOyc0stKlc8=;
        b=0bw5xcOdZE0vbd9GiiqSpi/gFIJEd0OY4mWA6FwBrkTy1VgY1zGFzEPxobH3/JvBjb
         5JfekHzTHOnSszs6aBn01BwwvhbkMdTDPGPu74leawcCOPdioLxMFBHsfSMMQjE6ab1V
         7AHCm9fYksiQJyoe5gXHFhwUsJdM4ud1foc9Xmyo4ZCWWLog5VOX8BQWeLkrr1/wWsw2
         esNX1kuMSePuqNP1rcMbA4GX2/2Df2Xa/pY2zEHM9rJfFPyaTEo1X/en3pVHOx6sYclg
         01e+uVxU+Ty3J4+fXaqGoBcOP72YrW4J6g8VBdTav2wRT+MBAIRJPPiAW3h1ySInZOit
         22tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrZY2i5eprT/l7uYOILT1Kp1DRj8jQxObOyc0stKlc8=;
        b=LOd0k1ah7YDnX9tIs0xiSg9HvCxRucOmCHLv6ES0IIvuPoVprJEsuAHfThx5u7T2QK
         i7cfbwZ0Ov+SXW38B54MK4WSWXWXfu6hMHHxKbv/q7Nb8gCzwQ8s1YqRr7iKE2cG6f5b
         l0OFY97adhdfECDxtFOY0Qz1iEhh38bqiJ2Yfq788CaKt2Txehwsmr6tbWJU6dUGaU0j
         C2mhi7vUHvmZ8TtgKReRJYjHjOljVOQDEp43ja8iDtvKq9FWwKyGJqrwhFDxNcffb+in
         WPe5vFibBYmrLVFY3oGEWB+O8ByGCJzRAUI41aVpHFgZda7z+ipc4BvFmi4ie0F4UShb
         zc8Q==
X-Gm-Message-State: AOAM530vBbLqhqRYwr5x0UHbPVrt5cZc22+K/+o+oXkZjX3ig8iKL0bZ
        ++oyOipaWXQ5qgXjuR9PO4VvadUcF82g8966lqCMPg==
X-Google-Smtp-Source: ABdhPJzDAD7OVTCmfBWUzfFbwQjy72Rk9G5o+HeIHj4rrQ0cFWLDQUyDirTYKDwkAMV2a06UoriG4O30B59w0jyygJE=
X-Received: by 2002:aca:75cc:: with SMTP id q195mr7112914oic.173.1610037684209;
 Thu, 07 Jan 2021 08:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20201222222637.3204929-1-robert.marko@sartura.hr>
 <20201222222637.3204929-3-robert.marko@sartura.hr> <20201223005633.GR3107610@lunn.ch>
 <20210103164613.GA4012977@robh.at.kernel.org> <X/H4C1eBNHdDS4vO@lunn.ch>
In-Reply-To: <X/H4C1eBNHdDS4vO@lunn.ch>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 7 Jan 2021 17:41:13 +0100
Message-ID: <CA+HBbNHJRuuFDRb_hMSSPvNHoz27y+dt8kzNF3WF+aaaNytEgw@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: net: Add bindings for Qualcomm QCA807x
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, David Miller <davem@davemloft.net>,
        kuba@kernel.org, netdev@vger.kernel.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 6:00 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > +  qcom,tx-driver-strength:
> > > > +    description: PSGMII/QSGMII TX driver strength control.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
> > >
> > > Please use the actual values here, and have the driver convert to the
> > > value poked into the register. So the property would be
> > > qcom,tx-driver-strength-mv and it would have the value 220 for
> > > example.
> >
> > The LED binding has properties for specifying the current already. And
> > it's max current which is the h/w property where as anything less is
> > just software configuration (IOW, doesn't belong in DT).
>
> Hi Rob
>
> My understanding of this is it is the drive strength of the SERDES
> line. Nothing to do with LEDs. The description needs improving.

Yes, this is used to set the PSGMII/QSMII SerDes TX driver strength.
It has nothing to do with LEDs.
I agree that the description is a bit confusing, I will try to make it
a bit clearer.
>
>       Andrew
