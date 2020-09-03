Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7506225C6FF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 18:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgICQfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 12:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgICQfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:35:42 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E64C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 09:35:42 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o64so3608889qkb.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xR8p6OfMm3Vs9CxLP71zg4PadItST95qCvRFBxxCgYQ=;
        b=WWKLmOR9QI9lvl9BcKFPwsSWwpOegtwY0d5VffiK4Bs+Z+3SKYGMwH4JIPimrn/285
         WT2CvBW4MJTH6BDFAvFdFbKWS4+oZ3xzkPVW+hZ6sCeBUXoa1umMCAYd6rx70ds2ITvX
         PUsD0YIBBIYS8jlrKycGQFe9kTc5m7JxKNW2RbNqP3uyrosKb1yCdQ7gXmRGxUBpuINH
         8rdZ7E99Sg3HmZ6jpIF42fo5G1UWXDaAcu0dybHd+X/twasB8LgImJQsd4ikLhUT1G87
         G4jQj8wVS9IKLMzzgQSXBLeSnyMwEjXgXJnWqSf7EWTb6aY0ZtOiGmePgLYwJy8klVoF
         116Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xR8p6OfMm3Vs9CxLP71zg4PadItST95qCvRFBxxCgYQ=;
        b=aUM48UAhAwhJYwGSFJHdrH8PtiVLRrhoIOmtPBQd2+gHM2YwgEY0AxO7Bs8mdgc1bb
         /ydOpxKR9d6JgCopw63uzFELIoQRQKmCKn4YNe9UKQs1a38Z5uH0UPOI6Wh6dOb84pah
         4q5exT0zlszVzwNbR5JfnEGvRbskW8LREEru8+74gmqc9Lo8nnqphX3ltxn00i8DVc/a
         5Yq0q9pto3idjaHFe5dWSPp49kSlKhLJsY614i0MkxHFFuAz06wYoiDKILHFCsD6FuVz
         AZZW11TTZF26N5YNvuFLVPVFYZ8IIk17Cx4kRZAjAr2MzTgXsOykRgoDFv4bXK9SE/tb
         dL1w==
X-Gm-Message-State: AOAM532yYoCXheKdhsKXBErCAujhxHOcA8pOnRQQEBJI60VjnX0zj2Mm
        8WoQEZqNzC0XLD3KFvgJS4krBskNVL3wHxOumVbCUA==
X-Google-Smtp-Source: ABdhPJwqI/chCMYWI1PNmMb5qEVWU+xL9Q//JT/T3ku1g2EPBx4P5yHfZ8wIKjpJ9fWPJKe4GLziaQ6ljwOytlicmRw=
X-Received: by 2002:a37:de17:: with SMTP id h23mr4206586qkj.368.1599150941506;
 Thu, 03 Sep 2020 09:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200903161804.403299-1-daniel.gutson@eclypsium.com> <20200903162756.GB406278@kroah.com>
In-Reply-To: <20200903162756.GB406278@kroah.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Thu, 3 Sep 2020 13:35:30 -0300
Message-ID: <CAFmMkTFXaU64JzWoc2cFYE9i8hXjfAwRy8Ct0_9EWV_PSJPi6w@mail.gmail.com>
Subject: Re: [PATCH] Platform integrity information in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 1:27 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 03, 2020 at 01:18:04PM -0300, Daniel Gutson wrote:
> > This patch exports information about the platform integrity
> > firmware configuration in the sysfs filesystem.
> > In this initial patch, I include some configuration attributes
> > for the system SPI chip.
> >
> > This initial version exports the BIOS Write Enable (bioswe),
> > BIOS Lock Enable (ble), and the SMM BIOS Write Protect (SMM_BWP)
> > fields of the BIOS Control register. The idea is to keep adding more
> > flags, not only from the BC but also from other registers in following
> > versions.
> >
> > The goal is that the attributes are avilable to fwupd when SecureBoot
> > is turned on.
> >
> > The patch provides a new misc driver, as proposed in the previous patch,
> > that provides a registration function for HW Driver devices to register
> > class_attributes.
> > In this case, the intel SPI flash chip (intel-spi) registers three
> > class_attributes corresponding to the fields mentioned above.
> >
> > This version of the patch provides a new API supporting regular
> > device attributes rather than custom attributes, and also avoids
> > a race condition when exporting the driver sysfs dir and the
> > attributes files inside it.
> > Also, this patch renames 'platform lockdown' by 'platform integrity'.
> >
> > Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> > ---
>
> Always version your patches, there's no way this is "v1", right?

Sorry, I thought the version was reseted after the title changed.

>
> greg k-h



-- 
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
