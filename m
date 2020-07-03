Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F2D213D01
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 17:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgGCPwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 11:52:06 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:50788 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCPwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:52:05 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 063FpcNj015275
        for <linux-kernel@vger.kernel.org>; Sat, 4 Jul 2020 00:51:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 063FpcNj015275
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593791499;
        bh=51tucxibSjG/vcrCdMCH60KzYwCL1PgdJ6jbgVRQifY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MEupVjsriDZecANC9FJeD+kABwL7+k0nSlQoC24o76msC3knHNeXyVocc2Jey5n7z
         rQc+6aVv/Ys/MbSpBUdr7QBxcsn9gWkuDIcnfHn+YnyCDNNrE/c6mw6TVW1nh3qIuM
         niWL4kp9OuLHfC8PDnyddpPnnJTzoernW80Ay4lpnHn5+Hsgba/3LpvPMdoWd76m6B
         b81HzXXAEL7ZPmrkEm23ufuMaZXch17YP4ITBJVa5n/dlVXjPPww6vb4BKTSZp/Pcg
         BDFtDtCOmHPLaFV2Igpm4IOyAoz5clS5nlTS7R2luTqk4QLmT6/OiR3QQmQpD+GAzM
         Ptt6eecyBzepA==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id g14so10164481ual.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 08:51:38 -0700 (PDT)
X-Gm-Message-State: AOAM530oOxMC/KTU7TXxrpGOX3j2mzau3pihItdLvEeloh8glboL9HJE
        2wOUBkmdz3cuFqsD9rFZB+5syIXBOj2t/7nYx3Y=
X-Google-Smtp-Source: ABdhPJyT7fhqA+I4r5LSZbfunMR0o/i2tAjn0jM39F/L3/nl8YS2I+40eYU4Q5AL4JzZBdVCzg5QzP+R0VghsbOwDiI=
X-Received: by 2002:ab0:21c6:: with SMTP id u6mr10250368uan.109.1593791497745;
 Fri, 03 Jul 2020 08:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200702111200.39997-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20200702111200.39997-1-pmenzel@molgen.mpg.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 4 Jul 2020 00:51:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNARM8VWVA4g7S03nRVTcpdw5nL_HpuxN4=VU8-wihF17xg@mail.gmail.com>
Message-ID: <CAK7LNARM8VWVA4g7S03nRVTcpdw5nL_HpuxN4=VU8-wihF17xg@mail.gmail.com>
Subject: Re: [PATCH v2] .gitignore: Do not track `defconfig` from `make savedefconfig`
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 8:12 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Running `make savedefconfig` creates by default `defconfig`, which is,
> currently, on git=E2=80=99s radar, for example, `git status` lists this f=
ile as
> untracked.
>
> So, add the file to `.gitignore`, so it=E2=80=99s ignored by git.
>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  .gitignore | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 87b9dd8a163b..f07500889fba 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -143,6 +143,9 @@ x509.genkey
>  /allrandom.config
>  /allyes.config
>
> +# Kconfig presets, default savedefconfg output


I fixed up the typo, then applied to linux-kbuild. Thanks.

"savedefconfg" -> "savedefconfig"

(sorry, it was my typo.)



> +/defconfig
> +
>  # Kdevelop4
>  *.kdev4
>
> --
> 2.27.0
>


--=20
Best Regards
Masahiro Yamada
