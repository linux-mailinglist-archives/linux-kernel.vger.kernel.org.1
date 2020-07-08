Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BA32186F9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 14:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgGHMMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 08:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgGHMMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:12:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD74C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:12:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so40648528wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dSkqKeCZdW90TMEdN9Flg+YLJ8bt6+9TzGKCz9DbybY=;
        b=zLDzhhyoreQIgEIR+ugQTfkKH6LFYLjo4qAI1sYIrgLdTPOOh3JOZs8KwZZPSQy4KV
         hy9OApK1AgcwFoenOaV33cNHbCOgmN0UOoWlJmVO2YGDMonyIjBkSAvHifjPCHQwROpv
         pOPrOS3R7g2YUNMHAk6wDbmgHvE7C+djIhTe7qg8SJB7O7S87v8hh/sOtJ9/mxY1Sin5
         PjCePV5bktTU06z9dpLw2dHoBZKb7qtaS9nj+iRlV6p35Gu5OAyRb5XjvHtJwYlVECB5
         b3+EYzR4g9A4hCWTCkGxnuVVhjliGkx+qPXcqtGolTTc11MW+ccNQn5wRRjfX3J1EROb
         bH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dSkqKeCZdW90TMEdN9Flg+YLJ8bt6+9TzGKCz9DbybY=;
        b=tqjrQ2Otxwbf6LQYgHP8OO2+QVywmZOU9lVazsySkckkt2LQo8lxilk78yAbJtFU7j
         Iw6GdYnKtiwJNtwYUEwR0whgv0egBmLnPzZRkb327/o1YM+SPXrAAddRkAIdwEi7t0AW
         QoBAxG2oSvc8jh4j3AWfqhUDDpGeLYdTTJC3Q0Lbqj1Nk0ZKjxUiuI3NIa7W1+p1hJ0a
         GbCPTJ+rl0xZahfYGZgLfNVi1cAomXYjssD81TtpmPt0BpvFqf+wnoCcDLBvcdqPBedu
         ENRNK34lvj81Aj4JmSsLAAx0KPSnLrA5RUffLPlwo5D0BagR5IPn08XWa5UOjMCUTdZZ
         UGZw==
X-Gm-Message-State: AOAM530MMw99eBTqd7lzzzCRm3XvMJHVoGhYwbaXSfxoXXjb6L+ECjJz
        ChGPywbQ+DNclWPL+GSq4rxdfVn7nEc=
X-Google-Smtp-Source: ABdhPJyqs3RsyDoSQ2yeKo0pKmqEfzGMbFQvw9N5l4jbOqxFffm4z8X+KKhpGC42G5O+NaxRNj/wpQ==
X-Received: by 2002:a5d:54c9:: with SMTP id x9mr61729854wrv.247.1594210332080;
        Wed, 08 Jul 2020 05:12:12 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id t141sm6455156wmt.26.2020.07.08.05.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:12:11 -0700 (PDT)
Date:   Wed, 8 Jul 2020 13:12:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 03/30] scsi: libfc: fc_disc: trivial: Fix spelling
 mistake of 'discovery'
Message-ID: <20200708121209.GS3500@dell>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
 <20200708120221.3386672-4-lee.jones@linaro.org>
 <SN4PR0401MB35986D7CECA87EA6EB9CEFA99B670@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN4PR0401MB35986D7CECA87EA6EB9CEFA99B670@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020, Johannes Thumshirn wrote:

> Looks good,
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> I think Martin can fold this one into the original one

Obviously I'd be okay with that, but it will depend on whether his
tree is able to be rebased.  Many public trees are unrebasable (if
that's a word).

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
