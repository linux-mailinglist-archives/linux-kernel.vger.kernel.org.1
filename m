Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88E3039B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391819AbhAZKAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731323AbhAYSyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:54:19 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBECC0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:53:39 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id t29so8917202pfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=qrcTMzLcjdbpmgAyRMy0BErO5zTudq7P3sXsgebErLk=;
        b=mliXsl9BqhYD322wmHDVaNV9Cr6dO5KVGZmKa1tNMTRbhZx/FJtxkEwYzvT1dqruek
         JuaunveJLJTWusqGkNdTa9SI9/qu4t44dSI5XzrERwfKSazFQ3I45wzxzVqUSd1E6S6/
         Yn0m6TMkTrwNUL4ziH8PhiR5DGvm0etUnD4mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=qrcTMzLcjdbpmgAyRMy0BErO5zTudq7P3sXsgebErLk=;
        b=bXk4k9T8zyJb2JLNFxirer2uRRnDI3DPfZ5kFsSGyztewS16JMiEppvusvpMXspqw3
         PKxKPYphGKqAm+sfZnjhxrgwpc2bJsfk93RzXzZjuAU6mUWfgUSDAwPg0NNzEbbDQdWW
         ndq/CyqKbN5sjsloJgXAODq1BiIYqvMzIX9CZ7ML2oD5EJZbUMlOTw1d//18VgBnUpKT
         C0tIBhd/n9ULOtALH9UPZ8Ts+74iwXb2V0F3f2DSyADmqdhN4eeQvv81Yighe3mQtljn
         bZ7KWOEs1MG4J2S+IEvwl4Hg/Q3zd0cT+YfS9B+lGqQE9VI0nKJgVyZ3ia3HZCivHpkx
         eKZA==
X-Gm-Message-State: AOAM531flCpl60Vl6UpU5c4N9lN5KJ9B6jpgQ0tnzgNndkaBa5P0P/r9
        2Q75wgOgWBTL4HqsqjnIcsnZqEMCqd1QGg==
X-Google-Smtp-Source: ABdhPJy7/wHqL9F4TAtM95bLSPUA0myWvYRQCdRt7RPyfwOmMPs0lOR7hNJLXfmsdyPQL8p42NXFnw==
X-Received: by 2002:a05:6a00:80e:b029:1b6:39dd:8b2a with SMTP id m14-20020a056a00080eb02901b639dd8b2amr1618159pfk.23.1611600818473;
        Mon, 25 Jan 2021 10:53:38 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:1066:b437:97cd:2278])
        by smtp.gmail.com with ESMTPSA id ob6sm97455pjb.30.2021.01.25.10.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:53:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210125150203.GA341275@robh.at.kernel.org>
References: <20210122225443.186184-1-swboyd@chromium.org> <20210122225443.186184-3-swboyd@chromium.org> <20210124172756.69ef7c5a@archlinux> <20210125150203.GA341275@robh.at.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org
To:     Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>
Date:   Mon, 25 Jan 2021 10:53:33 -0800
Message-ID: <161160081370.76967.12690026482235521779@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2021-01-25 07:02:03)
> On Sun, Jan 24, 2021 at 05:27:56PM +0000, Jonathan Cameron wrote:
> > On Fri, 22 Jan 2021 14:54:42 -0800
> > Stephen Boyd <swboyd@chromium.org> wrote:
> >=20
> > > Some cros ECs support a front proximity MKBP event via
> > > 'EC_MKBP_FRONT_PROXIMITY'. Add a DT binding to document this feature =
via
> > > a node that is a child of the main cros_ec device node. Devices that
> > > have this ability will describe this in firmware.
> > >=20
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: Benson Leung <bleung@chromium.org>
> > > Cc: Guenter Roeck <groeck@chromium.org>
> > > Cc: Douglas Anderson <dianders@chromium.org>
> > > Cc: Gwendal Grignou <gwendal@chromium.org>
> > > Cc: <devicetree@vger.kernel.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >  .../proximity/google,cros-ec-proximity.yaml   | 37 +++++++++++++++++=
++
> > >  1 file changed, 37 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/g=
oogle,cros-ec-proximity.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/proximity/google,c=
ros-ec-proximity.yaml b/Documentation/devicetree/bindings/iio/proximity/goo=
gle,cros-ec-proximity.yaml
> > > new file mode 100644
> > > index 000000000000..c0a34bdfe4fd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-=
proximity.yaml
> > > @@ -0,0 +1,37 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +
> > > +$id: http://devicetree.org/schemas/iio/proximity/google,cros-ec-prox=
imity.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ChromeOS EC MKBP Proximity Sensor
> > > +
> > > +maintainers:
> > > +  - Stephen Boyd <swboyd@chromium.org>
> > > +  - Benson Leung <bleung@chromium.org>
> > > +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > +
> > > +description: |
> > > +  Google's ChromeOS EC sometimes has the ability to detect user prox=
imity.
> > > +  This is implemented on the EC as near/far logic and exposed to the=
 OS
> > > +  via an MKBP switch bit.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: google,cros-ec-proximity
> > > +
> > > +  label:
> > > +    description: Name for proximity sensor
> > > +
> > > +required:
> > > +  - compatible
> > > +
> > > +unevaluatedProperties: false
>=20
> additionalProperties: false
>=20
> > > +
> > > +examples:
> > > +  - |
> > > +    proximity {
> >=20
> > Can we at least have the example making it clear this is a child of the
> > cros_ec device?
>=20
> Move this to the core Cros EC binding. The core binding needs to define=20
> 'proximity' and reference this binding ($ref).

Will do.
