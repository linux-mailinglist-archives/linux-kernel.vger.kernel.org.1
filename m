Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A299224E9E1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 22:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgHVU4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 16:56:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46532 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgHVU4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:56:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id r15so5000607wrp.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=msxGa2IzZ+LQXZdwx/mj0NMbaUdlVNLfYIuR/2n+dNk=;
        b=XbgovlSVK6qG6W7KXkkHFQbsrVJEMA8XdhGh70yi4rGImSzg3rDdY1+L3mbArsPEXM
         xKx0DG4phbzRUeopLsBQd4rTnZslSV9G7XorhJL2pp8roh/6nwNqElBB9c4Wiyl06jEJ
         6UEnLvAtItZbkrTAnZU9axs94DRf3B5M6YHtIKVOiRs3AaCRv5bSewSMgLCeU7QpiZGU
         Y1JltBxIE6NM7Eau8LgEcC+ZIHtGhVqca692+utUYdUwNoimrytLcD8NnMRvB8yQsPiB
         rs1LfButh29a5nfwHoPCREviAXPhtEEaeCOdaZm2o0jvNi7rHPLexJHEw4oYF9aS0110
         v1xg==
X-Gm-Message-State: AOAM530i8Vk6UixwGdanJhgIbBEO/HgVLzRhoLHpSU44O3yjYqqmHbyk
        oBwpk6jJfrfkKyUCBiGmKGk=
X-Google-Smtp-Source: ABdhPJxvXYFo8xjpn3BGJ6lHN0doaw/yA/+qpEQwDwyFBU5mHN+qOQsObLghzXpjaevzPBbYVgvfSA==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr4076853wru.9.1598129796472;
        Sat, 22 Aug 2020 13:56:36 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id h5sm14754940wrc.97.2020.08.22.13.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 13:56:35 -0700 (PDT)
Date:   Sat, 22 Aug 2020 22:56:33 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Markus Mayer <mmayer@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] memory: brcmstb_dpfe: fix array index out of bounds
Message-ID: <20200822205633.GA8809@kozik-lap>
References: <20200822205000.15841-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200822205000.15841-1-mmayer@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 01:50:00PM -0700, Markus Mayer wrote:
> We would overrun the error_text array if we hit a TIMEOUT condition,
> because we were using the error code "ETIMEDOUT" (which is 110) as an
> array index.
> 
> We fix the problem by correcting the array index and by providing a
> function to retrieve error messages rather than accessing the array
> directly. The function includes a bounds check that prevents the array
> from being overrun.
> 
> This patch was prepared in response to
>     https://lkml.org/lkml/2020/8/18/505.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
> Reported-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> Changes since v2:
>     - Added "Fixes:" and "Reported-by:"
>     - Fixed "From" address
>     - No changes to the code
> 
> Changes since v1:
>     - Added link of the coverity report to the commit message.
>     - Added Florian's ack.
>     - Removed second "const" from get_error_text() return type
>       (thanks to the kernel test robot).
> 
>  drivers/memory/brcmstb_dpfe.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

"From" and SoB look good now.

Thanks, applied.

Best regards,
Krzysztof

