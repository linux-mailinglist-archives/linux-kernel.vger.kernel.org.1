Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0D02DAFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgLOPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:01:50 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42860 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgLOPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:01:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id l200so23566695oig.9;
        Tue, 15 Dec 2020 07:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/D2pluZ7I/am9iy0DWbgJXEYcE9L4zDkl0i5rNHerY=;
        b=TYsshxVc088PBwqgItxWIzCPyDwLQvsPgis61FRfrDxJpdBE8J32TSK2UxJlQPLI4e
         Dha0xcBDlYwLm9WXVgiVQw8QvPnKy+8WGcJZLX06+cbAvbggVMjQL3Pnikt12jaMJyCU
         ivA1poHMcW3ZyI1dexEmu3VBC/a63OBE3BgDlW5xJzwxC6Okndv27RMXJHORqd+cZKIP
         p+0NZaDQKwzhxviedb/ZV6bYIudnbtNIazr0WC+SS/YTGjZ+aZcKKbpk9NPZQPHrl6yH
         zHkN1V2N/Pz7E6s/Dc1NQwF5cky9AiM8TWzz58ZZb9pUCNVKhBKFIlBKz/iVHKfD0msc
         YMyw==
X-Gm-Message-State: AOAM531T8A9ozl3U76mbh5h5GO8h3zSX5QGLokbsAtGxOk1VmZxBM/XG
        yWPM++dggAoRloSAcuIamg==
X-Google-Smtp-Source: ABdhPJx4lE7nEbnpKw5PeMU2z4n9r0AN+HlhQq5LR/rdIfF2+GwQ64GuPvmQ2p9iR8pYHXsY620XkQ==
X-Received: by 2002:a05:6808:a90:: with SMTP id q16mr332468oij.107.1608044448318;
        Tue, 15 Dec 2020 07:00:48 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m18sm4717473ooa.24.2020.12.15.07.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 07:00:47 -0800 (PST)
Received: (nullmailer pid 3830204 invoked by uid 1000);
        Tue, 15 Dec 2020 15:00:46 -0000
Date:   Tue, 15 Dec 2020 09:00:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        gary.bisson@boundarydevices.com, lgirdwood@gmail.com,
        troy.kisky@boundarydevices.com
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: add pf8x00 PMIC
Message-ID: <20201215150046.GA3829745@robh.at.kernel.org>
References: <20201214225851.23342-1-adrien.grassein@gmail.com>
 <20201214225851.23342-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214225851.23342-2-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020 23:58:50 +0100, Adrien Grassein wrote:
> Add a devicetree binding documentation for the pf8x00 regulator driver.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../regulator/nxp,pf8x00-regulator.yaml       | 220 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> 

With the whitespace fixed,

Reviewed-by: Rob Herring <robh@kernel.org>
