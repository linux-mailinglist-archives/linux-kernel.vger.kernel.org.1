Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C390296766
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 00:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372970AbgJVWip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 18:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372962AbgJVWio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 18:38:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02C7C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 15:38:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o3so1906812pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 15:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wszCCjsi7/wd9UBeO0pih1Xxc40zRbOGB+ICPDxk6yo=;
        b=U/9fFI1aK7njV4v+iIhQjAqJchN1MoMOzmTBPiaI+omoUi13HRvTCesdlQJv+TklyB
         FOscCBOnDd6k0ArfSmH2GeZtCp7aUE/MI3vxfftV62i0O8g9z08hlvdc0GCse9TVxzen
         vBgLEYhdxdJK2HfHr9ikHu+AXWI/l2s4aRXso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wszCCjsi7/wd9UBeO0pih1Xxc40zRbOGB+ICPDxk6yo=;
        b=IhNxvnoCexh7AfAVTA/cAXGRupJFYPFjjVSIbfBfAAw6ovAI7CNnj4SKU//+3GNbre
         TL1Nsg5//CfT09+kxbQA6F67Cn9S6oBWOXu8tKZK70xaBtQMSl4ydfDpkYIt3+AHLfFB
         AAoPWrvMm+JB/GD7CAaC91WO6Yzcbjb8KA5EO3BCzPzpCSzcFo/tljBs3WjIj/aoYstz
         UN1Cp1TcISoAPJr4Wsx3oOv6C06jPJKhAwVaMGDen7IYUsi8IUHscoMirv2PqdgnVVv8
         9m1zB+uT/tqlqKuZhaxXMLyJ45nHfHBBfAsp1UxETT6qArfRISNgqackx73Y8dfMcE57
         lmLQ==
X-Gm-Message-State: AOAM530CJPDyYhLtOnD80C6clI9UGAcY4Wt10Xya16OpWheCwkse75kU
        ke8PE7UhPU9HO4h5rTo9zd0SeQ==
X-Google-Smtp-Source: ABdhPJz1cscNM0QfMW/MoQhZPuKhhBX9tglJ9+tx9rN8oOyChBU7m+GUagvg+2esUFFKBmvddXCZ0g==
X-Received: by 2002:a63:ba49:: with SMTP id l9mr4253255pgu.246.1603406323532;
        Thu, 22 Oct 2020 15:38:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17sm3420650pfq.141.2020.10.22.15.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 15:38:42 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:38:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scs: switch to vmapped shadow stacks
Message-ID: <202010221538.9FA560D5B0@keescook>
References: <20201022202355.3529836-1-samitolvanen@google.com>
 <20201022202355.3529836-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022202355.3529836-2-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 01:23:54PM -0700, Sami Tolvanen wrote:
> The kernel currently uses kmem_cache to allocate shadow call stacks,
> which means an overflow may not be immediately detected and can
> potentially result in another task's shadow stack to be overwritten.
> 
> This change switches SCS to use virtually mapped shadow stacks,
> which increases shadow stack size to a full page and provides more
> robust overflow detection similarly to VMAP_STACK.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Thanks! I much prefer this to kmem. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
