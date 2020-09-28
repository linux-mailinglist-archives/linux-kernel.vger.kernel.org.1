Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7127B3B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgI1RxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1RxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:53:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C6AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 10:53:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id bw23so1108379pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VcSWQzeN0AmLIOeU7lVRuYXohJfDxAJkBb+mWUpJkbY=;
        b=A8zjOf2CHIC4ACdMhPKQ91cY8IlwMxNJpeNacR3FNI5TEmGOoO8iEVoYnx9tPBal27
         pWK+MZGfSZZN71hlQSNP+L32f2n5PXNEbyDI1mxQ2U/Usy/6hjZXZtnC1FZMxXaiK4FG
         wr8wQVHMwTpsdGmKwI14kLq/ciytADMApen7xfPEQ2RqKWEE6V7Hnbyj88ZIWlw/Uilm
         fbFOYhWPIdI5XGoEBnr9DcEcGOptQ7ODBk0YsN7Gr/1iQ5K4e0qov+Xy0z1HvLLdsBvA
         dP6h9ZmyCy+0OXz19yK2iedDKbz4/pQRu14na3ncX2sdoWIxWhwQns75sSzwdo0fJpTs
         7wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VcSWQzeN0AmLIOeU7lVRuYXohJfDxAJkBb+mWUpJkbY=;
        b=mg8EKltAKj9RP/xlLMZFPAlpHi2IV1As5JXlpHrLwnxfDq0h+O6jwyadF93qfUkKuT
         tQ6GDz8fxN3I7xx6Hw0O6pV2MhS+E236340rAaGXbBskmJK0y/1/dF1sXtiFy/NYaC7P
         SpnVZx9Bna6fpgI0NHAA2StsrCHDTyIfZKGXXt5atpgqzVCbDU6lZdDOhPMJXGJMtOib
         KFEbHlDkfLzRqfH6H9qV++CEvrbMmi4p33RYJQjehbOR35BqzbXVervoxjYRLx5wq7nU
         IGmTl4nJUHvscyFlpjwF+MPR62DNLcjLFY3b/KsoQOPdm5DFNJNXOXTrA8UXtFmOxXIl
         x0NA==
X-Gm-Message-State: AOAM532dCzXw333QhOrodwe2DLbpQr5DQNPVHS+S7v+KvV+fSFgPvpiP
        Yj2QVtiu3MzPLE0pnHI3Gy7F7H9va/Eqfnbd1BmuVA==
X-Google-Smtp-Source: ABdhPJyycyoHB8lSUDQdJQ5lxUPgHn14tkpu6dc71wMMTiF7vAMBRkZ7ouDDaRK2MgjbyjwsMQbOuNzRNyjzd8zxusQ=
X-Received: by 2002:a17:90a:e517:: with SMTP id t23mr371035pjy.25.1601315585940;
 Mon, 28 Sep 2020 10:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <202009271553.4OjMpGkX%lkp@intel.com> <76cae106-b643-57a9-e82e-48e46ebf1b70@ti.com>
In-Reply-To: <76cae106-b643-57a9-e82e-48e46ebf1b70@ti.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Sep 2020 10:52:54 -0700
Message-ID: <CAKwvOdnsQY6S+3zAH6_SD0ifbUaSDFj9mBdhF4GVq6VB=tjFsA@mail.gmail.com>
Subject: Re: sound/soc/ti/j721e-evm.c:528:34: warning: unused variable 'j721e_audio_of_match'
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 12:27 AM 'Peter Ujfalusi' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
>
>
> On 27/09/2020 10.27, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   a1bffa48745afbb54cb4f873bba783b2ae8be042
> > commit: 6748d05590594837e42dfa975879fb275099f0b2 ASoC: ti: Add custom m=
achine driver for j721e EVM (CPB and IVI)
> > date:   3 months ago
> > config: x86_64-randconfig-r033-20200927 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project a8=
3eb048cb9a75da7a07a9d5318bbdbf54885c87)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install x86_64 cross compiling tool for clang build
> >         # apt-get install binutils-x86-64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D6748d05590594837e42dfa975879fb275099f0b2
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kerne=
l/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 6748d05590594837e42dfa975879fb275099f0b2
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
ARCH=3Dx86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> sound/soc/ti/j721e-evm.c:528:34: warning: unused variable 'j721e_audi=
o_of_match' [-Wunused-const-variable]
> >    static const struct of_device_id j721e_audio_of_match[] =3D {
> >                                     ^
> >    1 warning generated.
>
> Right, in the attached .config:
> # CONFIG_OF is not set
>
> There must be a clean way to handle this without extensive ifedfery...

Pretty sure I just saw a patch go by wrapping another device table
definition in #ifdef CONFIG_OF, so it's not unusual.

>
> > vim +/j721e_audio_of_match +528 sound/soc/ti/j721e-evm.c
> >
> >    527
> >  > 528        static const struct of_device_id j721e_audio_of_match[] =
=3D {
> >    529                {
> >    530                        .compatible =3D "ti,j721e-cpb-audio",
> >    531                        .data =3D &j721e_cpb_data,
> >    532                }, {
> >    533                        .compatible =3D "ti,j721e-cpb-ivi-audio",
> >    534                        .data =3D &j721e_cpb_ivi_data,
> >    535                },
> >    536                { },
> >    537        };
> >    538        MODULE_DEVICE_TABLE(of, j721e_audio_of_match);
> >    539
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
>
> - P=C3=A9ter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/76cae106-b643-57a9-e82e-48e46ebf1b70%40ti.com.



--=20
Thanks,
~Nick Desaulniers
