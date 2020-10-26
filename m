Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B46298F68
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781560AbgJZOeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:34:18 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42771 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781507AbgJZOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:34:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id h62so8141383oth.9;
        Mon, 26 Oct 2020 07:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gu70+4d8Zu8/uxoB6xBSb3yW/hLHlyYk/LMJt3p6Pnk=;
        b=pLwI8Noh1VdkQVQRQO5E2eLIe97i50aVopGnOAQJI2WUAiyCUfHaGE8PJrW+5okhi4
         MYwHoQuOwvPfSsQsZufGZ3oF1jGY2uemoXddgbTnDK591D95j13v4UndF7BRUV8Mlc0p
         7ul/ezS1BFZbemfKUlDv4VIM3cbKJYXSywdvIXXkDDWUAaSPWrb2eBLSBmpOqRX+VOxE
         ZUYQoIJQZEiTTF9fhyDp6Spcu51/SJkiur+Ey6K5AaeEl7xIXcqCTHpG4tfmp5bwqZ+K
         llHY703SpQNQzZflHpTBEhg0AtUYN9L/QunpTv105Zbs0BHattqKOqeGbjPH0ycp7ygN
         kgSA==
X-Gm-Message-State: AOAM533eJP4WDk0kdRFi/d2Dkv9wC9c9hI+sGR1StiQr8RZFwVnyrT1n
        SgnE/OOq7BpGn0YYXeLLcg==
X-Google-Smtp-Source: ABdhPJw+O158CQSA6jqE9RrNha1lkKYpXpyDC9T1facmMZ7+/cjPi+O4C7tiVHVLFM1bBF8uzV9oKg==
X-Received: by 2002:a05:6830:1e44:: with SMTP id e4mr15220194otj.346.1603722850794;
        Mon, 26 Oct 2020 07:34:10 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e3sm3969247ooq.0.2020.10.26.07.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:34:10 -0700 (PDT)
Received: (nullmailer pid 117630 invoked by uid 1000);
        Mon, 26 Oct 2020 14:34:09 -0000
Date:   Mon, 26 Oct 2020 09:34:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        mark.rutland@arm.com, arnaud.pouliquen@st.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        alexandre.torgue@st.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Subject: Re: [PATCH v2 1/2] dt-bindings: stm32: dfsdm: update audio properties
Message-ID: <20201026143409.GA117596@bogus>
References: <20201020155709.2621-1-olivier.moysan@st.com>
 <20201020155709.2621-2-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020155709.2621-2-olivier.moysan@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 17:57:08 +0200, Olivier Moysan wrote:
> - Add missing compatible property in audio node.
> - Remove obsolete "st,stm32-dfsdm-pdm" compatible.
> - Remove useless comment in adc io-channels description.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml    | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
