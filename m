Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D253020E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 04:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhAYD5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 22:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbhAYD5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 22:57:32 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD7C061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 19:56:51 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id u20so2729568qku.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 19:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=TVau0aJHw2cbbXi3xnkXfOY59reeAdzp4nIU1mqCqEk=;
        b=bv1ZoTpyo6A6yxft+5CX6FAENFyTL2BZ/S6g/zKLElgUvuaMcJNa6zLDsRQXTnEBXM
         loPiXCHotnXdg8raDcRZa+lD7/bUb+45atxwLq2l+e8q1fD39J+vQCtc3cuJhd/gfu3T
         7F+6psLq2jl+SGH9z55ZPsRomMfs19BpWVTIu/TQK0ZbkZDqmtSCyuRlLo23AHRnvShA
         rEOJ2tFKVpyvtgT4G+PQe8lkvZM3zkpNUrYViETrkrx+95kTxiIfT4D9+0ljbwBbCM1P
         rSlBMjyVQlmb1/DXkpeKqv2cIHFBrGWMlUq6vSYW3yWAy9Ewya5gdFJX7Du/hwGWjVih
         XLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=TVau0aJHw2cbbXi3xnkXfOY59reeAdzp4nIU1mqCqEk=;
        b=d7PHvW1+sMK45et15m9o/HVQv75gThh5XzaKXJWXoRSSMNA2EIg/8NWcdR89jn6zg1
         Vhrq4olOpFceHqQHW/GEeRPXHtv0p2jw8rA+3EQHFMZ5r0/Jvhw5G82pO/MCiaceyL+1
         zqx+pZ1yD1iqw3zHVIyFr70ToaEH/wmKhRuau5eXuf/8WEPvqQFJE8SNep5iFbBIo1jn
         amz5DPyotLJb+CFkJqKGX+mc/VePuc13dMbkMbDH0b/AcKwtjMIO6GZCEq4wpjfaVQ2q
         AhnP8GCXynctDIeQTN+XWAYdFT7Zojn47QNpxrdJCextEfTP9o+/L4LTWfLEbnTQNPd0
         oWTg==
X-Gm-Message-State: AOAM533fX3xOqsTGQTmd2/8qt3YVbzTsouvzXd3Q+FsN+n6CGAG1RrPr
        rHa/LOOiypPxu2q5ovrNKWM=
X-Google-Smtp-Source: ABdhPJzYgrW+EQbnqesr+7anP5PPpdQv/PcqXUZJs5XVbShF6Mw1toYFE8sowbJL3KZUaAdRbsiaTw==
X-Received: by 2002:a37:7fc2:: with SMTP id a185mr5111297qkd.202.1611547010866;
        Sun, 24 Jan 2021 19:56:50 -0800 (PST)
Received: from Gentoo ([156.146.58.37])
        by smtp.gmail.com with ESMTPSA id f125sm11000992qkd.22.2021.01.24.19.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 19:56:49 -0800 (PST)
Date:   Mon, 25 Jan 2021 09:26:43 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc5
Message-ID: <YA5Be9sL4NUs4thi@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
 <20210125034819.GA163132@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ob3w+3uaNmB1MqhB"
Content-Disposition: inline
In-Reply-To: <20210125034819.GA163132@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ob3w+3uaNmB1MqhB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 19:48 Sun 24 Jan 2021, Guenter Roeck wrote:
>On Sun, Jan 24, 2021 at 05:06:40PM -0800, Linus Torvalds wrote:
>> So this rc looked fairly calm and small, all the way up until today.
>>
>> In fact, over 40% of the non-merge commits came in today, as people
>> unloaded their work for the week on me. The end result is a slightly
>> larger than usual rc5 (but both 5.10 and 5.8 were bigger, so not some
>> kind of odd outlier).
>>
>> Nothing particularly stands out. We had a couple of splice()
>> regressions that came in during the previous release as part of the
>> "get rid of set_fs()" development, but they were for odd cases that
>> most people would never notice. I think it's just that 5.10 is now
>> getting more widely deployed so people see the fallout from that
>> rather fundamental change in the last release.  And the only reason I
>> even reacted to those is just because I ended up being involved with
>> some of the tty patches during the early calm period of the past week.
>> There's a few more still pending.
>>
>> But the bulk of it all is all the usual miscellaneous fixes all over
>> the place, and a lot of it is truly trivial one- or few-liners. Just
>> under half the patch is for drivers, with the rest being the usual mix
>> of tooling, arch updates, filesystem and core (mm, scheduling,
>> networking).
>>
>> Nothing here makes me go "Uhhuh" in other words.
>>
>
>Looking pretty good now.
>
>Build results:
>	total: 153 pass: 153 fail: 0
>Qemu test results:
>	total: 430 pass: 430 fail: 0
>
>Guenter

Hey,

Mind letting us know ,what you are running? Any automated stuff? Any specific
tool or tools?? Scripts???

Bloody curious to know Guenter ...if those stuff are expose able to public
consumption , please do provide the pointer too (I am being lazy to find it)

~Bhaskar

--ob3w+3uaNmB1MqhB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAOQXcACgkQsjqdtxFL
KRXz/wgAwL3i3onniLfzxWAmMjFMnwDuSdmzHV4k67uZkl4t8HHQTPcKC+1G+pKD
EvP6TzRXjS8hOE7ucWc2Vz8qbZ/7qjIi9xlMAbKCJMlcRjcYDgO1ZNW9RhNlb5Nv
ZWKnt71sKW4wBkIbeRTZZVHewO2L9IbQN7/gsZihdKjh5RWdAnCefLTeRPEX0pzp
9Lhb9ux/Jn/Kglp9xdwU2ywolaXVbccul55wnhY/x52cJemlEOntps/ocN2U1nUc
z2D+ysWro4ukj+6ThV8dr5phRdX8Asaq0AsPKEydKFyPiBaJlU87aECoRBi2T09a
Rfbbso7xX+pst7mYXihDl1ZkV/ooVQ==
=BziT
-----END PGP SIGNATURE-----

--ob3w+3uaNmB1MqhB--
