Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9F22B86E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 23:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGWVRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 17:17:39 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39631 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGWVRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:17:39 -0400
Received: by mail-io1-f66.google.com with SMTP id z6so7805980iow.6;
        Thu, 23 Jul 2020 14:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=noC7oJP4WZUF/f7GdUnBuOG73HJgf/jAmUrRtRHVTUw=;
        b=pZ353bZfklJlkVT++QMuq5WPa/hY5LaMFXK/s+WgeI+p5vWeY1py+l8/hycVbljNf1
         WlvnmK0gWqUJO3Mec9LaIQpsu/j4QPAi7yRf1hkvD0oexa79Ny/ggA8/ataun9NwAMPY
         YMqyZK+pzk8qaeonhcSSMs9F7idFU3ty5cH6GQRA6jfIX60K/5L0O5tZ8W99wEABFT5Z
         ZQH4H9EXUsPMIXiuYbpx1WIpd7c+XON9P2Cqji2BWr5FmFBFEIPtR73+dq4iScPTxnWI
         05Q817ZGY8ulcm9Q2247D2N8uWH2SvBTq0qfm8bBxiU+h+sj38LO9mSGe3wjRY05jB+1
         iGHA==
X-Gm-Message-State: AOAM530MxCurFFD3dF8fIwCRNJ4Cux7TTUJt4s4QOYaBDAYnZXpau9fi
        uyk2KNDSRhip8k6GvAfTGA==
X-Google-Smtp-Source: ABdhPJyy72aVgT31ahqcGF1f82tVCcADGUbScdIdyb+xc8eQQbGC1oeFSAnsiyYiDLM+a7JLYXsKMQ==
X-Received: by 2002:a6b:5d1d:: with SMTP id r29mr495876iob.14.1595539058240;
        Thu, 23 Jul 2020 14:17:38 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l17sm2023468ilm.70.2020.07.23.14.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:17:37 -0700 (PDT)
Received: (nullmailer pid 874621 invoked by uid 1000);
        Thu, 23 Jul 2020 21:17:35 -0000
Date:   Thu, 23 Jul 2020 15:17:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: ti: phy-gmii-sel: convert bindings to
 json-schema
Message-ID: <20200723211735.GA874566@bogus>
References: <20200721225247.31034-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721225247.31034-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 01:52:47 +0300, Grygorii Strashko wrote:
> Convert the CPSW Port's Interface Mode Selection PHY bindings documentation
> to json-schema.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 104 ++++++++++++++++++
>  .../bindings/phy/ti-phy-gmii-sel.txt          |  69 ------------
>  2 files changed, 104 insertions(+), 69 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
> 

Applied, thanks!
