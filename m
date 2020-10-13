Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF51728D2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 19:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgJMRQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 13:16:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42185 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgJMRQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:16:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id m13so707834otl.9;
        Tue, 13 Oct 2020 10:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HAKUo4scbg7V2YEalYpDN/o8gpn5BSBKY+2DCt+wy38=;
        b=GCs36NlxMR574+2odTCz20p6hv7GIvRGux5SJ9YckMBJV2w2I9bfm9BfVv+17seFM4
         /kZOsmbYuZO+5mFwSIDccM7YEEruwNRiYxy7sArLeic7kIElZwSpJei1t1W9scfG8uml
         JuQ0QV4Jstl81TTi/QqTK8b5VUQt5kx8PMI0+Wl6sK1iaMqSS+hvOkLdlXki94ZIu06C
         zhkyql0xf4UzTnRqTsYG5/i/dwHZVQ3G6GM0xEKpPNgZzXStKKveqIzC0XAXcNa7oMty
         jy8Aji8i5yPf+4hWhi53gjSjqWa0H0enDaSGqBB7xRNYZ3ufZCq/hlc8b+RZ92AtHpHI
         2Eqw==
X-Gm-Message-State: AOAM531a+rAH1iqVn6sGXBlELCmq3W+t3WEWmR4T+KlamwsObBmJvXVd
        HQQ6UdGFDwKmXVCGB2BPQg==
X-Google-Smtp-Source: ABdhPJxYJqfSxHjkx1gdVXV4uFnQziYVvfV2finalHIGMvRrtKZTkJjC9BIVivEWTvGnkNd9GfBHbw==
X-Received: by 2002:a05:6830:1183:: with SMTP id u3mr457720otq.167.1602609359331;
        Tue, 13 Oct 2020 10:15:59 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o14sm129104ota.63.2020.10.13.10.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 10:15:58 -0700 (PDT)
Received: (nullmailer pid 3716207 invoked by uid 1000);
        Tue, 13 Oct 2020 17:15:57 -0000
Date:   Tue, 13 Oct 2020 12:15:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: extcon: add binding for TUSB320
Message-ID: <20201013171557.GA3716151@bogus>
References: <20201012144754.738830-1-michael.auchter@ni.com>
 <20201012144754.738830-2-michael.auchter@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012144754.738830-2-michael.auchter@ni.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 09:47:53 -0500, Michael Auchter wrote:
> Add a device tree binding for the TI TUSB320.
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> ---
> Changes since v1:
> - use tusb320 instead of extcon in the unit name
> 
>  .../bindings/extcon/extcon-usbc-tusb320.yaml  | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
