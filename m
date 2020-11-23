Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8B62C008C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 08:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgKWHS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 02:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgKWHS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 02:18:28 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45845C061A4D
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 23:18:28 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id f12so3564797oto.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 23:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfKjG2GvoDhQiB7EpkscGKZ+97rkBF/pnq0LhdxYBSQ=;
        b=Nhi41X2pbTeawhTkWHetJJ8SzZ7jdWhXuzFPECnPqfmjT2n5H0aJE/I9Fhz5WpkOTi
         U1f2uuCWR5MWR2ZUnRWcMSrmka1wwVzu4a6pwiYKsFabNZqQNgXJiJtVdQg6fBKG/ojv
         wQoiop9+kZRRADXjWOAF/gd5OO+gMdZdnWewS7O9jsEwzxEuyzSYSbmjWGXuCLu3smeQ
         aS/po47CbgOhCG5PUD2dzUI/mjZVLQVhLYtj9N8+Ga+eh9ixBzz4dcx2Roiqpt4QI0Al
         kmDFP01bTVN1xbUdqzWFwfsEyaL8LjqdkSyLMg1fWWx/9PneRe4zhP1jMIaBy3BPBPMv
         92TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfKjG2GvoDhQiB7EpkscGKZ+97rkBF/pnq0LhdxYBSQ=;
        b=CTIRnaRIvAvuxd8NG4IpSbUZu25t7pzqxvksZHzBPDTFOp93qUSF1Adj8gUe3plV91
         pL+pJwoVtEbgUMGNvIH3wWzTC8pwUA6yNDmpjYJH3zE4YXF0PMJFF8nLnmAg+ZXMrHCl
         5kzMmXgHP+ojJiOoOJ7YDL7/lh7UrpGoy0Q8HIkJWP3/PKb0xGPMmY27huzTMu7oORPO
         /w5Yak9gLoZsEYp/mF4QeX5aPK0Vj26H8lx2nVHQgBTYWGJABAhHIXBRcZvdmCU68IdU
         G0C8LPy4MDgFpE/c78iRcXExtO+N4e0P3fpWfcsZBKy/LS8UouBbj7Pw9y37EnXWTFsu
         mh8g==
X-Gm-Message-State: AOAM532BYcmRBs7JQ8vCLElqV50VX5REoDcxZx7DvS8QtGXWEe9NwTgt
        FvxPtSM3zgMRbz4//0Y1RhE6JFukI1feCEPjQQYTRA==
X-Google-Smtp-Source: ABdhPJweIoXhEjpbvXwglI32aXPOWNF6IbolZiWACHGNa+GuXDBW2FXTa0dak0WYveQO8IuYFPBrvHcq4162/Q4SUIA=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr22428460otq.166.1606115907677;
 Sun, 22 Nov 2020 23:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20201111100608.108842-5-zong.li@sifive.com> <mhng-738e4a27-9751-4937-b3ed-efdcdce56f0c@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-738e4a27-9751-4937-b3ed-efdcdce56f0c@palmerdabbelt-glaptop1>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 23 Nov 2020 15:18:17 +0800
Message-ID: <CANXhq0rQtgVNoDJ7DLFcBRwru1H5+4_0LoANCVcGMaB2LmCOMA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] clk: sifive: Fix the wrong bit field shift
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Pragnesh Patel <pragnesh.patel@openfive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Yash Shah <yash.shah@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Pragnesh Patel <pragnesh.patel@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 9:29 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 11 Nov 2020 02:06:08 PST (-0800), zong.li@sifive.com wrote:
> > The clk enable bit should be 31 instead of 24.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Reported-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> > ---
> >  drivers/clk/sifive/sifive-prci.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
> > index 802fc8fb9c09..da7be9103d4d 100644
> > --- a/drivers/clk/sifive/sifive-prci.h
> > +++ b/drivers/clk/sifive/sifive-prci.h
> > @@ -59,7 +59,7 @@
> >
> >  /* DDRPLLCFG1 */
> >  #define PRCI_DDRPLLCFG1_OFFSET               0x10
> > -#define PRCI_DDRPLLCFG1_CKE_SHIFT    24
> > +#define PRCI_DDRPLLCFG1_CKE_SHIFT    31
> >  #define PRCI_DDRPLLCFG1_CKE_MASK     (0x1 << PRCI_DDRPLLCFG1_CKE_SHIFT)
> >
> >  /* GEMGXLPLLCFG0 */
> > @@ -81,7 +81,7 @@
> >
> >  /* GEMGXLPLLCFG1 */
> >  #define PRCI_GEMGXLPLLCFG1_OFFSET    0x20
> > -#define RCI_GEMGXLPLLCFG1_CKE_SHIFT  24
> > +#define RCI_GEMGXLPLLCFG1_CKE_SHIFT  31
> >  #define PRCI_GEMGXLPLLCFG1_CKE_MASK  (0x1 << PRCI_GEMGXLPLLCFG1_CKE_SHIFT)
> >
> >  /* CORECLKSEL */
>
> Section 7.3 of v1.0 of the FU540 manual says that bit 24 contains the PLL clock
> enable for both of these.  I don't know if that's accurate, but if it is then I
> believe this would break the FU540.  Don't have one to test on, though.

Yes, the manual seems to be wrong and should be corrected. It doesn't
break the FU540 yet because we don't use these fields in s-mode Linux
driver, we set them in m-mode FSBL/U-boot-SPL bootloader during boot
time, and the implementation of FSBL and U-boot-SPL both are correct.
The following link is the U-boot SPL source:

https://github.com/u-boot/u-boot/blob/da09b99ea572cec9a114872e480b798db11f9c6e/drivers/clk/sifive/fu540-prci.c#L128
