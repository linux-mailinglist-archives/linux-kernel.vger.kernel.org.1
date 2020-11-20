Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E8C2BA5DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgKTJTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:19:00 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:38130 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKTJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:18:59 -0500
Received: by mail-ej1-f65.google.com with SMTP id a16so11905563ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJNTakbFwhRaoDBBX2Qv2zKhLnFzPrZ8orJ8Gh15hms=;
        b=LnrqGKYO8qT2RN9eZDwruEDqCGCoibddI6QIobPujvToJ05kAzatoeawR7CfTWxGM4
         /0GVVMyvIsJH0LwKTORQkuw5kZuHtM0ZSsdk3DrOyTIgm6dUYvzD2jYHC3Xw2SkbxHBK
         RlvwTsrARHluof0bj4GbkCPzxGKwAAu6cnYTLW/52Tj7UuIyxjTBS6gNCCZpABNf9SGu
         wy8r2p8kuljFWb/8TxM+cSLbhkc0y1stsArDnxHArYQADV+2oCXU/5XJdy+yokDRRVL9
         oKyxqVZmTRh3bMnNc5vjck9y6oNOYT51dCuktVwTsoDEYhRqy3iT9h7kqWrbc2271o+G
         Q8tA==
X-Gm-Message-State: AOAM533Tc1YIuROuZ6PU0hCc0Y64MGmJCyeMAVG3pNWTmAthnjcmJLjr
        /yNH/Qdq5mgVxGcVmq622DI=
X-Google-Smtp-Source: ABdhPJxhOs6nX3wl3JUpwyfylNA4SIDbFQHl5ntJ5lZXrQcioEy5Y1ufpt6zUhoD5apXZAJg0SDt9Q==
X-Received: by 2002:a17:906:af8c:: with SMTP id mj12mr31556277ejb.85.1605863937742;
        Fri, 20 Nov 2020 01:18:57 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id w15sm824295edx.37.2020.11.20.01.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 01:18:56 -0800 (PST)
Date:   Fri, 20 Nov 2020 10:18:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     linux@armlinux.org.uk, shawnguo@kernel.org, olof@lixom.net,
        alexandre.torgue@st.com, geert+renesas@glider.be,
        amelie.delaunay@st.com, aisheng.dong@nxp.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        christian.gmeiner@gmail.com, enric.balletbo@collabora.com,
        lionel.debieve@st.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: multi_v7_defconfig: enable dfsdm audio
 support
Message-ID: <20201120091855.GA10412@kozik-lap>
References: <20201120091506.18326-1-olivier.moysan@st.com>
 <20201120091506.18326-3-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120091506.18326-3-olivier.moysan@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:15:06AM +0100, Olivier Moysan wrote:
> Add STM32 DFSDM audio support by enabling CONFIG_SND_SOC_STM32_DFSDM
> as module.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
