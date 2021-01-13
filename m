Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25FC2F4440
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbhAMGE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:04:56 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:45272 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbhAMGE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:04:56 -0500
Received: by mail-wr1-f51.google.com with SMTP id d26so765934wrb.12;
        Tue, 12 Jan 2021 22:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y1NkgwubQJo6+DrdcxV+O/7783b4D3luaMS6tWEPlf4=;
        b=Re8B6XtiCxmGYTda6+ZkgEDf1G1w1jXorI3n1Otvca6nfLwwf98mphVXgZgZZqZaV1
         tjTh002F+xuz8ov5FaxoT9UmLYWFaFw7iWB1JrSEIFvVlcyEiGDzEJe8UX7x/FvTJbei
         +0SijzJYHUQQhSrjrtsdh2GAlevVBIggjkhj//eyX0FhSgmrx8uu8NduFcgZeEakrYYs
         M7GbXa6cUoK9453TeV9c52vY6vxz39ugQnOULKx7rhplcyPZbpHBr8sOZB/dgigZMKTq
         ADQ2sEdVWHv/fExDMAkKxO1VnQFDwgK9QHcKhufTA5txwjAiQBXWai3opT0BWvOK8Chv
         4Lgg==
X-Gm-Message-State: AOAM530Tib8Hov0AGis77S0IwOBvQ6CwWn2TsGNWxoQJOtjNJwgk1Cg3
        Qi/RgA+ekL02xxWfTVmUGjM=
X-Google-Smtp-Source: ABdhPJwfn69yV/CGlTIViEl6H+moC4YZBMTH+gYLzJj9vE5rpMUAfaNHk9wmEcLTmaRItbDa7Grpug==
X-Received: by 2002:a05:6000:1d1:: with SMTP id t17mr745151wrx.164.1610517853795;
        Tue, 12 Jan 2021 22:04:13 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c18sm10261967wmk.0.2021.01.12.22.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 22:04:12 -0800 (PST)
Date:   Wed, 13 Jan 2021 07:04:11 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mn-beacon-som: Configure RTC aliases
Message-ID: <20210113060411.GA12275@kozik-lap>
References: <20210110115354.1259994-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210110115354.1259994-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 05:53:53AM -0600, Adam Ford wrote:
> On the i.MX8MN Beacon SOM, there is an RTC chip which is fed power
> from the baseboard during power off.  The SNVS RTC integrated into
> the SoC is not fed power.  Depending on the order the modules are
> loaded, this can be a problem if the external RTC isn't rtc0.
> 
> Make the alias for rtc0 point to the external RTC all the time and
> rtc1 point to the SVNS in order to correctly hold date/time over
> a power-cycle.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
