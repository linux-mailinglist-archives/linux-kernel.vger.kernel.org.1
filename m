Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1B285871
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 08:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgJGGF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 02:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJGGF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 02:05:29 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97D3C0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 23:05:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id y14so685462pgf.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 23:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+WZVwcVZq17DkZh6Ek8hgtQgHh8+kfcgUyh2yGXklz0=;
        b=DDMZH9DrS5gsFGD94mHEOzp+CCLRwyQNYcYc57nxOJ5nvYUVhH/3HX8S+36V7pD23G
         67Yr1XpXiqangp7o/tajpethsaqQEFLnl2ZXBcVVVEGoZcIXPxhjsVguqN4S4yYZ2muw
         pwwesSCFH7kXDiBk1S6oowJU0gfy5ox74fFCfDcvgMCRpO9LD5HLi0kyCh5WCAqwTpNa
         /z+OuPqciEGAs0ZkIIoQUutaz86zp3BsDrDcQiepVR66XOtT2n0HUFdBTbDNsWJb5YOD
         D6z0ZqJ2LeGr7DNj/0NIAwzaOC5t0rzEhQ+rMdPwqv9dce1EhsQdg2/vUtHUXUGJbLkG
         vshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+WZVwcVZq17DkZh6Ek8hgtQgHh8+kfcgUyh2yGXklz0=;
        b=M9uk5rnOAnGcWNuiqjMRZ7yZlGMWOlF4Z2QhohT7YmmXJxZ4NqexNe3BWlUJHxosBP
         BZlPTacCQue3T63A/WAftmB3PsbSYKjODb/FOizq9e5nXAMfior+BKOSPq720Dq2NeyN
         bosg7s0G5slGf0igMwSfsFMhw/Heeysl4v9fCTQIBxnATeM/L857D4qfV/S8UfXQvb7N
         QhfZzvP/tT2nJMBZBp1TOvrVfXpcLfOWTB6U7DqvJRxWyK3PEsuKTNac8d2Wv/D7OS2O
         45lrnKntw4a3vybV8eLUj5o/JQCTKTjoXFzWaeCC2NDuzD102pKWBQtsjoDjCmdrk+VM
         Vb0A==
X-Gm-Message-State: AOAM532hUa0odmyRpn+VuJbSMyEE63R7+hDbzkDSi0Itm2baYF3YzE7V
        UcWPniyJ0OeSn9Sstq+79AgTxA==
X-Google-Smtp-Source: ABdhPJzL6EN0aBk2qBvnw5Npidm2j1PjotUyNK/TEeojHbbecjp5Iy1TOibk43m25s2nmjkP5q0G3g==
X-Received: by 2002:a63:3247:: with SMTP id y68mr1607315pgy.224.1602050728334;
        Tue, 06 Oct 2020 23:05:28 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 138sm1348410pfu.180.2020.10.06.23.05.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 23:05:27 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:35:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/4] mailbox: arm_mhu: Add ARM MHU doorbell driver
Message-ID: <20201007060525.ya6limypf6ggmtae@vireshk-i7>
References: <20200928114445.19689-1-sudeep.holla@arm.com>
 <20200928114445.19689-5-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928114445.19689-5-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-09-20, 12:44, Sudeep Holla wrote:
> The MHU drives the signal using a 32-bit register, with all 32 bits
> logically ORed together. The MHU provides a set of registers to enable
> software to set, clear, and check the status of each of the bits of this
> register independently. The use of 32 bits for each interrupt line
> enables software to provide more information about the source of the
> interrupt. For example, each bit of the register can be associated with
> a type of event that can contribute to raising the interrupt.
> 
> This patch adds a separate the MHU controller driver for doorbel mode
> of operation using the extended DT binding to add support the same.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/mailbox/Makefile     |   2 +-
>  drivers/mailbox/arm_mhu_db.c | 359 +++++++++++++++++++++++++++++++++++

Please put an entry in MAINTAINERS as well for this.

-- 
viresh
