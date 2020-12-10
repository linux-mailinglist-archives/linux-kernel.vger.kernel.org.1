Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0752D5CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389820AbgLJODc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:03:32 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39943 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389714AbgLJOD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:03:29 -0500
Received: by mail-oi1-f195.google.com with SMTP id p126so5796775oif.7;
        Thu, 10 Dec 2020 06:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=39LGye6padbJ1h7qO5yojPgi+E8q8E6FfLpRVUKm1mY=;
        b=uY1zmbyFsnh8qoP+jQ1gclNu5tTG4uC1iwzsMOX9Uk+/83WgSOHkaXuOnR7XIGCqoi
         /Wfhmzfg3rdLUWMpXG6gG536g8wJ7y+I6p5s3g2RA9UolTUEaCijHsQVKRWLIMMCnzg0
         GFTKB7rhupm+wdyUbc43q4etMe5nbP3tedokhMS6Ohmr+FGqXp0/0AiqJeN0AAtaeUjV
         r1LoGkbgBw+SKQ/h1kDju4KpbgLHcQSHM2ZNYok12Nje4XkvKHNRrvtGVJ76Dbu4KWk9
         I0IIcdmfBiDqwanDJDds3NY33A/0kfJfcj+SxyUk1iE3DWFWXMELU/aewp7V37PZ0yIp
         oCtg==
X-Gm-Message-State: AOAM533vFx+pvrXKdehm7+3EN68c3urtdGiqdNp8qHp8c3Owgz3gZGTd
        /vWcXIHU4yjClduBO55WPA==
X-Google-Smtp-Source: ABdhPJw5oIIwqgy0lXZKIoNURfttba4FSS7t7ggIjw5817ESI8NNtywOdNIpV1BM8ic55p68J6lw7A==
X-Received: by 2002:aca:5dd7:: with SMTP id r206mr5399970oib.30.1607608968763;
        Thu, 10 Dec 2020 06:02:48 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v207sm1013220oif.58.2020.12.10.06.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 06:02:47 -0800 (PST)
Received: (nullmailer pid 2424790 invoked by uid 1000);
        Thu, 10 Dec 2020 14:02:46 -0000
Date:   Thu, 10 Dec 2020 08:02:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 4/4] dt-bindings: reset: convert Hisilicon reset
 controller bindings to json-schema
Message-ID: <20201210140246.GA2424759@robh.at.kernel.org>
References: <20201208124641.1787-1-thunder.leizhen@huawei.com>
 <20201208124641.1787-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208124641.1787-5-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Dec 2020 20:46:41 +0800, Zhen Lei wrote:
> Convert the Hisilicon reset controller binding to DT schema format using
> json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../bindings/reset/hisilicon,hi3660-reset.txt      | 44 -------------
>  .../bindings/reset/hisilicon,hi3660-reset.yaml     | 77 ++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
