Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21329270011
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgIROoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIROoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:44:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C75C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:44:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so5589233wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6NiKzp3GYnVNlrj1nKLgBBFJ1a03bOSILhGt3u/+Pok=;
        b=XIp6kndVEG2N2+RGvk2CLTkKWfRU+U5aAp7NUBTHXY8UWtgpV3qgnO6RIrKMJP2gtz
         zirQylm1yKbgnZxlriyNfUVIaDLWf4G84eDl5CnQNKUWfoRInb8kZRK9KDBDK2khyC6j
         QEQ1CtSCDRHUIXTobBj4jhMHt6V8yVSBE8UcDUqWlt1em7Ef90dKhlzHeN1No1G4zCBl
         NeM9HvHya5j56QPjDMQhy6xDxEmDoAxKDxIbds8HUqMCsfdg5TZgEpm9xikP/ip6Z32a
         r+FXgb8s4aCv3lU3KmOPVPxLv4cZXqc05XtlByqTDPNAUqIQrmG6wp2rERCitlLOsLJV
         kqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6NiKzp3GYnVNlrj1nKLgBBFJ1a03bOSILhGt3u/+Pok=;
        b=ujRn+4wN1imVhFfwJ5EtlhOocNm+Q+NO5xo/tWOn/F2RFK3BMqJGMHxg/Nqc8J/LZZ
         +4/Bj1v8L+w0yiQ/izPAXZo3y748ZcKEARPuZGSMTsT6tYHOQngAmqjIK9xhvUOUCoA9
         vmM2g1fqto9JOd1wcvg2FWTHW2oH0Co/WAsYrqkWvllpY7PsilkmkV+Dbi5u21/ao1Ak
         CLcTBLN6uNMobNVKIsXrjGQc8CdEQ2jopnYbRDY66RWqlzZYp8jIcVlnjkx3WRuglZZb
         K/9JOCzRCQ4PplJMpHX17qprlod5Tr4HIkIyUGP0HBoDDI7n2Hv3q4NrEbTm21Daw17i
         e28w==
X-Gm-Message-State: AOAM530XEg3zetWlY5lm7P6oiT89Inntpc4yJdBOL6U+luiuP9BzrsJa
        Shm6wg2/eQt5CWNE5dU4m+HncA==
X-Google-Smtp-Source: ABdhPJyFC4mR1SfiLdJTxPUvBtO9C0cNuL9WhIwJnbYCiO8CdCCbWcOJrWJ1D+arshhoBuJ5gPciJQ==
X-Received: by 2002:a1c:a953:: with SMTP id s80mr15793418wme.70.1600440270291;
        Fri, 18 Sep 2020 07:44:30 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id s17sm5860736wrr.40.2020.09.18.07.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 07:44:29 -0700 (PDT)
Date:   Fri, 18 Sep 2020 16:44:23 +0200
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
Subject: Re: [PATCH v2 35/37] kasan, slub: reset tags when accessing metadata
Message-ID: <20200918144423.GF2384246@elver.google.com>
References: <cover.1600204505.git.andreyknvl@google.com>
 <f511f01a413c18c71ba9124ee3c341226919a5e8.1600204505.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f511f01a413c18c71ba9124ee3c341226919a5e8.1600204505.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
[...]
>  static void set_track(struct kmem_cache *s, void *object,
> @@ -583,7 +585,8 @@ static void set_track(struct kmem_cache *s, void *object,
>  		unsigned int nr_entries;
>  
>  		metadata_access_enable();
> -		nr_entries = stack_trace_save(p->addrs, TRACK_ADDRS_COUNT, 3);
> +		nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
> +						TRACK_ADDRS_COUNT, 3);

Suggested edit (below 100 cols):

-		nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
-						TRACK_ADDRS_COUNT, 3);
+		nr_entries = stack_trace_save(kasan_reset_tag(p->addrs), TRACK_ADDRS_COUNT, 3);

