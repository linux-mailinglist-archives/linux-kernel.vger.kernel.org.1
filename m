Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC27329DA77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390315AbgJ1XXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390158AbgJ1XWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:22:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32ACC0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:22:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g12so781747pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XZwWBaJ1YP4eUG0jbcZ/VfZJQEUP/FvDuE+Dcr6WVrA=;
        b=gkFHJe+kUFXAxf/8vOsy2x4sDIItYYYD9odc8xSFN7m2g8lYwKR38kgfTf8zfvYvs7
         yBKIMBqXPuX18tqVHBX3qCSclcuf06y4SGir3XllY4gvU+rJ7oabXjMnWHBu3qRHCt+g
         XDQ0BDU+YDLpbohWX+lRIQe1zsidFRDvJAehw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XZwWBaJ1YP4eUG0jbcZ/VfZJQEUP/FvDuE+Dcr6WVrA=;
        b=UW7EuvXu+FeY49gMjiR/6/Dx5RmUZ4cgUBk8pxz1JNYDthD9F615fVvgNuYuC0OHwm
         AI7Cy0OZrpIyiU+Nl22E+dujWeqGNus02tOg9OXWmsF9vLqP3b0aN3PlsNkRZMiSghXD
         v6B9hsChgC/RA5KedjyxBD4NODKbizpb+pVy6bSZBuh+sj9mZ05V4ViZAn3lDjsieXUJ
         gPI3g+0StNgjkpthyb422Nad+5Ic57F1eE1hY5ibtJMc0FwhTgaimZMc5+MioA2fjB8v
         Dbr/Nqr4DUCjWb4VUMcRoKRHHmmFa5Afswt2Uj91uCZUlhTuwp4Om+I06wkYaWs/nBAJ
         PcOQ==
X-Gm-Message-State: AOAM533JPWELtn5tHnQ0uMEJrmLzfPX/v3Area4ergrhwxush0ywD5lZ
        YrqjW29/QWdUvTPs7D/1kwCM4g==
X-Google-Smtp-Source: ABdhPJzIxT8kqv3hOAn/eutFdfJq4DAebLsNkfJ0qK4xV8rTZ+MoJFaBn7qxZgXgYmjQNvnQLalLqg==
X-Received: by 2002:a62:e104:0:b029:152:4f37:99da with SMTP id q4-20020a62e1040000b02901524f3799damr1294359pfh.17.1603927335230;
        Wed, 28 Oct 2020 16:22:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16sm457419pjf.36.2020.10.28.16.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 16:22:14 -0700 (PDT)
Date:   Wed, 28 Oct 2020 16:22:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Woodhouse <dwmw2@infradead.org>, x86@kernel.org,
        kvm <kvm@vger.kernel.org>, iommu@lists.linux-foundation.org,
        joro@8bytes.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, maz@misterjones.org,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v3 15/35] PCI: vmd: Use msi_msg shadow structs
Message-ID: <202010281622.40CB2D87@keescook>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
 <20201024213535.443185-16-dwmw2@infradead.org>
 <202010281347.2943F5B7@keescook>
 <87blgmf3zj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blgmf3zj.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:13:52PM +0100, Thomas Gleixner wrote:
> On Wed, Oct 28 2020 at 13:49, Kees Cook wrote:
> > On Sat, Oct 24, 2020 at 10:35:15PM +0100, David Woodhouse wrote:
> >> +	memset(&msg, 0, sizeof(*msg);
> >
> > This should be:
> >
> > +	memset(msg, 0, sizeof(*msg);
> 
>         memset(msg, 0, sizeof(*msg));
> 
> Then it compiles _and_ is correct :)

\o/ ;)

-- 
Kees Cook
