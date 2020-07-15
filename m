Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C2422162C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 22:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGOU0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 16:26:45 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46449 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgGOU0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:26:42 -0400
Received: by mail-il1-f193.google.com with SMTP id p15so3114375ilh.13;
        Wed, 15 Jul 2020 13:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iw+abfEcWg8r2U5F9bV1G66d69s59AL0m3KcUrPU2CU=;
        b=iYbokgXQXT0cJZH6c82/T3TFiE8oNqd+1YE3rikpLQ6J4bEEUl7uuwo9xIuxccHUxM
         U9UjYoIxkEWkoqftCxOwnN2IH46lUHsRgDVOnyuNZ5uogzBK3DBoFvSaiS74tmCxLTlO
         O7S2ZU3AlTxnxtEecQpLy+qJx8dK2FcznLs6ErgdX2hp6iLrPBpprjp3rtF732hWYECD
         cI94n84GFETmwg2tBFeejo8LK5WpnOJKZt764AEfAUWLFhSCe/mG080x9NNvujZLM5nb
         IfYNQ7PLDXbsfEhCRCnj7DlmHdCtEchA/0bbSbbz7AJD3II7LdD5eKojimP6gXrmF8NX
         qLvw==
X-Gm-Message-State: AOAM533bCoPGRg4+DZCsrlMQB4D4i8Ep/wJ6xPy2SWlQmpI6bPS+KHYO
        tXMvmJDDmYJSvov3ryKvAg==
X-Google-Smtp-Source: ABdhPJx8z2WZ6yDXhQQvie9RKIBtkE5Ub6i2jwYJzJRbMHG4H74n6NbT8s2P8GEZo8OR8QFixnLRVw==
X-Received: by 2002:a92:aad6:: with SMTP id p83mr1161782ill.65.1594844801721;
        Wed, 15 Jul 2020 13:26:41 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z78sm1654024ilk.72.2020.07.15.13.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:26:41 -0700 (PDT)
Received: (nullmailer pid 761926 invoked by uid 1000);
        Wed, 15 Jul 2020 20:26:40 -0000
Date:   Wed, 15 Jul 2020 14:26:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bth@kamstrup.com,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: ARM: imx: add kamstrup flex
 concentrator to schema
Message-ID: <20200715202640.GA761896@bogus>
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629114927.17379-1-bruno.thomsen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 13:49:25 +0200, Bruno Thomsen wrote:
> Add Kamstrup flex concentrator compatibles to the schema so we can
> make use of them for the validation.
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
