Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646322A4BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgKCQiF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Nov 2020 11:38:05 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:40536 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgKCQiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:38:05 -0500
Received: by mail-wm1-f51.google.com with SMTP id k18so13397514wmj.5;
        Tue, 03 Nov 2020 08:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tA/Gi64meoAIvJ1/rOlgArO0Q8knfxn/HDHGXBlXPK4=;
        b=m6Wu8j6Ou9+cCJVkr7jnhcRnbYLd10UxwWhWDI/J9yLz7N6upLGivXTjGyHRcCTTod
         z38tgRrBiiRj9qmRLsB52ZifkVwymYsvBQ1MucGd0OD6HwgBbrnEEdWeQd50Nlf/k04p
         PswnpK65PcAfcHkPGk/hFdw8/KaF9EUs5LmvLQyS5/WJFHv3Sv7e3F03AoRcqCmUT8Af
         IEaTNfmuJlaFQiFPu5IiHkNA5gP1ru/dUPROUSKb+H2c7m/fVnHLXga3vObArWkwBavQ
         LKrLLLSmu4A4Ji8h3oG/zGq6XdAcssrRo6ZdmYFHUF9sQN0RkD7Rj9im0QQIKrfoJiAs
         YWCw==
X-Gm-Message-State: AOAM533X2utkUDDXqe+uj7Fg/m4Ca31ZEBmhxVv4woiIRco1dkzKsG3g
        Ci+qR3K8eS4JN/sseBdVuqQ=
X-Google-Smtp-Source: ABdhPJx4xhE2bCdufMcnry8YViwBXFNgVh50OgUst6tZyNd9PNfUI3Q3Q95snRFaNhEacpE79StaKw==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr19550wmg.18.1604421482975;
        Tue, 03 Nov 2020 08:38:02 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 90sm7879759wrl.30.2020.11.03.08.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:38:01 -0800 (PST)
Date:   Tue, 3 Nov 2020 17:38:00 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Bart=C5=82omiej_=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 2/5] ARM: dts: exynos: Add Ethernet interface description
 for Odroid X3 Lite
Message-ID: <20201103163800.GC14739@kozik-lap>
References: <20201103124618.21358-1-l.stelmach@samsung.com>
 <CGME20201103124621eucas1p1e447d6d2eb3f29ecd657f0705f15960d@eucas1p1.samsung.com>
 <20201103124618.21358-3-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201103124618.21358-3-l.stelmach@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:46:15PM +0100, Łukasz Stelmach wrote:
> Add Ethernet interface description for Odroid X3 Lite.

Odroid XU3 Lite.

Best regards,
Krzysztof
