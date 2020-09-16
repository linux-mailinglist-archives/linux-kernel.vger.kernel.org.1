Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035D426BA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgIPDEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgIPDEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:04:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C8C06174A;
        Tue, 15 Sep 2020 20:04:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w7so3132310pfi.4;
        Tue, 15 Sep 2020 20:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=0U8gTwwtf1I3SqQBOYC8Zlo9VCb6c3WLAS2yjpHVrug=;
        b=DYoQjmFG+SnybXze9Fj47KS9DfEnYXyZOSME3aWZvVvb2Dyu0C2z9ftefgdHzJsFOj
         1mpmxEveyqp4r/z8P8ek3NTISpjGbAVsa4SveDUZj6TkHcdr6jUb5TauzzmGieHWSgUR
         Z9Szy8ocjKQoAmwsmf3BTsjs6hm2sa1u+HVuvgLgvTe+j2b0YZoA7rD9KvUOiPq/TmL2
         Jdo20AvayF9p48GvCZN3bFidND7l8wEdCZx8Zeo0VB/8WOZmgvOdSdMIZhdnd/h/1Tcp
         4+4hlXlRYtii9sqNelKGNfc6xy49PjhvNxte2Pav3Y3mdaGaRvvqTIKPzsvk0CWq30u0
         RjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0U8gTwwtf1I3SqQBOYC8Zlo9VCb6c3WLAS2yjpHVrug=;
        b=CP76rU6y8NOE9pMj1hJudXBPnjzfQDIIrwprnLy905ez2j3Q2BpvrVgUoKTxK9sYKA
         M6cgGQOPPNSw/u+VxTbpCt8kEBTU2Iuess0uXVlupcoLBD+0uG4edtpJp49D8LbZPEPS
         p6U8WUaJl5dQc9tqzyXTMkF5Ll+tF6jLYVSmzDzqIKWRfPnpqEZFNLPhhgtWhPHOTBYN
         2RNnGuLIKpnFbyFnojCftlcS1c7hwvEZsIq7nRPtVGF9VcHSrLh2aPz13C9CgALqf9XA
         BdsxWpHVS5P3QTESsDhv0T7ObMNIiGbPUbAdoELFP3jYE4kgJvVx1zLCTDFrQI3kxfef
         XJCA==
X-Gm-Message-State: AOAM533oFsskdnwg2mMI3L3oHY1Q0DKBsx2frakLJ4Dfl6MvZ1nadwPc
        Nk49PFG4uixbtKyW+QLiS7I=
X-Google-Smtp-Source: ABdhPJzqL2WyBVTd17nmYy98wE2v3mICzpSrbkFl5GhsXRZ35PEmr5GJVAIXMNXsJo+EVGaAHRQeOw==
X-Received: by 2002:a63:6fc6:: with SMTP id k189mr16391227pgc.165.1600225480523;
        Tue, 15 Sep 2020 20:04:40 -0700 (PDT)
Received: from Gentoo (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id p29sm12292898pgl.34.2020.09.15.20.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 20:04:39 -0700 (PDT)
Date:   Wed, 16 Sep 2020 08:34:16 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] docs: fb: Remove framebuffer scrollback option for boot
Message-ID: <20200916030416.GA20404@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Willy Tarreau <w@1wt.eu>, b.zolnierkie@samsung.com,
        linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org,
        gregkh@linuxfoundation.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
References: <20200915222511.17140-1-unixbhaskar@gmail.com>
 <20200916022552.GB13409@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20200916022552.GB13409@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04:25 Wed 16 Sep 2020, Willy Tarreau wrote:
Thank you so much Willy. I am trying to get the essence of your mail ...few
responses below..

