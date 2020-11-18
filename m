Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7058C2B7AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgKRJ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:57:40 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:38707 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgKRJ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:57:40 -0500
Received: by mail-ej1-f67.google.com with SMTP id a16so1888457ejj.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vHvynxXDRrbBpMyooiMx2F7a2F7tNi6glQIZcTUzvk4=;
        b=HDLjWsf69i/JhzLXus5pZLqVJG0jkAYc1DEZT+MeDR8Yh2hQd6u7hv33GDxBgHHjkn
         JU2YueZRRAZ9xPn2kYl47RNuJ0exk4DSTdrzX41RoK1xf5YmH4OtDnAncyfljHj1DVFO
         CLhFmmexJRoHy5LkBk1pvHX0yskkA435Ca4CmQO68RTDqEejPGt/pY/Zg9g/R/IVkNZY
         RzRttv6a8lDhEr6QHJ9N2bzxbhV8SIQcP06KpdYqLWyKYPLaoj28urjIQCrgyHriIiUX
         ZIT5/0TJFzE8/YlSqYqNoUZHSWRjN5It3uSRBR/KCI3ukSxupClyveab6s0YlVXI6ofX
         6Ipg==
X-Gm-Message-State: AOAM533COdLxxL6XLvAJ1hIG7crg+tedOH7Z73p+9SifFybSs/lKyuSY
        CXj8tXF2SDPBK/6xO3P2NtA=
X-Google-Smtp-Source: ABdhPJyseKCTaVrk2SwdP4AfF8+FYn/cik5SUbH9kHMZQoRS1o3QkFhxEZARB7YYZfb1FRLWdzdAwQ==
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr219486ejt.522.1605693458613;
        Wed, 18 Nov 2020 01:57:38 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id f19sm13176916edy.13.2020.11.18.01.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 01:57:37 -0800 (PST)
Date:   Wed, 18 Nov 2020 10:57:36 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     linux@armlinux.org.uk, shawnguo@kernel.org, olof@lixom.net,
        alexandre.torgue@st.com, geert+renesas@glider.be,
        amelie.delaunay@st.com, aisheng.dong@nxp.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        christian.gmeiner@gmail.com, enric.balletbo@collabora.com,
        lionel.debieve@st.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: multi_v7_defconfig: enable dfsdm audio support
Message-ID: <20201118095736.GB17075@kozik-lap>
References: <20201118095013.16094-1-olivier.moysan@st.com>
 <20201118095013.16094-3-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118095013.16094-3-olivier.moysan@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:50:13AM +0100, Olivier Moysan wrote:
> Add DFSDM audio support by enabling CONFIG_SND_SOC_STM32_DFSDM
> as module.

Please say why do you enable it (e.g. for what SoC).

Best regards,
Krzysztof
