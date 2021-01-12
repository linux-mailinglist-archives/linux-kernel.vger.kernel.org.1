Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755602F333B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbhALOuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:50:05 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43969 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhALOuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:50:04 -0500
Received: by mail-ot1-f42.google.com with SMTP id q25so2443899otn.10;
        Tue, 12 Jan 2021 06:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IWLlMkimtheXRJNfeaVYATyzETTt3j5yVq4Hw+rVSck=;
        b=gobj9zxpz9t7arVgdMPI2qHzCTfy7yZTygaMtpOQ6yaQliMbxdLQ96ITiPSqE93+Ig
         b3EUeJn3u3y/udipJ94TYYC3+BC/38+cPcFqLxDX+EOC+DypyJPPUiGmT3S0BBX5ecHp
         uhA2TrZdItZUR/a/yLzss/pobIlKd7ZlU4FHqg1I3CjNsQB70V0zUJdktp75hu5FBFwC
         3DnTJhKNqMMMPfb8WQ69iQvfQYR6MnoduA6NWtZ3o0X1h1KpBzfWg8KgmaDYN41s0GkD
         lurluk0Lbb0kOFtwoDlsFUr6oPVGls21qRUkTw12Ql/QLv7kD1o2RlG8s34GgRPFK0FZ
         4H0Q==
X-Gm-Message-State: AOAM533p56u8QjEle1lYNCqXmemG1lszTXKkudL3KcZAGtKu8ktrfjBs
        CwHI52wgChCiKXw5qWnXdg==
X-Google-Smtp-Source: ABdhPJy/6PT7DRQYGCTDug44TC+HCUic82SM9VAH6YLosWT87BKziW7GDMmDCgyuqvhV6ddUJ7BRzg==
X-Received: by 2002:a9d:4b19:: with SMTP id q25mr3080599otf.124.1610462963625;
        Tue, 12 Jan 2021 06:49:23 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m29sm607648oof.20.2021.01.12.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:49:22 -0800 (PST)
Received: (nullmailer pid 330261 invoked by uid 1000);
        Tue, 12 Jan 2021 14:49:21 -0000
Date:   Tue, 12 Jan 2021 08:49:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v9, 01/11] dt-bindings: mediatek: add rdma-fifo-size
 description for mt8183 display
Message-ID: <20210112144921.GA330210@robh.at.kernel.org>
References: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com>
 <1609989081-29353-2-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609989081-29353-2-git-send-email-yongqiang.niu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jan 2021 11:11:11 +0800, Yongqiang Niu wrote:
> rdma fifo size may be different even in same SOC, add this
> property to the corresponding rdma
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt       | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
