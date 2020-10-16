Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D4D28FCFB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 05:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394268AbgJPDtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 23:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394261AbgJPDtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 23:49:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE90C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 20:49:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ds1so618211pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 20:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=n4jJNZWDn+hw4rHThiTyPpOXbtuzXIsW5KU1Q58lcZs=;
        b=vMA3pkFMHBZ4qnZHj2YimB8WkxGD1OCjNvi1BIHVXDG1tIsbO7tagTxbsxg5gaegnn
         xYVQhilXPW4lbGCG/CxIAcLjt+tmgvFTy1bhRxDAJ09wxrXau6TCW0m8ib/XnBH1OJ+3
         m1iHc80VwlpnopXzn1daTyM/T126KlWPRyiOktVv5Dy6QvP7GLD82BpuyjJ4ZhrBXrcm
         YPn2Wb1VxSaAo6dqIIUio8rJlBE0eg29RN6s9aR8pKvXGb85gN3BEKyuWg/OzDKzpbQ0
         K8TDyEINUMPlsdvDnsbBeLgGB/z8iCAObIJlN9UYhMg98Hwudd/2YRdrVlRHxvTEiGts
         CpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=n4jJNZWDn+hw4rHThiTyPpOXbtuzXIsW5KU1Q58lcZs=;
        b=kA/24loxxCSSNTaCaDgE5Q4wv9Nf5mSahEqxi/OH9rds7A67FwVj34G1gfIAYmoys0
         P5Xd0p49TXeOVgWKCv+vyu/hpgnAzfRaYX8O2O0m6d7FXPJy/uwmcUStiWqXpBz+oynL
         SpgTLO4TXc6f6cnSINH4UIQRpDMw4AgBkuW3ZKfQlvkOus0Vm2OyCw9JYLhfjjeTnObq
         yc79BDwHiOZ+15DkaQHiBRxhkpn7tp/lgfDRYw2npMd1V0sZ0aiziEobvOc+OANdMF8M
         JpYqrELnYbc00zh8lf8EUwNMeVHOHCs+RlNZaf+dZ0lXk/l4yK4hPIzUxQwwnXICvPvN
         RRgw==
X-Gm-Message-State: AOAM5311dM4NDukaFFQmsrjkcPaUHmJ8duOEuZyGV1z6/+6WVHaYjgxb
        Be3aSmZoNIobQPH3I4fgzmM=
X-Google-Smtp-Source: ABdhPJzCSNhpbSPX1gzhbfdDIzDQVB/1V+/xKpjM7pRmgGCiIOwy7krIaB0twt6Ora7uiAU1sh9FVQ==
X-Received: by 2002:a17:90a:62c4:: with SMTP id k4mr1973965pjs.174.1602820191320;
        Thu, 15 Oct 2020 20:49:51 -0700 (PDT)
Received: from ArchLinux (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id a11sm907554pju.22.2020.10.15.20.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 20:49:50 -0700 (PDT)
Date:   Fri, 16 Oct 2020 09:19:36 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     akpm@linux-foundation.org, colin.king@canonical.com,
        sfr@canb.auug.org.au, wangqing@vivo.com, david@redhat.com,
        xndchn@gmail.com, luca@lucaceresoli.net, ebiggers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] scripts: spelling:  Remove space in the entry memry
 to memory
Message-ID: <20201016034936.GA1142048@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Joe Perches <joe@perches.com>, akpm@linux-foundation.org,
        colin.king@canonical.com, sfr@canb.auug.org.au, wangqing@vivo.com,
        david@redhat.com, xndchn@gmail.com, luca@lucaceresoli.net,
        ebiggers@google.com, linux-kernel@vger.kernel.org
References: <20201015132336.1770828-1-unixbhaskar@gmail.com>
 <796974d4de89d1e8483d16f4f1f3d6324b49bf86.camel@perches.com>
 <20201015135407.GB1899805@ArchLinux>
 <f479c3b907279ba79391ae1d4ec27773a79ffd15.camel@perches.com>
 <20201015224919.GA1129531@ArchLinux>
 <d8237d5151e108f969628302c22e27dda3860bdd.camel@perches.com>
 <20201015225558.GB1129531@ArchLinux>
 <a03bbb48d2e8b27a2469e91500b264019bbfc33b.camel@perches.com>
 <20201015230842.GC1129531@ArchLinux>
 <943aabb5a27dc58321cb4a8e53e7b2c12cd791dc.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <943aabb5a27dc58321cb4a8e53e7b2c12cd791dc.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 20:19 Thu 15 Oct 2020, Joe Perches wrote:
>On Fri, 2020-10-16 at 04:38 +0530, Bhaskar Chowdhury wrote:
>> On 16:06 Thu 15 Oct 2020, Joe Perches wrote:
>> > On Fri, 2020-10-16 at 04:25 +0530, Bhaskar Chowdhury wrote:
>> > > You have all flawed understanding...please stay away ..
>> > > if you don't understand something...
>> >
>> > <chuckle>  You're funny.
>> >
>> > You're wrong, but you're still funny.
>> >
>> >
>> ROFL ..you too...what a waste of time ...shame that I am engage this kind of
>> conversation ...heck
>
>Your tone doesn't become you.
Same  goes you too...

>Please try to be polite next time.

Please stop sending unnecessary "reviews" too. Thanks. If I need ,I will ask.

Well, didn't I appreciate your feedback first time?? It the following that
stupid and garbage .

>I'm rather familiar with the appropriate process.
>
>$ git shortlog -n -s --author="Joe Perches" --author="Bhaskar Chowdhury"
>  3227  Joe Perches
>     8  Bhaskar Chowdhury
>     1  Joe Perches via samba-technical

Never doubt that ..but you clinging on something not true is surprise me...I
believe you do better next time.

This is the most "useless" thread I have ever been...

Stop propagating it ...>

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl+JGE0ACgkQsjqdtxFL
KRXhcwf9FqpjVI4BUla6UMOR4vltR+VIuoR8sSrPbqIbrvYjAmw88uRFSo4j2sUB
Ke7xivltcUGC+BYKw0Xo0lZ0LCNEq5HXA3fzUlPS3khurZml2ok3S9u0xJlIzxP7
vDX2S5CgjU+JfXUGe9yQdr0zt4PmsHbxWtsK7f8hfq9GIHO+4NyHpoyG3bcAra3a
AOvl2au9CkxqbeJ5vVcZtkLF8Sil9aVojnDOlO99LOpZp4aJoaVsxkAyjuaRy5pF
YQWtbfKQeR3sLXncW98Ytxr056dx9hKLL+6Joo2g2A/IdVyDQWQslHU7ZsD223CG
j3KWkVsOetSaiVg9+uq/VDZH4OdLXQ==
=BFH8
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
