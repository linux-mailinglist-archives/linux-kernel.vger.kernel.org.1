Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7514E234D87
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 00:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGaW1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 18:27:14 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46803 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGaW1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:27:13 -0400
Received: by mail-il1-f196.google.com with SMTP id l17so16392915ilq.13;
        Fri, 31 Jul 2020 15:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0VUfDkvVHH4W6XLORiRyqtNq2plcQ7wzsPH44IkkNSc=;
        b=jM22gGIvdY5LBoAbwaz/Jq05KIq657pQHeVOjt3ZFtgeDfEilrU3gCalTwAzcw4ql8
         BWecKTtni5gsPPQj7GzhYTOp7EzBxpUks/V2ki85Zw4S0/qaDqvwbl5r5orXzuqcfnzn
         8SN4RXj/5v0XoKkl7VgCfIV8jEJrgdDcWVkHBfbZgpwyLpK10jbM/TYzrA0ucMTSAYrJ
         trKCgnbshCuMqgnO4+v7lxonTackvfma4bHoM+pAY4k6gTnMCcAwUfFySUdt0SKHIcPb
         pTD5k5mghDN8uaxQwtsqCw2qoCZthPhhjyO5/KCqE2Ysy2OtsMK7ZTENsRdxib2q05he
         VPog==
X-Gm-Message-State: AOAM533S52VpHGduMdgPVFv1B4U5gjAeKH9rp+rlUFM55trbbcoBrkF/
        YUk/HQop6mUhPVPbZe38BA==
X-Google-Smtp-Source: ABdhPJz7Vco6kuErpdnt+GHHFaDlfvdp8NRkNceWXBuJgygMGIdQkhox9ceVN6YtpoAW8FKkTue4zA==
X-Received: by 2002:a92:da51:: with SMTP id p17mr5907157ilq.44.1596234432878;
        Fri, 31 Jul 2020 15:27:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f19sm5818459ilf.15.2020.07.31.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:27:11 -0700 (PDT)
Received: (nullmailer pid 917522 invoked by uid 1000);
        Fri, 31 Jul 2020 22:27:10 -0000
Date:   Fri, 31 Jul 2020 16:27:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     peng.fan@nxp.com
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shawnguo@kernel.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: reset: imx8mq: add m4 reset
Message-ID: <20200731222710.GA917469@bogus>
References: <1596091569-10013-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596091569-10013-1-git-send-email-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 14:46:08 +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add the m4 reset used by the remoteproc driver
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/dt-bindings/reset/imx8mq-reset.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
