Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692AF27D81E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgI2U34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:29:56 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:42558 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgI2U3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:29:55 -0400
Received: by mail-oo1-f67.google.com with SMTP id g26so1624429ooa.9;
        Tue, 29 Sep 2020 13:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FTi6LMy/4F0hyTkg+sOtqFPHtr4skrXHQdZZfvLvsfQ=;
        b=G9gKNbCaw7NGcK1xNanctN6s6Uy4Q9Jc6aCR7NEEdrE7rkKdj3IS19fUY9vboa4mYe
         0MJYE2uoJuI3ar0sy1db78YWeKvGoMEUzgKALtsHvOjR8fgJtupZhaNwUYuH97bFfyQb
         4Sgl3W0JPnUWACwa3Wc7+lc9PctXopod4cW3IqwhfsTqPG+WkjEkss99azbH7b0x/OmU
         23YJa1hWdYHw3sKLOe07tEeRxDTwRypRnznQNzs3ob+ZCp5RzzwiMpSORbcUfoZmwVuc
         bw5IT68v5u/60OOKIntn24R8BO/dKQD8ff9p5XH934eXoWdWaeA7hP17jkf0llCrbyv+
         LqPQ==
X-Gm-Message-State: AOAM532XQszrQM/YpelsJOnaHuhbXs4pEuepA/6Dyrya7o9736i3PQUX
        /4e/9TnT6WTavZEzm5Os5Q==
X-Google-Smtp-Source: ABdhPJy0NQN+BFgCuKOqQFVxciKHjFihFZ+wXLRic16bQ1fGtahI+ZlS6wNFVhBOrPFtXr8/voU9NQ==
X-Received: by 2002:a4a:d0ad:: with SMTP id t13mr5985254oor.58.1601411394921;
        Tue, 29 Sep 2020 13:29:54 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o9sm3161110oop.1.2020.09.29.13.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:29:54 -0700 (PDT)
Received: (nullmailer pid 1114457 invoked by uid 1000);
        Tue, 29 Sep 2020 20:29:53 -0000
Date:   Tue, 29 Sep 2020 15:29:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Libin <huawei.libin@huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 12/17] dt-bindings: arm: hisilicon: convert hisilicon,
 pctrl bindings to json-schema
Message-ID: <20200929202953.GA1114428@bogus>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-13-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929141454.2312-13-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 22:14:49 +0800, Zhen Lei wrote:
> Convert the Hisilicon peripheral misc control register binding to DT
> schema format using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../arm/hisilicon/controller/hisilicon,pctrl.txt   | 13 ---------
>  .../bindings/arm/hisilicon/controller/pctrl.yaml   | 34 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/pctrl.yaml
> 

Applied, thanks!
