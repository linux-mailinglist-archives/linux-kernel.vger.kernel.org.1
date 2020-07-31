Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D3234D92
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 00:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGaWaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 18:30:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35114 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgGaWaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:30:39 -0400
Received: by mail-io1-f68.google.com with SMTP id s189so25940404iod.2;
        Fri, 31 Jul 2020 15:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=45H1JgCHHdhQApbjvQq9Pb4Y3l2t3RueYD94Macm5D8=;
        b=PfmdjgzIQr1Z1JXO3DdSLNrshnDhac2bqHxk0tAW+rybFQxvCXxN1k1gA3o2huU+eq
         wfBBNaUscmmrcNKgNIb21JgNxmWP7Lb1y4SYYZdg/MUKGBvhY1ppttO67XhR45q2iptu
         lm7Egh0jaFebdw1oV3x45+YbRCTqqEuZ5yak7+iimlpPnVnfhjnZV/SSefFB+sl8+N0j
         PwuhsMYZfRabAXnuloh0DknMmkDAyT3msC0Mizdfj+obyOfh22RRZO4hEf4IT7tlsTw/
         y1zn8M8CUdQkoxieFlYMs9lb9loDSdlPVXM2j/ti4nqToGF/qJNHgltTOw5VJoFbcDc8
         z/ag==
X-Gm-Message-State: AOAM531Vr2Q+luieS1PGL5gUrSk2uKPremFkESIl7UJZAu2nF6VdLboP
        gDPHpIyk5VP51XsBypbjnw==
X-Google-Smtp-Source: ABdhPJzZAaX6MlFfNyrl50UMUoKtOe2pALDSo+xUOpiSIJ57RHBGhOQHylD+u3088MEWzsbuB1YUyQ==
X-Received: by 2002:a5e:d80e:: with SMTP id l14mr5802006iok.65.1596234638546;
        Fri, 31 Jul 2020 15:30:38 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f132sm5171450ioa.45.2020.07.31.15.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:30:38 -0700 (PDT)
Received: (nullmailer pid 923415 invoked by uid 1000);
        Fri, 31 Jul 2020 22:30:35 -0000
Date:   Fri, 31 Jul 2020 16:30:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-mtd@lists.infradead.org, Linux-imx@nxp.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org, han.xu@nxp.com,
        richard@nod.at, vigneshr@ti.com, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH 2/2] dt-bindings: mtd: Convert imx nand to json-schema
Message-ID: <20200731223035.GA923337@bogus>
References: <1596113004-15548-1-git-send-email-Anson.Huang@nxp.com>
 <1596113004-15548-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596113004-15548-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 20:43:24 +0800, Anson Huang wrote:
> Convert the i.MX nand controller binding to DT schema format
> using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/mtd/mxc-nand.txt | 19 ----------
>  .../devicetree/bindings/mtd/mxc-nand.yaml          | 42 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/mxc-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/mxc-nand.yaml
> 

Applied, thanks!
