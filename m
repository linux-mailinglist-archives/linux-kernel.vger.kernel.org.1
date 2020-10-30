Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ECE2A0A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgJ3PuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:50:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32943 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbgJ3Ptq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:49:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id i18so1226938ots.0;
        Fri, 30 Oct 2020 08:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ftl2mmglzVyNPpTmwwRhyO51W+rV9lT76LSvntTyw0=;
        b=VrJEZoeBgRu8Y7gMbuWTtZk7x9F8rfiN4iBUghToNsUpoyU+wwAaqf+R1/DQAUPg5S
         rkXGi5Oun77l2hf4GEZh836UosjIQfTrdVpjH9qGOSFAAGWiX20Q3NJOKIqRxqYcJc3c
         Xd3DDmdC6ZzUr0vuBYvOyhhapsH8QyhB/UlMJuruuLp1L/Z0hSw9/UrmrxGzrf6kK0h1
         rcVifeupPmBivyf3Z+cyr1Tc5xFABJ1Jsh6epZWT5R5RkdsTuJCoWOXARU2BL1q8jWTE
         dQu4bIx0wSRD5DHiCDgJ5kjcBnEgy/zJDgBnD6zTONlVEmo8HcDdE7k1u/CX1XIvbdON
         Vs0g==
X-Gm-Message-State: AOAM531bxkoDCHd+b7JBb5kQQFRhbh8fUw7TZWWdtovlRNuURk73hLFk
        x0l/RVxp4HjwAin4BdvYVQ==
X-Google-Smtp-Source: ABdhPJz9aMo+yJ2ejJuLVzoOC70cg6U3LofBzYRBqTxOKAB+DSztHTx+rg5h2SrWLXIwxS+SilU8AQ==
X-Received: by 2002:a05:6830:2018:: with SMTP id e24mr2241291otp.278.1604072985738;
        Fri, 30 Oct 2020 08:49:45 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w8sm186211otm.64.2020.10.30.08.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 08:49:45 -0700 (PDT)
Received: (nullmailer pid 3905477 invoked by uid 1000);
        Fri, 30 Oct 2020 15:49:44 -0000
Date:   Fri, 30 Oct 2020 10:49:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, chunkuang.hu@kernel.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] dt-bindings: display: mediatek: disp: add
 documentation for MT8167 SoC
Message-ID: <20201030154944.GA3905431@bogus>
References: <20201023133130.194140-1-fparent@baylibre.com>
 <20201023133130.194140-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023133130.194140-2-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 15:31:26 +0200, Fabien Parent wrote:
> Add binding documentation for the MT8167 SoC
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
> 
> Changelog:
> 
> V2: No change
> 
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
