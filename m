Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7102DD69A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgLQRxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQRxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:53:13 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71557C061794;
        Thu, 17 Dec 2020 09:52:33 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qw4so39095290ejb.12;
        Thu, 17 Dec 2020 09:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qe4fPlW4MKxXKIVn9ySHT8yT8yRaN3t1O0dtrhKYy0=;
        b=PKG/lkYghDlxKIVy+OMwZ+UUf14Ku2S3sj1eC0X01Oya8jXLN22eb7o64Odk6B6jFx
         O2VTxkCyoWkl1CLZWqL48R27lPb7PBxN0za9bAcABoV3LrhkWbyFfmThuQATCKGHyH5K
         //51FoTKa3dz99UiMuNiV2xDziZ52JcQebUzKHYu62Cx793YqUtWmEsKI2UJ+hickko8
         v1m94YvOdMRofYi0K/H0jBOJHbSbYlSTvJ0nAGqZWme9pT9V7a22TN99KQpgd4Sm7UkW
         Ms7x5aoffENfZ2SPetVLjR9BwdvbPZcc7z9S5DmnzEbu16eNoeKVFkqKoVqjp9xGWGM8
         nzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qe4fPlW4MKxXKIVn9ySHT8yT8yRaN3t1O0dtrhKYy0=;
        b=Fxuu4IGjx28GoGgVlRFG85tlhfHLMP+fkxWzfHVz2yJutziaciLcS6dwBLqrFkS83K
         VB/Jl8gY6zY5mHZkdkchzSJNq7tCe9af6KjHqGI+D+yQicDXIv/LDT7LBzD+QvRLOceu
         ghn1gTD1qUPc+Q1DyEyvJTJX79LKrSpN3rGtWM1VoLCK1Gg3PcBa21mTwt/nPzpHzzNr
         1gZE02wLYrBN2S2gEo4YQPv/5HKAXAeQP4mjY3Ta1uN2lb5ME6Y0YFIomce52i+dAftq
         GtqQfN1iEp2hJEVVQZkVNThVP1mXXTlR8s6rvMr/fORwdV/YOS36VSvzQQit7jvqrRvr
         3ASA==
X-Gm-Message-State: AOAM531Fe9k7kw38i8UiRGipiSojE1YIcXiZ5tj6PKGIvApn61xf/w5G
        06ACy1ptdCIuE6ogw75QtBK1ul8qqGwx3luhzOkMz4Ct
X-Google-Smtp-Source: ABdhPJwMKSZ+KqlrwpMSngtpDvSY6fbWPcTMBpqokyWhZ274iZwTREtjVcLgvzXhdPBxicpAYekkW5NqkLeq0/muTNE=
X-Received: by 2002:a17:906:40d3:: with SMTP id a19mr175451ejk.98.1608227552264;
 Thu, 17 Dec 2020 09:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20201217172427.58009-1-colin.king@canonical.com>
In-Reply-To: <20201217172427.58009-1-colin.king@canonical.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 17 Dec 2020 09:52:21 -0800
Message-ID: <CAMo8Bf+Q3BQjjc2N=ykZy7KJ4-CYY+qpDFZmJFe1_wuxAsL2cQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: fix spelling mistake in Kconfig "wont" -> "won't"
To:     Colin King <colin.king@canonical.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 9:24 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the Kconfig help text. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/xtensa/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks. Applied to my xtensa tree.

-- Max
