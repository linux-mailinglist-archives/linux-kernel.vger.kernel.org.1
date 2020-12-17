Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996002DD48E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 16:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgLQPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 10:49:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgLQPtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:49:32 -0500
X-Gm-Message-State: AOAM533i08aL8cS5pR1EoeDbphURYYfbgo7l7TP5kH6TPvBIE+efQheN
        v0ec53g+rt8PdI0c3sHoRyoYmhw9qGnI8Cyp+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608220131;
        bh=HUSPQFcXMROvPbYKYtXZIsh/aLWhRKEeLyA2ehKEYJI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NDEigNYHKI5UgntIvlCeYPFftngTCzlwBb7C/svF0MViJSdDGdwpIl/nEHvdHR4iS
         q0jbD+EEeEc3OeR2JJ56OP2pk5LV8zSaBvfodZBHULrYDf8D+KgsKB3JV/LyaYXz6p
         6eWcsfjAmeJSY7Aq5Musv+Esv8i0bh2bh4u1aFvkm5HoNdoEesyP9NnsiS9rFxgfO4
         cev/wes6Q2QNboybE3tQaMCelT+iye1u5b3XMeM23sh2Gm4eZMiEo5OuGKP+cCL0m+
         SIb2ngcl3vlN9OUbT0OHEdLSfvvWtreBF7rkxVNfzTc8fP7x0WVljimLoFDdg3Lj6m
         YVhuhfpAFcTPw==
X-Google-Smtp-Source: ABdhPJxQ5o8gr3Ol8IZEUu8ChReLok3hNEWyi2XRN7tE4l6FMSS1YJtI3F49qoZ7PM1sTugtMnsvnSwKCZenmICk0Yk=
X-Received: by 2002:a17:906:1197:: with SMTP id n23mr35857468eja.359.1608220129334;
 Thu, 17 Dec 2020 07:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20201209175708.16252-1-a-govindraju@ti.com> <20201209175708.16252-2-a-govindraju@ti.com>
 <20201211033301.GA3581630@robh.at.kernel.org> <70d6c152-5d8d-9ad6-ce06-95a9f599c492@ti.com>
 <20201214222339.GA2471866@robh.at.kernel.org> <76e73cc7-fdb7-45bb-6270-1f668969ad50@ti.com>
 <96eada83-cf24-e02a-60a6-d81907a1bba0@ti.com>
In-Reply-To: <96eada83-cf24-e02a-60a6-d81907a1bba0@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Dec 2020 09:48:38 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+7A3C5eV+8aoOXTC+axhtQSgf7NAR0ffMD4UUmcTzU9Q@mail.gmail.com>
Message-ID: <CAL_Jsq+7A3C5eV+8aoOXTC+axhtQSgf7NAR0ffMD4UUmcTzU9Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Documentation: devicetree: Add property for
 ignoring the dummy bits sent before read transfer
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 7:48 AM Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> Hi Rob,
>
> On 15/12/20 9:42 pm, Aswath Govindraju wrote:
> > Hi Rob,
> > On 15/12/20 3:53 am, Rob Herring wrote:
> >> On Fri, Dec 11, 2020 at 08:34:57PM +0530, Aswath Govindraju wrote:
> >>> Hi,
> >>> On 11/12/20 9:03 am, Rob Herring wrote:
> >>>> On Wed, Dec 09, 2020 at 11:27:07PM +0530, Aswath Govindraju wrote:
> >>>>> Dummy zero bits are sent before data during a read transfer. This causes
> >>>>> the data read to be shifted to the right. To fix this send zero bits after
> >>>>> the address during a read transfer.
> >>>>>
> >>>>> Add property to send zero bits after the address during a read transfer.
> >>>>
> >>>> When is this necessary? Why can't it be implied by the compatible
> >>>> string which should be specific to the chip model?
> >>>>
> >>>
> >>> This is necessary for 93AA46A/B/C, 93LC46A/B/C, 93C46A/B/C eeproms, as
> >>> it can be seen in section 2.7 of [1]. We were not sure if these were the
> >>> only devices supported by the driver(eeprom_93xx46.c). So, in order to
> >>> apply this only to the above listed devices, we thought that it would be
> >>> better to apply this change when required by introducing a DT property.
> >>>
> >>> May I know how has this case been handled till now ??
> >>>
> >>
> >> No idea. From the at93c46d (which has a compatible string) datasheet it
> >> looks like it has the same thing.
> >>
> >>> If this is required by all the devices then we can drop the property and
> >>> include the zero bit by default.
> >>
> >> Looks like you need a combination of compatible strings for the above
> >> devices and a property for the ORG pin state on the C devices. I assume
> >> s/w needs to know if x8 or x16?
> >>
> > Yes, there are separate properties for indicating different types of
> > types of eeproms.
> >
>
> Here I was saying about x8 or x16 using the data-size property. ORG pin
> state is implied through data-size property and an additional property
> is not required for ORG pin state.

Ah, I missed that property.

>
> > So, do you think that it is better to add it as a seperate property??
> >
>
>
> These are the available options to my knowledge,
>
> 1) As you mentioned earlier all the eeprom's supported by the driver
> send a dummy bit before the read data. This can be thought of a bug and
> add this change as a fix for it. This might a problem for users who are
> already using this driver and working around it using user space tools.
>
> 2) Add a special compatible string "eeprom-93xx46B", to add the extra
> dummy cycle and not add an additional property.

No. Genericish compatible strings are what cause the problem and this
whole discussion.

> 3) Add an additional property as proposed in this patch and use when
> required.
>
> Are there any other suggestions on solving this issue??

You need a compatible string for each vendor+model. Period.

Rob
