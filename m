Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6B727EFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbgI3Qwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Qwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:52:34 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AA3C061755;
        Wed, 30 Sep 2020 09:52:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d13so1437940pgl.6;
        Wed, 30 Sep 2020 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+YsaxwbfWVm9IFurTjwCUMxSyQutFwvjtbnnkumX19M=;
        b=u3844wxgYnVwyWa4w0p3mTTnwhl7Fw+TjOYFjmX8MhxYBMAaEM9uNfKf6g6gBgOoNW
         3k7VlSuh/pcMQ45YvtUQBGfjqAHwrAGVleWPcj40j7SiTTLTGBxdNMtpbJcqF+6cKwAK
         +CQ+mKiImaxtnB6+1j60FY6GdcZwR8zzLk2idGIM4nS7JEJQ2/IS9kQyrqR9qPBhYIXY
         MzcU0Vc4RcHFhFU/okXq+u2NJVMfqDkxRA1fOQ8tC56Lm4OOuxAvtP2q/h0mFG6g5FaG
         +yNtijMH0UiW2Dqdvlr0it4WAT+je7x6JwH7E1FzW1OLg3UHZ1dX+lNc2DeSfhx4U6Vq
         e2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+YsaxwbfWVm9IFurTjwCUMxSyQutFwvjtbnnkumX19M=;
        b=Qr9Pb8k5CJMLvvUSnERkmDN94Dwkf4xaihtwy8DxsxSsORcTSGh8yld6M/fuXpXVNW
         rQm5XQW7o65eGVODSp2SAxiF/exCxaRT2d97SVqUFYyOAqKV6QE9r0vJPB8qSyK1+1CI
         S1s+Jkq95/2PJlYZ52J9gg4wFEzglkObM4BD06zO/EiT89bExwr8kVMvkw2ZuXvf8H5w
         yRooNy8ocztzm5aiy5dshnzrLv5HOyhFmEydx5BQ//zLDMWUyNyx3OMzxZpVJRlZvf+Z
         J7Bai0Vp8JPFwLAqUpLyDxH08OP6Kk0Bz4ctC7fsx5GWIqQaXW0Z4PHcRKDpCAOkO9Ez
         oNOw==
X-Gm-Message-State: AOAM531q8Iuj2T69Kn75b1Iz2T/GyIq4NnXoz/dEfUBxgB9+xn2V8EZb
        OdjyIAYLLudyDT5iDO9KfxE=
X-Google-Smtp-Source: ABdhPJxe7Y8PEYrteg+lJFZ9ldu33jakNS/cEF4k+L41nnRzTbkCmZk9s7On+r/ByoQGhHJfCXwmNw==
X-Received: by 2002:a63:e40b:: with SMTP id a11mr2913850pgi.450.1601484754295;
        Wed, 30 Sep 2020 09:52:34 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id x3sm2944015pgg.54.2020.09.30.09.52.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 09:52:33 -0700 (PDT)
Date:   Wed, 30 Sep 2020 09:52:31 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, bmc-sw@aspeedtech.com
Subject: Re: [PATCH 2/3] usb: host: add uhci compatible support for
 ast2600-uhci
Message-ID: <20200930165230.GB25872@taoren-ubuntu-R90MNF91>
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
 <20200930040823.26065-3-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930040823.26065-3-ryan_chen@aspeedtech.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 12:08:22PM +0800, Ryan Chen wrote:
> Add support for AST2600 SOC UHCI driver.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
