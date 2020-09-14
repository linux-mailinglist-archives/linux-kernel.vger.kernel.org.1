Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B2F269404
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgINRtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:49:09 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:34903 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgINRrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:47:41 -0400
Received: by mail-il1-f194.google.com with SMTP id y9so417158ilq.2;
        Mon, 14 Sep 2020 10:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8FKqqHI43ZNUstDJ82DPkSy2JKzbYvOmCyAgDqTrEzk=;
        b=LdXc6OEW1dya9NnOAvIXdboElsOzgnHV3O9Lf4KZ50pA0cm+cvSzEeZ4hlAepBU4bV
         iKVBG1P49hyDN90V6gIoDaMs5SGziuzyHmE/VywenZZFQ7iiovgfxDuEKzQcEKRQOvPH
         zbfKp1InxuM80y/V4oHA7e6KS+fq7G3tggOQhm60yzakYyueWRG3GcwQbD8kBZluewDo
         R88nQnDGW58+9SqhY2lHnEIrW7etmfD5pniiomKZLuBykTnu3a2VGczWywqGrv9lHglf
         cHf1kFkq55hruikcXgqmXkQlgIvw95GYPUDJMwfjGR92VS4S0AV5lR3s2K7y5eg+U2sN
         Sk7A==
X-Gm-Message-State: AOAM531mjkNz6Vg8a7LwMTLf0OAWeo9mVqaW1y9sNfzZfV8nH2s0Zu2+
        qgwhAq91qgEX3unhhqAH311vuxEi4MQ3
X-Google-Smtp-Source: ABdhPJzpyn24Vz9ija1M57QQb8SfqJ917hudtYiBZDQuh5eGko/u4/bPPbpYYckifhGhUstBxDgYCQ==
X-Received: by 2002:a92:d8d0:: with SMTP id l16mr1593436ilo.47.1600105656088;
        Mon, 14 Sep 2020 10:47:36 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x185sm6411583iof.41.2020.09.14.10.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 10:47:35 -0700 (PDT)
Received: (nullmailer pid 4125400 invoked by uid 1000);
        Mon, 14 Sep 2020 17:47:33 -0000
Date:   Mon, 14 Sep 2020 11:47:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     andriy.shevchenko@linux.intel.com, kishon@ti.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        eswara.kota@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v9 2/3] dt-bindings: phy: intel: Add Keem Bay eMMC PHY
 bindings
Message-ID: <20200914174733.GA4125267@bogus>
References: <20200913235522.4316-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200913235522.4316-3-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913235522.4316-3-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 07:55:21 +0800, Wan Ahmad Zainie wrote:
> Binding description for Intel Keem Bay eMMC PHY.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../bindings/phy/intel,lgm-emmc-phy.yaml        | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
