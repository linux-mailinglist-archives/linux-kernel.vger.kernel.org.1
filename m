Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28161A492B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgDJRhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 13:37:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38501 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgDJRhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:37:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id d18so2516221otc.5;
        Fri, 10 Apr 2020 10:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Aj31Y2OxjNZWadL3dR1pjjhq1FJnk4aoDDhDh7CesfE=;
        b=jMS/ZemosQ61o6RYD2ZP+bOWZZ1wWcHfpJqxmKkzOWO+6iHUTNg24UZkUAPAUzKY5Q
         RDd/bZS0In8Y4jCDx/dHAaAslnz3brpVL6a4Ao/hMCVqd5zYnwnOjztdmJlwYS8kWfwG
         /g/cseY+w50bYy/2WUUGeZNLc1pO6Hn9Py1Dfp8IS6Z9KJamyuzTJWuSUotPGoku20aP
         0II850bMxCGga2zYirW2o+RF4pKCL/xFr16txQAz4RroQMDAZ97HNrouzKV5sXCFTmgu
         aVrwpU0+Z2nwt1Fsu5ff1DOBrnduxJOsiieby/d/LEK8WxSg0HKg2Dbb8WIyl6TXidP8
         7B/w==
X-Gm-Message-State: AGi0PuZUR1ocjRopZg0WsXkUZeEvG+dCFQw9rzQKzgF10Cp85THCKzt+
        FEvv7Du+sXPfmfoJIlX+1NfsyfA=
X-Google-Smtp-Source: APiQypJQUIGeesRhEejm8KHRr0h2e88sQoMo7cGXfu/vNd/4KTH7ZKaSZ68+GZzIfZ3FoPZuxB4NMQ==
X-Received: by 2002:a9d:ef8:: with SMTP id 111mr5042755otj.94.1586540266709;
        Fri, 10 Apr 2020 10:37:46 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.cgn.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id t7sm1483530otr.46.2020.04.10.10.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:37:46 -0700 (PDT)
Received: (nullmailer pid 11141 invoked by uid 1000);
        Fri, 10 Apr 2020 17:13:40 -0000
Date:   Fri, 10 Apr 2020 12:13:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: remove unneeded variable
Message-ID: <20200410171340.GA10868@bogus>
References: <1585562702-360-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585562702-360-1-git-send-email-dingxiang@cmss.chinamobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 18:05:02 +0800, Ding Xiang wrote:
> rc is unneeded, just return 0.
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  drivers/of/dynamic.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks.

Rob
