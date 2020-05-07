Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C541C8549
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 11:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgEGJCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 05:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgEGJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:02:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C896AC061A10;
        Thu,  7 May 2020 02:02:34 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so1823526plo.7;
        Thu, 07 May 2020 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOdvCBh6A+44UKKGp971PkTmgaQHFgAwFMeDcVdZ35Q=;
        b=COHtvy6f1zzYF1vbbbNV13NHaEzbqJAH9/MauFSUuDr9zh9TZx9343ZJKA2BfULDdM
         EQq8Uk4fEQeWiOHzAYGGm1Jp5MA+JVnd0M5S+XN5HMlT42NCmb+62lSNJxTgVIXcAczg
         DvMZKMpcVtAZsOITyOP5+ygSccgpoY96CKSzONfqVjtXyjVpM3h3Xt3T4G2MwzG4Vaha
         WbBHEswvzwM9vT6h3rSBp1Xn6DDbPKAyuRmgvjCbFm8uFZSIDntiQ+J4T0Cgape6v3pQ
         iydcDNNDcz6IK4moZev5Vb3ZagH2RsVhvvvoXsc47ZQ5kH+gWvFjgMfy/o+9BVLRfFZp
         rBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOdvCBh6A+44UKKGp971PkTmgaQHFgAwFMeDcVdZ35Q=;
        b=B4ostJ6RytZy+CaUTdJSl+rxKxpDmPNjI2KU3MpvrgMnbdu0Vy3Af873ZtOULkWCUB
         zggYnS62AaGRFOnotATrC5IOsi7Qpyhaabe/wDlgZv38FjRa8gVzSRmcBmD9Ufp/RuRj
         QTCiP9VTrJ9k/APizJKWBof3sY0BtgbeCBM2zdbi6uaLoMA49Pywq7p7qNU2KKtjqY2E
         5/i8VfaU/ICHx0JsclNcdw0F1EWngxyOZcu4ud7XHz9Nco8kkJzbMCwWxybWHYMrq6/+
         FImLsHnHv7BQ69LFp8vGzGsW1kcZIHBVAAHvnfOq7y/0apDYG4NIGJSwvuvbPH8u1o+2
         6RvQ==
X-Gm-Message-State: AGi0Pub4lC5OoOYPv4f40hvD0La+scVG9NiyQxCh70tEgeJ2xx0fRFKX
        8VDU1weqgdDMEBHfIrU633pvYAOuf/lT1kUJgp8=
X-Google-Smtp-Source: APiQypLWZHbZU8+59QBEQtwl+bVcAaW0wQmOMzUeCYypLH2ZTYYzmIPSKlVv+J9r6A7jmodKvM2btdr6G+cs3BlOLPU=
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr14661044pjb.25.1588842154251;
 Thu, 07 May 2020 02:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200507084932.5486-1-koba.ko@canonical.com>
In-Reply-To: <20200507084932.5486-1-koba.ko@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 May 2020 12:02:23 +0300
Message-ID: <CAHp75VfpX8dZEMkkGrpNyCRXojfvGoJEusYVpri=JCpArj-FRw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
To:     koba.ko@canonical.com
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 11:49 AM <koba.ko@canonical.com> wrote:
>
> From: Koba Ko <koba.ko@canonical.com>
>
> First, get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
> If one of two tokens doesn't exist, don't register platform::micmute.

This doesn't explain why.

-- 
With Best Regards,
Andy Shevchenko
