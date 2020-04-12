Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453C81A6000
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 21:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgDLTYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 15:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLTYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 15:24:08 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2079C0A3BF0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 12:24:08 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 03CJNmXV015715
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 04:23:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 03CJNmXV015715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586719429;
        bh=NMozP3DYwt3NE7LQJWa1rj0X2R6il1LXjzmgjQnxUbk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bgCfyXJmIovSQ0gSE2ssQaeO5duSl26FbvO2fIug0KlEqjTUKftwCvLf0ZbCxX/1j
         lqmLwzwNIW3uUiQ3pgftGSjSO69Nj8LclLyIB1igmsQfHxhLrlJ2A4c2/JYHvYVt1p
         fNi0yxpBDMaFmW5IE0noaPWKaOmNavyZ//Z/MC1vNp5ICv2uc/2PsVhpHT51O3Hzpf
         W7u474au0KYQU9C6IhJRhhuosV4woUiSb38Tn7PxjIpRlPAcArbuETuqKvHgO1ohdf
         EMBwjEijQXVEXX9aUXs2LdJVl/vxNxAYVMZeFgjLd0ifP+1CldyLZI+1fZab7jN+kP
         yHEp7EPEfGaaQ==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id l5so1783976vko.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 12:23:49 -0700 (PDT)
X-Gm-Message-State: AGi0Pua9kLimde7PteB90+E7QajAChnrUmQ7AOfnYbH41NKEk1fJcD7M
        89LKbOMtXCf+mBxROosbDm9adGnA42NIu3yWfa4=
X-Google-Smtp-Source: APiQypJseq22CKkD2zXqPBsNkgPQaV+1ABsu7rpd2uGY+yTFtz30aO5h5CmCBthEKxo5sPtVmMTHomRDdedF3H8mMJ0=
X-Received: by 2002:a1f:d182:: with SMTP id i124mr8779268vkg.26.1586719427938;
 Sun, 12 Apr 2020 12:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200410165741.27078-1-jeremie.francois@gmail.com>
In-Reply-To: <20200410165741.27078-1-jeremie.francois@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 13 Apr 2020 04:23:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7R3LW2ZLRJNHyRqcyWfkz5UiSRaw059sgSSe5qRG=cQ@mail.gmail.com>
Message-ID: <CAK7LNAQ7R3LW2ZLRJNHyRqcyWfkz5UiSRaw059sgSSe5qRG=cQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/config: allow colons in option strings for sed
To:     "Jeremie Francois (on alpha)" <jeremie.francois@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 1:58 AM Jeremie Francois (on alpha)
<jeremie.francois@gmail.com> wrote:
>
> Sed broke on some strings as it used colon as a separator.
> I made it more robust by using \001, which is legit POSIX AFAIK.
>
> E.g. ./config --set-str CONFIG_USBNET_DEVADDR "de:ad:be:ef:00:01"
> failed with: sed: -e expression #1, char 55: unknown option to `s'
>
> Signed-off-by: Jeremie Francois (on alpha) <jeremie.francois@gmail.com>
> ---
>  scripts/config | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/config b/scripts/config
> index e0e39826dae9..d365081b60b2 100755
> --- a/scripts/config
> +++ b/scripts/config
> @@ -7,6 +7,9 @@ myname=${0##*/}
>  # If no prefix forced, use the default CONFIG_
>  CONFIG_="${CONFIG_-CONFIG_}"
>
> +# We use an uncommon delimiter for sed substitutions
> +SED_DELIM=$(echo -en "\001")

At first, 'echo -en' caught my eye,
but this script is always run by bash.
So, there is no portability issue here.

Applied to linux-kbuild.
Thanks.



> +
>  usage() {
>         cat >&2 <<EOL
>  Manipulate options in a .config file from the command line.
> @@ -83,7 +86,7 @@ txt_subst() {
>         local infile="$3"
>         local tmpfile="$infile.swp"
>
> -       sed -e "s:$before:$after:" "$infile" >"$tmpfile"
> +       sed -e "s$SED_DELIM$before$SED_DELIM$after$SED_DELIM" "$infile" >"$tmpfile"
>         # replace original file with the edited one
>         mv "$tmpfile" "$infile"
>  }
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
