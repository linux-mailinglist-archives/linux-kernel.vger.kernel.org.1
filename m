Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3709225AF1B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgIBPd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 11:33:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35085 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgIBPcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:32:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id ba12so5370125edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3bSjrsWyOdwws/6V1L8nkxgPO+2ogVVxA6Jvka04XvE=;
        b=DNa3rO7392CsWZfBeclVaMUTqo/0IxRuzPqVYjRg4yzPKijY77vR1pu4+VNlcQyavc
         18aiFJyTd8b8+jINzh46PqEIH8P7waWHN752Q3Lh33GhlSPw6RmaDBaZr+IhIvBoxfbg
         i7hjaliHr0tpQYIeJB963Q++GMmK8DoqqfdwNrg80aqVvJe/+d3BFONB8XDXBsD0G7vp
         x/eGuGNWuUM5mrRYYOFTuWRuyRH+TGnzDFxTt+voK5LC85Jc3gVoA1ZnjevUwVmvxSm3
         AKIaqlF/FzcHqtaPC1GR/SRV7Zvyj4t7QFax0PzexZ8Z+7QqHi3DdRtELIctq1ykIyJW
         skYA==
X-Gm-Message-State: AOAM533d9mBSBt8bQJsr4EKbqJVjxauy+lFwYArD7tjSmdbosL3anJPh
        7yTaHd83i7m0ybep1+6yEuHi6KhUpsCoEw==
X-Google-Smtp-Source: ABdhPJxippTb/3lhBVf4jGnlPaco8p2sPtbg+e2Miuxwy2TICwyCT6TxTd2a4oOuvoBNhLsTrIKy0A==
X-Received: by 2002:aa7:c896:: with SMTP id p22mr616756eds.382.1599060741980;
        Wed, 02 Sep 2020 08:32:21 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id rl14sm4869930ejb.109.2020.09.02.08.32.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 08:32:21 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:32:19 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Scott Wood <scottwood@freescale.com>,
        Bharat Bhushan <bharat.bhushan@freescale.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: fsl-corenet-cf: Fix handling of
 platform_get_irq() error
Message-ID: <20200902153219.GA20895@kozik-lap>
References: <20200827073315.29351-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827073315.29351-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 09:33:15AM +0200, Krzysztof Kozlowski wrote:
> platform_get_irq() returns -ERRNO on error.  In such case comparison
> to 0 would pass the check.
> 
> Fixes: 54afbec0d57f ("memory: Freescale CoreNet Coherency Fabric error reporting driver")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/fsl-corenet-cf.c | 6 ++----

Applied.

Best regards,
Krzysztof

