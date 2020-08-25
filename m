Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836B8250EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 04:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgHYCNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 22:13:12 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45609 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgHYCNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:13:10 -0400
Received: by mail-il1-f196.google.com with SMTP id k4so9103349ilr.12;
        Mon, 24 Aug 2020 19:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8RGyg0EWP+nepBUnlLz9KN7Donf8Om6i4DgazMKOK9I=;
        b=N+EN6Ym1MlRkalsQQy4kIgwB3JSHgrfcOAWMHEkTUTeONmYLSM45ssRoUaZYR4iBf/
         Pnm9XGz7ayW9BTmpKc+jekM33oTcbbLexkAS0KUggY2v26vQiVe1otDZN2DVGMaQVGK/
         37JreoRYNboPRzOKRCMdqcPjUxwRw8kFlXuEH9JSZOXYjVhZ6GtjvMW+17KXXONxt+T4
         FaIP5L6No3TGqbSxfAITAEX4F12LPZki27+g7j3pJKxdC1YAmfiy3w2e95mW2epfqI/e
         MJfgtHqQKgpPUWqXnOyJw3zNzZVus3X2hR6QPmfl5JNDp/hhcv9fcBI2MjmTqhDLR5kJ
         GBOQ==
X-Gm-Message-State: AOAM533gZ2uj8myA+c7CC2+m3G3Pr1w1WIDIXlUxgMGt+CjbizPeswys
        97rKGj3MgHdAEBrAHvogdQ==
X-Google-Smtp-Source: ABdhPJxrhTemLrh5lmm4Gt322imwrdF0OpqFjk+vrpUlKEWmt6jA7vwx39TXzKRmY+yLp6V75LeK4Q==
X-Received: by 2002:a92:d8cb:: with SMTP id l11mr6969597ilo.221.1598321588226;
        Mon, 24 Aug 2020 19:13:08 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id v16sm8201996ilq.84.2020.08.24.19.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:13:07 -0700 (PDT)
Received: (nullmailer pid 3794910 invoked by uid 1000);
        Tue, 25 Aug 2020 02:13:04 -0000
Date:   Mon, 24 Aug 2020 20:13:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fugang Duan <fugang.duan@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Mike Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 02/17] dt-bindings: reset: imx8mp: Add audio blk_ctrl
 reset IDs
Message-ID: <20200825021304.GA3794881@bogus>
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
 <1597406966-13740-3-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597406966-13740-3-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 15:09:11 +0300, Abel Vesa wrote:
> These will be used by the imx8mp for blk-ctrl driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  include/dt-bindings/reset/imx8mp-reset.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
