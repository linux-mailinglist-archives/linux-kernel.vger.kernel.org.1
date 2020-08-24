Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022B024FBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 12:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHXKit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 06:38:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50819 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHXKip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:38:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id t2so7593695wma.0;
        Mon, 24 Aug 2020 03:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7u58c0keG+Yz2ZMucv/08ubtmOiqVrLF+ILIBtxzQko=;
        b=PFP8XxuTiWsxSiy25V1VxQQ90PYzj5Ly4Rt5xZOi5QRAaXrxqHT/WXon1q/ujXJjQb
         whvhHDciHoPWYNEZVFxCUvYwU+2yxvVYWFcBCnyqpQ0Uefo8gcfiV1dAnkfz3RBHetPl
         t0SzIzzizvIvC9iBtj5NHASV5cgg7sG1GM3rczt9qqIbZG4J4KVpmIJ49vJCdWp2H6Lx
         P57OdoHjTa/IBsSQiexB4IgWNEwzexc19ooTiq69FUVWE+2Ahvp3oXfyQPBFFrwdaHsP
         cLCgT8zAXx0wW5DZN8Iq7q2J+yobnibR/c3EJdt+UdCduSJ+2A2KD5Emlswi1dFgaTQe
         XcqA==
X-Gm-Message-State: AOAM5327OWMX9tHHyCDGUgOHvDesUjNVvtVWCUq7866J+MPE/nh5rhDX
        UPbX6m8h44FostYOb+yEDZ0=
X-Google-Smtp-Source: ABdhPJxdgoBANLff8G8lGhg7HIgBV9mVxGbGUh18QBqP12CztPagvk8fjE+U3wpmdCGh7zOFSIwBNw==
X-Received: by 2002:a1c:286:: with SMTP id 128mr4839844wmc.37.1598265524149;
        Mon, 24 Aug 2020 03:38:44 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id g14sm23168771wmk.37.2020.08.24.03.38.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 03:38:43 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:38:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 00/13] extcon: ptn5150: Improvements and fixes
Message-ID: <20200824103841.GA26466@kozik-lap>
References: <20200817070009.4631-1-krzk@kernel.org>
 <2879914d-7ad6-4d98-8b9c-a7646719f766@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2879914d-7ad6-4d98-8b9c-a7646719f766@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 06:36:04PM +0800, Ramuthevar, Vadivel MuruganX wrote:
> Hi,
> 
>  Thank you for the patches and optimized the code as well.
>  I have applied your patches and tested, it's working fine
>  with few minor changes as per Intel's LGM board.
> 
>  can I send the patches along with patches or we need to wait until
>  your patch get merge?

You can just base your patches on top of mine, send them and mention in
cover letter that they are based on these series (with link to
discussion).

Best regards,
Krzysztof

