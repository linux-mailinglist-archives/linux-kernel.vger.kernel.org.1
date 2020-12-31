Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFA62E81CE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 20:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgLaTUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 14:20:02 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:34441 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgLaTUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 14:20:02 -0500
Received: by mail-il1-f170.google.com with SMTP id x15so18085546ilq.1;
        Thu, 31 Dec 2020 11:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z2xI8lRFtXgUuANWqeMfptI1eTIpO7AT0AspslO1UA8=;
        b=j/Rc4Dzc3rwxP73USeTHo5CHn6ld2JhXXPM9sYT98zA8AzkkYGNSz4wLhp3sQpNQxN
         5Ad9lZfq4WIY3mn/kduBCwSdcjCOLKYDqMaLSyQA5ZJettnJjLdmtj7ghxl+AqVXUpua
         745JnzMtUL5krMZi3ZTbhuSGR84c4xG2jFnCSAlunqJ0Weiqfmhhp2Cilz8Lu82HNuZ4
         BjPQFec5b6MPlKlgyy+j/Ig/pm+cyAHv0U9s3hLUe9J/xofNMw9Q99U2L6567xhGOYtw
         iMx9Z2Hm9Xa8uAEEplbJCvs6LuTaAMzGmu8Uel0Dd9KevosLvQvgDPiw/ugObudT7Q/m
         rw6Q==
X-Gm-Message-State: AOAM533iAJiwlhGvR6hXNFa5EX4PWV7kyfzdfpEFk9T694V7zq6asWhj
        WL0DZsEsh+lF7+SVIFKayQ==
X-Google-Smtp-Source: ABdhPJxIXgn4WILo/4bkwjAZlJy3+pHbkT+PCgIMDqt4hnb+1h5cI34oMz3nEVSjFMXtTqvmQtPIuw==
X-Received: by 2002:a92:dcc4:: with SMTP id b4mr56780430ilr.164.1609442361369;
        Thu, 31 Dec 2020 11:19:21 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d18sm34083838ilo.49.2020.12.31.11.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 11:19:20 -0800 (PST)
Received: (nullmailer pid 2202140 invoked by uid 1000);
        Thu, 31 Dec 2020 19:19:19 -0000
Date:   Thu, 31 Dec 2020 12:19:19 -0700
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 3/3] dt-bindings: mxsfb: add compatible for
 i.MX6UL/i.MX6ULL
Message-ID: <20201231191919.GA2200237@robh.at.kernel.org>
References: <20201218141035.28038-1-sebastien.szymanski@armadeus.com>
 <20201218141035.28038-3-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201218141035.28038-3-sebastien.szymanski@armadeus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 03:10:35PM +0100, Sébastien Szymanski wrote:
> i.MX6UL/i.MX6ULL have eLCDIF controller, too.
> 
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  Documentation/devicetree/bindings/display/mxsfb.txt | 1 +
>  1 file changed, 1 insertion(+)

This will need to be rebased on this:

https://lore.kernel.org/dri-devel/20201007012438.27970-2-laurent.pinchart@ideasonboard.com/
