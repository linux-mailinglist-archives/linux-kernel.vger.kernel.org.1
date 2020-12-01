Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56D42CAE45
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgLAVSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbgLAVSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:18:43 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4CEC0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 13:17:57 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q10so1998610pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xJaKmI6na5T5AatcerLS5KIuUjusss8HMVYnHL9hQWU=;
        b=RWKppFpvI7O9Nk1xWUWvwkD4988+mAaKp3MVnM/N0rNlOdKGMN7Pzwm9LVfF//9voe
         vkfSejegwj60MQWV4MfbpnmhYvcvazkIdlGe6pFo+DLzfqEv2lBj3CuNWmlrs7ARfMRn
         IOJcSFwLf1FXGNvy3vCI9fU/emz2JR+KNDjdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJaKmI6na5T5AatcerLS5KIuUjusss8HMVYnHL9hQWU=;
        b=SzIuMt5/8IFiMA/sW14kyfX+YNioLk84D+Dyc1fQ9fl2b5srdqIhxeaW0wYjepzEAX
         bXhmVdzNbCjNXeFO1T5O+e21kxtRaCx2CyLA4RY/+jxdnmUV0Frrff9JlLpQ6J1BTozT
         oKi7az+lrX96sAv9DRW1mRsqyBis0QTHUOgTj5zLnH1zEkxzDH6P2BI+TiFd9+rI2d3A
         9IZRuRavNRIx4o0A+zNjvug+P4xqbTVPsQY5g9HrG2+CHiy1tUPxWBMn00GaAIBWzL2c
         gsIYfQZL0/VaU89JXxIj7VSiDhG462c4in22qq9LCVSg7mtVYfXGZlsCk/Fo09NBejdx
         gGqw==
X-Gm-Message-State: AOAM530aC0TdpUJRqDLGcAHiX4N4EEku3gxp+aLuiAWtRoHWrV7uf5gK
        BJrTSmqlr3MQo3bLJHL2vsKkZA==
X-Google-Smtp-Source: ABdhPJw+BPzKlEns9G0kWGJJCE0tpZNIRXbmUtTmglTDps7ABlMu6UF1ItlFt0+XS9NxEwVUXueNtA==
X-Received: by 2002:a63:985:: with SMTP id 127mr3849650pgj.449.1606857476712;
        Tue, 01 Dec 2020 13:17:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t16sm460875pga.51.2020.12.01.13.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 13:17:55 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:17:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 15/16] refcount.h: fix a kernel-doc markup
Message-ID: <202012011317.D383308@keescook>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
 <afb9bb1e675bf5f72a34a55d780779d7d5916b4c.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afb9bb1e675bf5f72a34a55d780779d7d5916b4c.1606823973.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:09:08PM +0100, Mauro Carvalho Chehab wrote:
> The kernel-doc markup is wrong: it is asking the tool to document
> struct refcount_struct, instead of documenting typedef refcount_t.
> 
> Fix it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
