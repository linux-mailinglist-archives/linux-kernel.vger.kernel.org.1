Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8901E6FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 01:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437432AbgE1XDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 19:03:21 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:41260 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437356AbgE1XDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:03:14 -0400
Received: by mail-il1-f196.google.com with SMTP id d1so639821ila.8;
        Thu, 28 May 2020 16:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ctiRhZJqkq9GPLI1qnw2R8C8DD3A/KqAjotWPV/6zk=;
        b=mmyaaBidu5VMqwjbfN7dNUiTULJGHJKt5gq/hkLEHiPR6ZOX/eAjVIGez3GklQPHd8
         8l1Lvfp16T78s1yN77FTDsMtfrnyEqgXjjCF243Kc01XiBpNttBJygaMocvYWMFnv1G7
         Q/JMJrSqkfO8PGoo2MCijtxF/JBtS0gAxGCStv4irRK8jMQvyjBwtvZPC8VytqdpmkWw
         bwD07ph5wYdB/h2K3AAngoFod4NCTbr0CoTZFuSfwsHGCtuG1p6e+0rRLRx1tKazz5wA
         f3YUDTzBI1RsAO29n1nnsBxm4dspm6UfZp9T9dI+SLS0+kQMqkA9alGdzU75koz7PDRA
         vAsQ==
X-Gm-Message-State: AOAM532Slh3tcC3nzPAf4s/eJ+4/kkil75H0YisOAXCy6ijltm9+4RPq
        SsHs4ynnCnkezomIDVdZpw==
X-Google-Smtp-Source: ABdhPJxEsCezKmw3TYs8HpLuM/wSex2W7FhhK1kpR3KO4YDloi5nu/AF+sDdd5riZydKHN5bukUDxQ==
X-Received: by 2002:a92:5a5d:: with SMTP id o90mr4915661ilb.206.1590706993159;
        Thu, 28 May 2020 16:03:13 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t22sm3042515iom.49.2020.05.28.16.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:03:12 -0700 (PDT)
Received: (nullmailer pid 842110 invoked by uid 1000);
        Thu, 28 May 2020 23:03:11 -0000
Date:   Thu, 28 May 2020 17:03:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Jason Cooper <jason@lakedaemon.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 7/9] dt-bindings: spi: Convert spi-pxa2xx to
 json-schema
Message-ID: <20200528230311.GA842052@bogus>
References: <20200521091356.2211020-1-lkundrak@v3.sk>
 <20200521091356.2211020-8-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521091356.2211020-8-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 11:13:54 +0200, Lubomir Rintel wrote:
> A straightforward conversion of the the spi-pxa2xx binding to DT schema
> format using json-schema.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Drop #address-cells and #size-cells
> - s/GPL-2.0-or-later/GPL-2.0-only/
> 
>  .../bindings/spi/marvell,mmp2-ssp.yaml        | 56 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi-pxa2xx.txt    | 27 ---------
>  2 files changed, 56 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/marvell,mmp2-ssp.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
> 

Applied, thanks!
