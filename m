Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12C41E1FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 12:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbgEZKhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 06:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgEZKhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:37:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72338C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:37:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z18so23814139lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFAkmo/3cdktHlOyxHVabozodlR2MwWYHLZY7n5aStQ=;
        b=UILgeofNTbfLZpZnyu/Ay1mqGxtWW0ZZ6cAk34g7BwBMaDbf0LVZBZvLI2QsLJvXnf
         mnTqgr4ULcAja1d72GrBYGp5w50D+Ear2BwAp4oeG+59fubr+aYKgsVd3fhTiBFbl2cv
         lAvY8OBUPsb+LxDm2LvDtVPIwSVWechKtvNbjBQ83zRdzz5UyFA0LoluoD+A3Y5Pjh1D
         rcV4vuORjEFo6Q/v1YpEhqYjdJHfTN0Uiyt6quZ1LK0Dw0HCdKLlXN7B5SBZG6UQjI+f
         pKrPSVmlEcjIdBUScKwavMUrxMsEPI3SSMJ+mELZkSrwTShPmdnEd/DBuf/tGGp7ob41
         5/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFAkmo/3cdktHlOyxHVabozodlR2MwWYHLZY7n5aStQ=;
        b=s4zeo/VQsy3pqxxVnFeDD3bWMQ98tQGWgE6H/9qX2m0SDAc1c1F1XooHmr0jXRB6O+
         yvnNnWdbyyG6Te15Zu3u80VvcWwkihopD6wklTvfl7Xvzb/p0OnStx+ln/vM3yYJXPjP
         h/Dt9k6pClmepC0wd4jHquw2hiUyFf6lmIKCR02INVPCIYprIxm5o0cRkWunqq96FlJS
         wK9hjj2iWrGY7BOO1sivU/etanC/WBKOAGR+ngAgCNuHH0b0ndadDSSnlRYLcVtH+FXd
         fHQj45NFOsVvg1sxFftgbgG0oZRGCMhNmG/l9zeMQuel7jU1/HbCDS1jmCi0mHjtN+Qn
         iL5g==
X-Gm-Message-State: AOAM530IHb8rXi1qGJa9iLFtjScTuSjLy+XmpazqV7o+2ObFh+LKA+Sc
        2j3J3vSmkQztWk4Hlvhx4gxdr/TNgYM0PdhWhQfaIg==
X-Google-Smtp-Source: ABdhPJy3vsaxtZM/4U4n6ugafhhOKAb4R7zuKibi+T/spqxAZX0b333XfjK5j3qjGwJqR3yQ/djKhbSNgw6Owtcl/E0=
X-Received: by 2002:a2e:2204:: with SMTP id i4mr338122lji.110.1590489465850;
 Tue, 26 May 2020 03:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200525115235.5405-1-maxim.uvarov@linaro.org>
 <20200525115235.5405-3-maxim.uvarov@linaro.org> <7de3fea9-cd88-4dbf-aa27-3cb188fd6e85@forissier.org>
 <CAD8XO3amGVeyn9qsWE-AyGM=e36ubwxC4tiwGMVHYBL6E46ZhQ@mail.gmail.com> <4be64892-e027-a58d-09f5-0450088292f6@forissier.org>
In-Reply-To: <4be64892-e027-a58d-09f5-0450088292f6@forissier.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 26 May 2020 16:07:34 +0530
Message-ID: <CAFA6WYN7d=wEY_4wRmG4p5dBHHL1+0u8i5=uf6xZgv1UJsSgEA@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv3 2/3] optee: use uuid for sysfs driver entry
To:     Jerome Forissier <jerome@forissier.org>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 at 21:24, Jerome Forissier <jerome@forissier.org> wrote:
>
>
>
> On 5/25/20 3:36 PM, Maxim Uvarov wrote:
> > On Mon, 25 May 2020 at 15:10, Jerome Forissier <jerome@forissier.org> wrote:
> >>
> >>
> >>
> >> On 5/25/20 1:52 PM, Maxim Uvarov wrote:
> >>> Optee device names for sysfs needed to be unique
> >>
> >> s/Optee/OP-TEE/
> >> s/needed/need/
> >>
> >>> and it's better if they will mean something. UUID for name
> >>> looks like good solution:
> >>> /sys/bus/tee/devices/optee-clnt-<uuid>
> >>
> >> How about mentioning it is the UUID of the Trusted Application on the
> >> TEE side?
> >>
> >
> > Jerome, do you think optee-ta-<uuid> is more suitable here?
>
> Yes, a bit better I think. More "self explanatory"... kind of :)
>

+1

> Is it possible to have several devices bound to the same TA? I think
> nothing forbids this although we may not have any use case for now...
>

A single TA is represented via a single device represented via UUID on
the TEE bus. And I can't think of a scenario where the user may not
want to split the TA so as to support a particular driver in Linux.

-Sumit

> --
> Jerome
> _______________________________________________
> Tee-dev mailing list
> Tee-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/tee-dev
