Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7342A0E49
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgJ3TDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:03:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36465 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbgJ3TDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:03:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id 32so6519376otm.3;
        Fri, 30 Oct 2020 12:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tp6jGd10k28/5TtEQRd3SeWAiPCRXH/hj9Pu2EBBOJE=;
        b=ipfLMZphGSEEHTtF1804cZU8T7P10TRy4WfwNaTTlm5NUYu5FK2rIyQDHmT6ksesft
         oQZ/9S+beO/geFznsIUhlhD7NB6aNjXdFxCzetW0GjS15Ke/QmDpqfBxieiNvWBukaUq
         A02Rbz5e/7PGodJX9beTmYSXxDkJd7OdmJjPPcmeJMApX3a3yPGjrdYtR3XcONuvODTk
         rOhx/qwXRNmMS+jpndokp5WWKhW/Ql1rOp+Onl2dKk9D9BwRFfKdx1sdwsunph2VOa1I
         RhZt9o8lKJwbh0P45bkVMc7blT/niAj7E7BiVe0TYZ1HprWE68Yi1v7iEp7iWfrcN6s8
         xjPQ==
X-Gm-Message-State: AOAM531fuqvZkyHfkCRbordr351d6nxb292pNG2vU32tVa8U2ldPLOMd
        0yRAbx2Ar6yDOxHv7mkUvg==
X-Google-Smtp-Source: ABdhPJwXOSuERod/HGVCj/MVbdhkwEnNU0wrCAT1ORY0lprndKvuitse6DaiDe+gwDXmO8FKSawGPg==
X-Received: by 2002:a9d:2487:: with SMTP id z7mr2622733ota.133.1604084610161;
        Fri, 30 Oct 2020 12:03:30 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d17sm1491747ote.47.2020.10.30.12.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 12:03:29 -0700 (PDT)
Received: (nullmailer pid 4153325 invoked by uid 1000);
        Fri, 30 Oct 2020 19:03:28 -0000
Date:   Fri, 30 Oct 2020 14:03:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     enric.balletbo@collabora.com, Weiyi Lu <weiyi.lu@mediatek.com>,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add MT8167 power domains
Message-ID: <20201030190328.GA4153272@bogus>
References: <20201027131122.374046-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027131122.374046-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 14:11:20 +0100, Fabien Parent wrote:
> Add power domains dt-bindings for MT8167.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> 
> This patch depends on the SCPSYS PM domains driver [0].
> 
> v2:
> 	* Implement on top of new SCPSYS PM domains driver [0]
> 
> [0] https://patchwork.kernel.org/project/linux-mediatek/list/?series=370737
> 
>  .../power/mediatek,power-controller.yaml       |  2 ++
>  include/dt-bindings/power/mt8167-power.h       | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8167-power.h
> 

Acked-by: Rob Herring <robh@kernel.org>
