Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1789D1E801C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 16:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgE2OXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 10:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgE2OXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:23:52 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AB9C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:23:52 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w90so2013130qtd.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9m7HC96Ef8eGO9rZOO3bOn+8xlUDhhzFobGDGShkHTM=;
        b=EhZ2cC5KaDLmpfGxCfLJtl2DoFnvYjDJJaVUeSuaRLOPdUfcA5DI4ZCmdDqA/pL34G
         BfyW83y/IOrYJSGu3WuJJQoSO13oSPEKGCxQcL1lUPETeM8rLtSMHsJtu4IsixLDqTbm
         SNOJaiXnx7yFACCdmaZ9sG+ukvRDCJBmius1zI0jlI6kx6YFdS1jLb7hjM+eX95Y6PFE
         eJHEbB+jm2+K7st36rvT4t37ptWzLK5oFkWvzg4TcY9w1bdALIRma12t+6unR3Y5bUSE
         dZQKw16fgXkmzc7gvZf98MA3TXygt/sEL4BVVOeMJin8MYb53X6gSkda8ji6YEhtr4Dn
         XCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9m7HC96Ef8eGO9rZOO3bOn+8xlUDhhzFobGDGShkHTM=;
        b=DO2bISjUKIyK0/ohj5YAlegq9cKItO+YPPx9fQTFIsYXjbnq/tpsHTgaQBHmkglRm7
         ze28s8NVsSN+J5eL5AblKOUJlR8Dzs/KCUb3Wmgx7oH0augjg87JWb3z1HRUA8XMnAY5
         fwi9RmRAXKlaF7OkwewhWdcSTCImO3z5QU6ipDXq0YmOZgTOC9KGs3fXN1IOEhiPPIFG
         xIruQyYK9QHCkzYDXcpXfwCLK14jy29leJSr+hOH8h0xqIAIlTw80fLQijn6fAm17vgA
         L8PIL42PL7acfR+zCr4xeBI32hdb3LbSEaTBAGHwddORT8OqeBV+BjIEped065+Qh9Kj
         l6jw==
X-Gm-Message-State: AOAM530RWCMpHQNm/Tkxhb14B6dK5cv5er9p+4d9yxFb7tEge+ErdzE9
        1BbDmqMCE8ITBmksSoa/rEQ=
X-Google-Smtp-Source: ABdhPJyZCWXkL38Y1OI3lqWXPVRCznCioIVlFCocrHF2xP3hF21jfecERyVpqi6kCFJdcIgxWZPybw==
X-Received: by 2002:ac8:6f50:: with SMTP id n16mr9618671qtv.336.1590762231344;
        Fri, 29 May 2020 07:23:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:5493])
        by smtp.gmail.com with ESMTPSA id a1sm7878884qtj.65.2020.05.29.07.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 07:23:50 -0700 (PDT)
Date:   Fri, 29 May 2020 10:23:47 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 3/4] workqueue: free wq->unbound_attrs earlier
Message-ID: <20200529142347.GD3530656@mtj.duckdns.org>
References: <20200529065903.1758-1-laijs@linux.alibaba.com>
 <20200529065903.1758-4-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529065903.1758-4-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:59:01AM +0000, Lai Jiangshan wrote:
> wq->unbound_attrs is never accessed in rcu read site, so that
> it can be freed earlier and relieves memory pressure earlier,
> although slightly.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

I don't think this is gonna make a material difference in terms of memory
pressure and would much prefer keep freeing together so that we don't
complicate the lifetime rules.

Thanks.

-- 
tejun
