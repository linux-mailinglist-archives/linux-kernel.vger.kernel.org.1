Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BD2274C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgIVWkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:40:07 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40778 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIVWkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:40:02 -0400
Received: by mail-il1-f193.google.com with SMTP id x18so16488536ila.7;
        Tue, 22 Sep 2020 15:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ts/H5lGkxCVpSIUsT+nwlHs+QYSEjYzumhKnYN5QEbQ=;
        b=TwMaaN9iQmLQb/tRjdURoOEQ30KKw7YYViFRSQESTznoGBkIVHlxtTcJsTmjOJjaOK
         PZdma7dt1yo7sv03d36o/LVUWznuRc/HMwWiVyDIoW7fdTaJBKzN8JrCPjV0i3mremyY
         f4KekBSv4z35WUNZ4W6aYw3yjS9I39RkQUXVqydW0qHdcHK3z2Q+Hbp1pN+6/1UXSuXv
         P2CDYZvarwMOB+jk5DIPs38nWvmNpqeM11IvWKWEmgumPVRl0RNxn/5kZ650tYoT1gYr
         aM2Aa9myuEV//0/lddDepk7BuRcxqvOwdJHuYwGRe7QoyY97bV90YC1/rG1dJ/KXXo0R
         ZL0g==
X-Gm-Message-State: AOAM531b9Ou0YREmCDQd990w7MpGxsFiCryCm/gPpaZgMQhh27f6zrm8
        no7E6jofVYRpuQCwiIzIog==
X-Google-Smtp-Source: ABdhPJzHf0W5nJgwpFfumBS1r8ILyOBzztbl7WxBBhsWTRLofS+g1hJjBquRMnQNVN/s/620iReBwg==
X-Received: by 2002:a92:5ac9:: with SMTP id b70mr6098813ilg.110.1600814401820;
        Tue, 22 Sep 2020 15:40:01 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s17sm9889563ilb.24.2020.09.22.15.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:40:01 -0700 (PDT)
Received: (nullmailer pid 3391920 invoked by uid 1000);
        Tue, 22 Sep 2020 22:40:00 -0000
Date:   Tue, 22 Sep 2020 16:40:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, perex@perex.cz,
        broonie@kernel.org, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, alexandre.torgue@st.com,
        lgirdwood@gmail.com, arnaud.pouliquen@st.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: add mclk provider support to
 stm32 i2s
Message-ID: <20200922224000.GA3391859@bogus>
References: <20200911091952.14696-1-olivier.moysan@st.com>
 <20200911091952.14696-2-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911091952.14696-2-olivier.moysan@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 11:19:51 +0200, Olivier Moysan wrote:
> Add master clock provider support to STM32 I2S.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
