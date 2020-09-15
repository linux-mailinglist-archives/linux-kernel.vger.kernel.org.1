Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D3D269E44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgIOGNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgIOGNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:13:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A93C06174A;
        Mon, 14 Sep 2020 23:13:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s65so1451257pgb.0;
        Mon, 14 Sep 2020 23:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=SVLoXQ1ycHMawjtvv2t7w4+CFgDyZyB3tKz9C+ILDsg=;
        b=Ek1AX7Ay1jdgLkyiFhVeniDo+G6q07WEB36d9ux+38vU2vAwZ0gyHiCFZyvSZA8Xyq
         j1viIijzD5WXHLGSxFp6uk1aDdrqlGu/PozPlO7iQoPnm1jKHZvE2JYVOQ9OaTWiY/Og
         wi5ovBGEG/+y/ICGZdEaq0vLaakb1Uh+0AOk8MdF2FHHvRboI9GFFCOqxjWUEv7yPqU+
         6MWvCMeoNBxgrhhqWYU6aKpxxC1jVj40o/WWhBh6q3Ms3aCBxwX9isOw8RXMO9ahGblR
         1Qjk0Ji+/Cd6ampSWy2/VPFIcL0349VoOVNhGwWz8BzAS+qWPGHAfajGTWDmmoTugAjh
         UXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=SVLoXQ1ycHMawjtvv2t7w4+CFgDyZyB3tKz9C+ILDsg=;
        b=sYAe9VtEDlhscHlbiY2FmInTia6yreT887refcmPFIty6o8SJ83zkNovdcDmjpjUrV
         XmtW+uixMxyss5tVAPFmSRInlO/SNefbdPvizGSGcupl1m+6yZP1hZy3iT1nHqZU+yNy
         Y2e0k+uYrY4N2pikKWlrmvnxcwPgOu+7EzAbTEAllbRhpZEJhdrd+/wiuhh6UqMmgGfp
         31h8/dfoopfthVm6QU+9/A5qHaGzsumHcGyJXfZVYkrjHJVOajSj6BxdHuwQtJr0pTI6
         L4NdFuwJrSXEunISmyB0gWKcd9PgQXUqpL8RlLEiyuTppTbBfz7CGwMPa2juJ+eWtN6L
         1UKQ==
X-Gm-Message-State: AOAM530wqPLAHl5lexh7Wvq9f3wLhmjIKvKOoA05XG2eLaGAG9UnnTlz
        gNJtpWatX2QDKdx2xPUFgnY=
X-Google-Smtp-Source: ABdhPJyJe8prFf/LBNbGur9P1EfTKWxqiU1AaAemUElUP4y3b7ko9EduCy2kUNZ/VeZz3pCqqYcA2Q==
X-Received: by 2002:a63:cb0a:: with SMTP id p10mr13938034pgg.314.1600150396813;
        Mon, 14 Sep 2020 23:13:16 -0700 (PDT)
Received: from Gentoo (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id fz23sm11110921pjb.36.2020.09.14.23.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 23:13:15 -0700 (PDT)
Date:   Tue, 15 Sep 2020 11:42:59 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch,
        yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v2] docs: fb: Remove scrollback related lines
Message-ID: <20200915061259.GB25365@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, b.zolnierkie@samsung.com,
        linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
References: <20200915055712.968-1-unixbhaskar@gmail.com>
 <20200915060437.GA16383@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20200915060437.GA16383@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08:04 Tue 15 Sep 2020, Greg KH wrote:
>On Tue, Sep 15, 2020 at 11:27:12AM +0530, Bhaskar Chowdhury wrote:
>> This patch removed the framebuffer scrollback related lines.
>>=20
>> This is the effect of this commmit  50145474f6ef ("fbcon: remove soft sc=
rollback code")
>
>Why the extra ' '?
I hope you are pointing at subject line space, Greg?? I was looking at it o=
n the
docs:

Subject: [PATCH v2 1/2] USB: at91: fix the number of endpoint parameter


>
>And you can line-wrap things here :)
>

My bad...I will fix it.

>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>> Following Greg's suggestions,fix the subject line and include the commit=
 Subject
>
>Same thing for all of your patches you sent...
>

Suspected that :) by looking at my mistakes ...thanks,man ..V2's are on the=
 way...
>thanks,
>
>greg k-h

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9gW2cACgkQsjqdtxFL
KRWsUggAr0PSxxzslM5iA3j0EaXmgX8XPJBTAlsdURT3dflZeE5enzw70hVuIc9z
fdDgaSnAospS4j4XpAQzwl3bbidr/rBCu3slcMWgxJx8i03htWby21Czg1YNV3e3
a590QDGsIXXT/V10yJueKA9SUIO4HL2KbeF6SqefcfSWvsCYaLcrhJLrkDqdIdGd
W2G11xWdPHRCiMToBAnuT/nfmb2I3gkwWr/eVu+qzxvOXT7nCEG8y3UHoIDTDaTd
DU7bTrYUQr1kMMp2du6vKovV4F+ij7h+3xwVyuEoyv0YEaQW/v6/YTDDJfURVX9z
MnRZPsJ+J2E4F1EUVvHPZ7IIeAAgeQ==
=S0ks
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
