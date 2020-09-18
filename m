Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE1270042
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIROzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIROzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:55:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0248FC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:55:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so5930753wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z3dW688qENJW8v47iZvvhvhPKK/yGjEUH8Eu+wx3dcI=;
        b=hRpHFUiCcG7Gi3kj+fr5O0595M4eBZNAFLSknVYmIwpL852cKZ/LtOxsANbtBJBLyu
         6d/bwK0TB3Ht3xk1MmkkG42PniVPDYeyVMXqXK+KCenphtzEIVGHK+tkrM6NsmdeXmwO
         sFNWACPuFOZxwL6BrVy/EHOd18Jw/ajbfPvt1WfoarOkkyyIIdh6gWRkpBFR7HrhalsL
         NJfJ5A1ef0h/Aqntpff0xHBgMqO65KenSPKD6QdjIREJWIUCHrN/FZqv8bbTJpGtjmIE
         scNlz7swY2V5MqxB1dQxBLlhSbUIVMLifj/FJ3JznYPZ2mpLk5JfgstcnCSKiXjcnQaK
         UIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z3dW688qENJW8v47iZvvhvhPKK/yGjEUH8Eu+wx3dcI=;
        b=RxJLLuzc9+V9D8lwLv0JjEht9TrO16dofltHoMBRy/ef7WzbP8eTFOn9jsEEJrYSCY
         XsbobOYRrqawvvDfqAHxla60K1KfdujOCMXKXehRSO5K3iYqhf+2EaqX3MhXrIFvGvLs
         fBa8rZLFz3bpd3jz/Qxri4oJtLawv5HS6a7C8EG2qZ4Mc5K8GJQNEs0mFExXH+KaMkTz
         uJvMJE696tZfa3jPRaC7nu/04ykti11RIqN947ZEcAuK+fWL3VHrmTkzRnIOlOFWrS0Y
         H2knpCl8DS3hohK3PGkV5NQJy0frozUR2KsNiO4mjzG6AJWasTv69x9RON2tVlsAxeij
         LDzg==
X-Gm-Message-State: AOAM530tc2zXgKdQ12qJpKzgq4lZ0coNiATb47BeJqngDocxMdyRYTKS
        OuLrSmMyAv4GMljAjgGPwxWPiA==
X-Google-Smtp-Source: ABdhPJxyrtUGrRfhz+6SFZnO4tJiJgk6Op4RFkuAA4SwNbdBYxTaGK6F9CgdAGr3EhD1gaa/DkU78w==
X-Received: by 2002:adf:f50a:: with SMTP id q10mr37861563wro.319.1600440948316;
        Fri, 18 Sep 2020 07:55:48 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id n4sm5659779wrp.61.2020.09.18.07.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 07:55:47 -0700 (PDT)
Date:   Fri, 18 Sep 2020 16:55:41 +0200
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/35] kasan: shadow declarations only for software modes
Message-ID: <20200918145541.GA2458536@elver.google.com>
References: <cover.1597425745.git.andreyknvl@google.com>
 <272b331db9919432cd6467a0bd5ce73ffc46fc97.1597425745.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <272b331db9919432cd6467a0bd5ce73ffc46fc97.1597425745.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 07:26PM +0200, Andrey Konovalov wrote:
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
> 
> Group shadow-related KASAN function declarations and only define them
> for the two existing software modes.
> 
> No functional changes for software modes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/kasan.h | 44 ++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index bd5b4965a269..44a9aae44138 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
[...]
> +static inline int kasan_add_zero_shadow(void *start, unsigned long size)
> +{
> +	return 0;
> +}
> +static inline void kasan_remove_zero_shadow(void *start,
> +					unsigned long size)
> +{}

Readability suggestion (latest checkpatch.pl allows up to 100 cols):

-static inline void kasan_remove_zero_shadow(void *start,
-					unsigned long size)
-{}
+static inline void kasan_remove_zero_shadow(void *start, unsigned long size) {}

Thanks,
-- Marco
