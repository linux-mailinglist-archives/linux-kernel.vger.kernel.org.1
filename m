Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856C92FE0CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbhAUEec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbhAUENn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:13:43 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A30C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:13:02 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id n7so555829pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yc5sQoByld/hyuMTGXnutyShMdqAx6iOCrjbfzusVe8=;
        b=OkllhuEWFCX1TeteF/cwCQCaB8qVbP3JtdM3NiPeIa67Snmy5RTlWnTmY1aQ6FnQOS
         U1whlfJjuzCbGmQVFEEncQEDCfi+QFZaT3vo6jfp3AYGoor+tfaDAnNUxHcRg7JbZMiR
         1Qb7LU/B+/WXxYqU95NkV8n4vMDX1FQ3SCzQL5u4nuZWheHDJrPcgXJdvGjYpTK8k+3E
         cf6CnQGh72zO2SQfuJQgVHD1gttD8bg9vjX3cGXOgKHIwqn98UJn5X+u3hIw/TBfv9pt
         p+ZEzJFb9LRlL851AqLoDp6Y8CcPNSMYXP20M16aPaz0mCl4nVqh/7tEst8l4z+V9Nxi
         XdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yc5sQoByld/hyuMTGXnutyShMdqAx6iOCrjbfzusVe8=;
        b=At7cvaSTtEyrtwgSOlHdF3uTr3rV9K70+uN8fVYnO9xk65VtZnhuRhFeWPn5EHJmNn
         XXsu9FvcW4WDSPR8EY1NVhKZqkJOXrTyegpTLjZT307zlgzNoubq9gsBiVZD5ppEVkjw
         w8Z8vXWUYkv4Sc7ZYYrWzVjZLR6yww4TzA5X45xogXO9levAxtrVcah09HDURvEBRfOq
         AvfP5k9eCPdB74wDY/qqsgCWl5MCw6nPF2Sk0h3jyjqcuipJQl1HCi8LHE+PxPTuM1Qw
         D+Kyb87zhYh9bnav3pAuoIre/2a2bAH52D6DHJqxdJIhiGjtZ++60XMGo8rWdsPCcDL5
         kIkA==
X-Gm-Message-State: AOAM531PvcUvkDZw9cYARbesIADkg7k+v+niov0/mwFCrZfIX0gkoN11
        3HW2t5rr/Mz6+3xtd8OaCJ3hkw==
X-Google-Smtp-Source: ABdhPJzyBgR2jF8DPAxnHdQlNowaHrlEIfkQvW2esOvhX/6tHDmlitN+26RRuC2jJxpD8CQXlyzuNA==
X-Received: by 2002:a65:450d:: with SMTP id n13mr12582028pgq.208.1611202382444;
        Wed, 20 Jan 2021 20:13:02 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id k15sm3857699pfp.115.2021.01.20.20.13.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 20:13:01 -0800 (PST)
Date:   Thu, 21 Jan 2021 09:43:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH V5 4/5] kbuild: Add support to build overlays (%.dtbo)
Message-ID: <20210121041300.ocerhqaieytj6gds@vireshk-i7>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <6e57e9c84429416c628f1f4235c42a5809747c4c.1611124778.git.viresh.kumar@linaro.org>
 <20210121004955.GE5174@yekko.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121004955.GE5174@yekko.fritz.box>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-21, 11:49, David Gibson wrote:
> If you're using overlays, you probably need the -@ flag, for both the
> base file and the overlays, which AFAICT is not already the case.

I think the idea was to do that in the platform specific Makefiles,
unless I have misunderstood that from earlier discussions. So a
platform may want to do that per-file or just enable it for the entire
platform.

-- 
viresh
