Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A21621E5D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 04:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgGNCkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 22:40:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41156 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGNCkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:40:16 -0400
Received: by mail-io1-f68.google.com with SMTP id p205so7210939iod.8;
        Mon, 13 Jul 2020 19:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZUxfTMve7tojlRGU3UmWyKCsiZ0g9ylD95o3JMJaHuw=;
        b=msLqDt412xTvgulRCoPLH3OnsyTKnXKLmDSahY06rQeBXZ6IZTyp/BnUaW4RgPHtoA
         cwSW+ND+hE9TN5HQ7qrzmQl/cZSdBZ2ROHNKxltGYfWQnzD4iDTe0ys98X4MR3welOMY
         5twIj+HweDYAzmeG5AUrIcEKA+xkBpzgJUT4msktf1Ai3uGgm36SIkv984hUWDI3qoqr
         onRUWRvVkrqGXzRhlukSgnYiP5pBgAwSar2H2Ja5V4+xe3K9xzsMKBKJprmCPd5kGqNh
         0z3jmIFfV4CI7lENBBciB5LtItxGxRraS9GhA8jQyfs8zKYysb8MtjepOwGAv6dQkDiu
         rQ7Q==
X-Gm-Message-State: AOAM531YEZPTdSXUFsZ8XvY4iF5XJsYRiPQUFKXH0Qn49L0Ksgi9Y2PB
        3I6X3zrYvLqdhu6JZKf51A==
X-Google-Smtp-Source: ABdhPJyQQ3l5wL9LK2h1nC5hBDql8xmYYC4aucq68v/QWIzNcqQJqg/E/pPoWEH6BkoQeBwwOwy36w==
X-Received: by 2002:a02:c50d:: with SMTP id s13mr3380078jam.109.1594694415522;
        Mon, 13 Jul 2020 19:40:15 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id m6sm9645103ilb.39.2020.07.13.19.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 19:40:14 -0700 (PDT)
Received: (nullmailer pid 1174824 invoked by uid 1000);
        Tue, 14 Jul 2020 02:40:13 -0000
Date:   Mon, 13 Jul 2020 20:40:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add UniPhier AHCI PHY
 description
Message-ID: <20200714024013.GA1174775@bogus>
References: <1593507574-10007-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1593507574-10007-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593507574-10007-2-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 17:59:33 +0900, Kunihiko Hayashi wrote:
> Add DT bindings for PHY interface built into ahci controller implemented
> in UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/phy/socionext,uniphier-ahci-phy.yaml  | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
