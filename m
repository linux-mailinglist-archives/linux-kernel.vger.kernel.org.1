Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B153234D7A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 00:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgGaWXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 18:23:32 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:46535 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaWXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:23:32 -0400
Received: by mail-il1-f194.google.com with SMTP id l17so16387306ilq.13;
        Fri, 31 Jul 2020 15:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MaMmVcn9+MRWfRbWgy83xpczYMM2Vm09Dhlhwr8Itsc=;
        b=fsWv+xkRFCX979cULkZhmLx7UPWq0m+VVV9TTuApXxKpxmOw8VyoE+nIcvi0C9T9kZ
         5kkHEXZKBqkWZzYEOwgJ9L87TMDOdOocuo4lLQROF7XL8UWD/O2tsRb83fo2WNPKBGVt
         lUPiWAfeKL95vQ7CbMBT+3a1spFzdwIzfbH/tW62mZzj8EjoYYDKJgiV3oAjJm1Y9IGL
         ZRHAU1cAJA3lfWt9wjDM7+AkoIikawP6o0YS/Rz5cWdcNQMgGQK/iTHRSkqmjzaB2m8n
         /KGeJzuBPmF1QFEl6Gta3NculUDosw0SPRkoAbZXIpnpXuSReX905BScqodu5JDl4ODk
         NRVg==
X-Gm-Message-State: AOAM533DI0gySZRAM5E0sqjUQAdK4v9vn77ftI4sUVwim8Djs8czKKez
        VO7m+otfwBdTMmrwNSuLcw==
X-Google-Smtp-Source: ABdhPJw25SjHkJ/TWClbXqnxnuR3D1De8j0F7V2yx+H7RmvU7z3XMZ/O+c2e69RlhjHg/Ie+J0Uviw==
X-Received: by 2002:a92:d4cf:: with SMTP id o15mr5144838ilm.160.1596234211087;
        Fri, 31 Jul 2020 15:23:31 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u3sm5557606ilq.37.2020.07.31.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:23:30 -0700 (PDT)
Received: (nullmailer pid 911354 invoked by uid 1000);
        Fri, 31 Jul 2020 22:23:27 -0000
Date:   Fri, 31 Jul 2020 16:23:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     linux-clk@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 05/17] dt-bindings: reset: imx8mp: Add media blk_ctrl
 reset IDs
Message-ID: <20200731222327.GA911246@bogus>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
 <1596024483-21482-6-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596024483-21482-6-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 15:07:51 +0300, Abel Vesa wrote:
> These will be used by the imx8mp for blk-ctrl driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  include/dt-bindings/reset/imx8mp-reset.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
