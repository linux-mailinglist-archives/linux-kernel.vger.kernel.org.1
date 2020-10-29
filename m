Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00ED29EB00
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgJ2LwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgJ2LwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:52:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61728C0613CF;
        Thu, 29 Oct 2020 04:52:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e15so2134805pfh.6;
        Thu, 29 Oct 2020 04:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U3m1CrvhBF5ZSjmNj0DT84Tf4MllZuPLAp7rAxUIIvk=;
        b=QbTdGARbBTH/u8+FxoM+algkxX8+k9z37QEV7DSMGJfl/VPaZif1EZtmt1UPut11q3
         EVWLS4R53NN8MF8GXNC9B53c/zMgekULAhUJDxQcaP9OhOl6hs07H/rolO1r1S8LTb6L
         U9F+u8KsQORfQ8vk5gBSX+VyhXQR+aPOP8Xfe7sqlaL/YGd74cGwFuMp5mLQI9iNPUDK
         fl8rz6zWLVtrUO2NvrehBMxmypFHFhpbeTUuExptjP2+7zm69V3jh6vgxL3cp6x3rzMq
         OhlaBmJaLka7PZD6znS+RFKyKdCHMJvxhywJci0czrWINe3bKzaJi11Gfi/QnluAy5Jj
         Qalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U3m1CrvhBF5ZSjmNj0DT84Tf4MllZuPLAp7rAxUIIvk=;
        b=nRNcpD2v/4L06ATsBDxBpBx8dbS/0nR85LXyqy49s6cw5BRipnuatxIJxmSaRwHyB5
         +C/6QmuXkx3hqtg1fxCgAoxucyzPx0U8bYgm9IKbmJFDwTgCy4xaVSaJTRPYyXXaO2sh
         fBJAjYJmF2ZKNlmQY3ft9eIgBYZXNbKAMksDiUmO0gPuWmanfjAr1uqXshnwltPuU8Gd
         Hhrxvk18ShkE78TWHBOQ6Nqg8Q/tCfE/ikGManS+Xhzi7Crh182o5U4nJEFNKqNiLNpF
         b/NYo68vhIW6vH3kq5CttdSmbaf9kijJqTIncXVeBSBxAA0p7XgXDkBnNA8gHpn3NZYR
         ck6w==
X-Gm-Message-State: AOAM532btieDmoDCzyCzFpKH7f9jPzCjxY8yS17VYx2VpRihxgAyrLi3
        8EJ8+BgNaEOCf1s6aQWKPXBV01422sD1NTx2PNg=
X-Google-Smtp-Source: ABdhPJyaBf39lMSO0TPYNh2S8KAa85eKhsXcVTmuCiVl5I8J3IMkHJ2lCrVhNke2Ju0R+sUHXoOSMyJmKC8jFQRHUBM=
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr3907925pjs.181.1603972323962;
 Thu, 29 Oct 2020 04:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <1603972048-64271-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1603972048-64271-1-git-send-email-zou_wei@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 13:52:53 +0200
Message-ID: <CAHp75Ve64EvD7_H8h2MW39dpimWbPcANZC3-zgF__yA6C7BGQA@mail.gmail.com>
Subject: Re: [PATCH -next] platform/surface: remove status assignment without reading
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 1:36 PM Zou Wei <zou_wei@huawei.com> wrote:
>
> The status local variable is assigned but never read:

...

>         mutex_lock(&s3_wmi_lock);
> -       status = wmi_query_block(guid, instance, &output);

What are you doing?!


-- 
With Best Regards,
Andy Shevchenko
