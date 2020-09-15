Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FCC269AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgIOBDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgIOBDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:03:31 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D936C06174A;
        Mon, 14 Sep 2020 18:03:29 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a22so1237784ljp.13;
        Mon, 14 Sep 2020 18:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E1q14rQlgrSLatoty0jVapm3PrkVuxqei5oD9yAnTYA=;
        b=TQ0tAo4Lk8BmjNMpUM7B2v2eJgGqHIHTW2E4/JxHYLBPYEbL2GOEXa3hYcB88YPV+D
         rsXL6SY9r8ASAgE8jpvkJDHh7GmJRqXRkxR6+qr8+tk9bxXzavjg3CwjSUtf9LgQObtW
         Z+EHPWbFuFvC2eCxhz4QYvrSwCiSTExOiHWEXRxGeQE6M2sHxISOTWmc4reYPsdTqqTf
         FdUJ/4a9+XPrM3y0O/QWI4f2oR7SR4EtfK7OXk6DnUduKU/fV/k6zykUVgrBbLdSMGcs
         OguZcbCFAGKIoxi3jOmgPotq4ZsnC5XQS4jk6GvHyMXC+pkQkfjwBclCIyq+G4XyQTD1
         eiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E1q14rQlgrSLatoty0jVapm3PrkVuxqei5oD9yAnTYA=;
        b=Bw3FiwWrJAyIB8lDrbNRHplDrziMjmHy1U/+ccJljGtSS+IPGkJ06br5IKDM7pMlrd
         HagumRy6edKOPcPt1RA5fKKl2D/msfsvgD4zhGI+HWIGG0sGeI9P6OuqRwk2co8Fm8ll
         0ZqhgV6CtU3k9l2KP6bnT8YEdG04Pzdqpa/r/+rA0HNH7axR7Uocs6NdgLKl1kotrMMA
         qdyR9YHlyXjqCVfzLb8mI+R5AZHWBZfRjcue7iPMqnsADqwxq9sbxPNSI1Qrj9iNzC4/
         Qx9ctbzXewsEWOaPphGDqOHQyYONuzZVxoTCSO9pmvus9OOoZFU04Cga3j+3FshF5F/k
         mKwg==
X-Gm-Message-State: AOAM531JoDVe9vynewwWkILloEDuGPOxz3T4GnRtSKga16hyq3glW8RB
        6ZefVUswhTnZad+mGmI391bCf2kj0asfKRlmVFs=
X-Google-Smtp-Source: ABdhPJw9ifkbVP+uEe2SD7R2hIj95UXfSck4Zwdz+D0V/9bCy7pHGJ86/66K1wgr6YE3PVf6c5+qVxJJUbQVva9yrXk=
X-Received: by 2002:a2e:9955:: with SMTP id r21mr1824267ljj.119.1600131807796;
 Mon, 14 Sep 2020 18:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <1598928042-22115-1-git-send-email-u0084500@gmail.com>
 <1598928042-22115-2-git-send-email-u0084500@gmail.com> <20200914182916.GA4193162@bogus>
In-Reply-To: <20200914182916.GA4193162@bogus>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 15 Sep 2020 09:03:15 +0800
Message-ID: <CADiBU3-Rn9wPNh_17U9yiDmhHSRcxb5L3nqtg+qigbmiYBjrbA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] usb typec: mt6360: Add MT6360 Type-C DT binding documentation
To:     Rob Herring <robh@kernel.org>
Cc:     cy_huang <cy_huang@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, gene_chen@richtek.com,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        matthias.bgg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8815=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:29=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 01 Sep 2020 10:40:42 +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add a devicetree binding documentation for the MT6360 Type-C driver.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../bindings/usb/mediatek,mt6360-tcpc.yaml         | 95 ++++++++++++++=
++++++++
> >  1 file changed, 95 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt63=
60-tcpc.yaml
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>
Thx.
