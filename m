Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3672C8411
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgK3MYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgK3MYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:24:30 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6DFC0613CF;
        Mon, 30 Nov 2020 04:23:44 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id s13so6059792ejr.1;
        Mon, 30 Nov 2020 04:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hj58atYHNsjUADrTNQ6rEQLtFtphE98duXIfLMcX7Bs=;
        b=d1HX085oWS72Y6jTHNC+YbV35KkyALeW7xBbeQ4SqmHXLcHFQ8kz/Gbl339zBP/ZL6
         Df7g/4vqxMD7diYuf9YKbEXV/vOv287n2IB9hv+hen2qKgXMNkn88PNkiRwgldrF9eAa
         dAhBO8xikTnY7syZA685HaYhQ2QKQfk6bXz78izCT9tas0du01sYXZAJC7xUNMJAaWIa
         /N8wH0tIQT3xP3Pc19MiYoAWqGhP3MFMx5zu4+Vu+PWoFSDpUTv5tHu2drHXtOFi5Y6/
         u1L0qYUJSiSxoZ37yD24ylvb+YP38Uue/7FCVdBIgjKOuW/jT+Okz9qXO6XA7ojxpGZA
         Ox8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hj58atYHNsjUADrTNQ6rEQLtFtphE98duXIfLMcX7Bs=;
        b=XP0OFm19GEa9CdZQ/U1ZxxawVLS9NxAiC9GqEdCfPFrtu1dsQxsAfzJBa3wjDKknXk
         qXl8lhxTNGutAxWx6MJjUYSu9STvp1mbGBfokjv9DfU50p2Zz6BwKUh6MfA2TLncKUN9
         z+6sTULnN+F8fRLpVSifjiq1ZV4kfmAzIX0SgMFLfkQ0EuChI8vt0aAD9dnyfeVolLBF
         NK80ep7dyO31VZoSBCGtGhW/ICCnhXiSttLE1w3SuUYpkiCcGqolxi9XqieeZ9K1mesf
         oEriWyFq/uCwTPSQyAiCmgmOM/Kd5P/WqpqDPvPyFRwEk/fThOHarIxEHJqg5+y8s8wB
         7prA==
X-Gm-Message-State: AOAM5309dEQ8iZ+BlzJwG72wWDgAOyb3EAVOvw+qq3aQ0S73GDRezhMq
        w99Xyxpjsq4Gq8FGYXf2Et8=
X-Google-Smtp-Source: ABdhPJwgWYjsH2RlX5CzBXKBKH/5GOX3qie1Q6J718aa6KLhkAjzCDmzUM9IWKxjTDyjVTrEEPA6yA==
X-Received: by 2002:a17:906:1450:: with SMTP id q16mr1212100ejc.524.1606739023318;
        Mon, 30 Nov 2020 04:23:43 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b17sm6254659eju.76.2020.11.30.04.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 04:23:42 -0800 (PST)
Date:   Mon, 30 Nov 2020 13:23:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Correct GV11B GPU register sizes
Message-ID: <X8TkTQ4MZR/I9kcB@ulmo>
References: <20201124121842.1037035-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3xezRJ/dTBvDl7fn"
Content-Disposition: inline
In-Reply-To: <20201124121842.1037035-1-jonathanh@nvidia.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3xezRJ/dTBvDl7fn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 12:18:42PM +0000, Jon Hunter wrote:
> Commit 90a09178f309 ("dt-bindings: Add documentation for GV11B GPU")
> added the GV11B GPU device-tree bindings information but incorrectly
> added an additional 0 to the size of the addresses in the example.
>=20
> Fixes: 90a09178f309 ("dt-bindings: Add documentation for GV11B GPU")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--3xezRJ/dTBvDl7fn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/E5EoACgkQ3SOs138+
s6EBOxAAiuCgSdW3O/2JYtfIFAXviz2Acd3cANdmQnhuz8WoOcw4STA4ka0jBIp/
GGa95K2DtEV+l04pfzplqa1CZI0r42eRERejtS/axzGo1o6NJO8IP99QkFT60/9c
JhMApiy/dDBL0Qi5gnphoT3sO9CgpBWYyYpVEWVdPEJgWwIXAEdVVvaY/odNkC+y
eUau6mRyrbKD8yk2iaAGVnfysipodzT0gEYxfudHAwEjG2RHT14UcI6xvm4F7aVv
HhyAsdF0YKnfNqrmi6jIh39SCB+m3aPof0vM4ZrL/7Sg+Q6QKiTCsQ+hqnVcE8bo
mHFOsHFjv2pPUfLV+cXIOdKOCGJAlhey07r+7XOlFWL3SJxK04YM9vEyrpoNXqR+
JeyLK2ygc3tmhq3E0ULOmQqMZkcZyJJ/xhT9FKkTF+7XkEpGtmIDY8vIG8ovIjK0
15UVsnNxEqgOnH+Q3zDjAPvn68jE8eXj574GPyWWdBkx+Wt7Fs5KCNXR/8D1VoxA
tufZvpNiAS2str1+arVMtKfrf5bI+IKnnxp7KpifP62o9qmE//Civ9r835rGMjJG
Ig5jUtldq5SRWPw1mQRf3uWS5wQ00o7e9BW25bkcGe1INRb1ayWOKD/Fgdu2eIpG
wVngsKUsHYLxUaUvM0PDIddbnBO0OgDkv7cISbPIktNWozpcI2U=
=Yp5G
-----END PGP SIGNATURE-----

--3xezRJ/dTBvDl7fn--
