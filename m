Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56D8280801
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbgJATp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJATp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:45:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD58DC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 12:45:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v23so5686115ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 12:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2gfbOiiR0so3N0eX6gQPc6WKY7PeKJeRfa9G0R50hA=;
        b=L8wFd+HleRUy2It+KmWJB1fwyoQVZjtyVGCA52KJRhRXbSNUGkkwN3/7mIaxQepJR7
         iuog+JhLqKQBpndNTN35oHdPDn2rnXahO3Xx7vmOsxZXqDUs1JrtwY5UwiWm423plAQj
         lo4HD9GZCPKZ25/bwDhXwjYcudcL/Zg3xzqRhLqf4r9rXjw1u5njkPwGOnFinErUgbBz
         YCDMiwdlkMrqWJj2GxZ5QqLrv8qMsrR+Iqj0LfK5k4TPlCzy3PughEAPTlwiNRXlpGVR
         XFx8eCdsk0HIUFNeGUhrVgk3rWB5BrHFd9Ow8NqbjOPmaYbuAs3sCg2YWbchqAuzJNzK
         2vUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2gfbOiiR0so3N0eX6gQPc6WKY7PeKJeRfa9G0R50hA=;
        b=OY6v7wefa4eYo7/PdK2HSolMDXbIe6OiR0u/rzK/Lwsx1F5IIK2Mis6b7ZUsKPY58O
         1n9p76FATzuEwf7jWdRs/0qalvBDKsL5t8J/0vvyjTE9ufO/VF8EbFzUvJvWtk4wrYKb
         Ac4PiIb4Ii1acyY7VZI02vWPW7ZNX+0+EaSPcnTmhgQ4tvRAoQNNZxfDvMs9xQA7dpxz
         YjI0wrJPlkyc6auhBcU4Ww+3/uIcxuBgei5QaSzUDJtyajn2IjbHtrjNGMH1oQGEtsVY
         IDqQuqpoTnT8m/+Em1cOJBMLf5tx83WsDTI1VK8trsj+eUUG/67PEyBD9K0bB/JJ4un0
         udQw==
X-Gm-Message-State: AOAM530yJMvj3ECECL2KJtubpY1v9jGCjiGq8j6AZZO68LFAn3yp4yTo
        J3aMrmqwXXBXxVk0OZd/fOT80heKGsIvoqGZUT3Apw==
X-Google-Smtp-Source: ABdhPJzhr62N6D/DY0NMD6Re7tm+lJuTbYgAQTgrVa6ZpBk/+rg4S7xE0mJMNKGk9FcSYDYEXfBWz/WFBYcaS/gYx8o=
X-Received: by 2002:a2e:804f:: with SMTP id p15mr2979567ljg.199.1601581557161;
 Thu, 01 Oct 2020 12:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <cfce2276d172d3d9c4d34d966b58fd47f77c4e46.1599120059.git-series.maxime@cerno.tech>
 <20200929221526.GA1370981@ubuntu-m3-large-x86> <20200930140758.gummt3umouva3wyu@gilmour.lan>
 <20200930163823.GA237050@ubuntu-m3-large-x86> <cacbaef2-4221-50d8-3c5d-efab9f1a9c04@i2se.com>
 <20201001064843.dlewcu3b7dvqanyy@gilmour.lan> <20201001085402.t6mzzwzplviunhoc@gilmour.lan>
 <CAAvKZ65WqQqH-9JVdb5M6HcKbR3yQdvZha8n9UXXCfciYRq4aA@mail.gmail.com> <8bc3f2b0d1b5ae59996bc9316a401a68c92ebac7.camel@suse.de>
In-Reply-To: <8bc3f2b0d1b5ae59996bc9316a401a68c92ebac7.camel@suse.de>
From:   Tim Gover <tim.gover@raspberrypi.com>
Date:   Thu, 1 Oct 2020 20:45:45 +0100
Message-ID: <CAAvKZ65qyKDrmzHR=HELJmrRdchJ8MEXJZJGcj1oyNXg-BamZA@mail.gmail.com>
Subject: Re: [PATCH v5 80/80] ARM: dts: bcm2711: Enable the display pipeline
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, my previous statement was misleading.

enable_uart will select the mini_uart for gpio14,15 unless the
disable-bt device tree overlay is loaded. As well as disabling
bluetooth disable-bt swaps the uart0 pin configs to point the regular
UART to gpio 14,15. After resolving the DT overlays the firmware does
the initial UART setup according to which controller is pointed at
pins 14,15.

I'll have to speak to others about exactly when the fixing of the core
clock takes effect. There have been a few changes related to the
initial turbo frequency configuration and how this is reported via the
mbox APIs

On Thu, 1 Oct 2020 at 17:47, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Tim, thanks for the info!
>
> On Thu, 2020-10-01 at 11:15 +0100, Tim Gover wrote:
> > hdmi_enable_4k60=1 causes the firmware to select 3.3 GHz for the PLLC
> > VCO to support a core-frequency of 550 MHz which is the minimum
> > frequency required by the HVS at 4Kp60. The side effect is that if the
> > display clock requirements are lower than 4Kp60 then you will see
> > different core frequencies selected by DVFS.
> >
> > If enable_uart=1 and the mini-uart is selected (default unless
>
> What is the actual test made to check if mini-uart is selected? I can't get
> firmware to trigger this behaviour with 64-bit upstream kernel/dts. Note that I
> see the core clk setup at 200MHz just before having VC4 set it to 500MHz.
>
> The only thing I've got on my config.txt is:
>
> enable_uart=1
> arm_64bit=1
>
> Maybe we're missing some kind of DT alias upstream?
>
> Regards,
> Nicolas
>
> > bluetooth is disabled) then the firmware will pin the core-frequency
> > to either core_freq max (500 or 550). Although, I think there is a way
> > of pinning it to a lower fixed frequency.
> >
> > The table in overclocking.md defines options for setting the maximum
> > core frequency but unless core_freq_min is specified DVFS will
> > automatically pick the lowest idle frequency required by the display
> > resolution.
>
