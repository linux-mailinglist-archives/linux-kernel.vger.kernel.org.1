Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF61527D69C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgI2TQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:16:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34785 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgI2TQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:16:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id h17so5598324otr.1;
        Tue, 29 Sep 2020 12:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=khfEMCrzC+xeFgceSK4LdFPerQXIwX6/lVcBadrzIYk=;
        b=bG1vsDu1Fo1XDy63z1ibg2jRZfmOGC43E3aYKzEtB5V5ImkqWX7fABOATWd7Bnok3/
         v/m3dOg1KGTSdHbuXyAnyn9I+ySbhTZJlc+AbPbO7VFd49rF5ujowzbLLPTugdg5Oc1/
         FHG0/wJOiew+N9izfsio5K8YAYNR+24VsieWVtPYuK67nZTwX428spXIvXR38pAetA3i
         Us4mvX726nEUBzl8UBTUuS/9UdqVsvNEsm3KvooY1BfEVkGK3+5HnuPBfDP8EFRi3GCo
         upZLnmZnNRHGDUZaKSxztTFSznPsmsfQuJMcy0huDMqo0kI9j1HU/iRFVn4CExv775dF
         0SVQ==
X-Gm-Message-State: AOAM530QpAF8hxsPwCQwuljCJvXiD3omRvPXwvr+iMQbswEqBzAZWxQV
        4M6t3D4vqiDOXYmqbw+N+g==
X-Google-Smtp-Source: ABdhPJyRtz1kFwr3M3xWap4ZWJW1APh9OvKctV1hgwY7u4VjhHCPtQVDgdIexDcnDr4bNze6lkMvjA==
X-Received: by 2002:a9d:709a:: with SMTP id l26mr3610157otj.115.1601406964161;
        Tue, 29 Sep 2020 12:16:04 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v7sm1268121oie.9.2020.09.29.12.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:16:03 -0700 (PDT)
Received: (nullmailer pid 993468 invoked by uid 1000);
        Tue, 29 Sep 2020 19:16:02 -0000
Date:   Tue, 29 Sep 2020 14:16:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 04/14] dt-bindings: vendor-prefixes: add
 Wandbord/Technexion
Message-ID: <20200929191602.GA993414@bogus>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-4-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 18:28:01 +0200, Krzysztof Kozlowski wrote:
> Document vendor prefix for Wandbord/Technexion.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
