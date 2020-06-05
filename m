Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC021EEF32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 03:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgFEBmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 21:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgFEBmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 21:42:38 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE55AC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 18:42:37 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id t132so4436987vst.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 18:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5ypsurKn6EPPW0g1fbnIZOkTknD4rOPJcEpT9vTQck=;
        b=HffCxMdymASad9VyvMn/2LNf5v56Dj+53oolcX6jkBuJFGkFou2hGGiXSQfqGBOmNm
         HVEWDNLljg2ISFqqel2e/W5bnjMEvy3YskA1uOcGblTVNrCvGqzmgYhvPPo9mdMM7heK
         SLkKGObs2MrKOK4IxHgkDx7gnhF7q1R+N2MBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5ypsurKn6EPPW0g1fbnIZOkTknD4rOPJcEpT9vTQck=;
        b=Uglkjh527w4vEeAvxvv5qNvpbiJ4pHV/RZSan6wNspBi/RDvO/p3Yf6ZSXdN/1+biY
         56fNMDXJlkRzTCgfnAuqYqhlM4p9yUBnwlZ+tLx+CAwfTStmBbGsm0EWQ/+MFTIf8ZWx
         0pf0HJNrfiEd6HFBJWbTQ1Ur/15r6Ww813JpD/jxk6/EADw23IWEcPreEKGKdNuP2Meb
         HTiqrSW9di5DTqlpdW1Fp17/2ppIOXFFpaObj9mnZ2MPj9jj5LJZkiDMItyarw1grLQ+
         1ZGNtXh5b5AiPFxhDYvvsYFn/RmoColQiL8j8iMSIrNQrtB+SIGMzAgHuXOW/THx8oHa
         2IlQ==
X-Gm-Message-State: AOAM530rdRgPARA2rsXwKBKiffHmbTEjCG0L5ob1lWNmJIpea7vh8cEy
        1SN+rZAW3ndIypHBNHrB6kVpBHXEX8Q=
X-Google-Smtp-Source: ABdhPJyynLYDSPx2mTRBja8UI8WHu7pHGaw4T/yrowaddhVkqihk9oPI5lnnLeddepdxGXqAdQoESg==
X-Received: by 2002:a67:2504:: with SMTP id l4mr5433713vsl.228.1591321356853;
        Thu, 04 Jun 2020 18:42:36 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id m184sm943484vkg.51.2020.06.04.18.42.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 18:42:35 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id q10so1841889vka.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 18:42:35 -0700 (PDT)
X-Received: by 2002:a1f:5e51:: with SMTP id s78mr5587128vkb.59.1591321355196;
 Thu, 04 Jun 2020 18:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200602052104.7795-1-lukas.bulwahn@gmail.com>
 <828311d2-61ea-42cb-1449-a53f3772543d@roeck-us.net> <CAODwPW_oxDxF_5-icRs0eaRVLgtP+bDc_OSKa=EcfeSp=c6Fag@mail.gmail.com>
 <CAKz_xw0Tqr-idoZbNzg_didSCr5L+L1=76xjF=Sqj4DgpL9g7Q@mail.gmail.com>
In-Reply-To: <CAKz_xw0Tqr-idoZbNzg_didSCr5L+L1=76xjF=Sqj4DgpL9g7Q@mail.gmail.com>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Fri, 5 Jun 2020 11:42:09 +1000
X-Gmail-Original-Message-ID: <CAKz_xw3KuWFSkcz-9hLHGZ2=S7nJ=K=AN6j2FJ6afZBFowJO7g@mail.gmail.com>
Message-ID: <CAKz_xw3KuWFSkcz-9hLHGZ2=S7nJ=K=AN6j2FJ6afZBFowJO7g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: rectify entry in ARM SMC WATCHDOG DRIVER
To:     Julius Werner <jwerner@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICT this has now been merged upstream, I'm not sure what action to take:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5c24a28b4eb842ad1256496be6ae01bab15f1dcb
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=72a9e7fea5866fc471fda78f05f166595c8c6ba6

On Wed, Jun 3, 2020 at 9:22 AM Evan Benn <evanbenn@chromium.org> wrote:
>
> Apologies for that slip up.
>
> Reviewed-by: Evan Benn <evanbenn@chromium.org>
>
> On Wed, Jun 3, 2020 at 6:16 AM Julius Werner <jwerner@chromium.org> wrote:
> >
> > Reviewed-by: Julius Werner <jwerner@chromium.org>
