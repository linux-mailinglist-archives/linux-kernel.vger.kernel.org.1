Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0202F7EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbhAOPAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:00:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731503AbhAOO7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610722707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmVQjQTpqOnD4r9o3Q6+/fS9ZXoOCu6z+q20+s/vvWQ=;
        b=QH75kkNUjnFtmHIIAnk1g5yTdMJo0KL0iIzcAuux4a77OpfG8gGALAvTJeogWJxk77+1LD
        ZtQ5oSEyrbE9XSsjxVZP5rNEPuyibBv/BMPGdZjmGkKk6Wxgj0sXfo5FLVC5bh+ft/lqMw
        qhwKXS+fpj342daF/MzD0fZLwA3MkM8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-rgGdeWj0MmifTgpM8s-7vQ-1; Fri, 15 Jan 2021 09:58:25 -0500
X-MC-Unique: rgGdeWj0MmifTgpM8s-7vQ-1
Received: by mail-wr1-f72.google.com with SMTP id j5so4267585wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dmVQjQTpqOnD4r9o3Q6+/fS9ZXoOCu6z+q20+s/vvWQ=;
        b=DUzFz/DxVzITpoyKx5JvwkY63zgC0nXdYdUw3emUF6Y13QWL9FeNvNYJ2BINzGK+5/
         6Lb3q9JYQD2Ewe7q/juVvBH1APG0J7JdY3Ez1K1pLR5fZm7HwzSyqKaVRA34J7RQgTi7
         bYo5xxyBLq9ZLAV5Abv7aJP7XVbF2zm9THIMZdEK9U/mjGdUuZ5EWqTZbRmDwEb237ZB
         9Gu2O48Neq9g6X4JteQ9v679K6qbb0aX9e6Qi3O65Q2BmUysymZ1fuDAi315atdS3npU
         DxEkTEKHaTXTlgD9LnyHaWw8zN5x0Idchp58uRbFBgU4utXSSt4lxZ9pUW32XCEVMD2A
         jucg==
X-Gm-Message-State: AOAM531t5oXp81Q9BL5Veojuhsj22mkjyxb2p6sNbYzKgFnHu4QFPG8B
        2lyL4fzMlkYjuKW9jueVRegT66QMVimW10d09FJZegc1SWMn7kRNLsPdypyyKRrb8YEQsjKjSD6
        SihAotDxeD3PQzySVHApMnNXYX4f2znt4W+8tgk0vMdE/hCy8tShaQ5/T2ph5vGqawp9wmI76n6
        qMQYa6Ne4P7OWz4Q==
X-Received: by 2002:a1c:e255:: with SMTP id z82mr1118491wmg.60.1610722704235;
        Fri, 15 Jan 2021 06:58:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW+XSWfmPhbHhzTUqZ64FJxtNe1z+L1rkyzhGjXUijdF1PlSioAAyUWeDkY39cnqvjrYChFw==
X-Received: by 2002:a1c:e255:: with SMTP id z82mr1118429wmg.60.1610722703896;
        Fri, 15 Jan 2021 06:58:23 -0800 (PST)
Received: from ?IPv6:2a01:e34:eea6:7961::e71? ([2a01:e34:eea6:7961::e71])
        by smtp.gmail.com with ESMTPSA id f14sm15410402wre.69.2021.01.15.06.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 06:58:23 -0800 (PST)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v8 0/4] HID: i2c-hid: Reorganize to allow supporting
 goodix,gt7375p
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrea Borgia <andrea@borgia.bo.it>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Jiri Kosina <jikos@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Pavel Balan <admin@kryma.net>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20201211222448.2115188-1-dianders@chromium.org>
 <CAD=FV=Ve4wGJ=KxQjraYsiAQZHG_5qEeFW0ZhmBBkRmtdm7Gwg@mail.gmail.com>
 <CAO-hwJK+=537C-EbgNXPY3=m5LvM8SVKCDB5X145BfSMHgUMdw@mail.gmail.com>
 <CAO-hwJLuzAccZbLSCvyP0JnkCW8fgswrm8RJfMaVKjtyF5Yg_A@mail.gmail.com>
 <CAD=FV=W3uzNPwAGPCUfjC-zoWEPyY4bF8TE4JgPP21s-3MAfpQ@mail.gmail.com>
 <CAO-hwJ+Gz_yp_vn1prREvhcU=YqVatqd_Hp+95L5i2=bcwfhbA@mail.gmail.com>
