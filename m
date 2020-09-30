Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63327EFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbgI3QyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3QyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:54:17 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A68C061755;
        Wed, 30 Sep 2020 09:54:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f1so1382386plo.13;
        Wed, 30 Sep 2020 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a+511h/yRt0hAA530rhVf+uoJRBXRfwSraxYw7O/kA4=;
        b=gIyzm/LMhzk6FmcrH/7F0RNZbSSNuIox03V/NLAc7uhQqZOnGw/v9WAuwtjpk4/RQY
         XEpq9jhXtvSdVu94k5qKQOY3C5IEKNbbw5Bvf0KfJCtDCzFqXGNuWsXiBHXvhWSYSSLC
         LkMgyB5FEeg5osBePET6/2KYORZWx7FaA54whxElkY+wMODcQ1mWmgEF2rxIa99COPLs
         Du3GQhn5WOMk1QnHxrVk5fyHenVzPaJ0WuPTdRshqMsDj6smYr400lgsVHYIVG7f+CUd
         tufeR0zq0+xx5Dw9a5Qx6WFxekg7M+70Da60wDPBpZoBeb7pSlWA/U1MmPVaLKhnBN7t
         WukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a+511h/yRt0hAA530rhVf+uoJRBXRfwSraxYw7O/kA4=;
        b=LFfxyHhgKtSQmpuvTFxvdgcwPds5xnkEL70cFXmd/9whLUnXTUn+OYstQ/F410Vwiw
         6PBYHDisfnp6Y3IgV8b+iM/hq8ehvLBJ4fpA84BP6C3kp24xFlP0Jf7NbnugYZ1neva1
         nxH4KAj8sFcEmM7Pwam0b+LOHBeznIR5xkMHwiC8BGXFUX5x13wumgBtYfpS8pVYmfPC
         q+AxRzneWMVt4BOh+iJ7HYQiC7NopTahhZdE9JptVfDvu95DeNv/p15p5v2rprO5yCkR
         8xK0Mgpycu42ly1CNSagA5MfwT+mvv0CZ+vXr1BHsKQqlHxz7vUiZ3pG1F0hyh2YwcUf
         2deA==
X-Gm-Message-State: AOAM530OwpzbEKjibhP9SK3urVOCtiT1LVs5uZD3Twe7NO5AIsypnXuA
        ztHC/c+6loOqS7HFPcJECVs=
X-Google-Smtp-Source: ABdhPJxwezn+YlJ0I0Lsa/QSD/QW96cOmMj3PWOOxNwHQmumz6Lo0kuB7h+fFEjaG5LEvcuSBTpVLg==
X-Received: by 2002:a17:90a:bc08:: with SMTP id w8mr3317041pjr.168.1601484855301;
        Wed, 30 Sep 2020 09:54:15 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id l141sm2960368pfd.47.2020.09.30.09.54.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 09:54:14 -0700 (PDT)
Date:   Wed, 30 Sep 2020 09:54:12 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, bmc-sw@aspeedtech.com
Subject: Re: [PATCH 3/3] ARM: dts: add ehci uhci enable in evb dts
Message-ID: <20200930165411.GC25872@taoren-ubuntu-R90MNF91>
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
 <20200930040823.26065-4-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 12:08:23PM +0800, Ryan Chen wrote:
> Add EHCI UHCI enable build in aspeed-ast2600-evb.dts
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
