Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE8269DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgIOFhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIOFh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:37:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33BAC06174A;
        Mon, 14 Sep 2020 22:37:28 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j7so740563plk.11;
        Mon, 14 Sep 2020 22:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=JbTmQEDnFXoVyXL5V7qohvPRti7w3yBAV8q4DamQcx0=;
        b=iOW15gRXFF4pt/78OVnu/o3R+7uGPRSLN9jaIVHkStrseissPoVDa/S/SnWgtCMDIf
         kaJlimiNmDRmO0RgXk/Ee07AhvVxNGg2vbpRN9uaDOrFNuExlJRX7xM9KPcssSoQmZVl
         T5jLYzUxnFyBIktT/9ZTWuLO1g+KbWM/WBXS9q205JaTk7slQ2BYYx1hESg9iMww5jnn
         rz0hNET2pXJf6gkpzdc6ctSXnfQkierVR73qHRZqjIlH7X9iR+n1KCNOeNhvfgDm/FKO
         0OtLwgYFdVSvUBYpSf6yzXRSZ/NWNAxVlpeALWTFdosJSDXORwXxXbM7PB9A8GSpk9ZY
         mBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=JbTmQEDnFXoVyXL5V7qohvPRti7w3yBAV8q4DamQcx0=;
        b=dzlWSgkQR/46DZnvJyPBP+Yef3Cw9vHPposkTnLkSzNlrWhfkW0we6pmnUVib45wSV
         bOgxl5dF0nLp3jyhOXfhDUdVfl8Lr33QHIT+s4U0TdP/XOwYBjKoQy4OjBZC+dmLLPna
         dQxZZzOHO9V/Pxu4qMSEi7k51AMWH6Zu819zIB3/3eHR1ZT4HSMOq0NqoXttJjGFjACx
         JV20pCSE1B+m4r8G7g+FWUh9eGgAojO7jViTqUypilXI/6vVXeFbSEpvdgjz7RGEB9sF
         s2d5mQOwXbTkIl+MAFkghZ+hT1Pk6CUxGp09Iui1oiv3oJn3muFw8lqWieESuDI2WrJl
         fcBQ==
X-Gm-Message-State: AOAM532R4+t79WT0OBWX7/7g4hnN4oDtVtLPn6n0eaXwhX0j4OPfaERU
        nq/5Sr1vBvUwybYQ/U6X604=
X-Google-Smtp-Source: ABdhPJzB9q0hxigaDX1TGppKfw3YbMeORri+nN+f/3/3daNDweoW24ePIY1Az6qsJYElfg+4B8Pzjg==
X-Received: by 2002:a17:902:ed4c:b029:d1:e5f8:81df with SMTP id y12-20020a170902ed4cb02900d1e5f881dfmr132263plb.60.1600148248282;
        Mon, 14 Sep 2020 22:37:28 -0700 (PDT)
Received: from Gentoo (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id r3sm11904537pfh.88.2020.09.14.22.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 22:37:26 -0700 (PDT)
Date:   Tue, 15 Sep 2020 11:07:11 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch,
        yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] docs : fb : vesafb.rst : Removed scrollback related lines
Message-ID: <20200915053711.GA25365@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, b.zolnierkie@samsung.com,
        linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
References: <20200915051219.19479-1-unixbhaskar@gmail.com>
 <20200915051907.GA12074@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20200915051907.GA12074@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07:19 Tue 15 Sep 2020, Greg KH wrote:
>On Tue, Sep 15, 2020 at 10:42:19AM +0530, Bhaskar Chowdhury wrote:
>> This patch removed the scrollback related lines from this file : vesafb.=
rst
>>=20
>> In the effect of this commit hashes : 50145474f6ef4a9c19205b173da6264a64=
4c7489
>> and 973c096f6a85e5b5f2a295126ba6928d9a6afd45
>
>When referencing git commits, please follow the documented way of doing
>this:
>	50145474f6ef ("fbcon: remove soft scrollback code")
>
>Can you fix this up and resend?
>
>And you have a few too many ' ' in your subject :)
>

Oops! fixing ...thanks Greg :)
>thanks,
>
>greg k-h

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9gUwMACgkQsjqdtxFL
KRXsWQf9HkycWDlnlMt8lZNH/gG4utlccev4i6KjwimU3xzR2U+l1z0Ec02yg3sX
HaILkXgdCDZ480Wc8pXglMfT4ZGH9XgZeN+mPRJ4WhJwbNVrggiKERHz4G21Njdj
lMrMRT9mcidH4yErQ2crNVKdckhq31l9jZr6aIL3ql4p3ktwrzQsm/qx5Lvg6F3F
k1O+QQmiecQCxtmpxbYuJWQQqcTw3eBymIBciTBw8MlkDEZioeZR13GfJ/p9HG3O
fLkdU+lYPTCOBycQGWfkvLeTBOHK3JWfXozKn4QLqieKBQtdwj4Vamhkhp9qSYUQ
OuuJ6w1qFDIMsSS0XV4vidyHeTgF8A==
=qBSB
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
