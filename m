Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1643D292D26
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgJSRxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:53:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35705 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgJSRxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:53:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id q5so410084wmq.0;
        Mon, 19 Oct 2020 10:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kaj2effE0IGn4/LUYvpNhrsjTFxJeUBtfIsQ8uRH5Io=;
        b=rXGRn2/332d/j8c949gQFAap16/djF0N0rxAPt/cPrjPxZURADs43yRpwN2WNWgeBU
         ZVWQqb8aQ0ZsA/TH8rxDCTjH8qtJqhYDGgpJLXX1Odob4EpWUMg35nUmVaGcJf2Mbfn6
         CSshq4RVXZ7KIQxPLStjXcqpwigCXX03Py2to3i99zh2KxSLWbJ+uhELRwZ4sfD6pWyi
         ZU+ls/cTkqWXIAAIcyxa6AlHqvHDrBc2D18kazHMMWG29zPdzOeuklLeEMX9ljWX4J5O
         syFm28t76dOGEdlzWrn08ckcSi6H4v4TI/4Eu5VQ96PeJQ9vmAjuB0cQKBEhWg96CLqq
         OUJg==
X-Gm-Message-State: AOAM530XqImOPZlOJFZ96PEzZNTnyiMAqYYtsLIW2lPYKU6zgSksMF4d
        4dU+dm/CXDOQMnUHQuIvkSA=
X-Google-Smtp-Source: ABdhPJxWjHufMLDPPw4t+4vflwlXZwWA6RX4tW0HbR6pyOp73xqDBZNUgUHRknZfAVThGHrgOWtVQw==
X-Received: by 2002:a1c:750b:: with SMTP id o11mr459965wmc.32.1603129993216;
        Mon, 19 Oct 2020 10:53:13 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id a3sm552071wrh.94.2020.10.19.10.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:53:12 -0700 (PDT)
Date:   Mon, 19 Oct 2020 19:53:09 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] arm64: dts: imx8mm: Add support for micfil
Message-ID: <20201019175309.GC94694@kozik-lap>
References: <20201019165038.274164-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019165038.274164-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 11:50:36AM -0500, Adam Ford wrote:
> The i.MX8M Mini has supports the MICFIL digital interface.
> It's a 16-bit audio signal from a PDM microphone bitstream.
> The driver is already in the kernel, but the node is missing.
> 
> This patch adds the micfil node.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  No change
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
