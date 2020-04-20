Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02D41B1404
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgDTSIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 14:08:53 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39927 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgDTSIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:08:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id 8so9634849oiy.6;
        Mon, 20 Apr 2020 11:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bc56Dwj1aMPCCpPjifIrG4vj+vUAtSdEB9HyhT4YU10=;
        b=JWCxFYH+Qa7JgNcVMf+qCit5ViFepz8ox38ZsPfdqKGQbNDToFi+TOcUjye7jhiovH
         Aj2WYOmhuy6Ws0t9TCLSK+7Wme+L4AUOhyqxGAYKlDTZMYCaMueS0Jqs3eBbYzTzRryg
         RMBC/XyzXwzDTqLB/qEVE9tc9c2X8LGVIFCVkD/5w82CvqNukmpl29wEjwRSdLz4mWbg
         BOnY7tUulliNyDVQXRJjHichAiXeK2BrzTjyeQZZYuS8UuNSDJG+hkkCGA+r/UxZbH0s
         v8LUniz5TNLefFhTy96uFFoekxH4aL2DbRCw3+W8anC5ZiemEwoRE71AB1SF/NyCPF8W
         e87A==
X-Gm-Message-State: AGi0PuZ2wBW5u6KZ/ZYZc/mSN4l5vFg/1dtTgvZI8f7znElfaTSIobuy
        /Act0PtevNKOCuW8T6rhTGvZhGM=
X-Google-Smtp-Source: APiQypJ9IiQdq0jjyzPfhPrpdcpv8xxH38/RsgpZdDA5tEwK8oJrZwbmWnVs9XuPzOSsG6g8XvCCqw==
X-Received: by 2002:aca:3284:: with SMTP id y126mr428503oiy.175.1587406131319;
        Mon, 20 Apr 2020 11:08:51 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u9sm87462otq.54.2020.04.20.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:08:50 -0700 (PDT)
Received: (nullmailer pid 32206 invoked by uid 1000);
        Mon, 20 Apr 2020 18:08:49 -0000
Date:   Mon, 20 Apr 2020 13:08:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ASoC: dt-bindings: simple-card: switch to yaml base
 Documentation
Message-ID: <20200420180849.GA32130@bogus>
References: <87sghovzwb.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sghovzwb.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Apr 2020 09:00:04 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch switches from .txt base to .yaml base Document.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 
> 	- don't have "clocks" at definitions
> 	- tidyup comment of "patternProperties"
> 
>  .../devicetree/bindings/sound/simple-card.txt      | 351 ---------------
>  .../devicetree/bindings/sound/simple-card.yaml     | 484 +++++++++++++++++++++
>  2 files changed, 484 insertions(+), 351 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/simple-card.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-card.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
