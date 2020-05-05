Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272011C6085
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 20:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgEES6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 14:58:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34009 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgEES6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:58:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id 72so2647611otu.1;
        Tue, 05 May 2020 11:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QLflle2CTzf5TvGsv3/RnJZmAoRYV5eA/IwZnI7X1VE=;
        b=AEXnp19OHmwdE174voyhp0wFA6ePe5QQTvxnWhMNe2jj6wT9O0V9ynHUs3pd04JsAB
         otFHYTrd98hi9z9JLKeL6Tx+MdYQ5d/aWDuujoJN3Xe5NBmC3xdkDGQdt3bKUAI/uAJ5
         juklXuVfCue9V9rDo/iDvEUet6fR5ZaZsQcxuXdF78cEQsoLvVFHFcp0OiDZQ3eInJ+n
         Uf1w+nwM6VDcOs7BXHTQfleQTcE84E7b/fsBZQ8Eic4aVLXV5RW7zOcp6q7jPnMfzxyl
         ysSwtOidmbPwaN7GimkPEW+sgv8OOJvzIojryzQMNTEKBbLbSgTQmlwuvMAYhH3W/ZZX
         EIqw==
X-Gm-Message-State: AGi0PuZLNrKyzeuSn6nN9cqXtvKYpvvkIkursFKyuBRO99fEYILGaRYZ
        S27Fm2XcLWknucgpBoCUGMTOPyw=
X-Google-Smtp-Source: APiQypKItUMgGhyJv4Ds1UMh1LS87zMjeW32GyoIZJySORTWboRZCqIAxYAYpNNSJig3NDROnbAqaA==
X-Received: by 2002:a05:6830:1656:: with SMTP id h22mr3708724otr.290.1588705087964;
        Tue, 05 May 2020 11:58:07 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n16sm782516oop.23.2020.05.05.11.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 11:58:07 -0700 (PDT)
Received: (nullmailer pid 3092 invoked by uid 1000);
        Tue, 05 May 2020 18:58:06 -0000
Date:   Tue, 5 May 2020 13:58:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Pedro =?iso-8859-1?Q?=C2ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Zack Pearsall <zpearsall@yahoo.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/6] dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
Message-ID: <20200505185806.GA3026@bogus>
References: <20200505022517.30523-1-digetx@gmail.com>
 <20200505022517.30523-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505022517.30523-5-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 May 2020 05:25:15 +0300, Dmitry Osipenko wrote:
> Add a binding for the Tegra20-based Acer Iconia Tab A500 tablet device.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