Message-ID: <f3add027-d732-0846-fa54-b3c51430b152@redhat.com>
Date:   Fri, 15 Jan 2021 15:58:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAO-hwJ+Gz_yp_vn1prREvhcU=YqVatqd_Hp+95L5i2=bcwfhbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 13, 2021 at 8:35 PM Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
>
> On Wed, Jan 13, 2021 at 5:05 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Jan 13, 2021 at 7:09 AM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > > > I wanted to apply the series yesterday, but for these kinds of changes
> > > > I like giving it a spin on actual hardware. Turns out that my XPS-13
> > > > can not boot to v5.11-rc2, which makes testing the new branch slightly
> > > > more difficult.
> > > >
> > > > I'll give it a spin next week, but I think I should be able to land it for 5.12.
> > > >
> > > > Regarding the defconfig conflict, no worries, we can handle it with
> > > > Stephen and Linus.
> > > >
> > >
> > > After 2 full kernel bisects (I messed up the first because I am an
> > > idiot and inverted good and bad after the first reboot), I found my
> > > culprit, and I was able to test the series today.
> > >
> > > The series works fine regarding enumeration and removing of devices,
> > > but it prevents my system from being suspended. If I rmmod
> > > i2c-hid-acpi, suspend works fine, but if it is present, it immediately
> > > comes back, which makes me think that something must be wrong.
> > >
> > > I also just reverted the series and confirmed that suspend/resume now
> > > works, meaning that patch 1/4 needs to be checked.
> >
> > Can you give me any hints about what type of failure you're seeing?
> > Any logs?  I don't have an ACPI system to test with...
>
> I don't have any logs, just that the system comes back up. There is a
> chance we are not powering the device down correctly, which triggers
> an IRQ and which puts the system back on.
>
> >
> > Is there any chance that some type of userspace / udev rule is getting
> > tripped up by the driver being renamed?  We ran into something like
> > this recently on Chrome OS where we had a tool that was hardcoded to
> > look for "i2c-hid" and needed to be adapted to account for the new
> > driver name.  Often userspace tweaks with wakeup rules based on driver
> > name...
>
> I don't think there is anything like that on a regular desktop.
>
> >
> > I'll go stare at the code now and see if anything jumps out.
> >
>
> Thanks, but don't spend too much time on it, unless something really
> jumps out. I'll debug that tomorrow. It's much easier with an actual
> device than by just looking at the code.
>

Well, that's weird. Now suspend resume works reliably even with your
series. It could just have been that the lid sensor was too close to a
magnet or something like that. Though while testing the old version of
i2c-hid, it was working... Such a mystery :)

Anyway, while trying to dig up that now-non-issue, I got the following patch
that you likely want to squash into 1/4:

---

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index 0f86060f01b4..dd6d9f74e7e7 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -31,7 +31,6 @@
  struct i2c_hid_acpi {
         struct i2chid_ops ops;
         struct i2c_client *client;
-       bool power_fixed;
  };

  static const struct acpi_device_id i2c_hid_acpi_blacklist[] = {
@@ -75,25 +74,6 @@ static int i2c_hid_acpi_get_descriptor(struct i2c_client *client)
         return hid_descriptor_address;
  }

-static int i2c_hid_acpi_power_up(struct i2chid_ops *ops)
-{
-       struct i2c_hid_acpi *ihid_of =
-               container_of(ops, struct i2c_hid_acpi, ops);
-       struct device *dev = &ihid_of->client->dev;
-       struct acpi_device *adev;
-
-       /* Only need to call acpi_device_fix_up_power() the first time */
-       if (ihid_of->power_fixed)
-               return 0;
-       ihid_of->power_fixed = true;
-
-       adev = ACPI_COMPANION(dev);
-       if (adev)
-               acpi_device_fix_up_power(adev);
-
-       return 0;
-}
-
  static void i2c_hid_acpi_shutdown_tail(struct i2chid_ops *ops)
  {
         struct i2c_hid_acpi *ihid_of =
@@ -107,6 +87,7 @@ static int i2c_hid_acpi_probe(struct i2c_client *client,
  {
         struct device *dev = &client->dev;
         struct i2c_hid_acpi *ihid_acpi;
+       struct acpi_device *adev;
         u16 hid_descriptor_address;
         int ret;

@@ -115,7 +96,6 @@ static int i2c_hid_acpi_probe(struct i2c_client *client,
                 return -ENOMEM;

         ihid_acpi->client = client;
-       ihid_acpi->ops.power_up = i2c_hid_acpi_power_up;
         ihid_acpi->ops.shutdown_tail = i2c_hid_acpi_shutdown_tail;

         ret = i2c_hid_acpi_get_descriptor(client);
@@ -123,6 +103,10 @@ static int i2c_hid_acpi_probe(struct i2c_client *client,
                 return ret;
         hid_descriptor_address = ret;

+       adev = ACPI_COMPANION(dev);
+       if (adev)
+               acpi_device_fix_up_power(adev);
+
         if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
                 device_set_wakeup_capable(dev, true);
                 device_set_wakeup_enable(dev, false);


---

This allows to keep the powering ordering of the old i2c-hid module
(power up before setting device wakeup capable), and simplify the
not so obvious power_fixed field of struct i2c_hid_acpi.

(I can also send it as a followup on the series if you prefer).

Cheers,
Benjamin

