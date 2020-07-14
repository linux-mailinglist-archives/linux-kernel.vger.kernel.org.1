Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E621E622
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 05:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGNDGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 23:06:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41273 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgGNDGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:06:09 -0400
Received: by mail-io1-f67.google.com with SMTP id p205so7254498iod.8;
        Mon, 13 Jul 2020 20:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TVoVdyncLEeiffYNM9TJAyY6BL3tEPqyz6fqMegoifo=;
        b=TcwbaF5Yi32cnnnzwHV0pLe00rXR3MmV83iRBioJ13p78gkck131reN9Dhb8Vf9y43
         Pijc+kJeMrwu0HvUk+YYWJK07gsP4r51WWw7f71POMBeh/ktRkagtsJR5fMhuS1sDvCR
         U2d/qVuAEKqY2qul4yM0bQ0NxBd0UMlH8tb79XG/8vDJcIK3+k/G8nbTN9/exExduqgY
         +kVrOpDcHDZuSQ/nqRca4hCtgpiI8UunZy4AxdRjVzpSt1Zrkv4L9gBH41DUJ+zHZV93
         SFh7QdKxuRg7ESGv1fxO96wXPc/cXrr2bjD3Rtpg1sR6Lt6T7lwLYWDr8imtRxxCJHYa
         2xog==
X-Gm-Message-State: AOAM532PPHZVSUi7qePHe0MAQwNYK1kHC5v22ioTRLzfDbk+By8i4RYy
        1+CG087f5T7tJaL71zAGrQ==
X-Google-Smtp-Source: ABdhPJw5s5oyrn7t/NDh4TK+LlVmRSz7JZYGPC1ApbO6tdIF81Jx+PtJMuD1sw6xOfrFSCf/V7Lx/w==
X-Received: by 2002:a05:6602:2fd5:: with SMTP id v21mr2867118iow.41.1594695968898;
        Mon, 13 Jul 2020 20:06:08 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l17sm8877215ilm.70.2020.07.13.20.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 20:06:08 -0700 (PDT)
Received: (nullmailer pid 1210304 invoked by uid 1000);
        Tue, 14 Jul 2020 03:06:07 -0000
Date:   Mon, 13 Jul 2020 21:06:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: clk: versaclock5: fix 'idt' prefix
 typos
Message-ID: <20200714030607.GA1210251@bogus>
References: <20200708074035.31595-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708074035.31595-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020 09:40:32 +0200, Luca Ceresoli wrote:
> 'idt' is misspelled 'itd' in a few places, fix it.
> 
> Fixes: 34662f6e3084 ("dt: Add additional option bindings for IDT VersaClock")
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/devicetree/bindings/clock/idt,versaclock5.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
