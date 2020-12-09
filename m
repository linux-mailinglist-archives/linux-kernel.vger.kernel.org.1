Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C792D41D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbgLIMND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:13:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33532 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbgLIMNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:13:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id r14so1501295wrn.0;
        Wed, 09 Dec 2020 04:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YzNq/OrRULxzTzwcpqVhoNHAyvtCdZCJ/sWJN5KPKoY=;
        b=Xa8Umo3CErCL8QD3CCKhtlngjyUDKshJHqnQqBi4d99TASkSOdL19ml5MFKO0pqrz+
         ZhWof1mpeUcwiB6Zm0YKGe3MISrENsK7wvEaUz0Z4ANV91waIr1MnKCwUKKYIVDWke+a
         ggFKV6LJAFV86HoLj81sB4HLjM1LbCMSHG5xH7QTaZzcmukhiufm/lcqakvQhE8hh5HR
         h/5DLMoU7+tjWCNFmeEsKKCseEpN1kvum4JNpGxtiFjbUlMvv8bdjY54l1plVRyGkM3t
         YL5N9+E/6OjlVdcr1ce8e3davENsB9XSskswdPAfEg/g8Rlt8mwIsDDJpdBzNccTzgsj
         TOPw==
X-Gm-Message-State: AOAM530+5g0vEHc69Wo3L7QkFVplVt+jtEbA52FNhLYEABKep4ytrj84
        arPihdEgXYx8NoArpSm+aV0=
X-Google-Smtp-Source: ABdhPJyzVn9lT40VQ7tMQlRCoD8HI7BETLODhLoHSG3uMDmE6uPI+MIyct0aSvhiEK8h7LXVs1QvpQ==
X-Received: by 2002:adf:eac7:: with SMTP id o7mr2414611wrn.23.1607515940605;
        Wed, 09 Dec 2020 04:12:20 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 90sm3087627wrl.60.2020.12.09.04.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 04:12:18 -0800 (PST)
Date:   Wed, 9 Dec 2020 13:12:17 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
Subject: Re: [PATCH v5 05/27] dt-bindings: memory: mediatek: Rename header
 guard for SMI header file
Message-ID: <20201209121217.GA25951@kozik-lap>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-6-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-6-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 04:00:40PM +0800, Yong Wu wrote:
> Only rename the header guard for all the SoC larb port header file.
> No funtional change.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
