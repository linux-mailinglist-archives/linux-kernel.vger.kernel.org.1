Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EB52F089E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 18:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhAJRTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 12:19:32 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:46929 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbhAJRTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 12:19:31 -0500
Received: by mail-oi1-f173.google.com with SMTP id q205so17642861oig.13;
        Sun, 10 Jan 2021 09:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=0atvGl4wyF8gi+A5MyTDj8dXxWkRMttxRAM1sDUE6l8=;
        b=UICCvcxNu04v3OW0k8x5B2cvv2I7rf0x2mPo6Sy9eYaYF4QHcKKfQtj6arJn8+2odY
         46KfOj0nt3fBjapeN92kSkH0okJpxhgBmE7Hm7NBTcOb3th4GyXDGQGdSwRiNTpoApj1
         z6C+RaFjMBFfhKyHCe8U5lR58XnV+r+V7bYuvPvEBez0Yo80Fu1Ye/wdQeLOMoSW+Wk0
         e3rUZk02+/KlSdPxapQdz3DT1NCtyddflXf1vyM2SYynZ48jCxHiEZ6Hjn/MUxCSnCKN
         63WFiZBnsAOK7AMllPxar8FpMrYTK1/IXGjGF7eYgvxtp9R5OkZlsIywpzLOz1R945Lp
         paXw==
X-Gm-Message-State: AOAM532dXPHpQUGcsB03t7s+nlrWbbeCAWwModDdKfWsN1eFiqTEP7ef
        y3dvlX7bkjzABJpIZgP6qg==
X-Google-Smtp-Source: ABdhPJxNu1nnwAhVK/0IWOQRUYRUBa7d2NcHd/qwEnyubX3gyHaAdZejLXM3kxeqo9P6SAVOH57WwQ==
X-Received: by 2002:a05:6808:b26:: with SMTP id t6mr8361584oij.169.1610299130054;
        Sun, 10 Jan 2021 09:18:50 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o135sm2827330ooo.38.2021.01.10.09.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 09:18:49 -0800 (PST)
Received: (nullmailer pid 785277 invoked by uid 1000);
        Sun, 10 Jan 2021 17:18:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Nancy Yuen <yuenn@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org,
        Benjamin Fair <benjaminfair@google.com>,
        Avi Fishman <avifishman70@gmail.com>
In-Reply-To: <20210108224008.705687-1-j.neuschaefer@gmx.net>
References: <20210108224008.705687-1-j.neuschaefer@gmx.net>
Subject: Re: [PATCH 1/2] dt-bindings: arm: Convert nuvoton,npcm750 binding to YAML
Date:   Sun, 10 Jan 2021 11:18:46 -0600
Message-Id: <1610299126.020227.785276.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jan 2021 23:40:06 +0100, Jonathan Neuschäfer wrote:
> The general trend is to have devicetree bindings in YAML format, to
> allow automatic validation of bindings and devicetrees.
> 
> Convert the NPCM SoC family's binding to YAML before it accumulates more
> entries.
> 
> The nuvoton,npcm750-evb compatible string is introduced to keep the
> structure of the binding a little simpler.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> 
> If someone else wants to be listed as the maintainer, please let me
> know.
> ---
>  .../devicetree/bindings/arm/npcm/npcm.txt     |  6 -----
>  .../devicetree/bindings/arm/npcm/npcm.yaml    | 23 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 6 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/npcm/npcm.yaml:20:13: [warning] wrong indentation: expected 14 but found 12 (indentation)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/arm/npcm/npcm.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/arm/npcm/npcm.yaml#

See https://patchwork.ozlabs.org/patch/1423975

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

