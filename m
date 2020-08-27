Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181B7253E39
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 08:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgH0Gwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 02:52:50 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:36439 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0Gwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:52:50 -0400
Received: by mail-ej1-f66.google.com with SMTP id l2so6189079eji.3;
        Wed, 26 Aug 2020 23:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yjb4IAblmNaYNb4UyN8UvAWwkcCaPYr1YWuJlC155Xw=;
        b=jKwiImRjcsHWQqPdS5M4AuYB362jWhMKB72U5NoGjuGsbYWP72O6kcFzV5LD4FDL9A
         WaXEnHtJx8h0UbDhFldGZj4gfkZ7/Yc09xYGYDpA1t2kjZLuTMqEKVy5z4sDpbxjmPFU
         7oN4QGKGVGiBRI+bDO6xKHh7jX5EyGLUZVq0SH5VMFeidAPUMR0M0gHZx+DofjD43IqE
         csp8lNp4hBRv5EuNkIcBzvwjSN+W/PXSEwbR31HUa4gC2ArNnlBHsdsb8oD3ScgBDvW9
         hLOhKsCnOun9lwWoWqGkENvklmwdT6ewqM7N2iE0I7B2f2nlc6Nf7Lqp8iBnfuKgu5sf
         zPVg==
X-Gm-Message-State: AOAM532N0dKiPVKDqUJ+ueHEqY/4V26RcU/tRf+xCeYTfdHFEj0EueFw
        D/buAU4/RXWXfGiPzaGWmm8=
X-Google-Smtp-Source: ABdhPJxFi7OZcJ8tVwLQiriRIQeG6696mgkLPi6JyH7EO4QW9OqOFKyOZ9PPbkYg6qtMEYqAYHQLDw==
X-Received: by 2002:a17:906:1404:: with SMTP id p4mr19224149ejc.256.1598511168930;
        Wed, 26 Aug 2020 23:52:48 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id l25sm1146359ejg.11.2020.08.26.23.52.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Aug 2020 23:52:48 -0700 (PDT)
Date:   Thu, 27 Aug 2020 08:52:46 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        kgene@kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] usb: host: ohci-exynos: Fix error handling in
 exynos_ohci_probe()
Message-ID: <20200827065246.GA17964@kozik-lap>
References: <20200826144931.1828-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826144931.1828-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:49:31PM +0800, Tang Bin wrote:
> If the function platform_get_irq() failed, the negative value
> returned will not be detected here. So fix error handling in
> exynos_ohci_probe(). And when get irq failed, the function
> platform_get_irq() logs an error message, so remove redundant
> message here.
> 
> Fixes: 62194244cf87 ("USB: Add Samsung Exynos OHCI diver")
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/usb/host/ohci-exynos.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
