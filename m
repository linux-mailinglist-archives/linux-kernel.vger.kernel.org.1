Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5FB23F1DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgHGRU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:20:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1888EC061757
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:20:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so1349319ply.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZmKP+qCzihWJK9dXcNadQFATorS0FHUmvkMi7b8YfMY=;
        b=GhIm2Pa7v4YxhlXrHy3f/nlqbB1X4jZ2cO8Etlvz9zwHwM00RutEXb0eh+mr4sOATP
         aLxjs3msffA79SRugYCIpDPFF4XCrcdo2yPLvYsSi1VzP0prKlxDewDF4VO7M7mgBqrQ
         wBjOViIeaHA0LQo495hDAQ1HNFKtu0yZuJAlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZmKP+qCzihWJK9dXcNadQFATorS0FHUmvkMi7b8YfMY=;
        b=q/+MiC9qMohmUj/IfvAULozzdAfL4TNjfsluSeQ+yD39+0hh/aofuxP/aKDlhgmDxG
         D1JEfySjMSUrY+hI2lszBeM7zTvXaJBnmqGjvY8O915o1vaAWxJFhZBm3QPABB638+MZ
         SHyQiBDMxqoGPe4xrDjfXn6foCTKPnsCWV/xTP8GkeWDoGFd9CJF+w/mAXvb3nb+B56R
         pggu4p399vR041pRLiT9LdalhncTBDvZTMHoHTt6OBUUwaDqQKTKJuCA5Zl37SLONMCi
         QZCqKZcDxPrjuhonWejbjql8zfDjC8i8e1fdGD4CLFg1m8aeA+v0FHGCBKhnDV1m/UJh
         dwQw==
X-Gm-Message-State: AOAM532Wvv7RdcPncZ7dok1CPbQSLT4UN/YBVc1UFhhCbOD7oit088xz
        Ju8DU28ZidqNSjUXbZDRBUG/MQ==
X-Google-Smtp-Source: ABdhPJyB6OwUfUimb8Uz2hhZTkIwGjClz3vVRtHwCFeTj6wgxCBADhupXVxYQDrplWNO0sPKqpn5Ug==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr13409666plt.199.1596820855376;
        Fri, 07 Aug 2020 10:20:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e29sm4935070pfj.92.2020.08.07.10.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 10:20:54 -0700 (PDT)
Date:   Fri, 7 Aug 2020 10:20:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, arjan@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Function Granular KASLR
Message-ID: <202008071019.BF206AE8BD@keescook>
References: <20200717170008.5949-1-kristen@linux.intel.com>
 <20200804182359.GA23533@redhat.com>
 <f8963aab93243bc046791dba6af5d006e15c91ff.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8963aab93243bc046791dba6af5d006e15c91ff.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 09:38:11AM -0700, Kristen Carlson Accardi wrote:
> Thanks for testing. Yes, Josh and I have been discussing the orc_unwind
> issues. I've root caused one issue already, in that objtool places an
> orc_unwind_ip address just outside the section, so my algorithm fails
> to relocate this address. There are other issues as well that I still
> haven't root caused. I'll be addressing this in v5 and plan to have
> something that passes livepatch testing with that version.

FWIW, I'm okay with seeing fgkaslr be developed progressively. Getting
it working with !livepatching would be fine as a first step. There's
value in getting the general behavior landed, and then continuing to
improve it.

-- 
Kees Cook
