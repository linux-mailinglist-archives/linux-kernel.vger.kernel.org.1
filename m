Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C32999E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 23:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394813AbgJZWv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 18:51:28 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42200 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394700AbgJZWv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 18:51:28 -0400
Received: by mail-ua1-f66.google.com with SMTP id f15so3388713uaq.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 15:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=19k3R6N9Mjf8/fy6EgCnmozd0vTjcVDdUyOxd/Efois=;
        b=Xzdx9ayiwtEuil1EnIQHZmAft9rvmOipRojP7rR3Fnk/see8OvPnyG1nbyIFQHlYbp
         kQfz4zASOQYuOXi9MKYgpoj06g8IVWj80iDvbVi2c8ClU8zEfrXtCRj4r/dsU5vRazpK
         h0ku93hW4MFhYyb3VCN2IcBlvAI2kEcKai1Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=19k3R6N9Mjf8/fy6EgCnmozd0vTjcVDdUyOxd/Efois=;
        b=ZIntPvLVNWWHpHRMTaKyNXtUlBzxBSxzB7iw+9UgTcQdWPJEWsu+kwvoQUPVzEw+sK
         GLUq2BMPsfhu2aFjOCkx4MlWCOKKfAGfYcoCzr75GTYzZFJPsbvvdz3E1rEz49EE7De8
         1A223ZXyW0YmK9eEY+BqnJaOso0uNvHJx1mA6nGGy4IYJPfH39Mm6+fKR52Qw9fgDhFO
         gN+6Fog6lePVTt+Ze2T394KPrL9M3AImpvbNIdVw8iaL+dRsOeX6qoK34PFXvtJqm14A
         9pohdnwwWqzNqaA/m4CUrePF6JxRHKqU0bWkqkWSmZRCNL2oBnbO2MNOB3kliekY9v2N
         EeIg==
X-Gm-Message-State: AOAM531SqkyR3TGAZtFZIUZhLA4lDEEyoD/64dOc4oLD+A/YirBvkTBd
        pYL1MyUwd3fl3/ChvPgxubuaxylmV1K8Qg==
X-Google-Smtp-Source: ABdhPJysURSwNTkRgqmB/cRPoTpxUShQi/c9KluKp0O5EJHRgqGDDAUcmTo6oGQkRAaEtcuFfq7OuA==
X-Received: by 2002:ab0:5e95:: with SMTP id y21mr21543942uag.21.1603752686566;
        Mon, 26 Oct 2020 15:51:26 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id e9sm1467362uad.20.2020.10.26.15.51.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 15:51:25 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id n18so5718257vsl.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 15:51:25 -0700 (PDT)
X-Received: by 2002:a67:e3b9:: with SMTP id j25mr17631109vsm.37.1603752685047;
 Mon, 26 Oct 2020 15:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid>
 <CAD=FV=Xv7Usev=S_ViWPPsa0xL42KDymjEkqJF7S4CzDiuxP3g@mail.gmail.com>
 <CACTWRwtqcMxZKhDR-Q+3CyOw0Ju=iR+ZMg2pVrHEuzbOUebjOg@mail.gmail.com> <001a01d6aa24$6ceaf390$46c0dab0$@codeaurora.org>
In-Reply-To: <001a01d6aa24$6ceaf390$46c0dab0$@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 26 Oct 2020 15:51:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X5cVdMq9H+cABHmscZvJpswqGZONjqv7FL8kqRNvuHnQ@mail.gmail.com>
Message-ID: <CAD=FV=X5cVdMq9H+cABHmscZvJpswqGZONjqv7FL8kqRNvuHnQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: add option for chip-id based BDF selection
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     Abhishek Kumar <kuabhs@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 24, 2020 at 9:40 AM Rakesh Pillai <pillair@codeaurora.org> wrot=
e:
>
> >         if (bd_ie_type =3D=3D ATH10K_BD_IE_BOARD) {
> > +               /* With variant and chip id */
> >                 ret =3D ath10k_core_create_board_name(ar, boardname,
> > -                                                   sizeof(boardname), =
true);
> > +                                               sizeof(boardname), true=
, true);
>
> Instead of adding a lot of code to generate a second fallback name, its b=
etter to just modify the condition inside the function =E2=80=9Cath10k_core=
_create_board_name=E2=80=9D to allow the generation of BDF tag using chip i=
d, even =E2=80=9Cif ar->id.bdf_ext[0] =3D=3D '\0 =E2=80=9C.
>
> This will make sure that the variant string is NULL, and just board-id an=
d chip-id is used. This will help avoid most of the code changes.
> The code would look as shown below
>
> @@ -1493,7 +1493,7 @@ static int ath10k_core_create_board_name(struct ath=
10k *ar, char *name,
>         }
>
>         if (ar->id.qmi_ids_valid) {
> -               if (with_variant && ar->id.bdf_ext[0] !=3D '\0')
> +               if (with_variant)

Wouldn't the above just be "if (with_chip_id)" instead?  ...but yeah,
that would be a cleaner way to do this.  Abhishek: do you want to post
a v2?

-Doug
