Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3662D6EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbgLKDsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:48:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46803 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405305AbgLKDr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:47:28 -0500
Received: by mail-oi1-f196.google.com with SMTP id k2so8355888oic.13;
        Thu, 10 Dec 2020 19:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iwVzMGtpSHL3nSep40GqM93jnUr637ufBEvmc9oL7BQ=;
        b=FMaEXNvtavQr/FYZpDLB9d62ClxQcjXdjPtS8pNIfIgsGuMflKAJBYfmbxM0ECiBNM
         kUP9JUKYP4MCRHGCxkQ3saDEDk8GjT2MyQo5qW15+v1PEc7UPQSZ5TxJIpzHD94CFwnX
         s3oz9LbcsR1DRWlRRdL7F53JcpuAFNi7tQhP5W6WbPsK2envW8GWLwocQ4gSB1pPgPis
         lmDkbXuR8RH89EfXwXi8wCCJazGz0bI8UoO7sF7EqGJI/I2fp0K44z72mGCxY8Yofmtp
         DiK4/I1uWlEDKx/pk21/kbiXTZ5GhGuG0gwuKFYDc/njf0nE5WBqK7g04/AXSUW2zHC3
         EPgQ==
X-Gm-Message-State: AOAM531gbLMIN6c8NAZGWLp3Fh3Dav9hoX6NqVxHoJc94Y7png4WlZHz
        JS0MNwDMyWmv3P3aun/85w==
X-Google-Smtp-Source: ABdhPJxbn2bDUr56MHJSyIKL8JYbMykYRWoRV70y5sdY/tAEPi8Rt3Ge/B+Dd2pOmwAWcSlh6S+KsQ==
X-Received: by 2002:aca:ad85:: with SMTP id w127mr7853659oie.102.1607658407097;
        Thu, 10 Dec 2020 19:46:47 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s26sm1583997otd.8.2020.12.10.19.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:46:45 -0800 (PST)
Received: (nullmailer pid 3603005 invoked by uid 1000);
        Fri, 11 Dec 2020 03:46:44 -0000
Date:   Thu, 10 Dec 2020 21:46:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     anup@brainfault.org, bp@suse.de, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, sachin.ghadi@sifive.com,
        devicetree@vger.kernel.org, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, aou@eecs.berkeley.edu,
        Jonathan.Cameron@huawei.com, sam@ravnborg.org, wsa@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: Update l2 cache DT
 documentation to add support for SiFive FU740
Message-ID: <20201211034644.GA3602957@robh.at.kernel.org>
References: <1607596083-81480-1-git-send-email-yash.shah@sifive.com>
 <1607596083-81480-2-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607596083-81480-2-git-send-email-yash.shah@sifive.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 15:58:02 +0530, Yash Shah wrote:
> The L2 cache controller in SiFive FU740 has 4 ECC interrupt sources as
> compared to 3 in FU540. Update the DT documentation accordingly with
> "compatible" and "interrupt" property changes.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 34 +++++++++++++++++++---
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
