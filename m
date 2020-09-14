Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81972694DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgINS3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:29:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34176 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgINS3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:29:21 -0400
Received: by mail-il1-f196.google.com with SMTP id a8so552040ilk.1;
        Mon, 14 Sep 2020 11:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ShVzvpvKuoiH3FPPRTmbA0lU+CM55rQc2Vy9tKyQjsA=;
        b=LQ14OW4vi/vfiMn8VWOq79M0ilhifTad7N8ruSNwujVsaegkC8t4nawBXf4PAzdkJO
         RvY8Xqw+3f5deVQ8gbZ2kD0R495JmKh/00/6hgZDlHuwgn0EWQmxDZ+7aWoF0sZcb2jG
         Hz5HLD5ghlydSEYx/LIkl2RFC2G9dD3t4NxWmXy2gBk2fKp3oYhVNAMfntkTJllgO35n
         WRhw2SH6q3kzMX8jX+cu7thom920AxJav4saTZo2r2QlECrnUHsLuOSR923vl/rREsTc
         0SBXbzFLQt2vESLHGkqkBS5+W0C3G12HwrfEhgOXr/sM4c88yEeWJl5rpMB/TM/Wy6AR
         EMzw==
X-Gm-Message-State: AOAM531cI3opsQx3I27BdXqpTgl0qYxdiELb4zRdktyxHUi+OtPoTMny
        ndvTPDManCqPZxc/txXUzQ==
X-Google-Smtp-Source: ABdhPJy3jjcb0K3K5KjxGGEOIkC2lOncULnJ8ZLf2tGmO97sN6z9yio3OrGynPsv1mkXTwsvvOiOMg==
X-Received: by 2002:a92:91dc:: with SMTP id e89mr12279862ill.27.1600108160382;
        Mon, 14 Sep 2020 11:29:20 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e14sm6274979iow.16.2020.09.14.11.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:29:19 -0700 (PDT)
Received: (nullmailer pid 4193216 invoked by uid 1000);
        Mon, 14 Sep 2020 18:29:16 -0000
Date:   Mon, 14 Sep 2020 12:29:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     cy_huang@richtek.com, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, gene_chen@richtek.com,
        linux@roeck-us.net, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, matthias.bgg@gmail.com
Subject: Re: [PATCH v5 2/2] usb typec: mt6360: Add MT6360 Type-C DT binding
 documentation
Message-ID: <20200914182916.GA4193162@bogus>
References: <1598928042-22115-1-git-send-email-u0084500@gmail.com>
 <1598928042-22115-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598928042-22115-2-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Sep 2020 10:40:42 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add a devicetree binding documentation for the MT6360 Type-C driver.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/usb/mediatek,mt6360-tcpc.yaml         | 95 ++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
