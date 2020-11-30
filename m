Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537722C8CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbgK3SYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:24:10 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33503 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgK3SYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:24:10 -0500
Received: by mail-il1-f193.google.com with SMTP id y9so12259270ilb.0;
        Mon, 30 Nov 2020 10:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0neMxzWOSFLOXSknMHOSEKClv5G9ep++zXnTP/Rc0O8=;
        b=d2UxlyWgyZXI/Whc9L/l+nMUi/oHDXXWPi9QAfCiaYCNmplfik0llX+NQuopFCnlgC
         z0epDf/Gn2R3hSUrn2rHcRJcpyqRAG9v4xb0JaaP/Jp9X4XMnaOGqUjo/DSf0YaFGtRL
         xbNgiYiymexklk46FMIFNWqqlULbhV/WLk0V4lKCVxLeBvuOWTn95Z7e/x3BCkJ4CZjg
         WL5ugCX0rjLQSUva8+zgjaBvIjy/5NKqiqY9HSIBGT5u/E3OexlmF6NYqsoPpLiNe1nh
         2+7mnPn3No680kQXM/BzfYHRVn+t1e8zCi8XYy94sCY63S0tsebdBjboWggOitkMVkw7
         knJA==
X-Gm-Message-State: AOAM530s/UW591LODMcvBAaitUePNNmUTdbvIueXBYJkkLTYKPEh0yxM
        SunSt7EFwgRBRcxfqNdKDhez6JlwvA==
X-Google-Smtp-Source: ABdhPJzHXlx/TfQVfpIfEHQeSQemYh6/jCa4ib42N0v8d/w5/13Z4A2a0QvXXmVQUGCBpZNO2HvgFQ==
X-Received: by 2002:a92:40c8:: with SMTP id d69mr19411707ill.66.1606760608911;
        Mon, 30 Nov 2020 10:23:28 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z6sm11205177ilm.69.2020.11.30.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:23:26 -0800 (PST)
Received: (nullmailer pid 2759200 invoked by uid 1000);
        Mon, 30 Nov 2020 18:23:24 -0000
Date:   Mon, 30 Nov 2020 11:23:24 -0700
From:   Rob Herring <robh@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, richard@nod.at,
        miquel.raynal@bootlin.com, heiko@sntech.de
Subject: Re: [PATCH v14 1/8] dt-bindings: mtd: Describe Rockchip RK3xxx NAND
 flash controller
Message-ID: <20201130182324.GA2757731@robh.at.kernel.org>
References: <20201120095613.20172-1-yifeng.zhao@rock-chips.com>
 <20201120095613.20172-2-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120095613.20172-2-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 17:56:10 +0800, Yifeng Zhao wrote:
> Documentation support for Rockchip RK3xxx NAND flash controllers
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v14: None
> Changes in v13: None
> Changes in v12:
> - Fix some warnings while make dt_binding_check
> - Drop a allOf defined
> 
> Changes in v11: None
> Changes in v10: None
> Changes in v9: None
> Changes in v8:
> - Fix a error while make dt_binding_check
> 
> Changes in v7:
> - Fix some wrong define
> 
> Changes in v6:
> - Fix some wrong define
> - Modified the definition of compatible
> 
> Changes in v5:
> - Fix some wrong define.
> - Add boot-medium define.
> - Remove some compatible define.
> 
> Changes in v4:
> - The compatible define with rkxx_nfc.
> - Add assigned-clocks.
> - Fix some wrong defineChanges in.
> 
> Changes in v3:
> - Change the title for the dt-bindings.
> 
> Changes in v2: None
> 
>  .../mtd/rockchip,nand-controller.yaml         | 161 ++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

