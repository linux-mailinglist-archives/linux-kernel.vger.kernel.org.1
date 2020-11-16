Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0422B4BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbgKPQ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:59:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44692 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731187AbgKPQ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:59:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id f16so16629258otl.11;
        Mon, 16 Nov 2020 08:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gPm6sA9oRClgJ6QfZp27nZDmEP+LS+OgTAXUUaGYMo8=;
        b=NQu+Kgkz4/ZpIJNtRP/rVQFO8P+Cxxz75tZu57kSZB2ypMrls+xrfct+OfU/eTzz7b
         FfxLzgHWVMebyKXu4V0ODkPUamMGl1tJrT3g/jkTH8O2FJ3vF42VesP4rbmsiDNdPZ7c
         ZYY7kp0h7WqtEzvItRmLxdlsksybpBOxroi/yOJczboyH28Nx6ro66trdJRhhlYfsXW+
         G+u2nA78B7f06NtE1FS8W+Itniu3KsZg4gdjyq3iJ9mAinRex11T01fc3D2NolihN4QT
         eiPd+db79F3ojN3755EYhe32LfSS5/NriCv/u/R/SoAja16biXX5KjSKG5o8Lvo/9el1
         zyKw==
X-Gm-Message-State: AOAM532r5D+M6COQ8zI9KW/tCMyqWoea+QRqcHbdghx/dphvsvkSVCN8
        Nm7VgsYM4wwpUNTLSLIxKQ==
X-Google-Smtp-Source: ABdhPJzHMBn693UwxypsTfTm45fxNBdSjJ65WWD0gGtLKkeCDqW0MqxiCMCZuQZCn4s/O1X/I1R23A==
X-Received: by 2002:a9d:222f:: with SMTP id o44mr128581ota.321.1605545961368;
        Mon, 16 Nov 2020 08:59:21 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x1sm829638oog.41.2020.11.16.08.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:59:20 -0800 (PST)
Received: (nullmailer pid 1804579 invoked by uid 1000);
        Mon, 16 Nov 2020 16:59:19 -0000
Date:   Mon, 16 Nov 2020 10:59:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org, lars@metafoo.de,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: adau1977: convert text binding to yaml
 format
Message-ID: <20201116165919.GA1804532@bogus>
References: <20201106102052.32582-1-alexandru.ardelean@analog.com>
 <20201110084754.46756-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110084754.46756-1-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 10:47:54 +0200, Alexandru Ardelean wrote:
> This change converts the old device-tree binding for ADAU1977 from text
> format to the new yaml format.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Changelog v1 -> v2:
> * updated libraries to catch newer schema errors/warnings
> * fixed examples, added i2c & spi nodes
> 
>  .../bindings/sound/adi,adau1977.txt           | 61 ------------
>  .../bindings/sound/adi,adau1977.yaml          | 92 +++++++++++++++++++
>  2 files changed, 92 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/adi,adau1977.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1977.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
