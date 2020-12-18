Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49442DEA06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 21:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbgLRUOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 15:14:35 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44009 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgLRUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:14:34 -0500
Received: by mail-ot1-f51.google.com with SMTP id q25so3068238otn.10;
        Fri, 18 Dec 2020 12:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g3RrY/5H2pNsMpu6ivf90VzQI9V5J/8AaKgeKCK7dbQ=;
        b=YSQhqZ9YIDghOHfmWxXYxWXQwdbV2rdkCFx3AqQSnqnm+d7yBrbWmSNp14vFgnC+Ab
         GZ1USHiviPy8j7Ots2wvKplRaWpa5KrM1rEgFgw4AnIdT0zFm90AutXtLUwKp/WgDd6y
         PnKJhHQLxCV7w7sKfjYV2eEZOoCUfF6u0cw+DjlTSM3TSEJLac+km/RmGTq4GqdXxmHm
         NbxqEuLE6gItIuVmq8CORD3qs6R56BUnUV9Sr6hKvlFWAIUh/ELVhwLFMBeEwSwnF7jP
         81NQS7sJqyaoiVL1Zc47bP47Tn0uioIpOF+jMRoWF5jcbB3roX82yd7uO7EFdtsk6TN1
         RhpA==
X-Gm-Message-State: AOAM533OBslp2BtE/9wkA40NYXrqCOc/sRV2XLb1TzMoVYxO1fPpeCib
        puYXRFZSSI8/xQ+4LuIILA==
X-Google-Smtp-Source: ABdhPJyWxEs+KjRXMhcvoXJully+6tpRF+3fCMbOaLUN5jp5Oj0gdCDCFzDQrDoc79eGUooarLmJPQ==
X-Received: by 2002:a9d:46f:: with SMTP id 102mr4185215otc.293.1608322433172;
        Fri, 18 Dec 2020 12:13:53 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u76sm451886oia.48.2020.12.18.12.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 12:13:52 -0800 (PST)
Received: (nullmailer pid 2092213 invoked by uid 1000);
        Fri, 18 Dec 2020 20:13:50 -0000
Date:   Fri, 18 Dec 2020 14:13:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: clock: imx8qxp-lpcg: eliminate yamllint
 warnings
Message-ID: <20201218201350.GA2089699@robh.at.kernel.org>
References: <20201207045527.1607-1-thunder.leizhen@huawei.com>
 <20201207045527.1607-2-thunder.leizhen@huawei.com>
 <160820093389.1580929.3915867007740168331@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160820093389.1580929.3915867007740168331@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 02:28:53AM -0800, Stephen Boyd wrote:
> Quoting Zhen Lei (2020-12-06 20:55:27)
> > Eliminate the following yamllint warnings:
> > ./Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
> > :32:13:[warning] wrong indentation: expected 14 but found 12 (indentation)
> > :35:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> > 
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > ---
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

If I tagged it, I was expecting you to pick up. But I'm gathering up all 
the fixes for what landed in Linus' tree, so I'll apply.

Rob
