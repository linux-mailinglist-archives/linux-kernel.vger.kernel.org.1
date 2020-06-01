Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D5D1EB05B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 22:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgFAUmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 16:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFAUmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:42:00 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A025C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=umNH2IL374QzFan0BCFcUz4Yz1dQZIoKe9xkPK7BB8s=; b=B9o5hLZiZ1dPkxYLQykjzopdu
        GHX4LxcCtCvEGM3Etjy9cC/j67bI6OG7DXbk0FL3NMs4GZPx3NMDcxHGu3AhZgoQfMRYa5T/fklLd
        bQCadn2i3BcPIvBWj5CYlGe+NVeD+Iqwq5oR+Un9UgUzM7efNQbclkYVxmA1vrd4bg6oxwZAbG+aD
        ZOV2yspeu/h0j4c8lr2P52OlKgu8GVA2XqaVq+HSjhtnbubUjqs98lgJN3Ml6vPnD22gho5e+Ntxh
        kvqtycKCARRli2besSBD53t/GNcT3V3NK7tGXYyioK0xIldo9fhgWMcI4HYTljt0NHPKx9Tte0zh4
        553jyL+pQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40102)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jfrFa-0001Eq-Lu; Mon, 01 Jun 2020 21:41:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jfrFQ-0003e1-2I; Mon, 01 Jun 2020 21:41:28 +0100
Date:   Mon, 1 Jun 2020 21:41:28 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 3/5] arm: decompressor: define a new zImage tag
Message-ID: <20200601204127.GS1551@shell.armlinux.org.uk>
References: <20200601182555.GP1551@shell.armlinux.org.uk>
 <CGME20200601202757eucas1p11d380be9e0b2fe912a358d21e2d8dc2a@eucas1p1.samsung.com>
 <dleftj8sh6sf9a.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dleftj8sh6sf9a.fsf%l.stelmach@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 10:27:45PM +0200, Lukasz Stelmach wrote:
> It was <2020-06-01 pon 19:25>, when Russell King - ARM Linux admin wrote:
> > On Mon, Jun 01, 2020 at 06:19:52PM +0200, Lukasz Stelmach wrote:
> >> It was <2020-06-01 pon 15:55>, when Russell King - ARM Linux admin wrote:
> >> > On Mon, Jun 01, 2020 at 04:27:52PM +0200, Łukasz Stelmach wrote:
> >> >> Add DCSZ tag which holds dynamic memory (stack, bss, malloc pool)
> >> >> requirements of the decompressor code.
> >> >
> >> > Why do we need to know the stack and BSS size, when the userspace
> >> > kexec tool doesn't need to know this to perform the same function.
> >> 
> >> 
> >> kexec-tools load zImage as low in DRAM as possible and rely on two
> >> assumptions:
> >> 
> >>     + the zImage will copy itself to make enough room for the kernel,
> >>     + sizeof(zImage+mem) < sizeof(kernel+mem), which is true because
> >>       of compression.
> >> 
> >>        DRAM start
> >>        + 0x8000
> >> 
> >> zImage    |-----------|-----|-------|
> >>             text+data   bss   stack 
> >> 
> >>                  text+data           bss   
> >> kernel    |---------------------|-------------------|
> >> 
> >> 
> >> initrd                                              |-initrd-|-dtb-|
> >
> > This is actually incorrect, because the decompressor will self-
> > relocate itself to avoid the area that it is going to decompress
> > into.
> 
> I described the state right after kexec(8) invocation.

Actually, you haven't, because this is _not_ how kexec(8) lays it
out, as I attempted to detail further down in my reply.

> > So, while the decompressor runs, in the above situation it
> > ends up as:
> >
> >
> > ram    |------------------------------------------------------...
> >                  text+data           bss   
> > kernel    |---------------------|-------------------|
> > zImage                          |-----------|-----|-------|
> >                                   text+data   bss   stack+malloc

Note here - if the initrd was placed as _you_ describe at the end
of where the zImage ends up including its BSS, it would be
corrupted by the stack and malloc space of the decompressor while
running.  Ergo, your description of how kexec(8) lays stuff out
is incorrect.

> > Where "text+data" is actually smaller than the image size that
> > was loaded - the part of the image that performs the relocation
> > is discarded (the first chunk of code up to "restart" - 200
> > bytes.)  The BSS is typically smaller than 200 bytes, so we've
> > been able to get away without knowing the actual BSS size so
> > far.
> >
> >
> > ram    |--|-----------------------------------------|---------...
> >        |<>| TEXT_OFFSET
> > kernel    |---------------------|-------------------|
> >           |<----edata_size----->|<-----bss_size---->|
> >           |<---------------kernel_size------------->|
> > zImage                          |-----------|-----|-------|
> >                                 |<-------len------->| (initial)
> > 				|<----------len------------>| (final)
> >
> > The "final" len value is what the decompressor prints as the "zImage
> > requires" debugging value.
> >
> > Hence, the size that the decompressed kernel requires is kernel_size.
> >
> > The size that the decompressor requires is edata_size + len(final).
> >
> > Now, if you intend to load the kernel to ram + TEXT_OFFSET + edata_size
> > then it isn't going to lose the first 200 bytes of code, so as you
> > correctly point out, we need to know the BSS size.
> 
> Formal note: can we keep using terms zImage and kernel as separate,
> where zImage is what is loaded with kexec and kernel is the decompressed
> code loaded at TEXT_OFFSET. I believe, it will help us avoid mistakes.
> 
> >> >> +struct arm_zimage_tag_dc {
> >> >> +	struct tag_header hdr;
> >> >> +	union {
> >> >> +#define ZIMAGE_TAG_DECOMP_SIZE ARM_ZIMAGE_MAGIC4
> >> >> +		struct zimage_decomp_size {
> >> >> +			__le32 bss_size;
> >> >> +			__le32 stack_size;
> >> >> +			__le32 malloc_size;
> >> >> +		} decomp_size;
> >
> > You certainly don't need to know all this.  All you need to know is
> > how much space the decompressor requires after the end of the image,
> > encompassing the BSS size, stack size and malloc size, which is one
> > value.
> 
> I agree. However, since we are not fighting here for every single byte,
> I'd rather add them as separate values and make the tag, even if only
> slightly, more future-proof.

It doesn't make it more future-proof.  What happens if we add something
else, do we need to list it separately, and then change the kernel to
accept the new value and maybe also kexec(8)?  Or do we just say "the
decompressor needs X many bytes after the image" and be done with it?
The latter sounds way more future-proof to me.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
