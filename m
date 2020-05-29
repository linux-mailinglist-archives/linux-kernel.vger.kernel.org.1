Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194B01E775E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgE2Hph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 03:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Hpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:45:36 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6470CC08C5C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:45:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z64so905492pfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v0WL43ZgClHvK63U8tJSQHhuv1IY+XGJwk9TrYHJBpQ=;
        b=O4x09lmrpd35ttX4RvYlwthcP4XZDSh1wmXrWDdHgrwpzBD/ZZhH6KfxLQQJVRMSUT
         ksgx+s0fuOzYCaoj9NftFtYGCVyX2658+SqHPIgc0GBGp2+HF6OOy3DVu2+RhUov7nNo
         kF/ooebTjEWP/zFkJmzhMTRXeqdsXI6SpoiVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v0WL43ZgClHvK63U8tJSQHhuv1IY+XGJwk9TrYHJBpQ=;
        b=X5fnz5wXB1cJ/lvvENfzdOuxSwIvkaJWZDodUukxG2hUfuzp0BMBcn3y2OGth1EH9J
         IwUZoGPnAiazPZ6WCwPrjpldX2O1+5If1z8dgg6+zGgP9jbEztPl9D8sogquAYfnhhRq
         4h5PoIy0rMhvLhsfy/jCj7IPdzRq+CRbr+SDutlqq8YME7cwYPCK63bhSRKA4fU0V1Sk
         chihQBIk3LFOtRgFoO01PBtLAqG3x5cQJqEcCmOkg841Fkzyt2WwILbMjTu5e0QgfT+I
         +Sk0MVSKKNlw722XB8DBuuWc/IM6d/kdLgfa6+6C2EccGbZl7EryOBWiocppU5oOo3Gp
         Pk8g==
X-Gm-Message-State: AOAM530UoFV+pbTmT3pX1AHOWlnSeeftD12EGhR0gX8mNozkvFvXItRI
        Lmo/kAp+W6gBlBt5bEE9cNandQ==
X-Google-Smtp-Source: ABdhPJzbwFn0LKJavYqEyivVyPI9I8k58SVD1E/TsX1QWu1RxshYIIP2Z5NRX/HFonOSh2k/xMH/lA==
X-Received: by 2002:a63:1165:: with SMTP id 37mr7327753pgr.424.1590738336044;
        Fri, 29 May 2020 00:45:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 74sm3284357pfa.87.2020.05.29.00.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:45:35 -0700 (PDT)
Date:   Fri, 29 May 2020 00:45:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <202005290043.A402A7514@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
 <20200529073828.avywvdfprhupbkql@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529073828.avywvdfprhupbkql@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 09:38:28AM +0200, Christian Brauner wrote:
> On Fri, May 29, 2020 at 12:31:37AM -0700, Kees Cook wrote:
> > Nit: please use BIT()
> 
> Fwiw, I don't think we can use BIT() in uapi headers, see:

Argh. How many times do I get to trip over this? :P Thank you; yes,
please ignore my suggestion. :)

-- 
Kees Cook
