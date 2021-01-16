Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB42F8EB1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 19:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbhAPSfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 13:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbhAPSfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 13:35:02 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16945C061574;
        Sat, 16 Jan 2021 10:34:22 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id u17so24811891iow.1;
        Sat, 16 Jan 2021 10:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haCNNMLEdzsVTpRh+QKEOezUp3vmDWCORLXoscT61rg=;
        b=LLaT7umahNBRF/yvo/DrQ0/nyLC2UPJi2OXHwmC6xZihlYi4mQz253mbEn1qFHVCse
         xWMOF5lSDia7aNDzjDeUDWikpNM8g4dTd2xY454uYTDVp454GQk3sumuGpM7xEz9Edu9
         DWWw0oau5/H6RAGsfziTbIDHnNFlr1yJD0CJ/p7uQdMU1RO2kA5514mwGn9dgGMdNf2T
         npKmIepaoNcvnGO6WLo764f4VnfSHApdqijEVcMPVbtxd3RVRPcuAf35oKXDBxxbicnp
         cS4xNGxfhW+pqo/lHMixjc0XluPqHfKmrwQWlmzB6YN2B2Jd7PYqkaH06T/7YCaAQuyB
         eVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haCNNMLEdzsVTpRh+QKEOezUp3vmDWCORLXoscT61rg=;
        b=lEhpaU8BbaFh4tQso8MPmchTV7d49G+UCrsJIOsh7Iw3eFzPu5fSxkWhI3Tdr9VzWE
         0/OVEfhe348Vx6TUGrb8p9tr6Nmlh4/LZnViv1MWTpPUdQkPGJ7gt5pDRdNulLxSbZ8T
         SzpRraVHIFVG4mzjcveWVFvIc3J5GYlMzpxp+vY0lkk44Jr9hXr5oT0X13+C7skmaVBx
         bTiamLIHlzcegwedDuUz/wc8OdpDidvhf56USxlMm4OKP0Ki+mJhgp5DIlSF9ZBj0RfX
         HH5bPKdX+OZsbKQs/6+skKrmFLC5cJ1g/ig+XKL5REeE9EvlTGXvo9I0h1H7TCHnLy7u
         G2zg==
X-Gm-Message-State: AOAM532IZCLKirqsgSBnsb8GHViF/LMb0Mb3uvvd7WDC6rNNPZ/PhTOt
        V8zBIN7uzpwFBE+EXH1YPcAGHVI8BkAa2PLdfPzpbY9TYzBoI6Yp
X-Google-Smtp-Source: ABdhPJzpQNemTcMpDSUTGQzNMPMHsJF5ft+33M2D6OUvkLVfT2AZy8C0p6fW2I5l4pxXAkh5/fFyqJc7d2Anka1uVT8=
X-Received: by 2002:a92:cd8c:: with SMTP id r12mr15390669ilb.221.1610822061262;
 Sat, 16 Jan 2021 10:34:21 -0800 (PST)
MIME-Version: 1.0
References: <1610817523-6789-1-git-send-email-glqinhongwei@gmail.com> <40f475e1-2352-5bc5-3823-ddc40de3299e@web.de>
In-Reply-To: <40f475e1-2352-5bc5-3823-ddc40de3299e@web.de>
From:   Hongwei Qin <glqinhongwei@gmail.com>
Date:   Sun, 17 Jan 2021 02:34:10 +0800
Message-ID: <CAKvRR0QXuETjF3zMb_CBPhGt9h_WeYp8y3TVL7fK4FvS8hqQqA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gSW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIHNob3VsZF9jaA==?=
        =?UTF-8?B?ZWNrX3JhdGUoKSDigKY=?=
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Makus,
My apology for sending to the wrong mail list. Please ignore this
email. I'll reformat it and send it to the fio maillist.

Regards,
Hongwei

On Sun, Jan 17, 2021 at 2:10 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > This patch addresses the issue by not checking td->bytes_done in should_check_rate.
>
> I suggest to improve the change description.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=1d94330a437a573cfdf848f6743b1ed169242c8a#n89
>
> Please choose a succinct patch subject.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=1d94330a437a573cfdf848f6743b1ed169242c8a#n569
>
>
> > +++ b/fio.h
>
> Do you refer to a header file from a special repository here?
> https://github.com/axboe/fio/blame/4008b7fc8e2bff60a4e98de0005e6bc71b1a8641/fio.h#L765
>
> Regards,
> Markus
