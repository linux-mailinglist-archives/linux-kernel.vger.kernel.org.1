Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA94A1ABBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502558AbgDPItQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 04:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502758AbgDPIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:44:22 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E4DC03C1A7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:43:31 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b7so13393789oic.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykDjvtxv4Q2KeXX83+m1/r5YqBgMSd9dJ4muRIWqoK8=;
        b=sTtX0xPof16ieMD0Q9OdwI0NgjF/5AfTvpLiSV8y9MbHQuapST//WTvCgs1LhmMB/w
         ltPjhVc7fz135Ygr7sOa5IK+HaQdpyz/InJXeSWuxtXsWPPZy0uBaatPkI+Lc9lHdAn6
         20iOMacLvX4sttfW6pW8XAqDOz7Bwn8/ptj70PbeazMMqNLmjF9kd8Q/nUlOzlNFi5Ke
         7ZBEIsWWaUPDQQXnL5TlrPwok27nzT9jJ7s7YylaHtmNDtyfhiE+xPq+mQL8FtWhCquD
         cBEglwnIAdIbkGUObP3+Kn8YaUCPMmjpg1dv106flH+bZeFyO88/3UgEUf7DI9L8arWQ
         3BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykDjvtxv4Q2KeXX83+m1/r5YqBgMSd9dJ4muRIWqoK8=;
        b=iQKJAPciZroZujavisLJxSRqjxxC+HwTlru4cXjxerw+fLTeBcwFN5nZQxBYTC9I66
         pLq4NgZHLwUP/Q8F2TJZiHtAGRFRbMUhjCB8t+GVqnX1KspFC6XiU8oJrnztzQqOdZPN
         KG04rJBtAl2AhCxRK6A6EqMAB6D/JGfj0fXV58z1rrPXmHBR3gCPYUFL5ge3FTQJ3Fsj
         BAgLMH9iEkwqrboETxYOJuviNRB9hwzH2MbUYYJ2iItfkiWddz3mBpeMhmdhlayPrZNv
         //dyWyDd2uhDOBFEEiIlKapCTEQaaXGrlrebyWwJYougP0t99SO4M6eFTODHGJmpNquC
         if3g==
X-Gm-Message-State: AGi0PubwngecbArWmvH5Jg9Q1cMjm1V122ofZbTxlZIq6AUEFOrmY7Mg
        AcQ+UV21d4m1KXXMM7yfXeNMyc3Le35DBvCj4DbKzg==
X-Google-Smtp-Source: APiQypKA0tsSgmkVKs1bVQXUH8aVDS5ErxQUQokg0NYz0kQHISsOtgMVqpA9ywjDpHxMmo0pN5cR4SI23dw3PEHfkJc=
X-Received: by 2002:aca:4d86:: with SMTP id a128mr2238387oib.96.1587026611441;
 Thu, 16 Apr 2020 01:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200415150244.2737206-1-robert.marko@sartura.hr>
 <20200415150244.2737206-2-robert.marko@sartura.hr> <91e6a0bc-2189-69b7-ddca-14721dc6ca1a@gmail.com>
In-Reply-To: <91e6a0bc-2189-69b7-ddca-14721dc6ca1a@gmail.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 16 Apr 2020 10:43:20 +0200
Message-ID: <CA+HBbNF22tXVtOQkZJ0JHi_ryeeUnnH3hZuxuHFcyTAxZ_Z2nQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: add Qualcomm IPQ4019 MDIO bindings
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 1:55 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 4/15/2020 8:02 AM, Robert Marko wrote:
> > This patch adds the binding document for the IPQ40xx MDIO driver.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>
> Please do not drop tags when they were given to you in an earlier version.
Sorry, I did not know that.
Wont do it in future,
thanks
> --
> Florian
