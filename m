Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7B28FB5E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 00:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbgJOW4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 18:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbgJOW4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:56:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E62C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 15:56:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id j8so303836pjy.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 15:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=KO6O4VPBvjWPVA3/jrUgJJqc+T9jqa0uJB/g40QuMaQ=;
        b=HNI+KmZliGRiKd8sTnig2/Jz5c00PpK1Z0HQSgYOoDpmD8Dhp7pEzSfyVP5Bx9x7zR
         x9EexyKeaNrOQzHJowtieianO7e564cYvgRIwONXEIPrnp5XVSVvHTMRQePdRpgyz4fB
         CdVsJIeOGTHmQn7S53wZnA7XdLB/o/jJZfJfIPLL9hGrRz+Tovs95rRtdiJz5+gVG8s0
         UL+9jPCQozSll83GDURAGaLMQRzczPGY47RfytSfeOhfYqTlIiZC8UpAZ0Hb7CwPa9W8
         EJYf3OGdwo0v8t1ftqH5l8EG7rxlH6Pd9YjfKqklmkL1EIWit4uR8b2ir9aJjzgUhBbR
         kX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=KO6O4VPBvjWPVA3/jrUgJJqc+T9jqa0uJB/g40QuMaQ=;
        b=hU/b8HnAsP6kWo5ktwGiBn6e6Zy0TUzVjaEq+5eFgxgyWqWP0nrTNgHwAiWgDvXPhV
         zRbZXnw2CXLT+m2A5dljVvtN8WYHZTufsnfLENZiUcFWX20rISZ5caXmIy1eVRCknn5e
         HhXrECv1+3ySjF96D4GDPcPXZ6hq5Js4Um9j5COcu0DtlnueiQ32qdspCV8FDeVRI/Ly
         EH4qbtay7PecAmCmeBhZk50ezWSwiCnB4VNfK4K/drRUJC2VDSXRznxN2/bJ12iqNaSt
         dJCvI5828b9uBHaSxvLo88rZAigtO84jquzJUnUi8Eu8GDh1oZiWMJfWsiUh3GE2HMLD
         swGw==
X-Gm-Message-State: AOAM532f47oxRaX4YHCCHWlh8nAJkAMefHPbDkQLHmvDEt5CVXPJhbb3
        T1gxidyBlvX6jj2iLt3+yfM=
X-Google-Smtp-Source: ABdhPJwkRMDxmiNxWgsoUEjCuvXnEICTHvqAGMWixEFiwoKdNt1AsGhUOf9UpZtU/WJtEV4UlA7+Uw==
X-Received: by 2002:a17:90a:ee87:: with SMTP id i7mr905888pjz.25.1602802571711;
        Thu, 15 Oct 2020 15:56:11 -0700 (PDT)
Received: from ArchLinux (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id k127sm357066pgk.10.2020.10.15.15.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 15:56:10 -0700 (PDT)
Date:   Fri, 16 Oct 2020 04:25:58 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     akpm@linux-foundation.org, colin.king@canonical.com,
        sfr@canb.auug.org.au, wangqing@vivo.com, david@redhat.com,
        xndchn@gmail.com, luca@lucaceresoli.net, ebiggers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] scripts: spelling:  Remove space in the entry memry
 to memory
Message-ID: <20201015225558.GB1129531@ArchLinux>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <d8237d5151e108f969628302c22e27dda3860bdd.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 15:53 Thu 15 Oct 2020, Joe Perches wrote:
>On Fri, 2020-10-16 at 04:19 +0530, Bhaskar Chowdhury wrote:
>> On 14:10 Thu 15 Oct 2020, Joe Perches wrote:
>> > On Thu, 2020-10-15 at 19:24 +0530, Bhaskar Chowdhury wrote:
>> > > On 06:38 Thu 15 Oct 2020, Joe Perches wrote:
>> > > > On Thu, 2020-10-15 at 18:53 +0530, Bhaskar Chowdhury wrote:
>> > > > > Fix the space in the middle in below entry.
>> > > > >
>> > > > > memry||memory
>> > > > []
>> > > > > diff --git a/scripts/spelling.txt b/scripts/spelling.txt
>> > > > []
>> > > > > @@ -885,7 +885,7 @@ meetign||meeting
>> > > > >  memeory||memory
>> > > > >  memmber||member
>> > > > >  memoery||memory
>> > > > > -memry ||memory
>> > > > > +memry||memory
>> > > >
>> > > > No.  Don't post a bad patch, assume
>> > > > it's applied and then post a fix to
>> > > > the bad patch as v2.
>> > > >
>> > > > Send a single clean patch.
>> > > >
>> > >
>> > > Not sure what you mean...could you elaborate...don't know what is going on..>
>> >
>> > You sent a patch with a defect
>>
>> Who doesn't???
>
>No one.
>
>> > You sent a V2 patch that just corrects the defect in the first patch.
>>
>> That's how it is working here for long time ...I am not sure about your
>>   involvement.
>
>wrong.  Your first patch has not been, and should
>not be applied, as it has a trivial known defect.
>
>> Please don't unnecessarily streach thing ...we have other things to do ...do
>> not bringing "new rules" here for the sake of it.
>
>It's not a new rule.
>Don't introduce patches with defects.
>
>

You have all flawed understanding...please stay away ..if you don't understand
something...>

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl+I03sACgkQsjqdtxFL
KRXGMAf9EjboQm3dL+RVdS9x5Xxwdz0ZXDHKchvAgTAp1cZDgHjvUzIJ/sOpxGq9
BRPzHuZL4d+YjwjKcYH3lSAGkfbOf2o3fCrn1gOm/nWTNFmEo94a0ZAt5UCY0nUB
Oh5MxFPfUvO4dW/aagcpq0EyMRmZ+WQfZ9cI5hdUmV8kcGSj2uyDLC5nZZ1Eg7rU
Ss+Z9Ej9vRiSd7waTGEfTils8F5s1/lmWrjjkxdTPn8uhV/SR+HKwnqTi8kRVupU
iLYkPk9KWYlEKwx5pUzhW2kRLDCvTdKNwNvHKVzl904OtBdWBOOAVr4LYz0JZVwE
nEwZzQlngkp8dXVWt+dXwLwiQXEuEg==
=Ecyw
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
