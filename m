Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5016283807
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgJEOlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:41:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46267 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgJEOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:41:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id m11so3203121otk.13;
        Mon, 05 Oct 2020 07:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9bJPJc/0YFm4pMXzg6Pd5rp8R+BK4BSmdTiiXnloDY4=;
        b=H78UvLJhHvsNkhbIset80niaHn32hwaSJZVkW/hLhPsSt1avkrEpayAYOnLa9b3nwi
         r9sFn8FcgpiMRKI/5y5wSKN4PaxUveQGZ7MFH22jJbBeS9AeMxgExPlLKw6KuT9JvPDj
         EcoJgJc74yZ+W/A1DfQS90LSCWpiDyrd+UJAeZByW5sDx73dqKar9GlLG8oAahhOoEhc
         sdzdVBX5R3Ek1p7M+kP7LlHPqwxh2vIbTnEklboOdQpJY9XoCpL8amjyEdaYiEWz7q9O
         sPc7co8WZQG4tlJoWGUb+plS0xKqFTurvfTx4nPZyk9vdd7BZGDkns+M/P7WZADMR4a+
         kKow==
X-Gm-Message-State: AOAM530IDGGixYG1RrsU9KUjRIejwRPtP9C0HM8BKvMwFyAfWrk8S0Q3
        vmIO23HAWGMWUI7Z+Mwmg49kEXnUm1IJ
X-Google-Smtp-Source: ABdhPJxs9QD2rXZYSKcBC5z+8AzZfLlTL1JZdqwKI5hy0BOUwSmgkaRe0EA+ekgrzfEpXxDuIi8cxQ==
X-Received: by 2002:a05:6830:1f2b:: with SMTP id e11mr12357240oth.296.1601908871008;
        Mon, 05 Oct 2020 07:41:11 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 2sm1921010oty.59.2020.10.05.07.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:41:10 -0700 (PDT)
Received: (nullmailer pid 154079 invoked by uid 1000);
        Mon, 05 Oct 2020 14:41:09 -0000
Date:   Mon, 5 Oct 2020 09:41:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     vigneshr@ti.com, heiko@sntech.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, richard@nod.at,
        miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v10 1/8] dt-bindings: mtd: Describe Rockchip RK3xxx NAND
 flash controller
Message-ID: <20201005144109.GA154028@bogus>
References: <20200930020710.7394-1-yifeng.zhao@rock-chips.com>
 <20200930020710.7394-2-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930020710.7394-2-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 10:07:07 +0800, Yifeng Zhao wrote:
> Documentation support for Rockchip RK3xxx NAND flash controllers
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v10: None
> Changes in v9: None
> Changes in v8:
> - Fix make dt_binding_check error
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
>  .../mtd/rockchip,nand-controller.yaml         | 162 ++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
