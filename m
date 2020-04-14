Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D811A8294
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439352AbgDNPXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 11:23:37 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44518 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390829AbgDNPXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:23:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id o25so10684668oic.11;
        Tue, 14 Apr 2020 08:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iP8Yme/yERTcpil3n55AnAW8LqUxlEwBY586w3E95nU=;
        b=KT9HFxB5XAPJZQub5tcJd1ffCgoZe4Hsu2bB0YtfnDWq2kD75KpsszfuWNTjLzgU3X
         e/F3hMrd3dg3ncoIMwmvQo8ejnJR1IFwwHcBrGVYMawTbhAk3LZBxbtUdmHEkckxiYp6
         K7FDWE7Vt+2FAyAcWOViXnJRwqG3BrwcNB0BSZjIfsYZ0LeqDlg5tCkqEpQHreQs8xKC
         YT8E+Gpoy6UV4otFRwVy3/6CL/XxPlRoYVhvifLKCbysa1UmQtSn2/CC6N1ku/ifr5tx
         OLsThO6XYfkZtu2/g0tvd9J2FY3VuLsUXUaItuvV+QvoaeZq1IWojug9mBGayLv6Xt1l
         TV+w==
X-Gm-Message-State: AGi0PuY5vxM9cfMvQNaWmTRz9FR61YhAexF8Kqa7pa/V2RoWkNvZB660
        ShQOWhGZRCqHebr+L46ukQ==
X-Google-Smtp-Source: APiQypLYJkYYKWXvpSOEoNFc0cMsCUBSl8xLkW9q0c1ypTr4XS04mdZTHyq74lAxBh4DcMxaGjA35w==
X-Received: by 2002:a05:6808:a8e:: with SMTP id q14mr13614601oij.63.1586877791941;
        Tue, 14 Apr 2020 08:23:11 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a13sm6106021oog.32.2020.04.14.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 08:23:10 -0700 (PDT)
Received: (nullmailer pid 28919 invoked by uid 1000);
        Tue, 14 Apr 2020 15:23:07 -0000
Date:   Tue, 14 Apr 2020 10:23:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] ASoC: dt-bindings: fsl_asrc: Add new property
 fsl,asrc-format
Message-ID: <20200414152307.GA28870@bogus>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <47fcf06689d1a086141ce4d80f7ea7af7958dc89.1585726761.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47fcf06689d1a086141ce4d80f7ea7af7958dc89.1585726761.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Apr 2020 16:45:35 +0800, Shengjiu Wang wrote:
> In order to support new EASRC and simplify the code structure,
> We decide to share the common structure between them. This bring
> a problem that EASRC accept format directly from devicetree, but
> ASRC accept width from devicetree.
> 
> In order to align with new ESARC, we add new property fsl,asrc-format.
> The fsl,asrc-format can replace the fsl,asrc-width, then driver
> can accept format from devicetree, don't need to convert it to
> format through width.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
