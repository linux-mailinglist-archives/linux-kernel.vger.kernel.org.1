Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B736828FB52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 00:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbgJOWtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 18:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731738AbgJOWte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:49:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786CAC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 15:49:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o7so213861pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 15:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=7+gN5beWb7xuqtjFxy0mOY8Dj5aWNKV2raCCT+QivsA=;
        b=kezZ/4VKA2aqU9lsNyWwpiS8RG4Ojfws+ON1DhdAcgNdBdZ6hekqsJahAlZfErewe5
         YP9CQctdP2RmQWFy3fq0zW9yZf4+84y/gcfAsQsU65jCud84QIQl3SibQXXJOcexoHzn
         zRXAupCKNl2vkkK28VvWkvViGhzQ9iClAf31jKEgcaLeztgweJygfN7uMJOZJDyloaFB
         lQxPBoDnTTORrCcR+WA5YIl3OhSERw08KCvThArrPNEyo4+GoEXZsBoyTnhIxrl+Pt9x
         vJO6feVXrwryVHpGPv3wo8uF4Mg9SG24ZmHokY9xCg1v+V/MH6FsEUMtSEQK7owExwbB
         Z4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7+gN5beWb7xuqtjFxy0mOY8Dj5aWNKV2raCCT+QivsA=;
        b=ew5CeYqpZzZ9IuLKTLdx/POFTDdZGAxN9N/4Qa3gHxXulvYzhgqjQsu+XPdKQ6OUfN
         TmL7gRYesWd/IHOCV1UED6mUxt+9diFK0PaM+T7Y/llIJpauN0Z+2ECe8QcoYENtstkr
         PY44PFLHAYy7HGPBdxXeI96rJx3R6Yi5Mt3WBFej8uGcEPSqw1eCcNDNyHgphjAX2FdH
         tTvNHfQ7TS3EzgWPxluv8dH5doHR1GmbLklZYkJQsabJZFLrTt7iPDD2j1kIMEiuGAiV
         /8txO3oTRMD/Bj8sZYROKRkCrZRvKENvUugZbegoTqLROIqz/d6R8hxrQjWRKLKbc7iN
         P2uw==
X-Gm-Message-State: AOAM530MidkcKz9KW8nX8L7VZw79yLhA3uX7EMuXtqfACCUVxgTZjVmx
        foUA0ojV3C7UYRI1B7nXwkE=
X-Google-Smtp-Source: ABdhPJzwYSWqtxW5zmlYRlkpepcQCiM+U9HCaOiKuKRvOWgJtGOAmSIRdArIjgvVHSl6jNw5qQM6wQ==
X-Received: by 2002:a63:c57:: with SMTP id 23mr644458pgm.109.1602802173722;
        Thu, 15 Oct 2020 15:49:33 -0700 (PDT)
Received: from ArchLinux (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id 198sm335393pfx.26.2020.10.15.15.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 15:49:32 -0700 (PDT)
Date:   Fri, 16 Oct 2020 04:19:19 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     akpm@linux-foundation.org, colin.king@canonical.com,
        sfr@canb.auug.org.au, wangqing@vivo.com, david@redhat.com,
        xndchn@gmail.com, luca@lucaceresoli.net, ebiggers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] scripts: spelling:  Remove space in the entry memry
 to memory
Message-ID: <20201015224919.GA1129531@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Joe Perches <joe@perches.com>, akpm@linux-foundation.org,
        colin.king@canonical.com, sfr@canb.auug.org.au, wangqing@vivo.com,
        david@redhat.com, xndchn@gmail.com, luca@lucaceresoli.net,
        ebiggers@google.com, linux-kernel@vger.kernel.org
References: <20201015132336.1770828-1-unixbhaskar@gmail.com>
 <796974d4de89d1e8483d16f4f1f3d6324b49bf86.camel@perches.com>
 <20201015135407.GB1899805@ArchLinux>
 <f479c3b907279ba79391ae1d4ec27773a79ffd15.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <f479c3b907279ba79391ae1d4ec27773a79ffd15.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:10 Thu 15 Oct 2020, Joe Perches wrote:
>On Thu, 2020-10-15 at 19:24 +0530, Bhaskar Chowdhury wrote:
>> On 06:38 Thu 15 Oct 2020, Joe Perches wrote:
>> > On Thu, 2020-10-15 at 18:53 +0530, Bhaskar Chowdhury wrote:
>> > > Fix the space in the middle in below entry.
>> > >
>> > > memry||memory
>> > []
>> > > diff --git a/scripts/spelling.txt b/scripts/spelling.txt
>> > []
>> > > @@ -885,7 +885,7 @@ meetign||meeting
>> > >  memeory||memory
>> > >  memmber||member
>> > >  memoery||memory
>> > > -memry ||memory
>> > > +memry||memory
>> >
>> > No.  Don't post a bad patch, assume
>> > it's applied and then post a fix to
>> > the bad patch as v2.
>> >
>> > Send a single clean patch.
>> >
>>
>> Not sure what you mean...could you elaborate...don't know what is going on..>
>
>You sent a patch with a defect

Who doesn't???

>You sent a V2 patch that just corrects the defect in the first patch.

That's how it is working here for long time ...I am not sure about your
  involvement.

>Instead send a v3 patch without any defect.

No point ...I think your understanding takes a back seat...could you please
rebrush it??

..and you are telling me something which isn't practice here ..maybe some
other project with some other people you worked with...

certainly not here ...

Long story short, you found a flaw what I sent and I appreciate your review
and corrected the trivialities ...but rest what you are asking is garbage .

More ...I don't know why I am explaining this stuff to you...we have been here
doing this stuff for a long time ... (not sure about you)

Versioning is important for the person who maintain that file..because of lots
of reason ...and I am sure either you have forgotten or it skipped your mind
for the moment ..that is why I suggest ...please rebrush your understanding
...

Please don't unnecessarily streach thing ...we have other things to do ...do
not bringing "new rules" here for the sake of it.

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl+I0ewACgkQsjqdtxFL
KRXUWgf/Siz0KYl6XDzIBkSGsP2b3PjggVQplz9257TzISyhL9/w7c5Ikl5KJG4k
iteA49NrKsi6GkYSVuwdvngpWwVhT1ONlnSGlIZFkAcnU6uahvhK4AH1DKHmXSm2
8mgjgY7hmq7lejNguZEVo1M8N5yj+WVGY/5dGZWkxb2tpp5DDubQUF41Jr/pPbY6
yh7RrgHsBSKFJTGZ0gV7j0iSdNI5yN5V0bFF4qtj1OjJSomS8OGYN9ntuGAx3hFk
8vsTL+HkxtJNI+JAlSbhwEGgiunQJsMGqpcix5Cuvxb/uKGkBlciFTXCUnMRXjk2
CUH9aYXB1ShiiQDt/8qa6N00If5ZlQ==
=lEhQ
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
