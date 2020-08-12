Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6DD242F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 21:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHLTng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 15:43:36 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33507 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgHLTnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:43:35 -0400
Received: by mail-il1-f196.google.com with SMTP id p16so3089052ile.0;
        Wed, 12 Aug 2020 12:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F25zreK/uMPj1Zeh3/PKOdX/kNSOqJf1CQzVccpZong=;
        b=ih3bdNbffP96OWOdGAjUwTnLFJFiVPQyXj9OSLdn10xvmcj2IKzOXdNo2dSwx+uw4q
         cQxN0U4yNFJTRxlREU6tmNu9jmLAsKiRM3eiEi7RnePTMZRGwVeJAhQxNmbEHZ24DyNB
         zuhO+UrfQxlXoHWRG1uhIjrKEq8J85nSFNR/mNaP7erHjsZgBlY78z9cjuEGnV5V4P9Q
         D1NQVwt9/HS9iu9FbkKRfP4dXvTl2IPHQfGbWLbdrUlNNd2hYebY3OQmcPOXlZ8wLf3E
         +BRdnSO1OTm73E9y3KO5zsTjZcrtQKfVo2pPVksTlfmLZecanlgFPNVwVICjQCzEE5Au
         W+Wg==
X-Gm-Message-State: AOAM53211IaQkPOfcUickkcqF1uvl2+VddEaNckfLcmJY4d/u3f/qvAt
        VmLn6rQUz4Kb4CqsAwmKo3dOML0=
X-Google-Smtp-Source: ABdhPJzXbKpQczi7VhkjG9X+vXDz4AATVf/LWQQxKg2HZu8cGQum7joDaIR3c56n1O/YtSkfWB1Qog==
X-Received: by 2002:a05:6e02:1207:: with SMTP id a7mr1177891ilq.303.1597261413373;
        Wed, 12 Aug 2020 12:43:33 -0700 (PDT)
Received: from xps15 ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x12sm1503060ile.14.2020.08.12.12.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:43:32 -0700 (PDT)
Received: (nullmailer pid 2586064 invoked by uid 1000);
        Wed, 12 Aug 2020 19:43:29 -0000
Date:   Wed, 12 Aug 2020 13:43:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, ludovic.desroches@microchip.com,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: sound: add DT bindings for Microchip
 S/PDIF TX Controller
Message-ID: <20200812194329.GA2585991@bogus>
References: <20200803081851.102570-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803081851.102570-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Aug 2020 11:18:50 +0300, Codrin Ciubotariu wrote:
> This patch adds DT bindings for the new Microchip S/PDIF TX Controller
> embedded inside sama7g5 SoCs.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v3:
>  - removed 'oneOf' from 'compatible' property;
>  - added 'maxItems: 1' to 'dmas' property;
>  - removed pinctrl related properties;
> 
> Changes in v2:
>  - replaced https with http;
>  - reworked example, included bindings;
> 
>  .../bindings/sound/mchp,spdiftx.yaml          | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
