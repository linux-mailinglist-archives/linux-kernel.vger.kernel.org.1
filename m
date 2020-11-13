Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2182B2B27A4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKMWDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgKMWCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:02:39 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9212CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:02:38 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id r9so16247892lfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3s0XYpB+iDmnXe4S8Rs1cHa6g/+ZRuknf+qRo53qb/Y=;
        b=gfvziIJecoQVPSaPSyY8jD51dugBWXmTbQuExeCPBeLgrojELeOnDefXaLiK+aowe1
         OB+FGAPdbSA8Rc8eYIr6eHHH41bOY7UdeVWnAHXxhl7dALTeEUz11ERUJW+3B3aUaG7v
         H3DPC4inaLk56ou2rBmz1VjDI9fXiBr+JAATNWiBD4j3Llnk6mtWbB/aJ4U9ouzMlRno
         pJh2w5z/gYr26jK91BfEh+88qCWmXuJVFtwwKiu/J+D7Bqp0L+Bh6PPLB1BF9HDZXrsU
         SfXH29OItgWFouL6qNPe559nl4Bz6JM3dRVVlaMH7PRJDi1hCs+54RDXxQ2EIrIq+hkR
         /WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3s0XYpB+iDmnXe4S8Rs1cHa6g/+ZRuknf+qRo53qb/Y=;
        b=W3FwNurPLb7SHW6JRlnLDYFEi6dkW6Fi4JcTkyDjsaddS/HmwADrp/2Ojh7vK5ex1y
         ZiSt9QDptah31dePqkuh1AxrFLtqQ+dHtt1rreJFPrrah9usqiyGEEYjPJNlByM5RO0X
         kRi2m284cAgrL+73oivaSS370fjvzy9oFVRiDLkSuGHC5EVRNQtveUmpE0+pmx+oyj0L
         UpzxIypeX/SIKo1iUnvzmcoINxkj+kexBRKqFwMdNoZLfEnjT34k2P0OTxgByhc6MEK+
         heA6EwkmYHYd2z28eEN5Ozz5/yjHO2Rv0z8ixmnABdwpBGa12Lq4AnzbJOTnV5e4/pD3
         j3MQ==
X-Gm-Message-State: AOAM531yaIoWmj+RfdiegD0/c8N+p399Ik0pYPrgMQT2c9L7YD/kPW/0
        fbvVAQ5fpULYBl2c8MMnm56BNRrUoz86XOwyTaQm7g==
X-Google-Smtp-Source: ABdhPJxAQ5huJTre5xVC9zvJxXQwQ9C2Ubnw8oc4vi8tdZGWGcVHRnEBCc7twqMcLiaDDoNQ4ejwGC1bLtusztLwq5k=
X-Received: by 2002:a05:6512:304f:: with SMTP id b15mr1574846lfb.411.1605304956666;
 Fri, 13 Nov 2020 14:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20201113205233.827493-1-rkir@google.com> <20201113210730.GA1992396@bogus>
 <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com> <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Fri, 13 Nov 2020 14:02:25 -0800
Message-ID: <CAOGAQepCsj63yZzJJHKCdHTenkWNLc_v=Ab6PgvS3hzqZMwH8A@mail.gmail.com>
Subject: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
To:     chenhc@lemote.com
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hancai,

I see you added /arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dts which
refers to goldfish-rtc in 39c1485c8baa47aa20caefc1ec0a3410fbad6c81.
We (Android Studio Emulator aka "goldfish") do not support MIPS anymore.
Do you know if goldfish-rtc still works and is assumed to be available?

On Fri, Nov 13, 2020 at 1:18 PM Rob Herring <robh@kernel.org> wrote:
>
> > > What about the binding and MAINTAINERS?
> >
> > My bad, I will update those files too.
>
> Though the binding is still used in arch/mips/generic/board-ranchu.c
> and arch/mips/boot/dts/loongson/loongson64v_4core_virtio.dts. The
> latter was just added recently, so maybe premature to remove things?

Thank you for catching this.

Regards,
Roman.
