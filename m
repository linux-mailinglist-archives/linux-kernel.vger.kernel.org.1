Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42BA2D1904
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgLGTDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:03:48 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37970 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLGTDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:03:47 -0500
Received: by mail-ot1-f68.google.com with SMTP id b62so13514860otc.5;
        Mon, 07 Dec 2020 11:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xdn2VRO56uAFABzC8UZ3Pa3q02QQGItW2Iah+Zcfh3c=;
        b=YiWqvt6hxn8VTh/vsFfSauXcOHqLWXkGzpS5wyj0DcF9IrDXAXLbAPVary6JdUf+Sk
         9x98knQiEz65N4EDxxmn2U4j9nhYv5+TuzsdczPA7SeoH6N1tOGoI8lBYqH1BKhZP+7q
         TUE6GjpyDN1ytxYmW54fMF7J8k5W+zZq4p8w45OiW65/4iaBy4EW9ayZXNdClpM9b/+b
         2BQ1yCjD/iXhPXE/RNbqcwL0HCFE/wV4eaAUt16mNrK1mR07BER2yXv5AEk4Mxp/Iv+2
         IQJcjI2btgXJO4ck3uyOTTY+5kLP0EG9NfvUTSg9JTBhXlJ2OGrH7Yn+K2/rSL8H4v7z
         ka8g==
X-Gm-Message-State: AOAM532l7AVyhMM6JtIAx++lcjFWIvtaW8I0qJJuNHK0w0O5RmYOndKE
        8k9fHHFlqZoepd8VGxAemg==
X-Google-Smtp-Source: ABdhPJwedWQa3ugHKeUrTyeT4B8u41zK9Wxrb1uEivXzCY6bsW7FO6pEir6ls/nBxQn/t08o6aBzzw==
X-Received: by 2002:a9d:5a9:: with SMTP id 38mr13654440otd.173.1607367786920;
        Mon, 07 Dec 2020 11:03:06 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h17sm2763135oor.1.2020.12.07.11.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:03:06 -0800 (PST)
Received: (nullmailer pid 628529 invoked by uid 1000);
        Mon, 07 Dec 2020 19:03:05 -0000
Date:   Mon, 7 Dec 2020 13:03:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-clk@vger.kernel.org, w@1wt.eu, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] dt-bindings: clk: mstar msc313 mpll binding
 description
Message-ID: <20201207190305.GA628475@robh.at.kernel.org>
References: <20201114135044.724385-1-daniel@0x0f.com>
 <20201114135044.724385-3-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114135044.724385-3-daniel@0x0f.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Nov 2020 22:50:40 +0900, Daniel Palmer wrote:
> Add a binding description for the MStar/SigmaStar MPLL clock block.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  .../bindings/clock/mstar,msc313-mpll.yaml     | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
