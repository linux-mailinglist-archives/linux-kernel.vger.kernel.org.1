Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A127A7DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgI1Guo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgI1Guo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:50:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFEDC0613CE;
        Sun, 27 Sep 2020 23:50:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so10987921wrv.1;
        Sun, 27 Sep 2020 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6BUCtRQudyL3oZudd2zI1GLfqtbwrgqT+bYMsIQL7nA=;
        b=IW3m/iIqKFlwSWbpCzIa9cKS8cOZwhypErZ+Tye+vUl5ZLu+MBkOF5j8Z0mmXZGASX
         chh2MSg7XEJBGh+kpahF0LVtlbjR52VfQbmSzqZ1d231Nd+Pyha+N8nJRW7r5ZnB9CMz
         getrzScqFk+NvDqus+Q5H7HfVIFMlpHfEyn9jQADzKLrIAXdUwxKO1geqAWsyZn7FVLD
         zmDOCfpAYCFYu8AFXdZhOEioovq1qC7X/drFnUac7u6EaJkiU5JWOCrhqxk31l28bRaI
         m2lURiMhNmx3Lj7Wvms8rhn4PUxg1eA41xHbNOo9Ac3Q64A5yIyUxWzWibGU4e7vLIaL
         sT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6BUCtRQudyL3oZudd2zI1GLfqtbwrgqT+bYMsIQL7nA=;
        b=VZ60ur9tbrZwx5IewH0KpwU1HmEe4D+tgyGr3aQiIIOo7/K1GMv2UfdC+z/AERnCCl
         OvozdEF+6+rKydASq+of6kC09tL/D/rpnIIc/5B8wPsfRhezfz6OpFFuyaz/3c+nNonF
         MXAtVkUFMxWjBZj/WCGUpJEsrYeFu5L/ZisB59NgXLG0b7A9yf9cIxQF/aBZ64kiawAE
         e1uGL5pxKEWrR5pmMRC8/fwvAZILtv8I/CzGsUfnIgVnD5uTHG0a4htQ0SN82PlOgO9s
         EH23p089D1yJPFY+e0lBvSsAWT7ElkTdHQYiUXpa9N44/Sd2QLGMYw6oN6ZUoQQhYW+c
         1qrw==
X-Gm-Message-State: AOAM5337tqiR+xudG2uZy5pqRwGKekO3y8ZYZCP2RCAA1Ix2Qapnck8Z
        ORr9Zohy/4Ulc136wWwwd5Y=
X-Google-Smtp-Source: ABdhPJydUek7h89ikzl2Ha2RAi7hyyWpqnPoMpeZKtP9W8ECKRs6bvysmD1T/CKzC4ap+3fHGVSvuA==
X-Received: by 2002:adf:f885:: with SMTP id u5mr16542136wrp.382.1601275842549;
        Sun, 27 Sep 2020 23:50:42 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id x10sm8002713wmi.37.2020.09.27.23.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 23:50:41 -0700 (PDT)
Date:   Mon, 28 Sep 2020 08:50:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/3] dt-binding: display: Require two rests on
 mantix panel
Message-ID: <20200928065039.GB2837573@ulmo>
References: <cover.1600707235.git.agx@sigxcpu.org>
 <71a9108f3472ba9af4bead01b1b770d1e73eb08e.1600707235.git.agx@sigxcpu.org>
 <20200924193807.GA1223313@ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <20200924193807.GA1223313@ravnborg.org>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 09:38:07PM +0200, Sam Ravnborg wrote:
> Hi Guido.
>=20
> On Mon, Sep 21, 2020 at 06:55:52PM +0200, Guido G=C3=BCnther wrote:
> > We need to reset both for the panel to show an image.
> >=20
> > Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> > ---
> >  .../bindings/display/panel/mantix,mlaf057we51-x.yaml       | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mla=
f057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,ml=
af057we51-x.yaml
> > index 937323cc9aaa..ba5a18fac9f9 100644
> > --- a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we5=
1-x.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we5=
1-x.yaml
> > @@ -35,7 +35,9 @@ properties:
> >    vddi-supply:
> >      description: 1.8V I/O voltage supply
> > =20
> > -  reset-gpios: true
> > +  reset-gpios:
> > +    minItems: 2
> > +    maxItems: 2
>=20
> reset-gpios is, as you already wrote, defined in panel-common.yaml.
> Do not try to change it here.
> It would be much better, I think, to introduce a mantix,reset-gpios
> property.
>=20
> This would avoid that we had two different reset-gpios definitions.

My understanding is that this will only override the defaults defined in
panel-common.yaml. So everything else about the
panel-common.yaml#/properties/reset-gpios definition remains valid and
all this does is say that when this matched on "mantix,mlaf057we51-x",
then the "reset-gpios" property is expected to contain two entries as
opposed to the single entry that is expected by default.

Thierry

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9xh78ACgkQ3SOs138+
s6FB8g//QtBW3j5TqyMHUoddPBCtKSfsY10GMjvB1UNVnf3COAo+qKbNI+aCEeJV
EXr7Nek9zLYPMfbSGaNkk9T36D4SMBVJdpTLm93kXAHSE3CW4e/mNpA78MRDPzPN
rORuQHrZ7yhNnZbKZIrIXCP9o38Y5HPuPM/3qoc5Yx2cnUFSCCN+O2SGyAMbZw26
sXOsGKOZ2p0nHXrEf1YZ4DyX8u+WJzYV8NOWLfaZgs6HkEFRE+4nF3IwYmeU8h7E
5BkqKiTWiruu1hK9I6v7CLWQj6efG1VuNL5dZwqYiJU4q9vqr/Cw23GxBeBhu8z8
umUV5LRHxf4CK5+1Rp9hPJHdjwG6gm3FoeXABD/uY5pzbcjoxqxzgN0GGE5At5KZ
2yRc1jfWC8ZIQOg9iI9XKhOP+id8GXmlHZT0CazBtesDbm2g3/J+zdzzJgheYRzz
wHKkAb5AZjBzVhc8R8UbbczdPUEwMn6hnO4d5Whg41PGcD9PsfzGRx92KUNpkmK/
Ofj1ZgfhAKNGoJSoKjkBX6b7bviU9q1BHKKr7hryAS04r7M9kBWcF3iC7m7/cDsP
WtyDubuGQOqQ43kL+frGrjgLXnF7iy/m16kPgjD7DlxeWYL8kFYfRnSr/976oXdH
5zKXEIdFrPEHmcs89OBFRchJ91m531oM+wbTv6N4Ec8i8X2R6X0=
=sjb9
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
