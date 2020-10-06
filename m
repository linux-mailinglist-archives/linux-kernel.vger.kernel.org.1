Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E48F285203
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgJFTEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:04:22 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41652 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgJFTEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:04:22 -0400
Received: by mail-oi1-f194.google.com with SMTP id x69so13731710oia.8;
        Tue, 06 Oct 2020 12:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qRpEP4O4Xg7xFp6XQzZqQIu/xXtLIIBg9evjxYMVcxA=;
        b=eXc2eFsptcQkJLm/KSKZ5QiGMjYYZW1Vf3S3NrbJfxzlfu0ZSdtIo+qwy8VF+elEhu
         9XaTbuuKw1XyjOpO1YAw8WxOyRtOL6w4PquhltdLUkjiyUyDQfIZ8XdhNqeFmDbxOnni
         WFrSPKRJZMA3wxtVOMr19Xav/x1RBGxBAdoU55lIfWpipxJ0NCCsUFjC9dJjpOkwdBoK
         oP0EuUJeoEFQqMoO6kH5Le9yqlVQ24Pb5lYpscxTSpHA369/Q1jUr7s0yFp+NnB7ypUy
         zQNVaM5ajLU7xUPw2YFUPoWA0xeVlrxqS6b03LwCUFSrbRmZ/bEDIB4z6QyBpFoh8GT4
         2Raw==
X-Gm-Message-State: AOAM532f33WzHpiogdd2gFCbRu4qi4tbFCAzBWOrlefjsVhjeIpXEVH7
        GEvErcYAPV3Ra4oxJQx+iQ==
X-Google-Smtp-Source: ABdhPJx7JJEYZejq7vojdRBlVNLxq4Nqt8pFIHjeMaqptJwbsYMpCHWJ6VcmOB1RXwIlYPVt4E9KxA==
X-Received: by 2002:aca:f203:: with SMTP id q3mr3454887oih.148.1602011061400;
        Tue, 06 Oct 2020 12:04:21 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m187sm1544891oia.39.2020.10.06.12.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:04:20 -0700 (PDT)
Received: (nullmailer pid 2647308 invoked by uid 1000);
        Tue, 06 Oct 2020 19:04:19 -0000
Date:   Tue, 6 Oct 2020 14:04:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 15/17] dt-bindings: arm: hisilicon: convert Hi6220
 domain controller bindings to json-schema
Message-ID: <20201006190419.GA2646913@bogus>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-16-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930031712.2365-16-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 11:17:10 +0800, Zhen Lei wrote:
> Convert the Hisilicon Hi6220 domain controllers binding to DT schema
> format using json-schema. All of them are grouped into one yaml file, to
> help users understand differences and avoid repeated descriptions.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../hisilicon/controller/hi6220-domain-ctrl.yaml   | 68 ++++++++++++++++++++++
>  .../controller/hisilicon,hi6220-aoctrl.txt         | 18 ------
>  .../controller/hisilicon,hi6220-mediactrl.txt      | 18 ------
>  .../controller/hisilicon,hi6220-pmctrl.txt         | 18 ------
>  4 files changed, 68 insertions(+), 54 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
> 

Applied, thanks!
