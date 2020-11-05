Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C12A86AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgKETEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:04:34 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35017 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKETEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:04:34 -0500
Received: by mail-ed1-f67.google.com with SMTP id ay21so2688231edb.2;
        Thu, 05 Nov 2020 11:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zqyCE8j+KUun/fJoeSvUEUCu9rjigk9T/yqFJYAG6HE=;
        b=ub1ZiXtD1v3VIAO3+G/JKURaAw/wLa5IPU67+hKYGZ20g3XLPLBvxOkYb/hWsSQYRY
         I4ZEpiNg53dyjqFpk3DFiYVsoZwTZwssJK7SxfLLqBLpZQQYTeWZ8IOBI67gkKz1HXJS
         WGIizfo/zj99WHdx3JWj2tZFlWueuoWNb3Bsh5Y79Nurxre9d6g3Bl41SkOAnoVQAnpq
         e/qPjlC7VFckmvYD+WtIZh47hRVA9ZmsBAJdRSLQVQyokshKaGBV3nFd+uFsryYSzC/w
         uiAU4SBxr221Sh1Ag0EPIt11f8Bv1KB8GYG4HIpujUZizss/3g0TaS/sta07vGsIW8Ho
         V+lQ==
X-Gm-Message-State: AOAM531ztJn+PAyTG89N8VW6pSiBVaEHrJHgxkh5mmdzRtuOAKw+uAV1
        s629gzwp9SKsMj1AGSVtwA0=
X-Google-Smtp-Source: ABdhPJz1Vs7KZFfoAlojBxrrmYqF0uUmNwhflz1BNcxZt0QGdXEDkjrc6x/XVjVsJtmzvIn+5lPqDw==
X-Received: by 2002:aa7:cb58:: with SMTP id w24mr4093038edt.35.1604603072260;
        Thu, 05 Nov 2020 11:04:32 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k23sm1490058ejo.108.2020.11.05.11.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:04:31 -0800 (PST)
Date:   Thu, 5 Nov 2020 20:04:29 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        ming-fan.chen@mediatek.com
Subject: Re: [PATCH v5 3/3] memory: mtk-smi: Add mt8192 support
Message-ID: <20201105190429.GC217610@kozik-lap>
References: <20201103054200.21386-1-yong.wu@mediatek.com>
 <20201103054200.21386-4-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103054200.21386-4-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:42:00PM +0800, Yong Wu wrote:
> Add mt8192 smi support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 19 +++++++++++++++++++

Thanks, applied.

Best regards,
Krzysztof

