Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE0B2DBD56
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgLPJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgLPJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:11:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE8FC061793
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 01:10:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b73so23979769edf.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 01:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cv2afJbDeZJNb1odPyKMoHfXMkCAGkNQaGWk4xDkS1Y=;
        b=aYow9Orkt22cpARMEbzczCYJF7d3nB8JC0mzA4kCpjQMSF8i1k5v9BLeSnmwvBWFzp
         cRzilpZhe2Hvvlfaw9vhCLO/h5Ig5nAIyBRN2k10KMKF6LH2KYgJP0gST9xCeaWoO8qO
         jFg4uFhuesKnSuW1FKLeV5P52pyg9I8v0wgtuGvR5aLOwZ0CrIyrJQPypZPwlUWTNSvB
         D6ZVFLOEUuktmmqWiBK7pBR2zeYAiP8Qe3EajqtTIlSoO1bGjIrJDRU8b9itrKo7Ne36
         zsIe4WxfKf3M4jhs7ywJOHVKFXBYcXhnbxtVfeVuVC9PoMBquvarhPtisLTQ6xSD3qlm
         pWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cv2afJbDeZJNb1odPyKMoHfXMkCAGkNQaGWk4xDkS1Y=;
        b=RG+nXhS7exOYL77GIJ6RWSsPqtUHO1lt1j7QfBLI3PYoeEMgqt61MWAJQ6KQAPZNgS
         uj3pXCeLPhMcldDQcLF8d6LW4ZqJpDUtsqgQabmTCMU2XhXpzcb4bRwX0uB0fOrKblos
         plr9+UkvIaiHW0BywaCFDjS8wH2M1MVonkFQxhG8TjNT1sgiqtBzmTfmc7F7WIVtjmTA
         r7gL6kinnmUVgpaSHociPzObk/6UoicHuNrDYpTuZyqisezhW7dYn034SLJqYVaML5Zs
         +qbBUO81s2m1uyefj4HTkdkkIp+yAIQBDX/D+vGarseVmjcNOPvAI9ryFbJujTnH/HRS
         zokg==
X-Gm-Message-State: AOAM5335UPiy9apPV4mu3hdsoq8sxkOLGn5nbzmNSMQdoBuqjFBpqwhB
        Jlkmcn1ev/voVwhgtMIpoRgeEw5EWPvoTa0WvowpkA==
X-Google-Smtp-Source: ABdhPJxFZuRzgHup4J3bDTq8jdykkcC7HXin6/9clUn2PkjgwGRqVFRdsuFAyz33PC9ado3AZRofaKMAw0/+VM13K+M=
X-Received: by 2002:aa7:dacf:: with SMTP id x15mr32490284eds.134.1608109853815;
 Wed, 16 Dec 2020 01:10:53 -0800 (PST)
MIME-Version: 1.0
References: <1607715903-16442-1-git-send-email-hemantk@codeaurora.org>
In-Reply-To: <1607715903-16442-1-git-send-email-hemantk@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 16 Dec 2020 10:17:30 +0100
Message-ID: <CAMZdPi8=9OsoCH_eV_JZohmFbuXcLv2kWNPLFzQUAKUCUHYs5A@mail.gmail.com>
Subject: Re: [PATCH v18 0/3] userspace MHI client interface driver
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

On Fri, 11 Dec 2020 at 20:45, Hemant Kumar <hemantk@codeaurora.org> wrote:
>
> This patch series adds support for UCI driver. UCI driver enables userspace
> clients to communicate to external MHI devices like modem. UCI driver probe
> creates standard character device file nodes for userspace clients to
> perform open, read, write, poll and release file operations. These file
> operations call MHI core layer APIs to perform data transfer using MHI bus
> to communicate with MHI device.
>
> This interface allows exposing modem control channel(s) such as QMI, MBIM,
> or AT commands to userspace which can be used to configure the modem using
> tools such as libqmi, ModemManager, minicom (for AT), etc over MHI. This is
> required as there are no kernel APIs to access modem control path for device
> configuration. Data path transporting the network payload (IP), however, is
> routed to the Linux network via the mhi-net driver. Currently driver supports
> QMI channel. libqmi is userspace MHI client which communicates to a QMI
> service using QMI channel. Please refer to
> https://www.freedesktop.org/wiki/Software/libqmi/ for additional information
> on libqmi.
>
> Patch is tested using arm64 and x86 based platform.

Are there any blockers or unadressed comments remaining on this
series? As far as I understand, the original blocker was the net/WiFi
mention in the commit message, that caused a legitimate concern from
network maintainer. It has been clarified now that this driver is not
for exposing any channel that could be otherwise handled properly by
an existing Linux subsystem/interface. It will be especially used as a
pipe for modem QMI channel (or AT commands) in the same way as the USB
CDC-WDM driver is doing (keeping userspace compatibility). Other MHI
channels, such as network data, QRTR, etc are not exposed and
correctly bound to the corresponding Linux subsystems.

The correlated worry was that it could be a userspace channel facility
for 'everything qualcomm', but we could say the same for other
existing busses with userspace shunt (/dev/bus/usb, /dev/i2c,
/dev/spidev, PCI UIO, UART...). Moreover, it is mitigated by the fact
that not all MHI channels are exposed by default, but only the allowed
ones (QMI in the initial version). For sure, special care must be
given to any further channel addition.

Regards,
Loic
