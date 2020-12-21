Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88912E02A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 23:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgLUWw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 17:52:27 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:40875 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUWw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 17:52:27 -0500
Received: by mail-ot1-f49.google.com with SMTP id j12so10280484ota.7;
        Mon, 21 Dec 2020 14:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xGMhjs6ip+VhnoHGisVBlYY5haZY44B4LgsaGJIElNA=;
        b=XTh3Xm+PO2QrF7etPF6zDag4i+AFVWgMrK5f1MK/flO0z0KHFr3lT4DGUbl86vsa1f
         OpdAi0wZf+wd704rMd2waorkxyhb9rCs8qmXsrxbQTjcHNrkqdOC3vlwZgu/NcbLTBDG
         rPXoQfFbLWy0ObqJpNnUwYWSpikx+AyLAc4igrwi6HXs4P2+LyjngyP2zo2+/tkRDIBH
         7pA07QyVkhXzgBwVJjW1J7AKIeNVI4I2XZqf7XHYYZDJ8einiEzFC/dGm6sJc91KsLbX
         2MBuw4jL8mSZq3B62SVyo7bN4xaG/sYV0aLoiVf68VDON1u+uuf+yLJTtmBpiCLoZAiF
         AFHA==
X-Gm-Message-State: AOAM533yHFiC4cYOIzpF59A7PovnL9MbRON+jnqaBDCukZb3LyfOwQ2c
        wAO4QNhAc2aNqBOBgtbJJxLBsFMC0w==
X-Google-Smtp-Source: ABdhPJyEneAcqgapuClLy3QG+WNloZI+QjG5a9eKSxP6BzvpzXcDR/RnINhSm96dHxDrcRZGlePjkA==
X-Received: by 2002:a05:6830:1d71:: with SMTP id l17mr13816820oti.269.1608591106625;
        Mon, 21 Dec 2020 14:51:46 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w138sm3856739oie.44.2020.12.21.14.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 14:51:45 -0800 (PST)
Received: (nullmailer pid 720870 invoked by uid 1000);
        Mon, 21 Dec 2020 22:51:42 -0000
Date:   Mon, 21 Dec 2020 15:51:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        aford@beaconembedded.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Add optional mclk device tree binding
Message-ID: <20201221225142.GA720812@robh.at.kernel.org>
References: <20201217162740.1452000-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217162740.1452000-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 10:27:40 -0600, Adam Ford wrote:
> The driver can request an optional clock for mclk.
> Update the txt file to reflect this.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
