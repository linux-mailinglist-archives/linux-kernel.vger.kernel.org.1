Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964B1294F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443986AbgJUPFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:05:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34902 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443639AbgJUPFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:05:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id n11so2120978ota.2;
        Wed, 21 Oct 2020 08:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j5vXzbajSvk2jPGnq190MC//0hHF/9k+3Xwub4lFqOk=;
        b=KCPu7Vpm1XQ6W9zQ5Zjbq0gTjbk0DhTFPblpthq/jca9MhmYhjXLZ9PlwiesBEeayw
         GTCMo/P/5o6sX58bhQqbT9k4o72wcRAaWv+IbRpAR0r3sVk3Hb41hlGlQBtm+1WVRX4N
         1qdxs8niNG3ZYGAP/Tsh14idxvescjxCzWJXz5KKQJ6+Z9PpgJbRvR81i1STDK/AspL6
         FOW6iMuDPS+m0khpMOnj3gjNTW9Bp2oKfcxd4OU45WPM474ezGyVOpEuGf4mEv+DHJZF
         VB1aWhQWjPczQt6CgfquL8mV1k7+2nBG/ENlkqSlVfkPW8ijTWGLocW5J+SXbGr9ek2l
         IR/Q==
X-Gm-Message-State: AOAM533ejL4JDsyfJ1KAS32Y8JsIpWJlzkOvKhEqOI1sI5IJtDkiwjeC
        0Q4wMIGNvv8cfDDZRa38XQ==
X-Google-Smtp-Source: ABdhPJyBdffq8YFayXKBVbcSTDZtsjX1dHiZVOnDChBLmQ2MNXBFO87aO+PpqoH5j4nTyRzv+goqMA==
X-Received: by 2002:a9d:7993:: with SMTP id h19mr2830613otm.289.1603292723983;
        Wed, 21 Oct 2020 08:05:23 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u140sm727527oie.41.2020.10.21.08.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 08:05:23 -0700 (PDT)
Received: (nullmailer pid 2798579 invoked by uid 1000);
        Wed, 21 Oct 2020 15:05:22 -0000
Date:   Wed, 21 Oct 2020 10:05:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>, wsd_upstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: devapc: add bindings for mtk-devapc
Message-ID: <20201021150522.GA2798521@bogus>
References: <1602732039-12179-1-git-send-email-neal.liu@mediatek.com>
 <1602732039-12179-2-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602732039-12179-2-git-send-email-neal.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 11:20:38 +0800, Neal Liu wrote:
> Add bindings for mtk-devapc.
> 
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/devapc.yaml   |   58 ++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
