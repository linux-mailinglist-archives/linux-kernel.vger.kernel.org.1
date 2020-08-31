Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D968257874
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 13:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHaL3r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Aug 2020 07:29:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39917 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgHaL2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:28:53 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1kChzW-0003Do-UZ
        for linux-kernel@vger.kernel.org; Mon, 31 Aug 2020 11:28:50 +0000
Received: by mail-wr1-f69.google.com with SMTP id l17so3086567wrw.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 04:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k+4/Yx6DeQldeglbS376dNJoVgOKnSc5ajKOtdzMws4=;
        b=e6+GbnZk8ReLcGRsLHHg19i2MK6JZPgu0/N1aB51ipJKIlL7phJWbNjlygze1PHBzU
         AMBNxPYSUJxnzoQooEzlG7PGne/dV84/+iMv/USOiKNm7XFs92PUrvkl5x2DSi5uIrFM
         VRB4IKMes+L87wXvYUWydvIteQ4UFOq+nUBFj7DlLTPj3R3qtHD1Wda6pOcUpFVTggfL
         B8tveY9ehEfWpWXH3sS7/AbToaOPCDwfRMwlt25pyfDDYR4wsppbwA+AnG7fT4Kao8xW
         Od6/w/84qmmSkaidvpjrEkA+JNndgnbQaoiF4qBQC0uyYUuYYDpKxRhKRJBiGD+caXpo
         kmZA==
X-Gm-Message-State: AOAM530UB5yDVBqdtj4QkPJJ2H2A3HpTODfp+uFCD2Vrl/kqg7C6zeQu
        1seUzfvQo+U0MjAyTTZkO4I95WPMapbm0z48emqyIpghtz2P8svPOR6jof1jnmjtdPKJS00K5LL
        JOD2QKfvnhWG/upjC7VLElbBBZc032YT+odfKJ4geqyswplJ1PG5K9OrI/g==
X-Received: by 2002:a5d:6910:: with SMTP id t16mr1345544wru.178.1598873328736;
        Mon, 31 Aug 2020 04:28:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNUaRTbjM1YE4AAR11tE2YfJvDxtl/R6uUHfYMBUE4Qb+ZRi35hOwMuCN3NIWR3kfvnlBKWAY3T3S0eBA+ytc=
X-Received: by 2002:a5d:6910:: with SMTP id t16mr1345532wru.178.1598873328545;
 Mon, 31 Aug 2020 04:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw> <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
In-Reply-To: <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Mon, 31 Aug 2020 19:28:37 +0800
Message-ID: <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     William Sung <william.sung@advantech.com.tw>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan and Andy,

This patch is mainly for Advantech's UNO-420[1] which is a x86-based platform.
This platform is more like a development platform for customers to
customize their products,
so, specify the channel modes in ACPI table is not generic enough,
that's why William submit this patch.

Are there other ways to specify or pass values to the module without
using module parameters?
It's good if we can leverage sysfs, but I don't know if there is one
for this scenario.

1. https://www.advantech.com/products/9a0cc561-8fc2-4e22-969c-9df90a3952b5/uno-420/mod_2d6a546b-39e3-4bc4-bbf4-ac89e6b7667c

Andy Shevchenko <andy.shevchenko@gmail.com> 於 2020年8月31日 週一 上午1:07寫道：
>
> On Mon, Aug 24, 2020 at 8:54 AM William Sung
> <william.sung@advantech.com.tw> wrote:
> >
> > To use ad5593r more flexibly, we use the module parameter to setting the
> > channel modes dynamically whenever the module probe up.
>
> > Users can pass
> > the channel modes to the module parameter for allocating the
> > functionality of channels as desired.
>
> NAK. We have a sysfs interface.
>
> > For example:
> > * Use in the kernel command line:
> > Users can add the module parameter in the kernel command line such as
> >
> >     "ad5593r.ch_mode_cmdline=88001122"
> >
> > "88001122" means the channel mode setting for each channel. The most
> > left side indicates the mode of channel 7, and the most right side
> > indicates the mode of channel 0.
> >
> > * Use when manually probe the module:
> > Similar to the kernel command line usage, users can enter
> >
> >     "modprobe ad5593r ch_mode_probe=88001122"
> >
> > to start the ad5593r module with the desired channel mode setting.
>
> Again NAK, this basically should come from Device Tree or ACPI.
>
> --
> With Best Regards,
> Andy Shevchenko
