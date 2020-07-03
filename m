Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D01213050
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 02:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgGCAEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 20:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGCAEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:04:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9C9C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 17:04:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l12so31885198ejn.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 17:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eR453wzeWt8OI8WdKhu67tJlFuD79V2ZuDVAjiUvm2c=;
        b=osQmIcYiPfIrkDD+ZwM6dC63hjNoQl5eJ2OZwLavbQurYzG9Dke7CSXqDk4DOJMxmq
         mgZDjJ+OYp+hGtROGwdoSWE8k+7Ul7qx0yhNJ2S6CoF/ARBU9hpEeFz02oxAuRrFXgQP
         EbA+DPpPc3p10H91Ec4VT/tWZZD1B6F/UC1Z9FkhsBfm0LJM8G8zUeRvdO6tJnqFGaDU
         ZDKJ0tZoIml3IJ9T6aMwOpfsfxAN3DSLJs9ospeLrtHaEEMwMr97YnR+gQM4MKocVdRX
         Q+X7ZC+cjkDAJCc9nEgJOry7EIJtaGRAq7TEYnPZO5KzrxXOvrUJRtxBmF4TFnGcI4q9
         pxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eR453wzeWt8OI8WdKhu67tJlFuD79V2ZuDVAjiUvm2c=;
        b=OApl+/laKXSlBMPdPaixZ81WoZES7npGkkLGGYmGQA428ZZkCzn+YDOsQV7tD1cRRL
         18y2L5Mh/Jlk2+M29kCqdJIT3Mpdn+GWdxXcblVtZTgDo8CkzOnXoOeCPXfmmuOjcI36
         fcK/4h1ITcM1SpIWoraDpF2CXapcGXN5qaDXQY6GgafABmzmieIQE4MUhxRBEWakvgI+
         zPQCc3q1nbjaF7QbmJYi84vummYQMsKEOojKGv2SU6Dg7XNzoOBi7Fr5e9hK4fdkhCqs
         x6IpgNUEDBwaJlqwQsw+Fxtb+q+f0az/Bma3svFs45HsW0yPgQKPolx9Ml/fc2FaaXm1
         Tfwg==
X-Gm-Message-State: AOAM530X6Y1kfUETLW+OQ/RtPHBz5f+vC4P/FSVjnO6//BK0/hXbP9Ca
        d6HU37BOlY6uxvtEpeZxmsbtTEcc
X-Google-Smtp-Source: ABdhPJySk384Au0n5AEnqWU1kZU6d1Am6vMA3dKTtIlPspHynbbfi1s40NUEi53UJMrJkqgRiMAEJQ==
X-Received: by 2002:a17:907:41dc:: with SMTP id og20mr5805150ejb.183.1593734647918;
        Thu, 02 Jul 2020 17:04:07 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id 23sm12455446edw.63.2020.07.02.17.04.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 17:04:07 -0700 (PDT)
Date:   Fri, 3 Jul 2020 02:04:06 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] tidy-up options / reorganize lib.c
Message-ID: <20200703000406.74363gobwhd3oj3w@ltop.local>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deepest apologies, I've sent this to the wrong ML.

-- Luc
