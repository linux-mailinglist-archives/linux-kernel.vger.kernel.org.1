Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB82201CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 03:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgGOBYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 21:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgGOBYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:24:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59208C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:24:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so887481pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=disvEr8QTdkdT/FiP6nWZpfKiZAj+1GxhY8j6L4+VsQ=;
        b=QlGUunqmMzd7BXyHpekbCEW2V6nSjcB7yoyoPGH4TzD3d5B8mTW/71ZE2cJL8mK51k
         71ARRXSzT77AumtXxSrdaGYuwgbX2UQGZA8vfQJjrakWMO6AYGjVROqvp8NejS2m9Z2A
         7IYT8IbO38FLfB1a/Y4tOBuCZnK/Z5sSj09mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=disvEr8QTdkdT/FiP6nWZpfKiZAj+1GxhY8j6L4+VsQ=;
        b=JtImHTvl7kIAZrOXykqBn99Gjel4euszOdpGGWp/SCAoVFTLACwCK8pa1p5aKTwGmb
         eKZl+ES1K+BSTEkdGX9CZZZuUGQ1X+Uog2Iz8Sy9AFjeb92yqnxBxjmkKTod1HeB2Bxj
         rqXZptxPBbjcs25CwGOVBb1ctkqPeb0BSDUwq9OdOnVgE1TgXgQAXl9H5OSrFQQ/n3OK
         mGdbfZq/HsRer+3sQarSapDjgoZSE6BvhbE1wqKrRLNN2tpaaChJZrRxX/lyy98wOzSW
         kRva9cYgq0ksWNvJBdBPuVTLz8qhd/QHwpsTzH+a3N1gw8EWwBs6PGVNnKde4Es9qOBm
         Ikkw==
X-Gm-Message-State: AOAM530P2l1vvuIdto5N7GNEbDZ6YK/yGDasdxiRs7o5+JUwrjgSHdfN
        AbEwL99rE5tQ3Y0/Cq9JHHwp7g==
X-Google-Smtp-Source: ABdhPJweUW+32ofnpX4MJsObP6q2/5f9TZOLrNQ+l84Tm/hPhwj19hU1a21zbXROqArF2N1b8PwEGw==
X-Received: by 2002:a05:6a00:15c8:: with SMTP id o8mr6820199pfu.286.1594776261955;
        Tue, 14 Jul 2020 18:24:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y19sm335301pfc.135.2020.07.14.18.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 18:24:21 -0700 (PDT)
Date:   Tue, 14 Jul 2020 18:24:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 16/75] x86/boot/compressed/64: Don't pre-map memory in
 KASLR code
Message-ID: <202007141824.6D5B3BE7@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-17-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714120917.11253-17-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:08:18PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> With the page-fault handler in place the identity mapping can be built
> on-demand. So remove the code which manually creates the mappings and
> unexport/remove the functions used for it.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
