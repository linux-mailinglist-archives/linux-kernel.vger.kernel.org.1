Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B151A4924
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgDJRhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 13:37:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33682 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJRhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:37:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so2538737otv.0;
        Fri, 10 Apr 2020 10:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTbeyk/8MKUbxThUiws/BIz7+fn9OO+aZs86k0WtGEY=;
        b=ne27CzQQbFbdiYpC+4xn98RuYZU8ADRPOm2qSuUQuVgLgDRNaYNly5ZoeI3B6/1DIJ
         0dFsY+oNiDMAooX/XbePl46yspFipCX/haEnHHcTcWnIp6WP3PVxeBtog/GxnyfBonKt
         S2LDGmPWo97rRes0/gRummb6eK97ymf+pkR0BDKMqD4xfNPF8EEp12DFBfmhu7w1yI7K
         ITLDVuxVXAprfqEgZxUMNfXe+2/LFRmFNsKPtlz434+6yZ570KtjkC+ZeNBYULR2kGXz
         GqYM0gLs1DlKrGtU9LGFCSDS2sOwUK2un4/GKMJ0/N6McR/fNRBxqh2TTY2xF4VxG822
         e/VA==
X-Gm-Message-State: AGi0PuZhklkEk2qjFiN/qvD/qUrequuxfhAiDIULJsSaCG8T2/YNl/Vj
        wNMhUcZgbU8iS5YchGopWw==
X-Google-Smtp-Source: APiQypIQx5fHf44Txa8QJaaNIJN+7pFohmFjr9Mc3XNnK9fxeikXH/pi6ykdhl/2VVzOFtQI1UOCsw==
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr5188684ots.310.1586540250772;
        Fri, 10 Apr 2020 10:37:30 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id a5sm1673876oot.5.2020.04.10.10.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:37:30 -0700 (PDT)
Received: (nullmailer pid 8169 invoked by uid 1000);
        Fri, 10 Apr 2020 17:11:38 -0000
Date:   Fri, 10 Apr 2020 12:11:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH 3/4] clk: sprd: add dt-bindings include for mipi_csi_xx
 clocks
Message-ID: <20200410171138.GA8130@bogus>
References: <20200330071451.7899-1-zhang.lyra@gmail.com>
 <20200330071451.7899-4-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330071451.7899-4-zhang.lyra@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 15:14:50 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> mipi_csi_xx clocks are used by camera sensors.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  include/dt-bindings/clock/sprd,sc9863a-clk.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
