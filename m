Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29F2D1E05
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgLGXBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:01:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44446 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgLGXBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:01:44 -0500
Received: by mail-ot1-f65.google.com with SMTP id f16so14149503otl.11;
        Mon, 07 Dec 2020 15:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yl8EdReeQNPvvWTCsgwnxMYnKdzktt93AM6rTiMbYOg=;
        b=Ehq5UaAFy4kQXLv0OkwYpVUZF+H+2msmvSe15RaKBWXOUFeqcyaOc6A59+G9dq5MXP
         Kn7aGWVrp/fBkuwZjPznGMbUjFLuG2Yt1KvBj+Mk7yZ/2rgF8pcPu8ynxAuyUbqOWl5o
         zMbMTUSp5vWVqQI7HIBFSlxiYrdldbzYryZbqr826rxy5jOtlOoKtzC6KMMvIes0B4Bs
         QdeV06jPzjl5QvzsWWYPeczMnxCGDinjDlJjT+J42gKKD+qlKLAfOZ2JXk64V3fD/RVi
         5cQLtcq2SH1eTxp1T26JL2twL/AA8JLjXVMDLPt04Ox5ud4oaw4zQGLw/0x4UoPMGdRL
         UINg==
X-Gm-Message-State: AOAM531N2bALuq2akjc3PzZ8DiUv1Ar48TpnKoh/ZG9x8iRzNeO9ThFQ
        ogzyoTnZw0xXDpIIJ4x8bA==
X-Google-Smtp-Source: ABdhPJy4o+KKt2VsZ8/Ja1T2ELpm7ZEgXBUA9XH7X4kKGoAM+PzLDIBf1VLVvm2YaJvvjKBoOgHo3w==
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr12740600otr.196.1607382062820;
        Mon, 07 Dec 2020 15:01:02 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v123sm3264882oie.20.2020.12.07.15.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 15:01:02 -0800 (PST)
Received: (nullmailer pid 1008235 invoked by uid 1000);
        Mon, 07 Dec 2020 23:01:01 -0000
Date:   Mon, 7 Dec 2020 17:01:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: eliminate yamllint warnings
Message-ID: <20201207230101.GA1008158@robh.at.kernel.org>
References: <20201207032626.1445-1-thunder.leizhen@huawei.com>
 <20201207032626.1445-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207032626.1445-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 11:26:26 +0800, Zhen Lei wrote:
> Eliminate the following yamllint warnings:
> ./Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> :20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> :30:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> :33:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 26 +++++++++++------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
