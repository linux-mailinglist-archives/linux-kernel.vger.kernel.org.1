Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937251AD1C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 23:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgDPVPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 17:15:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41164 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgDPVPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:15:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id c3so233198otp.8;
        Thu, 16 Apr 2020 14:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wF9LFb2WnHM43N9nJRd+Efvlf61P3hQp0pRx0O6S0UQ=;
        b=CZDz5nyA4RFolXbDXRaztkFfY5Be3lGYZ+UKKt/HJ18JAaEJvnNnkxv1CaKnSMSaE2
         3NLD7M/EjeZlbCO0uYb0lKCnjri82qhoO7mZQ8d5ZVnGY385i+74KyqyF1uMFZQNIP2I
         jx5xYLxmGYxblatajMCD0x//tMFMmNT+PVly4Mx3NUP8MHx7oeGwsYZh23TiHQCNFthE
         J6yFyrHwrmuxuqYMT9wG5dfkg7GhFf/oQDEI5P8TRUDPmCXR1ou28JegSfgI4SOaR2Io
         TitRVEJ6A2H5gm9xMrMJVmN3W51TF2bkQtgIDsBd8/SLoRa0KFqTWWr8bwGutr8T0IAp
         fnVg==
X-Gm-Message-State: AGi0PuZaDP+JdiDQtqzcZHftiEWAYbtusDpoAa/MNqr3VS51CghstCJx
        H3bmCE3jvyEbuyIFRxxKow==
X-Google-Smtp-Source: APiQypLNORYZDO+F1VLMjJmt2/9iac3R/DMHwg1QdBzGGqSksptwHI3MIDXgyNp1yA7oo3jm5xgM+g==
X-Received: by 2002:a9d:6a02:: with SMTP id g2mr93227otn.196.1587071701067;
        Thu, 16 Apr 2020 14:15:01 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s73sm3007660oih.14.2020.04.16.14.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:15:00 -0700 (PDT)
Received: (nullmailer pid 9062 invoked by uid 1000);
        Thu, 16 Apr 2020 21:14:59 -0000
Date:   Thu, 16 Apr 2020 16:14:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v2 06/33] MAINTAINERS: dt: update display/allwinner file
 entry
Message-ID: <20200416211459.GA8681@bogus>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
 <1be758765272ba4c2acbc3904bdf71c863a90186.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be758765272ba4c2acbc3904bdf71c863a90186.1586881715.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 06:48:32PM +0200, Mauro Carvalho Chehab wrote:
> Changeset f5a98bfe7b37 ("dt-bindings: display: Convert Allwinner display pipeline to schemas")
> split Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> into several files. Yet, it kept the old place at MAINTAINERS.
> 
> Update it to point to the new place.
> 
> Fixes: f5a98bfe7b37 ("dt-bindings: display: Convert Allwinner display pipeline to schemas")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Rob
