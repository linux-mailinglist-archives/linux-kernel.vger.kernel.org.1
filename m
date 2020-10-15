Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975AC28FB75
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 01:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgJOXJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 19:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732583AbgJOXI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 19:08:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CA3C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 16:08:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id y14so222023pgf.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=1jFVbek6YPEMX9Ziqb77dexEjlRAf49cuhAzA9oiXsU=;
        b=brx9O1Jd15rdxk7QPadihSR8cwYX9cScLK9dn39/5yL+bwLGsjE4y+PjuSutQJNRfW
         xBrijIpxbxEfes4A2um+M0a/7lbx3aB9cyJZkPBJbFV4zQS2xYh9OOUFTPJdIcm1B/JT
         9OM3jbKcVbd+gw/hJxdFFDBkS2B3eCF9UoLB5Zwgohi445SHoT0H15ZNNVrESNRVIPFZ
         642YrZlPbt2ptOHqAOoX2NowhMURsO2ROwiTZgvypWpSeIkHlZ2BFY9h6qamycQNyCM2
         j+QOMVojUC68v9fpBzlSM5z4IfgfBPWjim/HQw6JJEgIpEfzTvDhDHcnW3f/uxUUSrRZ
         j4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=1jFVbek6YPEMX9Ziqb77dexEjlRAf49cuhAzA9oiXsU=;
        b=RdGgbd+E2pRDdYtWbE4Yy60kCPynX0aoe7+y6vQfGFgQ0e9/ywwQVaKEB+nmzMEmXH
         8NWrg5BMBv/MW91AhOHyiMWPSbPDUQ7WpjiaXd1kV6y/uin/wNc/MVer+8+U3eteSgUr
         XAIHEVMlh6YOHKRb34gTfSDoa00e3tc/3vdzuYn3XKL4BuIEFK7T7eKqPpCCUYoXuXqE
         0S3eTlICGiB8nYggKezxtHQTTimuNmEWuvQtFFovQwlPkJFqzRlaRPLZxaGEz7//ZcoS
         8iPtuBZmOiJSrxwxrvWhwuR/r/4a7p8IpSZ5k1sq1SetREfEbfOGjbFSyQg+3E5E7Bwc
         7R0w==
X-Gm-Message-State: AOAM533qeV5DvPV/Mb/S9paGPKFg0/gux8ITy1uwFkhNjh9JbLjb56IE
        pcixKXgk5Uk2u9nFHOfL7tE=
X-Google-Smtp-Source: ABdhPJzZyEj8QtuDX7E+lHFlrpppYFu/8OLVQX3V1fpKtg3oTwhQtOmNTohxtHimM50kHi4+gWP/9w==
X-Received: by 2002:a63:1466:: with SMTP id 38mr703347pgu.150.1602803336606;
        Thu, 15 Oct 2020 16:08:56 -0700 (PDT)
Received: from ArchLinux (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id f71sm331248pfa.155.2020.10.15.16.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 16:08:55 -0700 (PDT)
Date:   Fri, 16 Oct 2020 04:38:42 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     akpm@linux-foundation.org, colin.king@canonical.com,
        sfr@canb.auug.org.au, wangqing@vivo.com, david@redhat.com,
        xndchn@gmail.com, luca@lucaceresoli.net, ebiggers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] scripts: spelling:  Remove space in the entry memry
 to memory
Message-ID: <20201015230842.GC1129531@ArchLinux>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <a03bbb48d2e8b27a2469e91500b264019bbfc33b.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 16:06 Thu 15 Oct 2020, Joe Perches wrote:
>On Fri, 2020-10-16 at 04:25 +0530, Bhaskar Chowdhury wrote:
>> You have all flawed understanding...please stay away ..
>> if you don't understand something...
>
><chuckle>  You're funny.
>
>You're wrong, but you're still funny.
>
>
ROFL ..you too...what a waste of time ...shame that I am engage this kind of
conversation ...heck

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl+I1noACgkQsjqdtxFL
KRVHXwf/S7K2CzekQJ0tdNvddm2yVqHent1KGtGNoJnDIeJ5HWhCA5RdvYn8Gze8
tOGbqvLlsLrGAMJLABFmHVXHEz3SpUlzRvFRg9hJKoKYFfyH/RCOfwgVQAzVIXyF
2yScT/2XbwFTm29Ue2CIE4+vPYR5RBzMZW/cr9dJFBw0pfiYuFSdCKEoBV3NO4dX
3rUYCOtavYrXENmzncrRVW5I/0zBBsXDu7YSrbJAyF5nMeQ2dPDPAi8Ol2GxdslM
LLctOI0wty3ddH+NmrzyhaJPMtISG51uPsPTNfOSc6eBUc5pt0WF8rSOe5vXX9pq
GXaf4y/pfACcX0aQMVDMuG9UWLVjqA==
=wioj
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
