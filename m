Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1507823C0E4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 22:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgHDUqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 16:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgHDUqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:46:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88321C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:46:13 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id m19so3438696ejd.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JkYcaggsGpcDWWPmcXd4JLlQeabzirm750hdjJEVhuE=;
        b=NFg4cddveDkJRaT1O3RuBGLGAnrKH5WS9QKSCol+urjsTiuPILUDsu2qHvIeGvmLZ7
         AWv+dqZp+ggBIBhCmlj/dhWBVfER342c908cQgR43cNevS278v8mPTqDnS7tFQPPI5ww
         0GTMHUZTW6oF7Vwz76ilfFm73ybFJNJ6rEwTxyixKG7b6bq1YJt4kSLY9n9xZOkm9GsA
         Ms3trDIpC1buR1fQsncoCu5fBb+/ZfZTnIFQ2mKOkNppcVA5uH6Iy+VT47X6Eph1VOxy
         8xECIF/WyUUaRndvro2duUlC7pL0ilZAE0eC7zsuhY2oRYLgdwQDK96xLtZRKCd3F+U+
         PQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JkYcaggsGpcDWWPmcXd4JLlQeabzirm750hdjJEVhuE=;
        b=H633OVK6WmSZ9YRbaYLGO7lyJ9Ox0VpbyMh4dq4i2Z/HxN1kM3MXGOkPrJ+6tbILqT
         E8c9wPErNuUjfySu8Xqd48+mDmAaf7xXiUzbzfVr5txdyJ74/dYSMQj55G2p2yYXO3EO
         4TSnHxoyZrwJFlrQaTC6H7bfHNxQwkWIdQdov3q4HlObraJhLZITW61SDdaL063EhmRU
         MV+wtCohhTwbrRzpljV4pTGf/WVqxTZsN/XB1bdijn5qnLnRlDxeUkGzeZTZAGVV70VH
         yR/j2Je7KCUKYlzWm2j9KG4pKM7cDKhYyrj8r3laEjCOPsnMGKds+eTDz7a8m4XzEWBR
         qTiw==
X-Gm-Message-State: AOAM533t7t7xe0E9/MkSffSFtlO3E06U0OthGJOl7NNEJJrqq1bC5gdU
        fZgCjQcBMzh2V3bBCRZVm6Y=
X-Google-Smtp-Source: ABdhPJyJT3XUe9lccfmgoNsSMRHEfwHQ577N9kfOoJ/bFHSN6uqY4hLXGO1yPEfJygTyEl+Xt0QxSQ==
X-Received: by 2002:a17:906:c08a:: with SMTP id f10mr22883770ejz.181.1596573972287;
        Tue, 04 Aug 2020 13:46:12 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:d068:a44f:fa3b:62da])
        by smtp.gmail.com with ESMTPSA id i9sm38188ejb.48.2020.08.04.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:46:11 -0700 (PDT)
Date:   Tue, 4 Aug 2020 22:46:10 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH 2/6] openrisc: uaccess: Fix sparse address space warnings
Message-ID: <20200804204610.mxzw6ahdnfw6yko2@ltop.local>
References: <20200804042354.3930694-1-shorne@gmail.com>
 <20200804042354.3930694-3-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804042354.3930694-3-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 01:23:50PM +0900, Stafford Horne wrote:
> The OpenRISC user access functions put_user(), get_user() and
> clear_user() were missing proper sparse annotations.  This generated
> warnings like the below.
> 
> This patch adds the annotations to fix the warnings.
> 
> Example warnings:
> 
> net/ipv4/ip_sockglue.c:759:29: warning: incorrect type in argument 1 (different address spaces)
> net/ipv4/ip_sockglue.c:759:29:    expected void const volatile [noderef] __user *
> net/ipv4/ip_sockglue.c:759:29:    got int const *__gu_addr
> net/ipv4/ip_sockglue.c:764:29: warning: incorrect type in initializer (different address spaces)
> net/ipv4/ip_sockglue.c:764:29:    expected unsigned char const *__gu_addr
> net/ipv4/ip_sockglue.c:764:29:    got unsigned char [noderef] __user *
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Look good to me.

-- Luc
