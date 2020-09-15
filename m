Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A521026ADC3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgIOTjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:39:51 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36869 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbgIOTj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:39:26 -0400
Received: by mail-il1-f194.google.com with SMTP id q4so4177497ils.4;
        Tue, 15 Sep 2020 12:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U2UgDFJ0TKRmCCDAAa0CKQN3PAXzQGowR+Y1XmFZbhs=;
        b=Q+hXpjyKg+gDJhg2wToXdDpgSkgcfDJKIH2XnSwjy0N+ZLQA1ZOg/qvlKOmPhK2MCE
         2CSdKGlsIYBCRrauxaSCBa4jY+ftt8dO4bcKjSlm7hyh/WYy/4gpzyKJTcO4QWAi8k1W
         rIBsA0aRYpnkRaoz4mFTI2afD02N7U5PKxKstvJW64qfKjxSKbjsj5OhUjENwOAfqlnw
         V76b4V3q6E/unaPC5ecbJgPP+ahrdO0psxok2OT1H6uL6q0R4u8fIMNzHxPp8jtQZCri
         o2eKrVethF5T23rmVM4umO1+x4WIhLOyO/15XZ/TCYkx/mo9CW0BdG3ihqHpXaHBqVvG
         cnrQ==
X-Gm-Message-State: AOAM532BLer/e1t9zE5R4IO22ox0R/iVh6fB0qZLD4fZSfz77YMoGZEu
        40AMx/Vrey9xXl9YcVklbQ==
X-Google-Smtp-Source: ABdhPJybqsFHREh3Yp9e8K/w33mykPZgUyZ7UjYfSpEI9dtCqo5QPP9N+6j1Ro+kJbdo4yd60ytE/Q==
X-Received: by 2002:a05:6e02:d85:: with SMTP id i5mr17620009ilj.115.1600198765639;
        Tue, 15 Sep 2020 12:39:25 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m87sm9620598ilb.58.2020.09.15.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:39:24 -0700 (PDT)
Received: (nullmailer pid 2375353 invoked by uid 1000);
        Tue, 15 Sep 2020 19:39:22 -0000
Date:   Tue, 15 Sep 2020 13:39:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] dt-bindings: mailbox : arm,mhu: Convert to
 Json-schema
Message-ID: <20200915193922.GB2362311@bogus>
References: <7f50b23d157a97242c79bd8f2ab649a9272b9b59.1599731645.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f50b23d157a97242c79bd8f2ab649a9272b9b59.1599731645.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 03:25:18PM +0530, Viresh Kumar wrote:
> Convert the DT binding over to Json-schema.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3: New patch.
> 
>  .../devicetree/bindings/mailbox/arm,mhu.yaml  | 86 +++++++++++++++++++
>  .../devicetree/bindings/mailbox/arm-mhu.txt   | 43 ----------
>  2 files changed, 86 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> new file mode 100644
> index 000000000000..4e840cedb2e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0

Also, as Jassi/Linaro is the only author of the txt file, please dual 
license.

Rob
