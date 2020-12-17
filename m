Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97ED42DD9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 21:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgLQUIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLQUIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:08:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C8AC0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:07:33 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i24so29884348edj.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOmQk0x3ccvRlceWbWP6GlZsmAYEOiZMR0Q/yyY99OQ=;
        b=bGdNtPX0MoCL7Rl8ZOlUUcr0begz62DKNFdyqODZRqutDa2Q6dORObDPEElCV3S+M3
         tiLYNwcZ9Kuog9umRyLnJqJAoRSA3vmtGtMd7sdnYOok0Lu96IorEfCenRHF5dlMWa6T
         6x7OuIuCydIYH1kr7i9ubxQFiW664ND4F/roXktfTkDQLmiQ6HQikuMjh8cWzWC+YNbW
         M7HYZale6/TmiMU215cWVN+Lv9piP79nJrcL3zha3FC14d/pxEPo1gRrYgGf0ttRPOoM
         lraQ3/y2lzGStkM4XAvwuqaIHgF3t+xGi7JtMbotzNVqu0CUlHqNYdhfESmu9gNsSJhQ
         HjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOmQk0x3ccvRlceWbWP6GlZsmAYEOiZMR0Q/yyY99OQ=;
        b=gegZHvTma0oWSJWjgqywXsTPOFwNcA9OlAUU5LCWDh2+cGYOTmkq7turU0aMsq7GUq
         8d+OsGSXnFAhxvO+mjkJAnCykahrjCSNFiPKRJawhP/a7+k/836aTNc4iAjz54fTeLS9
         NlYlaLiEsqgrab+Qv9HrwsNtuYzmJjd5A5lgmTf56ICEtcnFKBtUGKt2NL5g9HCadzkt
         kFIqbzgkh6E6hIdFCRIha9B4xeGsYaysXu2Vx3E7L4yUCRx9jDIgiuWij4OEBdtcN6QR
         +a+0gf/Q7/dRKGo/381wwl8jPx2XbaQbI/SOKiMjCKPXqr1jlyESzVTuBmWmwlK8xtuH
         jSQA==
X-Gm-Message-State: AOAM531g0Qh/C2XO3/g3MZEIu5qwkVlCDH7RGewgXhCA5pInmY2G8lfJ
        4RSAn9rrN+5/GEKrW7d21iQC+0Z8G0rUhJX8nFoKbA==
X-Google-Smtp-Source: ABdhPJwDePy04S+TEAbB/l0WUoCva/Xi7xKi/eubNc5Leg+G4l43zsZ/K98rDsbbM2EFRXtuSzl392zKo7dwdGlc4tc=
X-Received: by 2002:aa7:cdc3:: with SMTP id h3mr1106955edw.52.1608235652067;
 Thu, 17 Dec 2020 12:07:32 -0800 (PST)
MIME-Version: 1.0
References: <20201216174146.10446-1-chang.seok.bae@intel.com> <X9utMeDKfjdghy1M@sol.localdomain>
In-Reply-To: <X9utMeDKfjdghy1M@sol.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Dec 2020 12:07:22 -0800
Message-ID: <CAPcyv4h6hiSiE5xC=eccrQcd6Zb+aQeEjQ7bbC5jb_6heQkEsA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] x86: Support Intel Key Locker
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dave Hansen <dave.hansen@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        ning sun <ning.sun@intel.com>,
        Kumar N Dwarakanath <kumar.n.dwarakanath@intel.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 11:11 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Dec 16, 2020 at 09:41:38AM -0800, Chang S. Bae wrote:
> > [1] Intel Architecture Instruction Set Extensions Programming Reference:
> >     https://software.intel.com/content/dam/develop/external/us/en/documents/architecture-instruction-set-$

https://software.intel.com/content/dam/develop/external/us/en/documents/architecture-instruction-set-extensions-programming-reference.pdf

> > [2] Intel Key Locker Specification:
> >     https://software.intel.com/content/dam/develop/external/us/en/documents/343965-intel-key-locker-speci$

https://software.intel.com/content/dam/develop/external/us/en/documents/343965-intel-key-locker-specification.pdf
