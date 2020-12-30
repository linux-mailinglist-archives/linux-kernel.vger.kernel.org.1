Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212DA2E7D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 00:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgL3XZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 18:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgL3XZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 18:25:22 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6DAC061575
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 15:24:42 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n26so23663440eju.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 15:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kMNFm8ebIuItWKDvrj3xBA1Bsn2nUWXnMPwJswbaR+E=;
        b=uu86qXtwL1PIIG0UG9BMgMJ4c2ZxlXaQroeVmfqy2brWjSSk8C/3lq6n9APe174cFH
         gZWgku5F5yJgikuE0KwVkyQ672qRnX12/y9D17JuxH+XPN7LychGh/tT8XhS4sExINn9
         iIbEVtxoT4y17IwqSMXHFBD5gG2bM4/2hmqFDM/Q6/hilbTJWYG4CvIqqXau1Xzl5x92
         nB2qFZU99niHa3lFIlcCNI2gwLWf+GHPQoh7MF9k47ZPlmFAC37AEQ9TiU5NuD/C8FMm
         K0L4XISsbcazrJi+QjVjeKL1FRkXqIu5QRREM33JWvv1sttbvxUui5Vxk42W3u3QuUqc
         au6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kMNFm8ebIuItWKDvrj3xBA1Bsn2nUWXnMPwJswbaR+E=;
        b=VRu8v5iqlThgPHps3WQSEBnFZGzadVU/9h0Lj/3nycOlqlQCl0IPBqTMMyq29NHQJ7
         VVoF2lWjhvMbB8gN0t6J0xE2QQtqaZQYW9S3lWoyXT/1g23kOW/Qz8kpv1HHdRC47c6h
         3a81rXiBk+XiwIuNkOVO+kH/VJMJaSqhBl/QlQPr4MsA7xn9RLGMezNcH4L2CHZNARSv
         e/4Ruvc5GulNcDaTnM60xuQuz68tksnALT45tYN/H/kmssZKvDTVTm/AGyxIf/eLdbWq
         G+GyhhKg20cbYQR7THo0bgU3x0S/x/Z2kU+rVhThCAMW9mI8Si7zzySg8piTXvWmNVJR
         4SfA==
X-Gm-Message-State: AOAM533f1FtLfp/emVsJveIww0Vnb2N8XAY4Ojl84e3tiUz3PdVAV35q
        zy1O1uoiwlgnbsXha2qB6l7mDVzekgXCPGaMrbRO3iBu9Y4=
X-Google-Smtp-Source: ABdhPJxFwGExrQ/UAiqNVh0VJyQGgChhiNEMBWP2Gjc02ULU3SphCxh9Z5gMdS6n8/KU06h8Vi3LG3M49DxCbNN9W6o=
X-Received: by 2002:a17:906:a415:: with SMTP id l21mr50334789ejz.2.1609370680794;
 Wed, 30 Dec 2020 15:24:40 -0800 (PST)
MIME-Version: 1.0
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 31 Dec 2020 00:24:30 +0100
Message-ID: <CAFBinCA4EnbJZ5HnWzqP-LdLJE0FD_nGqA6PxdQaR5KfETgvTQ@mail.gmail.com>
Subject: discussion: re-structuring of the Amlogic Meson VPU DRM driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil and all interested people,

in the past there were concerns about how some of the components are
coupled in our Meson DRM driver(s).
With this discussion I would like to achieve four things:
1. understand the current issues that we have
2. come up with a TODO list of things that need to be tackled as well
as recommendations how to solve it (for example: "driver ABC function
ABC uses the recommended way - take that as reference")
3. one by one work on the items on the TODO list
4. add support for the 32-bit SoCs to the Meson VPU DRM driver
(without adding more "not recommended" code)

Disclaimer: I am not familiar with the DRM subsystem - so apologies if
the terminology is not correct.

drivers/gpu/drm/meson/meson_dw_hdmi.c currently serves four purposes:
1. manage the TOP (glue) registers for the dw-hdmi IP
This is Amlogic specific and consists of things like HPD filtering,
some internal resets, etc.
In my opinion this part is supposed to stay in this driver

2. load the driver for the dw-hdmi IP by calling dw_hdmi_probe()
I read somewhere that this is not recommended anymore and should be replaced.
Is my understanding correct and what is the recommended replacement?

3. it manages the HDMI PHY registers in the HHI register area
For the 32-bit SoCs I will not follow this pattern and will create a
separate PHY instead.
As a long-term goal I think we should also move this into a dedicated
PHY driver.

4. call back into VPU/VENC functions to set up these registers
This is a blocker for 32-bit SoC support as I would have to duplicate
this code if we don't make any changes. This includes things like
calculating (and setting) clock frequencies, calling
meson_venc_hdmi_mode_set for setting up the DVI pixel encoder, etc.
My understanding is that this part should not be part of the
meson_dw_hdmi driver, but "some other" driver. I don't understand
which driver that's supposed to be though and how things would be
wired up in the end.

In addition to HDMI my understanding is that for adding MIPI DSI
support you would
a) either have to follow the pattern from the meson_dw_hdmi driver or
b) also require some better way to achieve this

The biggest question marks for me are #2 and #4 from the list above.
Also is there anything I have missed?
Any input, feedback and questions are welcome!

PS: an additional topic on the TODO list will be "use the common clock
framework" for clock setup. it's currently not clear to me if that's
possible on the 64-bit SoCs in all cases.
I will start a separate discussion for that topic after this one.


Best regards,
Martin
