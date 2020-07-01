Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A3A210F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbgGAPrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 11:47:35 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:59015 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731519AbgGAPre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:47:34 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 061Fl7NF003090
        for <linux-kernel@vger.kernel.org>; Thu, 2 Jul 2020 00:47:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 061Fl7NF003090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593618428;
        bh=DAwQW/iKms2Pd5SxjfNrAxgMBpgB3wuUDGSw/2ikg0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WfcpXwhMfxGovAbt204Xh7ug7fFQv5h2nEgLS7kG1ZYqP0/YsTen/hhpvAC42YsNF
         jz+Jkf8NBaON4pyr/0CG6aaDEx0v4Gz74hE02pdfCBc+zEaoAsdk2sl5QmRlSALXSW
         NAQYS+KbYev9G5ZN/0B1IzM0gJwI2e9w/BkOtyt6jpNqjq5E1YjFDD02hq2F2cuPhF
         N5T9/Ov8F0gBDP2IVH03iU5KcSEKdjUPu11NaCvf3rFb7K5RSCPIPbUOVVOZEzpaiT
         l6xRv+F7T6SZxcgfen1PqssSjNW+ZOXoajNf7iWNnTY0ElkBZLBTzJSEFy32m6441L
         +3Meic2THJV/A==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id x13so8813758vsx.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:47:07 -0700 (PDT)
X-Gm-Message-State: AOAM531NDjFfWpC5yt6IgfD9hOvFWAnZlrrurXxfzlBIBe4AB7t0tny6
        VXmigs/De2HoRyWjZ4CI+SB5zwbFS9HIoX3C9ts=
X-Google-Smtp-Source: ABdhPJzB1vl8xD2N6vsVCpQAw+0Y9VboCtD5BhKxqQPhn3odFuKVp7dIo0dsORdnOtk8/amr/wIne1V8Q7+nUvvXNnY=
X-Received: by 2002:a67:22c7:: with SMTP id i190mr19510608vsi.179.1593618426679;
 Wed, 01 Jul 2020 08:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200630142653.10375-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20200630142653.10375-1-pmenzel@molgen.mpg.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 2 Jul 2020 00:46:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ79EYXMgRC2uexXAbgA7uUa7SoMKu+00qRvqJCv5+C1Q@mail.gmail.com>
Message-ID: <CAK7LNAQ79EYXMgRC2uexXAbgA7uUa7SoMKu+00qRvqJCv5+C1Q@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: Do not track `defconfig` from `make savedefconfig`
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 11:27 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index 87b9dd8a163b..5c1a5349852b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -142,6 +142,7 @@ x509.genkey
>  /allno.config
>  /allrandom.config
>  /allyes.config
> +/defconfig
>
>  # Kdevelop4
>  *.kdev4
> --
> 2.27.0
>


all*.config files are used as Kconfig presets,
but 'defconfig' does not belong to them.



Better to update the comment line above?


For example,

   # Kconfig presets

-->

  # Kconfig presets, savedefconfg output





--
Best Regards
Masahiro Yamada
