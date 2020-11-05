Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE512A86A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbgKETC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:02:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45319 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgKETCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:02:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id q3so2397282edr.12;
        Thu, 05 Nov 2020 11:02:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WRATYPVVpUj0dIlvu1sSRL+DjOGoPhuNmDfmJZyE3X4=;
        b=RtTTJ8ngNWV0mGI2qLJoxXJq+oIh6LYqYO4JJTR3Khz6qaLK1nY+l1ZCgBhvt7u3Xl
         u3nDEJCN8xYJFl0qVy8H8HR0ukEAzVCJ3VGbSv6D2a9qZXYQwIWIZBo8d79oXBtopHjH
         wyI/ARLBffJEVUYmtDAxjygzrIVB61K+CsI7yyKFo7euTsR5H+4FeH9Ju8igG0rS/9/Q
         tGVNLoAyNkYiqm79Y/9j3AuXUKO6ygCzXKiPgNgem+aky2K3aMmo9PZ0qqw0ecGLii2O
         C2wcbG4ztoJcsugPCrnZfoAjZqlXhktKg23Rmosd5TbF137+MatBtXTxU5zvgd+qczSN
         go3A==
X-Gm-Message-State: AOAM531bwuIM2a/zDY3PH3uvdw1FLCtDYlqAs5oN6fmz3FqY9Z1Nw05c
        uMLb8ZSt3R+HH0HWitzOZ58=
X-Google-Smtp-Source: ABdhPJy4eek/pneQf2INHGzsXHnasKODWlCZYK99ygc4HT8ykdbZgCZY3RkkdXqf9JumHekNW1uKCA==
X-Received: by 2002:a05:6402:4c6:: with SMTP id n6mr4246361edw.204.1604602973903;
        Thu, 05 Nov 2020 11:02:53 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id e19sm1472305ejz.35.2020.11.05.11.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:02:52 -0800 (PST)
Date:   Thu, 5 Nov 2020 20:02:51 +0100
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
Subject: Re: [PATCH v5 2/3] dt-bindings: memory: mediatek: Add mt8192 support
Message-ID: <20201105190251.GB217610@kozik-lap>
References: <20201103054200.21386-1-yong.wu@mediatek.com>
 <20201103054200.21386-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103054200.21386-3-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:41:59PM +0800, Yong Wu wrote:
> Add mt8192 smi support in the bindings.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/memory-controllers/mediatek,smi-common.yaml      | 4 +++-
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml        | 2 ++

Thanks, applied.

Best regards,
Krzysztof

