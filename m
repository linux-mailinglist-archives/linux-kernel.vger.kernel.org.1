Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8500B2A6F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbgKDU6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKDU6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:58:42 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633BAC0613D3;
        Wed,  4 Nov 2020 12:58:41 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id i12so36304qtj.0;
        Wed, 04 Nov 2020 12:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fBKwU/T8wqjOTI4gGxRpD2HFpArINM+J0+Z9WjBQy4k=;
        b=TIbSw/QHl+XBf/D5ipFdQM0LbDeQ6HlZKf0cO1GwN/XgXI1e1Csa/P2v1XlUHLioWF
         2+UCcLu3TLr6fQHp5U0ANs0LBS7oIM/rb0JGNFP4fgGw9sU1EbH4S2VkPctpIRb6kXCy
         8oQhTOSotKXzCiIJaYYlBkiS0NGwiQGY7gtB3Y1Y5OFLYuN0JNFEsqVTWifSRYNGeVmQ
         ClGP7YlPsmgdRRdU9pje5vjSiBWVCb72UF1vyLcNKE5pmHlCVCDU0jsvic6ZsRngPH0z
         F+yjLelfftxrHoJom5hgeuXpX5Q+CrE99kz82cuQ4YXpGffeeOjxet3k++O6qSYCnAS8
         MRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fBKwU/T8wqjOTI4gGxRpD2HFpArINM+J0+Z9WjBQy4k=;
        b=qGyInJcft+kAL//vpvcL4y+YrM/1iHSps8ZWJ13WmfCXD+KZvcN1qOLhHCRtSE9EQE
         X7kMuXXn4JCo5TajpUO4BhkAGnZx0DdCtcWTMyMMN/W4t12N/7SaR0XSErTaIcaRH2BR
         TUrBsfMEQjdy3nyfO0lsK/o5kNdcYk0Sv4NRN4FAYx458ajm6YQUMKMwqj9ERoXg6KxZ
         LyuxGUeZCTcIKXKIehMciM5T3wWxT3abfyMtPSanufWE+Ep18bE9OvV64fT+MZSlqSxV
         08TRbTyRGnKVFzSK3au6s1n/AjJORC0QncrcrjkT1dwFPqORb9zrmHCqQSeSEz/PzlLM
         Xt4Q==
X-Gm-Message-State: AOAM531R2Zwif8JK/YYyP3mWQE82Mhr/rfwkpFmRdqExiW/kTSchs1sw
        z4Yc30EDIbGPSGbwSpNGJL0=
X-Google-Smtp-Source: ABdhPJxR72eTVdzXASKG3LN9rH07q7ZgQPzAE/8m4oZXrZPiMERAenaceBPqQ07Oc5KkD/X08vPQzA==
X-Received: by 2002:ac8:7313:: with SMTP id x19mr21848845qto.293.1604523520656;
        Wed, 04 Nov 2020 12:58:40 -0800 (PST)
Received: from ubuntu (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.gmail.com with ESMTPSA id e188sm3356534qkf.128.2020.11.04.12.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:58:39 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:58:36 -0500
From:   Vivek Unune <npcomplete13@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     hauke@hauke-m.de, zajec5@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: BCM5301X: Linksys EA9500 make use of
 pinctrl
Message-ID: <20201104205836.GA783888@ubuntu>
References: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
 <20201104202952.783724-1-npcomplete13@gmail.com>
 <20201104202952.783724-3-npcomplete13@gmail.com>
 <c0d62a2e-59e2-c811-f5bd-e7299f540ca3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d62a2e-59e2-c811-f5bd-e7299f540ca3@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:37:45PM -0800, Florian Fainelli wrote:
> 
> 
> On 11/4/2020 12:29 PM, Vivek Unune wrote:
> > Now that we have a pin controller, use that instead of manuplating the
> > mdio/mdc pins directly. i.e. we no longer require the mdio-mii-mux
> 
> I am a bit confused here as I thought the mux was intended to
> dynamically switch the pins in order to support both internal and
> external MDIO devices but given the register ranges that were used,
> these were actually the pinmux configuration for the MDC and MDIO pins.
> 
> This does not break USB and/or PCIe PHY communication does it?

Hi Florian,

The external and internal MDIO logic is controlled by mdio-bus-mux.
Which controls the BIT(9) of the mdio register. This stays.

The removal of mdio-mii-mux and it's replacement with usage of
pinctrl doesn't affect USB3 or PCIe. See below USB3 detection.

[ 4295.450118] usb 1-1: new high-speed USB device number 2 using ehci-platform
[ 4295.690183] usb 4-1: new SuperSpeed Gen 1 USB device number 2 using xhci-hcd
[ 4295.721888] usb-storage 4-1:1.0: USB Mass Storage device detected
[ 4295.728349] scsi host0: usb-storage 4-1:1.0
[ 4296.811047] scsi 0:0:0:0: Direct-Access     SanDisk  Ultra Fit        1.00 PQ: 0 ANSI: 6
[ 4296.821159] sd 0:0:0:0: [sda] 60063744 512-byte logical blocks: (30.8 GB/28.6 GiB)
[ 4296.829667] sd 0:0:0:0: [sda] Write Protect is off
[ 4296.834502] sd 0:0:0:0: [sda] Mode Sense: 43 00 00 00
[ 4296.834864] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 4296.852604] GPT:Primary header thinks Alt. header is not at the end of the disk.
[ 4296.860079] GPT:1540387 != 60063743
[ 4296.863586] GPT:Alternate GPT header not at the end of the disk.
[ 4296.869600] GPT:1540387 != 60063743
[ 4296.873090] GPT: Use GNU Parted to correct GPT errors.
[ 4296.878266]  sda: sda1 sda2
[ 4296.884416] sd 0:0:0:0: [sda] Attached SCSI removable disk


Thanks,

Vivek
