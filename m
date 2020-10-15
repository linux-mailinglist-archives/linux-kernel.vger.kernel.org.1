Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F02A28F4DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgJOOhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbgJOOhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:37:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3A3C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:37:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t9so3744982wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atcomputing.nl; s=atcomputing-nl;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version;
        bh=BlxdYyMIUCSA+6cNAex4SwzO8S5YCgvJxaaXIsMT2yk=;
        b=hxblWQXDdL6Pknk5gfzyWCNGujyGqTDYiCpudBE/EPSclIPZ41n+wF9Jo8c0XITvIC
         OL8ZRykRU2q4HRVLGDNTk2mZtfzkL89OqZZKT5ZFox8fToxxfF99kWo/CPMVIUsNSyXt
         yXD5DC3RBkzNVOUQIHRgWDi7YimrYMcUdA9zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version;
        bh=BlxdYyMIUCSA+6cNAex4SwzO8S5YCgvJxaaXIsMT2yk=;
        b=j1OmZI55X95GHaPgX2lJr085Xq2n9BbPSkdgQa+t7BQdoAm3ubrN+94T61/p7nfa2c
         r7UKmYsnWtXweR83f9AdUnMDnaSEp8hccx6YgVq1wniFpt03lyqdxYT081DcgKLPi8QZ
         UVvrUWq1HE9zzv5vHr0V4yA0/BXj9c1JejsEbiCUWh8RZfPnaT3wRXLqSDCF8PxJzNXt
         EDhdzh1ULWj28gkRpHq4I/Hj5bYaGKhhO6VdlSrZPFNteBrJLLogeHz3KQ3kC+dfHonn
         CttusTdwWVXhgci2w2jM5K5LF+KzexKeTa+/AcBd5PQ1WX1NhC8SQFNT0ChoIN7Tdsam
         j+Cg==
X-Gm-Message-State: AOAM533GzI1a3VmmkQ8sCDxtZKU3wFs35TPQVX9eWlQ4anJP5rif01g1
        wo/WkubmIBB2eh7UPOANmM1PE0TR4uFlVwhR
X-Google-Smtp-Source: ABdhPJwgqUnP8Mldpa0nrzDfaKpDs4xYqt1UEegfzQhzuJOOdHBy/bbgWWe996jWN8Hz/K5oGBUX+g==
X-Received: by 2002:adf:e3cb:: with SMTP id k11mr4756640wrm.341.1602772666618;
        Thu, 15 Oct 2020 07:37:46 -0700 (PDT)
Received: from nyx ([2001:980:74ee:1:1ec4:4a28:e4c9:705c])
        by smtp.gmail.com with ESMTPSA id j7sm5253004wrn.81.2020.10.15.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:37:45 -0700 (PDT)
Message-ID: <b58d854afe42d45f499b978da96f0cf29c5e574c.camel@atcomputing.nl>
Subject: Re: [Intel-gfx] [PATCH] Revert "drm/i915: Force state->modeset=true
 when distrust_bios_wm==true"
From:   Stefan Joosten <stefan@atcomputing.nl>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 15 Oct 2020 16:37:39 +0200
In-Reply-To: <20201001152346.GR6112@intel.com>
References: <60a804aa6357eb17daa1729f4bce25e762344e9f.camel@atcomputing.nl>
         <20201001152346.GR6112@intel.com>
Organization: AT Computing
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-1ehRlM2nvfRUqr5GDzRW"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1ehRlM2nvfRUqr5GDzRW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Ville Syrj=C3=A4l=C3=A4,

Thank you for responding so quickly.
I was occupied with work and life for the past two weeks, sorry about
the wait, but have now managed to find some time to continue pursuing
this issue again.

On Thu, 2020-10-01 at 18:23 +0300, Ville Syrj=C3=A4l=C3=A4 wrote:
> Argh. If only I had managed to land the full dbuf rework and nuke
> this mess before it came back to bite us...

Yeah... I know the feeling.

> This is definitely going to break something else, so not great.

I did expect that. The automated tests failing was a pretty good
indicator.
You put that code in to take care of something. All I did was just tear
it down because it happens to work better for me... blunt but
functional for my purposes.

Seems to need some finesse or a condition to not cause my problem? Yet
still function for the reason you put it in there for.

I am more than willing to play guinea pig and test patches on my end to
improve it with you.

> Can you file an upstream bug at
> https://gitlab.freedesktop.org/drm/intel/issues/new
> and attach dmesgs from booting both good and bad kernels with
> drm.debug=3D0x1e passed to the kernel cmdline? Bump log_buf_len=3D
> if necessary to capture the full log.

I have done so today.
It's at: https://gitlab.freedesktop.org/drm/intel/-/issues/2579

--=20
Stefan Joosten

AT Computing BV              =20
Sharing and growing together  Tel +31 24 352 72 82
Arnhemsestraatweg 33          info@atcomputing.nl
6881 ND Velp                  www.atcomputing.nl

--=-1ehRlM2nvfRUqr5GDzRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQFKBAABCgA0FiEETjlf9HQ9GW2hDHJJSfQ+3gEWJQkFAl+IXrMWHHN0ZWZhbkBh
dGNvbXB1dGluZy5ubAAKCRBJ9D7eARYlCdRQB/0UKaMEMiO/73Q8nqqd7wMxYfhB
v5UqBk4fiG0bL1WnkW2nLq1AZ3OZWfrL+FuHp9uUC7qf6YXcAQYRlcxScMnCkdC6
SiK1NdIf5B4DULfbxaeiIfkGf94/zUdX2WTtb5ch6MufmgYfGgIovnT1TE2EKnk8
wNkZYiWMnZpffMJUU6qMHt+FR5YUdomuMGIwCDHHo7+YnLag0v+EpXBh8CNarUHa
EZKa3pOLrNAUaLr5mhDpdtEmDlDQ8of89KQod339gmI+bE1G7h0jHk6TDaMdFipU
uw8sp2MQiUWI6QJFulsIW6uwcPqCgNMKPJKWIDIlpqAxuhE5amOaJoQ0+2w5
=c3uK
-----END PGP SIGNATURE-----

--=-1ehRlM2nvfRUqr5GDzRW--

