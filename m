Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16ED2A81ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgKEPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:13:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730616AbgKEPNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:13:14 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8625B2078E;
        Thu,  5 Nov 2020 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604589193;
        bh=lCznpMvGuq3h8K0R23fx1rzZpVDjaxHiG5s2GHtPbmM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c6YMQgvejb88vHW01/sIVtjs9HZ5lHYub85TynOeLRl0Wo5IJlC1HmtmqC8kUIxcv
         ulmiA3pc7C/7YrM8RFJ0SwekCMEXXh8riPXoeW1sESsjP81GOSu70tCgUBSP13X7oA
         sMZ/5xZ9EgmZewhqjU5B83w1rW5L4Ew04dmiv5Vs=
Received: by mail-ot1-f46.google.com with SMTP id k3so1697721otp.12;
        Thu, 05 Nov 2020 07:13:13 -0800 (PST)
X-Gm-Message-State: AOAM5325RmU2IBhdhxsaA37A4ae1EDThZu2lAAMXui1NQsyorlaVcSoD
        5ETp9c7ueYFTcvLIDhszSv4/SYmHDJdKbo5E+Q==
X-Google-Smtp-Source: ABdhPJzv6qS1ty1wq4pONs+V7We2Eazy4XNYKljHi1aYqFquff+U7IV6X0TUmTL85ncAfvDnA0BqYOvwP9FO06EUmDk=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr1870443oti.107.1604589192723;
 Thu, 05 Nov 2020 07:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20201029195913.5927-1-james.quinlan@broadcom.com>
 <20201029195913.5927-2-james.quinlan@broadcom.com> <20201104215050.GA4180546@bogus>
 <CA+-6iNw1Z1dj8oFn8DdyVPuMUP-3+n9sKXuWYWo2rfPo5j4dkA@mail.gmail.com>
In-Reply-To: <CA+-6iNw1Z1dj8oFn8DdyVPuMUP-3+n9sKXuWYWo2rfPo5j4dkA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 5 Nov 2020 09:13:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQA_VLhez8y6HVCdFB2DZ85KoDZ1=RtbU4Mw98aQRSxA@mail.gmail.com>
Message-ID: <CAL_JsqJQA_VLhez8y6HVCdFB2DZ85KoDZ1=RtbU4Mw98aQRSxA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: Add bindings for BrcmSTB SCMI mailbox driver
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 4:04 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> On Wed, Nov 4, 2020 at 4:50 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Oct 29, 2020 at 03:59:06PM -0400, Jim Quinlan wrote:
> > > Bindings are added.  Only one interrupt is needed because
> > > we do not yet employ the SCMI p2a channel.
> >
> > I still don't understand what this is. To repeat from v1: I thought SCMI
> > was a mailbox consumer, not provider?
>
> Hi Rob,
>
> I'm not sure where I am implying that SCMI is a mailbox provider?
> Should I not mention "SCMI" in the subject line?
>
> This is just a mailbox driver, "consumed" by SCMI.    Our SCMI DT node
> looks like this:
>
> brcm_scmi_mailbox: brcm_scmi_mailbox@0 {
>         #mbox-cells = <1>;
>         compatible = "brcm,brcmstb-mbox";
> };
>
> brcm_scmi@0 {
>         compatible = "arm,scmi";
>         mboxes = <&brcm_scmi_mailbox 0>;;
>         mbox-names = "tx";
>         shmem = <&NWMBOX>;
>         /* ... */
> };

Okay, that makes more sense. Though it seems like this is just adding
a pointless level of indirection to turn an interrupt into a mailbox.
There's nothing more to 'the mailbox' is there? So why not either
allow SCMI to have an interrupt directly or have a generic irq mailbox
driver?

Rob
