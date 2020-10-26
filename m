Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62929913B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773430AbgJZPjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:39:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43806 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772929AbgJZPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:39:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id e6so6985630qtw.10;
        Mon, 26 Oct 2020 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vLQei8ZmgmFcSxn2MPuUAP5brChetukYTYeEtCq2OjI=;
        b=WZClcdFYON5jGkBEUsXDjjrC5+/8ykP+W6jK5+YeWAfaGlZD+93YguQywa1UlSp48E
         uuGYiMGQ/K04Dg/M2ZDj65g6NI2HxWyDWw75mA2OiPTlu4gvZmkKphql2hKrPxoQ6XkI
         KQDwxR3oSWF8+kE2PPMlU6jR7hvZSRY4CG0DkqzG5g1NmsiQ1zBanpyNT1bit/dYeJv+
         fa8TvdDcGh3m0EpxlNz1RjSkouEZjkL+LvrvKe8ilMfCbxc0hKKrGjgEho1DM3INinLX
         Z6gEQCXl+0JUCW9mEfYAx1I7W8SYlFzMt5uW3ji+qSjJskmQHCmirSbKgLG5odMoqpxW
         jDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vLQei8ZmgmFcSxn2MPuUAP5brChetukYTYeEtCq2OjI=;
        b=E00KcnsOh2BTaC/FqoiezxHRoTKA8w+mstyWzW3n+jX2ROYHqs7OjDulfZyKSdeW0d
         6rCsQq/B0rF2Uyz/X0qtZ7KxJWYpFT9gIgIpn1aA+0xLa+sRxlCh/QHL5YWthiLGgAXQ
         RbEMo5T0nHDiUlMIMHHBCo2A3N4Cu4mHh8lBZHbeScJpfH8E4BzFptyzgwmNbWoYX3Fq
         CVLypePnW6tuHy2fcRUAuFQPeGst7XoSpPSuDDYOPigT6m4gBw5T6ou0WHnSy9QIwMiH
         8Rm3vWErfDUa5B2tYPPTifUZAmaSoa9UxxfQbeh3Oz5OLUdB3yQvveellpOeaBT04QwS
         GopQ==
X-Gm-Message-State: AOAM531A8UPU72qiHttqr82iadoNwJCqkhVYsrX3NNAYDuiT8aKzlk1v
        zk8atZqJ2r+rS6zP+WpZGxq1N1YPQbOM/g==
X-Google-Smtp-Source: ABdhPJxwbjJpM7BXgATHrFMn/Ypqvv2ofYPBMDwSwLCNpEqKIsLxrJd136lnOkueYbC0g12unZabRA==
X-Received: by 2002:ac8:4b4b:: with SMTP id e11mr3668273qts.29.1603726779530;
        Mon, 26 Oct 2020 08:39:39 -0700 (PDT)
Received: from ubuntu (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.gmail.com with ESMTPSA id 22sm4586589qtw.61.2020.10.26.08.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 08:39:38 -0700 (PDT)
Date:   Mon, 26 Oct 2020 11:39:36 -0400
From:   Vivek Unune <npcomplete13@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: BCM5301X: Linksys EA9500 add fixed partitions
Message-ID: <20201026153936.GA258640@ubuntu>
References: <20201026131351.258296-1-npcomplete13@gmail.com>
 <e64d76cc-90bb-5b54-04de-fde21542e4fe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e64d76cc-90bb-5b54-04de-fde21542e4fe@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 06:30:53AM -0700, Florian Fainelli wrote:
> 
> 
> On 10/26/2020 6:13 AM, Vivek Unune wrote:
> > This router has dual paritions to store trx firmware image and
> > dual partitions for nvram. The second one in each of these cases acts
> > as a backup store.
> > 
> > When tested with OpenWrt, the default partition parser causes two issues:
> > 
> > 1. It labels both nvram partitions as nvram. In factory, second one is
> > labeled devinfo.
> > 2. It parses second trx image and tries to create second 'linux' partition
> > and fails with - cannot create duplicate 'linux' partition. I've set this
> > partition to read-only for now
> > 
> > The following patch works around both of these issues.
> > 
> > Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> > ---
> >   .../boot/dts/bcm47094-linksys-panamera.dts    | 41 +++++++++++++++++++
> >   1 file changed, 41 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> > index 5d5930edfb9d..13da16c5de68 100644
> > --- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> > +++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
> > @@ -292,3 +292,44 @@ fixed-link {
> >   &usb3_phy {
> >   	status = "okay";
> >   };
> > +
> > +&nandcs {
> > +	partitions {
> > +		compatible = "fixed-partitions";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +
> > +		partition@0 {
> > +			label = "boot";
> > +			reg = <0x0000000 0x0080000>;
> > +			read-only;
> > +		};
> > +
> > +		partition@80000 {
> > +			label = "nvram";
> > +			reg = <0x080000 0x0100000>;
> > +		};
> > +
> > +		partition@180000{
> > +			label = "devinfo";
> > +			reg = <0x0180000 0x080000>;
> > +		};
> > +
> > +		partition@200000 {
> > +			label = "firmware";
> > +			reg = <0x0200000 0x01D00000>;
> > +			compatible = "brcm,trx";
> > +		};
> > +
> > +		partition@1F00000 {
> > +			label = "failsafe";
> > +			reg = <0x01F00000 0x01D00000>;
> > +			read-only;
> > +		};
> > +
> > +		partition@0x5200000 {
> 
> You would need to remove the 0x from the hex number here.

Sure, I'll fix this in next version

> 
> > +			label = "brcmnand";
> 
> Not sure how useful naming this partition brcmnand is, can we find a better
> name for it?

I'll be more than happy to rename this that makes sense. Factory uses this
name as well. This is used as a general persistent storage for system cofigs.
Could we name it System?

Thanks,

Vivek

