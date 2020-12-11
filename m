Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE1C2D6ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405289AbgLKDmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:42:36 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44097 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391130AbgLKDl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:41:58 -0500
Received: by mail-oi1-f196.google.com with SMTP id d189so8349645oig.11;
        Thu, 10 Dec 2020 19:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JF6a5cRyN74JfPIki4yBoZHOtyP3dbYKgJjhXEIt/Qc=;
        b=MKs50hOwJ7EcAL9ItnSdColmd3dlRQxV+nwZTGSGL2Pj9yif5I1y3LNtyKbNy4AE57
         caifoTESSgMt0FWAgC4HgCCzwtpjGanLydEDUvcU0Ypx5mrBwQY68DebO+641BGiC1VS
         unPGsA9RAVDmonFUePFm8ITXyGh1UaUY3JFiboqmnJthAZOIgBfLoEYIQZYtym6Atgyk
         wEeZPFPPB7t2e7NAo+maKRLQ/2UExwMjXcDPyQ+RrpotZ7UpIlwSJqymAAU/N1Ur3CFr
         OTmyzpI36iJAigy6v2JZw6rAFJvy8TVZmhgAxwbm7JSH2PGBgmMLWB+T/1lQiM0yEbhC
         u+vA==
X-Gm-Message-State: AOAM533ne8sl+NvjiIVH6ZbGfAuFMDtlu4ggilX+qsMODhEBxgKFhMO6
        /znlvF5eJcuq2jKa97dHVw==
X-Google-Smtp-Source: ABdhPJyGbPgGdT7RVO4BHsUzlDrKOpsEQoXFt7a+VKXfIktLizdH955feW9AS7/DqIpm7zeXrKy01g==
X-Received: by 2002:aca:ddd6:: with SMTP id u205mr3560158oig.121.1607658077127;
        Thu, 10 Dec 2020 19:41:17 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 43sm1572383otf.28.2020.12.10.19.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:41:16 -0800 (PST)
Received: (nullmailer pid 3595522 invoked by uid 1000);
        Fri, 11 Dec 2020 03:41:15 -0000
Date:   Thu, 10 Dec 2020 21:41:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        CK Hu <ck.hu@mediatek.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8, 2/6] dt-bindings: mediatek: add description for
 mt8183 display
Message-ID: <20201211034115.GA3595491@robh.at.kernel.org>
References: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com>
 <1607591262-21736-3-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607591262-21736-3-git-send-email-yongqiang.niu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 17:07:38 +0800, Yongqiang Niu wrote:
> add description for mt8183 display
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
