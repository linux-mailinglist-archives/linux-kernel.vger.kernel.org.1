Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBCB1D89B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 23:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgERVAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 17:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 17:00:04 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608A4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:00:04 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e7so4465879vsm.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vQAvXs8YebqJQNpvsgx+YOpDZkNHLr4/g7pen09M+Y=;
        b=UzmCAWI3Et1k/ZetXQXo8P7q5FAsHXBwwnFSCGgtDVWBYyDfVAPaFJFOP+/jbBxQPZ
         x63KZMFIM/dDJIh3QlTuH2yECcrZwYZCpiYH9MFtMCDOG8n18NeS6lZ7oPGMpcTGWu85
         xnn+GfXK8uB79yIF6irfWr1brh/7UoNiSPDHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vQAvXs8YebqJQNpvsgx+YOpDZkNHLr4/g7pen09M+Y=;
        b=ImecVOMy1VJOjDcZlBfSZmun7Gaq/IPeq5aCQ3DLxukDaUnc+DfE2RQI8K0ZLQBder
         RH+sj9EWCtFs6HGBjo2wA/2G4PCzaCoDXQT07uOL9q+z9VXdlWLTUzQqYwz9umUoWutP
         dHDdR+60f4FLWHB5aHy2lobYX3wO3wCUkoTXN6oVPtYafNq7QfvKsi39kV4nfZHodNjF
         qEg0m299yItjiCCcTTliWdP0XR3oDJw4YHkBFVzCu42Qs0k2UK9BXRekhGOm+s6m6xzD
         KPpzAzY9cLEwRNL4avFE8NjL93OmTWnxgviSQZz72R8KeqzATRn5Rpo1Ze3Ts3gl8NAd
         6bUQ==
X-Gm-Message-State: AOAM533n+DVdaw1Eeme2lJN8WBF8Ot3QEwJwybVnIfcveCxSXYr6bYOS
        dq+W+ai5xR7HzqK35J4RgPNd2Ht4sD0=
X-Google-Smtp-Source: ABdhPJxuUJFdYeUGAqN3gSiaNMAXBqYc5/yGDCn+TMAy4JZVzIDDyqvCGobYJ51tcDXfnolxPNK6Lw==
X-Received: by 2002:a67:de97:: with SMTP id r23mr6866619vsk.102.1589835601976;
        Mon, 18 May 2020 14:00:01 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id v3sm3565225vka.45.2020.05.18.14.00.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 14:00:01 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id k4so3991454uaq.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:00:00 -0700 (PDT)
X-Received: by 2002:ab0:b13:: with SMTP id b19mr12713480uak.91.1589835600274;
 Mon, 18 May 2020 14:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <1588329036-18732-1-git-send-email-smasetty@codeaurora.org>
 <1588329036-18732-2-git-send-email-smasetty@codeaurora.org>
 <CAD=FV=WXv9DYf7LWoFBvro=7Bzeb1_0bXAvRH-suzxnrCu+V2A@mail.gmail.com> <20200518143920.GJ32394@willie-the-truck>
In-Reply-To: <20200518143920.GJ32394@willie-the-truck>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 May 2020 13:59:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=We2+5QHimzr+ukit9qkDKQaaTHYEZGkVbOwsNuy11k9A@mail.gmail.com>
Message-ID: <CAD=FV=We2+5QHimzr+ukit9qkDKQaaTHYEZGkVbOwsNuy11k9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm-smmu: Add sc7180 compatible string
To:     Will Deacon <will@kernel.org>
Cc:     Sharat Masetty <smasetty@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 18, 2020 at 7:39 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, May 15, 2020 at 12:05:39PM -0700, Doug Anderson wrote:
> > On Fri, May 1, 2020 at 3:30 AM Sharat Masetty <smasetty@codeaurora.org> wrote:
> > >
> > > This patch simply adds a new compatible string for SC7180 platform.
> > >
> > > Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> > > ---
> > >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > index 6515dbe..986098b 100644
> > > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > @@ -28,6 +28,7 @@ properties:
> > >            - enum:
> > >                - qcom,msm8996-smmu-v2
> > >                - qcom,msm8998-smmu-v2
> > > +              - qcom,sc7180-smmu-v2
> > >                - qcom,sdm845-smmu-v2
> > >            - const: qcom,smmu-v2
> >
> > Is anything blocking this patch from landing now?
>
> I thought updates to the bindings usually went via Rob and the device-tree
> tree, but neither of those are on cc.
>
> Perhaps resend with that fixed?

Ah, I guess I wasn't familiar with how things worked for this file, or
maybe things have changed recently?  I'm used to most bindings going
through the same tree as the drivers that use them.  Usually if things
are at all complicated maintainers wait for an Ack from Rob (so he
should have been CCed for sure) and then land.

In this case it actually looks like Bjorn landed it in the Qualcomm
and I just didn't realize it.  That seems like it should be fine since
it's in the middle of a clause that's all Qualcomm and the change
shouldn't be controversial in any way.  :-)

Thanks!

-Doug