>Bhaskar,
>
>your patches still all use very similar subjects and commit messages
>which are pretty confusing as they only differ by words unrelated to
>their real differences. It is important that the commit messages help
>the reader guess what is being touched, so if you're splitting your
>work into multiple patches, you need to indicate the difference in
>each message. What I can propose to make things clearer:
>
>    docs: fb: Remove framebuffer scrollback boot option
>    docs: fb: Remove matroxfb scrollback boot option
>    docs: fb: Remove sstfb scrollback boot option
>    docs: fb: Remove vesafb scrollback boot option
>
  I would prefer to stick with this model , what you suggested with differe=
nt
  subject and more relevant text.

>Alternately they can all be merged into the first one under the same
>name, but then the detailed commit message should specifically list
>them.
>
>In addition below:
>
>On Wed, Sep 16, 2020 at 03:55:11AM +0530, Bhaskar Chowdhury wrote:
>> This patch remove the scrollback option under boot options.
>> Plus readjust the numbers for the options in that section.
>>=20
>> Commit 973c096f6a85(vgacon: remove software scrollback support)
>> Commit 50145474f6ef(fbcon: remove soft scrollback code)
>
>This is still not clear. The message should indicate the "why" more
>than the "what" which can be figured from the patch. In addition,
>only the fbcon commit is a cause for these changes. Last, Greg
>mentioned that the format is 'commit xxx ("subject")'.
>
>What about this:
>
>  The "scrollback" boot option was removed by commit 50145474f6ef
>  ("fbcon: remove soft scrollback code"), but the doc for fbcon was
>  not updated.  This patch updates the fbcon doc and renumbers the
>  sections.
>

I lost it ...by head failed me ...do you want me copy more information text
=66rom the actual commit??

>If you merge all your patches together, you can have this:
>
>  The "scrollback" boot option was removed by commit 50145474f6ef
>  ("fbcon: remove soft scrollback code"), but the fb docs were not
>  updated.  This patch removes reference to this option in the fbcon,
>  matroxfb, sstfb and vesafb docs and renumbers the sections as needed.
>
>And please increase your version so that it's more obvious that this
>replaces previous series. Call it v3 or v4 or whatever higher than
>the highest you've ever sent so that it's easier for your readers to
>ignore the older ones. Ideally after your signed-off-by you should
>add a "---" line with a quick changelog indicating what changed from
>the previous ones (just for reviewers, this will not be merged), for
>example:
>
Okay, before sending this new set ...yesterday I wrote a mail to everyone ,
that I wanted to get rid of this damn versioning thing and will sent patches
afresh. So, ask everyone involved please ignore what have sent previously a=
nd
that mail too. I am sure that missed your eyes ...and I understand why :)

But I am still reluctant to bump up the version number and would like to se=
nt
all the 4 patches AFRESH(which has nothing to do with the previous patchtes=
 I
have sent) .

Can I do that Willy???=20


>   Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>   ---
>   v3: clarify message description, update all fb drivers in the same patch
>   v2: reword commit message
>
This chainlog of information in the patch getting spirial and not helpful
AFAIK. I mean, the version bumping and provide information appended to every
other following mail. If that is significant then I understand ...but for t=
his thing....I
hope you get me...

>Hoping this helps,
>Willy

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9hgK0ACgkQsjqdtxFL
KRVkZwgAjsi1Ci5jZXb9PSeHKrUiPeRimqYki9dhWdT6OprOtsISaI0wgKMo+sVO
dDZFI3q79XXzSfWWnUein9YphuggOYL7AqaDl4iNF6v9XnGfJa9kOyQjKzLTdlq3
Uk4bHGCNOs+3KIlbK0Fqj1xldFoHquYcFEXURK4jEIJ35kEs5tdI5jgSMU6QLBK9
VKPJFbkX79VvYC8UUMNvSVtY4XI5jL53NXxmV+hA6jHc/OdmVzfeThmrbkfwwWDP
P+t0U5l7tf6ZkWNi8bD6AXBa7a/QAuUYmgXf2xn7qj+Dc+Bo+i4SZniz1GALEWNm
tbuVvN9Zne8EcQImopPMEpayfI6lxw==
=4n40
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
