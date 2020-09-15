Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB926AF39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgIOVLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:11:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45868 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgIOU0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:26:52 -0400
Received: by mail-io1-f65.google.com with SMTP id y74so5566403iof.12;
        Tue, 15 Sep 2020 13:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lkiuck1dpqoY8hk2xhRbf0iSHZzrbHgAvYh0DjmUxuk=;
        b=rVATaa4LyhEmM4F3wHE/BTP6sp56yq/4DYk3we28co80qxgsbUlaUGzpdT1qJxQvDt
         gk6X1uDxTkMjqQlpA9R2LSf6l6AyLaP61VxpGgdiltvsJ99Oy3D2X8vsUwqfz92FdBDv
         kd71uaspKMjpL9G3LfitIee1yvUgfa7jCREp7V4al+7VWoN3bMevISLucC6P2PCSUjHp
         gwkXwCK/dYOwvgTBhE1T+zNT98suJxZgn8Ra9RVhZ+EIiT1dkPFl7lazcdc8OXEhlNV0
         cQzZsCLfNDiVH15vpZ6ShLMox3U+Gvqa3MdUQQURu/yMQWtiwcW70pHy5UJZPTkx5ezD
         Jcrg==
X-Gm-Message-State: AOAM532ouGF8d1/iv6od21DtNdVAaydRK6itfZ1wATgd55rjwovDKt5Y
        QXnCf9zahVxsqKGl9YmOAg==
X-Google-Smtp-Source: ABdhPJzyWohZ65GbQAbr2ukWUAn4GsntRKdTC/Pb9M773BsKkyysdyrVMLR3122AIM+KQWrHWt14CQ==
X-Received: by 2002:a02:778e:: with SMTP id g136mr19740297jac.49.1600201577250;
        Tue, 15 Sep 2020 13:26:17 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z4sm9293793ilh.45.2020.09.15.13.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 13:26:16 -0700 (PDT)
Received: (nullmailer pid 2451001 invoked by uid 1000);
        Tue, 15 Sep 2020 20:26:15 -0000
Date:   Tue, 15 Sep 2020 14:26:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Grant Likely <grant.likely@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/1] of: properties of reserved-memory nodes
Message-ID: <20200915202615.GA2450947@bogus>
References: <20200910162020.3927-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910162020.3927-1-xypron.glpk@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 18:20:20 +0200, Heinrich Schuchardt wrote:
> The reusable and the no-map property are mutually exclusive.
> Clarify this in the documentation.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  .../devicetree/bindings/reserved-memory/reserved-memory.txt    | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
