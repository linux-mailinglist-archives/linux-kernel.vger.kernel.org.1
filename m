Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232EA29754B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375704AbgJWQwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:52:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42719 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbgJWQud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:50:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id h62so1934026oth.9;
        Fri, 23 Oct 2020 09:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=exvsUIy/BUrDh5uX3pI+E6Ssx+/qdOWW1J3aRnGH1Dk=;
        b=D3mbYZeByapyx/WToUzG9umJw2/72IFDWxDk40wrjldfz6fOreeA5FmdC4h8Gfekd3
         60poRmmeHvj/YksuWjWBBmeXkr8hDiPr6XkFqkHLghNJ9JKMC7bhtppg0lCFVfo6uXk9
         RjBlALI5kxB9MH88L2cmGobjtJAyr+rwICT7HQfiD4nCs5BJXbLAkreFo2q95X9zBtg6
         Q0/pMtISCcqMwEjQjA1bpGAoEAprvWDI0WyMmHAty4bbv9w6r5YZw8qfMDEcXX3t1evt
         PkY9/cbzZlaE8PZF6MnDArA3UA8ALOFzIMYBBnA34WOuFxwcT0xM1E9p0HC2gsNFSaLq
         nDxg==
X-Gm-Message-State: AOAM5302LrUwda+pxHQ5jCdpHp2QSu1biI1eq5GLacr0AL4ShXS9eC7K
        LYsJtrJYcavGdS8t+fpHJA==
X-Google-Smtp-Source: ABdhPJxQb1CUVZ5Eolv6jLUFAORmCw/Iu0BCm2Nj1dbmD+VoabCQ5NFrMcYHW4aDTNxvrMS6Blp30w==
X-Received: by 2002:a05:6830:1282:: with SMTP id z2mr2312045otp.301.1603471832152;
        Fri, 23 Oct 2020 09:50:32 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r8sm508510otq.43.2020.10.23.09.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:50:31 -0700 (PDT)
Received: (nullmailer pid 2852997 invoked by uid 1000);
        Fri, 23 Oct 2020 16:50:30 -0000
Date:   Fri, 23 Oct 2020 11:50:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] of: Fix reserved-memory overlap detection
Message-ID: <20201023165030.GA2852897@bogus>
References: <ded6fd6b47b58741aabdcc6967f73eca6a3f311e.1603273666.git-series.vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ded6fd6b47b58741aabdcc6967f73eca6a3f311e.1603273666.git-series.vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 11:53:59 +0200, Vincent Whitchurch wrote:
> The reserved-memory overlap detection code fails to detect overlaps if
> either of the regions starts at address 0x0.  The code explicitly checks
> for and ignores such regions, apparently in order to ignore dynamically
> allocated regions which have an address of 0x0 at this point.  These
> dynamically allocated regions also have a size of 0x0 at this point, so
> fix this by removing the check and sorting the dynamically allocated
> regions ahead of any static regions at address 0x0.
> 
> For example, there are two overlaps in this case but they are not
> currently reported:
> 
> 	foo@0 {
> 	        reg = <0x0 0x2000>;
> 	};
> 
> 	bar@0 {
> 	        reg = <0x0 0x1000>;
> 	};
> 
> 	baz@1000 {
> 	        reg = <0x1000 0x1000>;
> 	};
> 
> 	quux {
> 	        size = <0x1000>;
> 	};
> 
> but they are after this patch:
> 
>  OF: reserved mem: OVERLAP DETECTED!
>  bar@0 (0x00000000--0x00001000) overlaps with foo@0 (0x00000000--0x00002000)
>  OF: reserved mem: OVERLAP DETECTED!
>  foo@0 (0x00000000--0x00002000) overlaps with baz@1000 (0x00001000--0x00002000)
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> v2: Fix handling of dynamically allocated regions.
> 
>  drivers/of/of_reserved_mem.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

Applied, thanks!
