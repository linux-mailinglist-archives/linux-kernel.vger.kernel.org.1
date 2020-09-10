Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8B5264304
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 11:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgIJJ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 05:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730553AbgIJJyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:54:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB89FC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 02:54:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md22so1079159pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 02:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F5h+9h0cZdkPW25qpRHYDsEGqxD1XBrnnk/6rX6atkY=;
        b=LlEDCWgpeqDgpOjcmWPATPwqcDWL30ELT2gpQ0RKc+nsv0DmZl7KzR+wBzWa3iOVW1
         hZoj8+bFhHUh00/hle1s8o7hTt4tCw27ur9NNvVYscHMUdlKcnPuo78LoWWf5x0kAyFY
         L82uvFjD+9fe24lrLCvrE/3k9iNz4Eo4rXtBRQ5salrpPxO3Wsi6U77bQMi0iOawjSAa
         m/jDOL+S/WFWakYspnhxAeCxKsonxnGD9xo3YoGuZGIqnkJX1/+YRoRErTaGApix9YhH
         6Wg6UOgHxIYfG6xe1O9LgeOANY8BBnFYOCEaXlypuNSCsnZF5MFqTu6mzDUwx3ZAN4W7
         sWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F5h+9h0cZdkPW25qpRHYDsEGqxD1XBrnnk/6rX6atkY=;
        b=Q9key93z0FkXRJyYviMwRmCchAJijpxElc3M2WTm1A00XGED0zFj0lHwaiFMxWfeQK
         zOv6TPhmrh8md9TxEyMUn9dSdp/Rhh44nVRU7uYo/Jg072BE4lyAcKeTw/IY29IysUTs
         Nr1jjm8jwTurbCv3RjtRcykvNltddMcMyGzRoM442+NdXDqGq3LPLeUl8IvV8gYDsvnu
         gtaUchwVuJ+is2c9pL4oCPQU1NO+MlnqUQn16oV5nPavAt0HaxUjLcWjp+pSSU3X348T
         d1Fw0mtj9IlOBPWvzcEVLLrZhV5T5MKXbQqe+88R4xvFvPpsj4BgRLy/snW9XcYSzkZd
         19oQ==
X-Gm-Message-State: AOAM530R6LeYW11CLSQSBsLJMrLW5HVvyGBlBdVbk9VvLMJ1g6SsbE9Y
        cYcygKLB7gi1/Thx0Os6l9vXLg==
X-Google-Smtp-Source: ABdhPJyyjLldSPXR3NqdKk6r7B8vIALvfp17tpVuzMdZQmhZeoDWx+QzRuSQDy4vQkGfoH/AbRs4Rg==
X-Received: by 2002:a17:902:b105:b029:d0:cbe1:e7b1 with SMTP id q5-20020a170902b105b02900d0cbe1e7b1mr4789265plr.34.1599731643373;
        Thu, 10 Sep 2020 02:54:03 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id c3sm5514471pfo.120.2020.09.10.02.54.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 02:54:02 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:23:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200910095355.s5lwv3mp2mcz2sdd@vireshk-i7>
References: <ee7439aea0c2076aab5dab26d8266d5faab01b6b.1599632119.git.viresh.kumar@linaro.org>
 <CAL_JsqJadbhUSiVQWAL5uDzqpkDPWT+M7nGDVJ7Wyf4zHkPvEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJadbhUSiVQWAL5uDzqpkDPWT+M7nGDVJ7Wyf4zHkPvEg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-20, 13:35, Rob Herring wrote:
> I'd really like this converted to schema first given it's more than a
> minor change, but I don't want to hold things up. (Though, where's the
> new driver?)

Sudeep will re-work his older patches to get the separate driver ready
for inclusion. We were blocked on this idea for ever and so I didn't
try playing with it until now :)

-- 
viresh
