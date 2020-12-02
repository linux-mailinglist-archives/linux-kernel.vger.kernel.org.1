Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69232CC6F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbgLBTsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:48:54 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:41528 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387679AbgLBTsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:48:54 -0500
Received: by mail-ej1-f67.google.com with SMTP id f23so6206464ejt.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TQmM+HIdcTmJmyNaf8HdlxDL9jtOJCKpZTat+C8vF38=;
        b=q5IVNhwxeqpU7ZVqq3H6q6Q05Cw4XAEGn1KXSJSBYflwp2a5a2qzPPH7JGVOzSniiP
         B7wro/bqVs2C7al5M10RoKbu1ZWfKW+Cdr7t/lHjopWIhcGgDDZWDzV1eM+9tAY0lNCG
         LRg9zgCmZrGY8RYoeZ/9y6WRdPkt7S5dL5PZs86UZFj7a8tXY7RrrgbYXds9yzveuwRp
         8+k5tUfEUFkHZHHaH4muX559VrqVYEGUgaEW4U2ffE26lc84wA3jMjy9bkKei2w/EjbU
         j817Ng6mrE8+j2KCsBKbZRsSdQpzTCTtjefDMbbQl1LKwAs4thZyUZmxGLnF5/KNGine
         +P3w==
X-Gm-Message-State: AOAM532VNv602xV9mIAvz+XntJHNZ0jqQ8nbLupbw3JAHo0ksrkGnihT
        jNN/Gx23xyCz9Bcn2t/vi94=
X-Google-Smtp-Source: ABdhPJw/CuLiWrUb4/BZ1ac+/zwEde+nxvodt7OmHOCETstmBtL381bZwq7Tklg4VHMNU+1FQl5wZg==
X-Received: by 2002:a17:906:f905:: with SMTP id lc5mr1322205ejb.177.1606938492995;
        Wed, 02 Dec 2020 11:48:12 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j22sm535448ejy.106.2020.12.02.11.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:48:11 -0800 (PST)
Date:   Wed, 2 Dec 2020 21:48:10 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] arm64: defconfig: Enable REGULATOR_PF8X00
Message-ID: <20201202194810.GA110502@kozik-lap>
References: <20201202194149.180058-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202194149.180058-1-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 01:11:49AM +0530, Jagan Teki wrote:
> Enable PF8X00 regulator driver by default as it used in some of 
> i.MX8MM hardware platforms like Engicam i.Core MX8M Mini SoM.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

You will have to send v2 of entire patchset, so wait with this till you
have everything ready.

Best regards,
Krzysztof


> ---
> Changes for v2:
> - update the commit message.
