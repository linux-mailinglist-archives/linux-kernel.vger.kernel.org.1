Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7970250EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 04:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHYCMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 22:12:51 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39404 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgHYCMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:12:49 -0400
Received: by mail-il1-f194.google.com with SMTP id f12so9112736ils.6;
        Mon, 24 Aug 2020 19:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3nloTOrXY+VdXbMaAs1xkJlpZLEd/OL2atDgyYM+HrY=;
        b=ouOvF2mZd5MzM6g85pgk5cKOvdWD86Fj4FasXtuH+qa6upqgiWp5sXuOk9Fh/F+TCr
         wCBvvwXXiPJfNmNgUqNJLmU1yRGxjlP5jMm8dGRxftBvfHIum14pglAv3OwM9DGB3cfi
         cSxMVT6vjtb/9FtAmMhJcxX4lrE+l2PGvBl9Lg7NcXom4cT4TbeIkH1Oiqmit64ZQIn+
         owsV4KbBQSnFFH2yEY1NNN+Tsjtqi3W9hJwDWPGafQjPrtQ3Lpe/8xpMcK6JsGkObQcs
         9H/iatBAUO02zzoHbcXaLzQmnrpc+WOgxdVOIdIpIcqh1E9QjfKEb3I7jmlkUqyTQvYM
         0P4Q==
X-Gm-Message-State: AOAM531l7UVQpTvw9OgZFCItLXiZXfEhP7sQlZ6T3YjIixKijtGk9/ns
        kMyO0Jet1sdLMe5BXJ0HPQ==
X-Google-Smtp-Source: ABdhPJzhTOb/YYKMebmePOL8eCdkTddl1osQhrsQdDZCr8NwQonHozFTxTzXQj36XazSDCyxjovZrw==
X-Received: by 2002:a92:158c:: with SMTP id 12mr8049584ilv.102.1598321568014;
        Mon, 24 Aug 2020 19:12:48 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id k18sm4422961ils.42.2020.08.24.19.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:12:47 -0700 (PDT)
Received: (nullmailer pid 3794322 invoked by uid 1000);
        Tue, 25 Aug 2020 02:12:44 -0000
Date:   Mon, 24 Aug 2020 20:12:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Anson Huang <anson.huang@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/17] dt-bindings: clocks: imx8mp: Rename audiomix
 ids clocks to audio_blk_ctrl
Message-ID: <20200825021244.GA3794265@bogus>
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
 <1597406966-13740-2-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597406966-13740-2-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 15:09:10 +0300, Abel Vesa wrote:
> In the reference manual the actual name is Audio BLK_CTRL.
> Lets make it more obvious here by renaming from audiomix to audio_blk_ctrl.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  include/dt-bindings/clock/imx8mp-clock.h | 120 +++++++++++++++----------------
>  1 file changed, 60 insertions(+), 60 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
