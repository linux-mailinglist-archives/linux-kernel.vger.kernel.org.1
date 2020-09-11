Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459182665CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgIKRNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:13:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36923 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgIKO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 10:58:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id n22so10271437edt.4;
        Fri, 11 Sep 2020 07:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GcoUTofUB6qhy7035EI6To3ibgdlCiURiNUbUNXaw6I=;
        b=CoAqONYoxg+HcuyC98mOH1F5HuivQHLHqYb5KqavqwuYnYCz5JpAidnpG744MNO1HA
         BGRgPM3UR1jnhjlzzdepH08zzrxbQO/kAkE5EUxjrzLeQw3pJhWa321lHNY/UwrYVnbf
         GquatHjpdTm4NqegPyES3bkdqL4pCb+kOx/tk7sLdzWl1I48SxkDZzJhCyz3e0iRBLyj
         9HJHlgztNKa0zj4Wfn6XlyovyDMLi2NRvZbdG34iQdyRAtLxmaDcZm8z4P7OF0WFJurH
         mHPeKJOMhalwjxhRNNAGg7lPSJCEAhoPHGpFW6kcA1oltjRcOOrDLdgcGvahvUVEv1aa
         nOuQ==
X-Gm-Message-State: AOAM532h69GSjTq2vCej2e+DktiT8d0vhxgy1xEzGQ27we9L9AtbjVYu
        zYRY19ANe3UEpHixDc4tZss=
X-Google-Smtp-Source: ABdhPJzTUj3zbI6elwZd3zIOb6pE2NGdWHdYR6xDJ6mTwv+rDxUE1HtD9YCd1R9SYENLPKkAK2+leQ==
X-Received: by 2002:a50:fe82:: with SMTP id d2mr2360474edt.86.1599836047108;
        Fri, 11 Sep 2020 07:54:07 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id gh21sm1743686ejb.32.2020.09.11.07.54.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Sep 2020 07:54:05 -0700 (PDT)
Date:   Fri, 11 Sep 2020 16:54:03 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH v3 2/3] ARM: dts: exynos: Add assigned clock parent to
 CMU in Exynos4412 Odroid
Message-ID: <20200911145403.GC15290@kozik-lap>
References: <20200906142146.21266-1-krzk@kernel.org>
 <20200906142146.21266-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200906142146.21266-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 04:21:45PM +0200, Krzysztof Kozlowski wrote:
> Commit 68605101460e ("ARM: dts: exynos: Add support for audio over HDMI
> for Odroid X/X2/U3") added assigned clocks under Clock Management Unit.
> 
> However the dtschema expects "clocks" property if "assigned-clocks" are
> used.  Add reference to input clock, the parent used in
> "assigned-clock-parents" to silence the dtschema warnings:
> 
>   arch/arm/boot/dts/exynos4412-odroidu3.dt.yaml: clock-controller@10030000: 'clocks' is a dependency of 'assigned-clocks'
> 

Applied.

Best regards,
Krzysztof

