Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89C12EEB7F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 03:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhAHCxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 21:53:16 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:36351 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbhAHCxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:53:15 -0500
Received: by mail-io1-f54.google.com with SMTP id u26so8380610iof.3;
        Thu, 07 Jan 2021 18:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j9BJOm6Gyl9YhJRZvOpzUQv+7D7nE5zdeZRpcSuRRBI=;
        b=nHvSzXXNmC1EHWbEHPHEdXyP/qNfgNYYBB1ydgAKByLINvCkR/lCWurTvp/7RLAZ5O
         4u/a/KJhpg+6AbIqu3QpaV0pABedjXcG6ezZRT6X6kDKa7+g7VIPKAfBg7wb5QHHxgre
         U74EpbSGHCTCEJwGCyFyOdAAllmYVFhrc/F5RjQOplnoq+jyyv8oLYo12fIbRWIhN4/j
         OTfGoHA78XfjUVF6YIlcaLJUgOCZavjdxDHFYw5nDdwhEEElz8AXJnUgSsrRR0khGwjy
         0zv0qeIOzFpckt3GAKct8PiSB0SsnPNyjzFErDfQXKpkeqQ5uTvKpTYNnODArXr3RK1U
         lQsA==
X-Gm-Message-State: AOAM530fJR+bENNMxOOQzjG7o/IlA4CqsPtFuYSanhBRmBNftTDfyP2t
        y7LgNzrjQ+pe0WBoa2R9NA==
X-Google-Smtp-Source: ABdhPJxSj3GS6b8u4lJrqSge/6GnqMxaAVuJHdUXCdgq9UGMMZClQFUGQc3VppY2A5kzN6A5IQaUGQ==
X-Received: by 2002:a05:6638:1a:: with SMTP id z26mr1500734jao.52.1610074354559;
        Thu, 07 Jan 2021 18:52:34 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b13sm4525239ils.54.2021.01.07.18.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 18:52:33 -0800 (PST)
Received: (nullmailer pid 1782876 invoked by uid 1000);
        Fri, 08 Jan 2021 02:52:31 -0000
Date:   Thu, 7 Jan 2021 19:52:31 -0700
From:   Rob Herring <robh@kernel.org>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, David Airlie <airlied@linux.ie>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2, 1/3] dt-binding: gce: add gce header file for mt8192
Message-ID: <20210108025231.GA1782839@robh.at.kernel.org>
References: <1608770889-9403-1-git-send-email-yongqiang.niu@mediatek.com>
 <1608770889-9403-2-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608770889-9403-2-git-send-email-yongqiang.niu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Dec 2020 08:48:07 +0800, Yongqiang Niu wrote:
> Add documentation for the mt8192 gce.
> 
> Add gce header file defined the gce hardware event,
> subsys number and constant for mt8192.
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt        |   7 +-
>  include/dt-bindings/gce/mt8192-gce.h               | 419 +++++++++++++++++++++
>  2 files changed, 423 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/gce/mt8192-gce.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
