Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6851CEB24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 05:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgELDJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 23:09:48 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:25765 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgELDJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 23:09:48 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 04C39X8H032485
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:09:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 04C39X8H032485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589252974;
        bh=rA8J4h8s7FTnqZbQ11ES1S2G/1hnGX0Gtq+vp70wCsE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WVU1N2PZsDU6eMWru2/F5a2gQNjpq1p7Wta+H6Hz28U0UMed8O0xuxcMwVA8FBFDW
         49erQ6JSaW6zbVST33S10tK25KAumY6gvvyZsg6DvHS1va1pzGIkUg1eEzEFSJ+PEk
         qnCv9KqFjmHV/dQnbEuCIf9kIfqiG4E+zwi0U5Rfs9Pq/XfKPb6o5JGXCdDs8W9Spd
         KmB7pSMGLLT/8qyr2rCjSVKhYl7Ff/OhcpJxGmGvVTaa0SQKn2sTQbzI0nXj0pqZ/C
         J76j2e8GeHNcxQJKpPrkF+j0kOK7ySOa0y/quEoO8fWtjmPyXnvvsfpD4UR8c5qMLb
         bDGj2FKKJ+CIg==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id j127so2936341vke.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 20:09:33 -0700 (PDT)
X-Gm-Message-State: AGi0PubXh7j5K/gfkyTRVB2gmftKpi2t+3Vp/iWNo7ma9p6gDIRC2ftd
        OF6TTxCAoZ5Pm8whkmoWVvjtduope9WL8Sj1QcM=
X-Google-Smtp-Source: APiQypIsHzbW3//5XymjHuAku6kajN66DWqQK4B5LMsnOCveflW3gGJLLqS2Vh/U3G8N4egyYqO02bB4w6BDiAdZEH8=
X-Received: by 2002:a1f:c443:: with SMTP id u64mr12700259vkf.26.1589252972453;
 Mon, 11 May 2020 20:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200428070614.GB992660@kroah.com> <20200502052619.26457-1-xujialu@vimux.org>
 <20200502052619.26457-3-xujialu@vimux.org>
In-Reply-To: <20200502052619.26457-3-xujialu@vimux.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 May 2020 12:08:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR1zbFxpPkWi4BMtQSAJs4zNa1QBfzVeu=NnJy-RjNfbA@mail.gmail.com>
Message-ID: <CAK7LNAR1zbFxpPkWi4BMtQSAJs4zNa1QBfzVeu=NnJy-RjNfbA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] scripts: Add a intermediate file for 'make gtags'
To:     xujialu <xujialu@vimux.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 2:34 PM xujialu <xujialu@vimux.org> wrote:
>
> As 'GTAGS Manual' said: If =C2=B4gtags.files=C2=B4 exists in the current =
directory
> directory or a file is specified by the -f option, target files are
> limited by it.
>
> So add gtags.files just like cscope.files.
>
> Signed-off-by: xujialu <xujialu@vimux.org>
> ---
>  Makefile        | 2 +-
>  scripts/tags.sh | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 679f302a8b8b..2c8304ae103f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1398,7 +1398,7 @@ MRPROPER_FILES +=3D .config .config.old .version \
>
>  # Directories & files removed with 'make distclean'
>  DISTCLEAN_DIRS  +=3D
> -DISTCLEAN_FILES +=3D tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS
> +DISTCLEAN_FILES +=3D tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS gtags.fi=
les
>
>  # clean - Delete most, but leave enough to build external modules
>  #
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index 941a5c61d343..e2edd0cf67ec 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -142,7 +142,8 @@ docscope()
>
>  dogtags()
>  {
> -       all_target_sources | gtags -i -f -
> +       all_target_sources > gtags.files
> +       gtags -i -f gtags.files
>  }

My previous reply was not sent to the list.

Here is the summary of my view.



With my basic knowledge of UNIX
such as the concept of pipe, redirect, etc.,
the following two commands should do the same work.


[1] { echo file lists; }  |  gtags  -f  -

[2] { echo file lists; }  > tmpfile
    gtags -f  tmpfile





The gtags manual also says:
-f, --file file
       Give  a  list of candidates of target files.
       Files which are not on the list are ignored.
       The argument file can be set to =C2=B4-=C2=B4 to accept
       a list of files from the standard input.



This patch looks no point to me.




As for the cscope.files, we had a reason to have it separately.


This commit:

https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/=
?id=3D3cd681bae4360e2f67ef9b232db28e13319f1c17


And, the bug was elaborated here:

https://bugzilla.kernel.org/show_bug.cgi?id=3D1948







--
Best Regards
Masahiro Yamada
