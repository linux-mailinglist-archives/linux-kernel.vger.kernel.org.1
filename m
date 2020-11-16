Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9152A2B3BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 04:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKPDOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 22:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgKPDOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 22:14:16 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE695C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 19:14:15 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id m13so17333930oih.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 19:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmXDsbkMyG3TLtFxXGtOYPD+kRSyJ20ru4tSJVWRVhU=;
        b=MhhQtbTSSKCTKj6L6N6yRgPmAq/Bi9/wSZ0bci2FRMthAssY1VMWTwL66hm6coRqEs
         Py2l3hJl9C9xA3x9NnWIIgxiuLD9tQwzWAQaMYVD7N09XjTVcHxjXCOiuYduIpgc+me/
         HQEWx7PVG7lgZ3jBkOO3N1GMg6zJWpNfLkCEPOU8OrfFpYvGGgo/y73ztBv0N8rhj2xh
         v1bLlewoDC7u+20WshYT0q6THMLY0PPz0cMLObfbqx+T+opfxL+2P9HcR6xHxhxN1B4H
         pItkSGEtq6zosMdnUlI3xlcrrbfZKkYLId3aNORkM5KTi1XsXB8qzNMMvv17D6l8bEwE
         4EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmXDsbkMyG3TLtFxXGtOYPD+kRSyJ20ru4tSJVWRVhU=;
        b=O4yRLqNCj+bxePnR/VX48D/PnqCkGEKej0toQMLfF22j20J0a725wHqh5m2awwgPrh
         VhUBKm0jJC9t8zYdZQYbiCVCkvJzMDl0euKM7LHSjnYh1bP8b/Vvys9MCuNvnReqlw+u
         qDupri3w0PuPohA7LxeKYhiCQ7PCP9pQwPMSe+4sGIde3rSOvaiYOma8f5RltHLh4W1u
         q1leGGQpVID1SyMNP9nYMDqL80n9xZxyUER8tiANiyX+4eni1NyVq/5d6+tlWzFCoPlx
         GHd9B3u+zzvHgbgM5st9pFFxgNdj7Od5/P+/U4RIRc2pEII1Bs25uw3Vqh4B7WGTF1P+
         kfOQ==
X-Gm-Message-State: AOAM533BvWepfco07FqdTn7jX7qlFW4kNkaHlfaggn0D41zFMV0VZVTI
        2CRnX6KdcMaOxoURvUtME6gxauQVldsHPgZwoQ06qNtdCkxXyRJC
X-Google-Smtp-Source: ABdhPJyDqNE9q4x0eWvYqW5pk63CuMMdkh8YP/75hsj5Hw4gwBaBxi0hKu8Sv2f1F706gKCXsdakj45MtBoi3gehBCU=
X-Received: by 2002:a05:6808:69a:: with SMTP id k26mr8650729oig.140.1605496455229;
 Sun, 15 Nov 2020 19:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20201111093514.103155-1-zong.li@sifive.com> <20201111093514.103155-2-zong.li@sifive.com>
 <MN2PR13MB279761320CFB61CEBC340B73EBE80@MN2PR13MB2797.namprd13.prod.outlook.com>
 <160516094980.60232.10838645292668930157@swboyd.mtv.corp.google.com>
In-Reply-To: <160516094980.60232.10838645292668930157@swboyd.mtv.corp.google.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 16 Nov 2020 11:14:05 +0800
Message-ID: <CANXhq0oX63CFqUUMqtcoqQavLnTymWAPHSQrfcboQZxznfc+Cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] clk: sifive: Extract prci core to common base
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Pragnesh Patel <pragnesh.patel@openfive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Yash Shah <yash.shah@openfive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 2:02 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Pragnesh Patel (2020-11-11 01:51:17)
> > >+#define RCI_GEMGXLPLLCFG1_CKE_SHIFT   24
> > >+#define PRCI_GEMGXLPLLCFG1_CKE_MASK   (0x1 <<
> > >PRCI_GEMGXLPLLCFG1_CKE_SHIFT)
> >
> > Same here, Other than this
> >
> > Reviewed-by: Pragnesh Patel <Pragnesh.patel@sifive.com>
> >
>
> Please trim your replies

In v4 patch version, I change the definition of macros to 31 from 24 as follows:
- PRCI_CLTXPLLCFG1_CKE_SHIFT
- PRCI_DVFSCOREPLLCFG1_CKE_SHIFT
- PRCI_HFPCLKPLLCFG1_CKE_SHIFT
- PRCI_DDRPLLCFG1_CKE_SHIFT
- RCI_GEMGXLPLLCFG1_CKE_SHIFT
