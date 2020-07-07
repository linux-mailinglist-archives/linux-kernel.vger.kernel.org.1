Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F48D216692
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 08:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgGGGkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 02:40:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36399 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgGGGkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:40:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id k6so43912603wrn.3;
        Mon, 06 Jul 2020 23:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vI8DxupuUbImB/T0a2XWJhMzabrm5GC5I3y8ZZb7Wpc=;
        b=XwpY8BrV1HYislsVC67BAFpz4LcONOItkgZsCM8jBr2nh/8qqSnaqNKeIMnPFvUXab
         2N8FwdMYEOMtZrtRbNW4raO8loPfqkSv1w3UhVvpAmsWEKQzuEi+b0LaqJf6vEwcQlH3
         SIMnhXWWuibQJAtVm7GMeqNl+U+Fpfkl3Rw676RE7dkeTgOmtzrxN/GA0aW4uDVxDNZ8
         6enxju5hcARDzG+SuQJvQT2WLEiBoqF7a/g/wdG+9c3kn/Xiyus1G9BvgFETEnglNsno
         uVL1NGEK/UMI5BHgmz4/9LdvVgbV/1kxeOUmDQxkAaDLyy4VYlcJz8FGcdH090Tz2X2i
         Lzog==
X-Gm-Message-State: AOAM530WxtttU8xpF8sI60Kt8b4ui/LLo3QcLovS69afLCuP7oWZrakd
        uDAqkPMCXqKh25Bm8DHxR7jMCbJz
X-Google-Smtp-Source: ABdhPJwf2m5P8QA824OMZJouAy2e4BXvU7D1KaqNe3ilQ0V+Q8oQBmWGCE4ZN8AyMiSHZ54kxTticA==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr51188746wre.369.1594104044716;
        Mon, 06 Jul 2020 23:40:44 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id 207sm2331459wme.13.2020.07.06.23.40.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jul 2020 23:40:44 -0700 (PDT)
Date:   Tue, 7 Jul 2020 08:40:42 +0200
From:   'Krzysztof Kozlowski' <krzk@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v1 2/2] arm64: dts: exynos: keep LDO12 always-on
Message-ID: <20200707064042.GA15031@kozik-lap>
References: <20200705070918.63531-1-alim.akhtar@samsung.com>
 <CGME20200705072938epcas5p479f0d040ca34fd44b2ba893a199efb79@epcas5p4.samsung.com>
 <20200705070918.63531-2-alim.akhtar@samsung.com>
 <20200705182306.GA13827@kozik-lap>
 <02e601d653ad$a5734190$f059c4b0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02e601d653ad$a5734190$f059c4b0$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:23:49PM +0530, Alim Akhtar wrote:
> Hi Krzysztof,
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 05 July 2020 23:53
> > To: Alim Akhtar <alim.akhtar@samsung.com>
> > Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > robh+dt@kernel.org
> > Subject: Re: [PATCH v1 2/2] arm64: dts: exynos: keep LDO12 always-on
> > 
> > On Sun, Jul 05, 2020 at 12:39:18PM +0530, Alim Akhtar wrote:
> > > LDO12 on exynos7 supply power to VDDQ_UFS20_RESET, in case this
> > > regulator is OFF, UFS host controller can not send command to UFS
> > > device. To keep this supply ON, set regulator-always-on property for
> > > this ldo.
> > 
> > Why UFS does not take any supplies? This looks like a workaround for the case
> > of not implementing any consumer.
> > 
> This particular supply is not part of UFS HCI spec and binding documentation, as per binding only one supply for host controller and three others for UFS device are needed. My best guess is, VDDQ_UFS20_RESET supply to reset logic block inside HCI, which might be specific to this controller version (I did not find any such supply in the latest host controller though).

The bindings specific to Exynos7 UFS are then incomplete.  Anyway it's
nothing worth revisiting so I applied both patches.

Best regards,
Krzysztof

