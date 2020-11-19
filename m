Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3192B9191
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgKSLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbgKSLoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:44:39 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92886C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:44:37 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id o144so4889771ybg.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c8Qo3iMTLDXZDQ8LhsVrB4GbG7ddhsHuA42Wrhb4+h0=;
        b=gh6maHtJeErJOD6UDW2c3CCbf+6ZoSfGn3H+8ciJk7tdtGTboUKsUQLcJZHMyBl7ZA
         b1+/DztKMtFKcSEblfJ9XDZL12+fIyTo4p6R6PD15BN/1bNpZnFdAHoVGCu9OB+Q4x/H
         xzMZ6S1ODsNOBBQkv+EZGsTt2pEFMRANM7HfnH9X85lyyCVItmSSRNIQdRgV9bQWTK0/
         gIVlRReIhZCA6kK2DYrdKwgUL0BSDlybyDUAgb60bjZNKj0eNV+uhmq/XtksTPeKpRoY
         pLX/H1qNeFsSB33WIvjrV2zkRLfo6Wiz07rd0rfwfY6Wattimo7gNt73V5Hjd/ZGtBK9
         +DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c8Qo3iMTLDXZDQ8LhsVrB4GbG7ddhsHuA42Wrhb4+h0=;
        b=S5gPOSx3DHV4yt90+KA8F3WzB6XF0bOCNuAzXz0skiaEADvpe9Qv/izy5qZg6+hm/a
         MwbA+wEmZaNbCjzooHJe+ODWv1Sv1TwUutta9zBjYbGPv1QhNpxXlk4iyn+kgVJQiXX3
         +Y2DIUzoGDaPFT5GhAxCPgOLOBHT+IW9qgcI1dsYvvsGFjDKgI4QU+6swCSc396GIUEY
         RzFrF2xzWof5dJUlr9XJSWdAI4w6SVRBVFSWR2RxmZZYYMZry8qJCAD57dkbIRRKrT3t
         zTrv1kHBeKeZb4gRNor62SPGQhGZRG88DIwi+D7JuCaxkPE0VgGPW0XRpASfjicn5SkM
         YZDw==
X-Gm-Message-State: AOAM531PeyZg7ehVGOiTv2K3aw+1e1HKObVkqQq5I93GhedhymX+g+/g
        M4lUTAbomJ+MIcCrcTXoNdWOUryW2WVCRYvrfsN83A==
X-Google-Smtp-Source: ABdhPJzEoiEVIDDG7CVsykDj/QZuLByOFuhSa5yFAPYsb/SMTp5op2dwar3PQWhrmEUaPh6JNJoGIhPp4adf8SrbWlw=
X-Received: by 2002:a25:9b44:: with SMTP id u4mr14103602ybo.426.1605786276902;
 Thu, 19 Nov 2020 03:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20200916071950.1493-1-gilad@benyossef.com> <20200916071950.1493-2-gilad@benyossef.com>
 <20200923015702.GA3676455@bogus> <CAOtvUMekoMjFij_xDnrwRj2PsfgO8tKx4Jk6d7C5vq-Vh+boWw@mail.gmail.com>
 <CAOtvUMfAKnodo+7EYx2M4yAvxu_VmxwXNRmgOW=KFWi3Wy7msQ@mail.gmail.com>
 <CAL_JsqJditVYJ=4K9i11BjoV2ejABnuMbRyLtm8+e93ApUTu9w@mail.gmail.com> <1450044c-5150-1da2-11e0-2ae48d8b4d0c@arm.com>
In-Reply-To: <1450044c-5150-1da2-11e0-2ae48d8b4d0c@arm.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 19 Nov 2020 13:44:21 +0200
Message-ID: <CAOtvUMfxrEZeBepL6kwQTT6v9Dw4vv5hxREVf_aHDs90o_fsVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: crypto: update ccree optional params
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 17, 2020 at 4:07 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-11-16 18:54, Rob Herring wrote:
> > On Thu, Oct 22, 2020 at 1:18 AM Gilad Ben-Yossef <gilad@benyossef.com> =
wrote:
> >>
...
>
> IMO if this is like PL330 where you just stick some raw AXI attributes
> in a register and that's what goes out on transactions then it's not
> really part of the platform description anyway, it's just driver policy.
> If folks want to tweak the driver's behaviour for secret SoC-specific
> performance optimisation, then give them some module parameters or a
> sysfs interface. I'm assuming this has to be purely a performance thing,
> because I can't see how two different integrations could reasonably
> depend on different baseline attributes for correctness, and even if
> they did then you'd be able to determine that from the compatible
> strings, because they would be different, because those integrations
> would be fundamentally *not* compatible with each other.
>

So, I checked internally where we get this requirement and it seems
you are right.

I'm dropping the Dt bindings and in fact the ability to customize
those attributes beyond
the basic coherent/non coherent configuration which we already support
and will just
update the setting to what we think is best.

Thanks for clearing this up.

Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
