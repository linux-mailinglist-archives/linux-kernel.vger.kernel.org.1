Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5497302BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbhAYTuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:50:18 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37244 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731830AbhAYTfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:35:22 -0500
Received: by mail-ot1-f50.google.com with SMTP id h14so13902862otr.4;
        Mon, 25 Jan 2021 11:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nrzIYcJaC27vd9nGfsmTdb5Bn759r1uAoAX6/LzWCPs=;
        b=NGrwKo2qEzZZ6PwV6UUv8xdV8wE9xZlF+IAUNqHnnRGsQfs7BqnjKQp1NZhAEAtsJj
         /HMBeMVvpUr5HOTW3YaxznkuQx4kkrrlFuMe8p+dq6Hs9aXAXOi8SLORAVWjuK1ptyBD
         j0u5o2o3Zldx1HLdCEskEgnvOT4pfUHhh5TxANp1iHruq7pHz6Z+RSODMo8w18++5SNi
         g9SiD0xFY+Ccjfa5C3HIChNEb7YLebVwoa26eu1gacTvPxJDORPLBD6qmY0O9cl027uc
         cTLw8184NFEkJynHQoaNOp9vNr1yyJLpfFpcZgBH0t/ROtuCQcKO4lFAECl5tuSRJug9
         vGHQ==
X-Gm-Message-State: AOAM533iBjQysAWXnU29+V94877XbmmHBMQ5O8oUnV/TVeAKuXK86mNd
        Pui/IVbvmRWJJ0Z719oFkQ==
X-Google-Smtp-Source: ABdhPJyijhW8AYwSxyVmK4BOFt9iIwV1Dz1LEgyrj0WDTVlSe0I/nBQEXyJDkHgjsrV7xcz12Mtd7w==
X-Received: by 2002:a9d:7344:: with SMTP id l4mr1523845otk.181.1611603277224;
        Mon, 25 Jan 2021 11:34:37 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e17sm3674840otf.32.2021.01.25.11.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:34:36 -0800 (PST)
Received: (nullmailer pid 826799 invoked by uid 1000);
        Mon, 25 Jan 2021 19:34:35 -0000
Date:   Mon, 25 Jan 2021 13:34:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 20/24] ASoC: audio-graph-card: update
 audio-graph-card.yaml reference
Message-ID: <20210125193435.GA826683@robh.at.kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
 <8a779e6b9644d19c5d77b382059f6ccf9781434d.1610535350.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a779e6b9644d19c5d77b382059f6ccf9781434d.1610535350.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 11:59:21 +0100, Mauro Carvalho Chehab wrote:
> Changeset 97198614f6c3 ("ASoC: audio-graph-card: switch to yaml base Documentation")
> renamed: Documentation/devicetree/bindings/sound/audio-graph-card.txt
> to: Documentation/devicetree/bindings/sound/audio-graph-card.yaml.
> 
> Update its cross-reference accordingly.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/bridge/sii902x.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
