Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46A1274E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgIWB1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:27:20 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37761 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgIWB1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:27:20 -0400
Received: by mail-il1-f195.google.com with SMTP id q4so19237692ils.4;
        Tue, 22 Sep 2020 18:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NPckTQcuIFYMeBOA91naq/GGelM7Z19S14ixJiZ/8TY=;
        b=lO2G4NrMkaYLXio3HcWtPN1mu3AZ9cJtCEQqHKt6blWtssktDE6oV9F0q0yreXw/9p
         K6XaTjlh0HJKLXXlj8nx3TK3yNQxfGUYNGNSIIWnVXm/QekrSvSsn8Omst+qCSlN8dxC
         hpKh7oRquCyfTolIuSi2qrECwLSo122P/qZxRhnw/nI0sqCakn2+wqdPNoq3Ipfzi88I
         E5raJ25C/n4swGRP/5PrkUjqu48EcLWY8FyMfJYvm2XSEJdqxwUp1zcpec0DYrv/MF23
         QRvDBW9lknXqxwhXmxWM8ROGOfZL2pg7TdZD20Pzkrf3soBBVDsTE0SpefDLC1A8oLMm
         eadw==
X-Gm-Message-State: AOAM5324sn1PnkMlIAUHWghmwWRTXJOm2UuPfoVCkMmjD1f/gEelcIbE
        7/qtLt0iMuSj5bBrXeIG/Q==
X-Google-Smtp-Source: ABdhPJzrFdS7oSqGtPLnlMILyspkxTHdvQlrAmwgNw4WL6uPhNtMJoHypAPFg/YfDbgfp9sx8qMG8Q==
X-Received: by 2002:a92:8e03:: with SMTP id c3mr6980178ild.16.1600824439652;
        Tue, 22 Sep 2020 18:27:19 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s1sm9952963iln.22.2020.09.22.18.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:27:18 -0700 (PDT)
Received: (nullmailer pid 3654307 invoked by uid 1000);
        Wed, 23 Sep 2020 01:27:17 -0000
Date:   Tue, 22 Sep 2020 19:27:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kurahul@cadence.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nsekhar@ti.com, vigneshr@ti.com,
        balbi@kernel.org, pawell@cadence.com, linux-usb@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: Convert cdns-usb3.txt to YAML
 schema
Message-ID: <20200923012717.GA3654245@bogus>
References: <20200915114543.2599-1-rogerq@ti.com>
 <20200915114543.2599-2-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915114543.2599-2-rogerq@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 14:45:41 +0300, Roger Quadros wrote:
> Converts cdns-usb3.txt to YAML schema cdns,usb3.yaml
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../devicetree/bindings/usb/cdns,usb3.yaml    | 92 +++++++++++++++++++
>  .../devicetree/bindings/usb/cdns-usb3.txt     | 45 ---------
>  2 files changed, 92 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>  delete mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
