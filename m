Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A506626AF46
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgIOVPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:15:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35050 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgIOVOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:14:04 -0400
Received: by mail-io1-f65.google.com with SMTP id r9so5801964ioa.2;
        Tue, 15 Sep 2020 14:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UlDLGNDfNIX30vo6TOptdsoHKv0FtXHPExY3lDotPuo=;
        b=J8985iCyJ7DACYAYXHjhxQPobqPMDQk5NG6+FzrH/Fa6lX+UEJKLT5GPWcm6pEctaK
         gMks02pNuA4Tr48aSMxTFwRiQ0f8b1VloWBibaIhQcLYWZoDY/mlkYLuDnGOrJ7ZSNzo
         IaJBDc1JHBd4OSW8Kz/orzGx43JlyBOYklx1EMMw5Ox9BxK3k1SSQgx44sm06k4Wjq9E
         wu8XC2k6VbkaiPPRgN2bJtYu5KNKDtkccEG0J/pE7hR5M8YNBATtP1QVcbVMLMIoJJ3U
         fY6g6dLrRPCvcSzfPgiTaTzgVeAUJkAeiBTFdefTWUOiriCuaIBbg8xMAbuwpKiq+T6z
         47qg==
X-Gm-Message-State: AOAM532Ctdt8wcreRzKPu94MOSfKVvBVDqUCfO5xm7NeeQGBD5dishx/
        dCJSvXW9aWIsU+zl98Lt1A==
X-Google-Smtp-Source: ABdhPJyVWPTPAOglxQF9NhMcWNJpbFKNXF1PJ0wdUxFZLDRkQNimmK+jCC+29w1IjGTMhIWd2g0+Og==
X-Received: by 2002:a05:6602:2003:: with SMTP id y3mr16652469iod.203.1600204436919;
        Tue, 15 Sep 2020 14:13:56 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m15sm9304692ild.8.2020.09.15.14.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 14:13:56 -0700 (PDT)
Received: (nullmailer pid 2518777 invoked by uid 1000);
        Tue, 15 Sep 2020 21:13:54 -0000
Date:   Tue, 15 Sep 2020 15:13:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        John Stultz <john.stultz@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com
Subject: Re: [PATCH 0/6] irqchip: Hybrid probing
Message-ID: <20200915211354.GA2469362@bogus>
References: <20200912125148.1271481-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912125148.1271481-1-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 01:51:42PM +0100, Marc Zyngier wrote:
> A recent attempt at converting a couple of interrupt controllers from
> early probing to standard platform drivers have badly failed, as it
> became evident that although an interrupt controller can easily probe
> late, device drivers for the endpoints connected to it are rarely
> equipped to deal with probe deferral. Changes were swiftly reverted.
>
> However, there is some value in *optionally* enabling this, if only
> for development purposes, as there is otherwise a "chicken and egg"
> problem, and a few people (cc'd) are working on a potential solution.
> 
> This short series enables the infrastructure for modular building
> whilst retaining the usual early probing for monolithic build, and
> introduces it to the three drivers that were previously made to probe
> as platform drivers.

I hardly expected more OF_DECLARE macros when I opened this up. Given 
desires to get rid of them, I don't think adding to it is the way 
forward. That wrapping a platform driver around OF_DECLARE looks pretty 
horrible IMO. 

I browsed some of the discussion around this. It didn't seem like it's 
a large number of drivers that have to be fixed to defer probe 
correctly. Am I missing something?

I'd rather keep the pressure on getting fw_devlink on by default.

Rob
