Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC772D16F4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgLGQ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:57:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40146 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgLGQ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:56:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id p126so16105963oif.7;
        Mon, 07 Dec 2020 08:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q5LAPefz819WcvyH8njj0IQNEGMhqPewfAR3Yy6+RgU=;
        b=B9KQ4JYwtf6Rmhgz81T9/JsnCW0tu+DOnyN3eH1NAORfw3dOgNr5He08WQbDQKQzyU
         0DD6oWTh2lQZ41f5ZFH67KK3t5kABPfkXjTQ4nMUZEkhRXpI4CuIP2Jb+ADC/apUr/wH
         YD3lTnA7AXsgIKDGD/sHHUEZHwOSbdIZgJnjXhBj/Mh0wa+4ey7noz6h2Nr5wpG3ErQc
         0UpdXKc7aRXlOE5wQmNtzN6Dqp3HUPrpGncu/w/4JQ3rD07XNf3QjxNfS7Qv5JUzxVvD
         0+74kCIz1SVq0JYkuAtE+lx7BPMVimDgL1aPUk/woWj5WW29pbLhUjXQQ0myDTh8KlTS
         s57g==
X-Gm-Message-State: AOAM530UE9cZno9DsazeFIFmXFvmQ0dbs1ZMbNGSigaA4ZlIzsZ6LRMm
        HuoAce5eUn+IEtGK+q3nXGOShnlQ6g==
X-Google-Smtp-Source: ABdhPJxh/f4NyyBojmD5vnzMx72dQ2ebVtDJI21XvG8f+sulWJdULnN26QlPXPi74W/0Zq/hQq48xQ==
X-Received: by 2002:aca:f456:: with SMTP id s83mr9908528oih.58.1607360172360;
        Mon, 07 Dec 2020 08:56:12 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b28sm2724031oob.22.2020.12.07.08.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:56:11 -0800 (PST)
Received: (nullmailer pid 429855 invoked by uid 1000);
        Mon, 07 Dec 2020 16:56:10 -0000
Date:   Mon, 7 Dec 2020 10:56:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     devicetree@vger.kernel.org, laurentiu.palcu@oss.nxp.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com, shawnguo@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        tzimmermann@suse.de
Subject: Re: [PATCH v3 1/6] dt-bindings: display: imx: Add i.MX8qxp/qm DPU
 binding
Message-ID: <20201207165610.GA429808@robh.at.kernel.org>
References: <1607311260-13983-1-git-send-email-victor.liu@nxp.com>
 <1607311260-13983-2-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607311260-13983-2-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 11:20:55 +0800, Liu Ying wrote:
> This patch adds bindings for i.MX8qxp/qm Display Processing Unit.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> Note that this depends on the 'two cell binding' clock patch set which has
> already landed in Shawn's i.MX clk/imx git branch.  Otherwise, imx8-lpcg.h
> won't be found.
> 
> v2->v3:
> * No change.
> 
> v1->v2:
> * Fix yamllint warnings.
> * Require bypass0 and bypass1 clocks for both i.MX8qxp and i.MX8qm, as the
>   display controller subsystem spec does say that they exist.
> * Use new dt binding way to add clocks in the example.
> * Trivial tweaks for the example.
> 
>  .../bindings/display/imx/fsl,imx8qxp-dpu.yaml      | 416 +++++++++++++++++++++
>  1 file changed, 416 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dpu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
