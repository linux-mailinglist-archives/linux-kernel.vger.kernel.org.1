Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190FF1E7000
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 01:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391528AbgE1XFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 19:05:54 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41507 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391479AbgE1XFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:05:52 -0400
Received: by mail-il1-f195.google.com with SMTP id d1so645842ila.8;
        Thu, 28 May 2020 16:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VvqN/oDoNwzvlnZA88yP5/utg3xHmVNHiIF/avCzb2Y=;
        b=i5z5pxbXKN0cw2vy/K4G2vwlvhQSdFkUr+Enx2rnKciH6tvVgbBTBeFRR+Z6YOnr9F
         EzpAeO+03s6kVLbZg+wU4XY+TqyB1SfUjEWtGcMobGHr5mdQLLEhryO047hwTPRabRKP
         +ESSClDyXl2GVBXjx3AppbR/LBXT100tzVc67nVzbiCah+DnASiatKLS0rIuYCugvtHV
         QxoM0Uc4VKKxsftGSkmfn6vxLkWTwroRsegKaj74OGSn1CBmtNJKozvW2tyTVfeLWUTp
         BVqKX5Yisd8ejvz3ENp47xbC9qKf79dike5uQv4pbOTNhvEwkoealX1IwpJfU+gxvVFA
         qFRQ==
X-Gm-Message-State: AOAM532xvXnjePifeEWsNKSAX0obZhesHICeabSrWJiGJ3Pbsy+NKSGh
        cnRkNytw+YEPlY0F0Zi1gA==
X-Google-Smtp-Source: ABdhPJxg3gvRTZK70YFNM+YsMmqVV2mj9HEEcnLZ9Kt/WJ5NGd+pc/Uoe3VuIvw2K5r5oGukL7Vfig==
X-Received: by 2002:a92:c88b:: with SMTP id w11mr4796589ilo.244.1590707150647;
        Thu, 28 May 2020 16:05:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f9sm3930037ile.39.2020.05.28.16.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:05:49 -0700 (PDT)
Received: (nullmailer pid 845762 invoked by uid 1000);
        Thu, 28 May 2020 23:05:48 -0000
Date:   Thu, 28 May 2020 17:05:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 9/9] dt-bindings: usb: Convert ehci-mv to json-schema
Message-ID: <20200528230548.GA845704@bogus>
References: <20200521091356.2211020-1-lkundrak@v3.sk>
 <20200521091356.2211020-10-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521091356.2211020-10-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 11:13:56 +0200, Lubomir Rintel wrote:
> A straightforward conversion of the ehci-mv binding to DT schema format
> using json-schema.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - s/GPL-2.0-or-later/GPL-2.0-only/
> 
>  .../devicetree/bindings/usb/ehci-mv.txt       | 23 -------
>  .../bindings/usb/marvell,pxau2o-ehci.yaml     | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/ehci-mv.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/marvell,pxau2o-ehci.yaml
> 

Applied, thanks!
