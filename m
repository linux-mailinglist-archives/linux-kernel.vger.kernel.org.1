Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B0425AEC3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgIBPZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 11:25:06 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:33022 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgIBPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:22:51 -0400
Received: by mail-ej1-f67.google.com with SMTP id j11so1530131ejk.0;
        Wed, 02 Sep 2020 08:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFHrQub+jTEKH5D1eU35+5gm+w2UlYWNNVwMw3mItZk=;
        b=r15hSUvrilTOq2F1Yu2f+YytVguJpWhjgHU3CS15axbYsgIHQm3ZDNVqWO9PDV0D8e
         83TH22gfhhP+Kmd8UY9ibYvj/HPEfpADiPiy2rLW04kAa6wI2NmRl0o12Wauu1RZgoST
         BNjikQXnAKGwBJoIsmka+F3GoKw4EYX88t4Hbej9t3lqqA/PhAwFJ3RZpetnD/EbGusX
         VrCXiJILBD3ZihQeJL8E6NISRTKK6Wy9fw5R0sD/rxSBTyqGEjMaRmU+uNu2ed+9s4VS
         76PSqrRtg/n7ASWhqQ/EOei9L2TxUPTKICKj7oMaynEuPy0GgPZd6eUyilUJV847tGc3
         Q0Fg==
X-Gm-Message-State: AOAM530g1nrVlPZz/rQdgAEuuRcTZhjvicdjOc/H26YuXN8uBdKYeoia
        INZ0Jws/S2M85gozeOyOwZ8=
X-Google-Smtp-Source: ABdhPJx988jNbSiGWtKhTNatNe3+5wNYljOf8q4qU2m3EM4LHKPlNuShz9gHWeXEp3FZLOdxA3HYhg==
X-Received: by 2002:a17:906:3957:: with SMTP id g23mr600042eje.24.1599060169950;
        Wed, 02 Sep 2020 08:22:49 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id x21sm4530841ejy.97.2020.09.02.08.22.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 08:22:49 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:22:47 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] memory: brcmstb_dpfe: Simplify with dev_err_probe()
Message-ID: <20200902152247.GA19659@kozik-lap>
References: <20200828153747.22358-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828153747.22358-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 05:37:46PM +0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/brcmstb_dpfe.c | 7 ++-----

Applied.

Best regards,
Krzysztof

