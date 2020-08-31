Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77158257FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 19:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgHaRtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 13:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgHaRtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:49:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D94C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:49:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u20so995227pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60DjW86vi7nEnF2m1S0V+BgpnMBj5NOWqgQoc/G62Ic=;
        b=Blq7WUiyfcqzqMg36C/s6JYWdSwHCeC0zFswKHsA7u4SlorNEWO65OsaVKyzpYB6sf
         K1vsjXOSSfLCq4yggqEYGYMdtBn572qD+baKMsmpaMAifd+nh+4s3LDHFN2RkBkMIabq
         DrxMM0coGV/lI46qJXGqRSWsOcFKwEXeVV8p+2xafxvSYOR3EUNN3cbDxrw/9+7CGLol
         38kZWtvn7A9FA/8PX+4L6NQ7iKWkxb4TVkthvuau/rcpyuOsryjHo2vvfJilOae4QlGS
         oJoXaX98k6pmU4tkUwYKAtyqMMWbEnsvQXmmjlP5V+8YO0z7eM8RPzAW+jhYNvNXf9Az
         nPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60DjW86vi7nEnF2m1S0V+BgpnMBj5NOWqgQoc/G62Ic=;
        b=aX0P8GlHKnj/ID+S0skNDJUHJ3AJNESmL3DmEX6KcAq/hePj1EWw+ntdzMZZbkqc3l
         DBJRcpYEsfT89kaZGhqoGmwrpdCpQoHh5Cu2WgHxHRcxJSKQcvlSiDx6zeMVwygJeOOH
         YADnrUeL9/2q49OJm8XaH00olnSA0xaQ6bJ68pWv2Z4N0zW5VRLIF/wovNQVIXaiMdY4
         lVBTYB1xw7atRHA00ywe2kejzKwVdj1r/bPhE2STVFYFvnNa9ze/HQ/CxeQB+DbnIbCp
         kqGIsfMm2b4TdO+O1fhZzxxlmZA5Kebqy4peBFtnrVAJE4YYlfbDsm6nvsifTigFm7Vn
         jsWQ==
X-Gm-Message-State: AOAM531jFZ0eF8HAP3GyU/5JRd6JMF56bExma/vzexJ1tmWGovXsBX7Z
        4TmSnjI8gtbGheUW0YYfUTWLR48O1O1a3kTeMt3+pw==
X-Google-Smtp-Source: ABdhPJypN97hfZ+Khzi41CHS5fVpaH7hcLzlfP1MK/KP1SDoAtQGgvEZrzjYc4yVQ4MDAVP9CrpS8MAzgkrfK/0mvWI=
X-Received: by 2002:a62:1514:: with SMTP id 20mr2181252pfv.62.1598896141381;
 Mon, 31 Aug 2020 10:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200829153515.3840-1-trix@redhat.com> <CAKwvOd=+X2AakX3kTYCvyug-MK_Y+atDbkDSRxA0pUfOatQ3mA@mail.gmail.com>
In-Reply-To: <CAKwvOd=+X2AakX3kTYCvyug-MK_Y+atDbkDSRxA0pUfOatQ3mA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Aug 2020 10:48:50 -0700
Message-ID: <CAKwvOdnn6eMqJsL=aJ8n5dWWoHjXUL0LBSyVwZPGCKpkBSLHXA@mail.gmail.com>
Subject: Re: [PATCH] soundwire: fix error handling
To:     trix@redhat.com
Cc:     Vinod Koul <vkoul@kernel.org>, yung-chuan.liao@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        shreyas.nc@intel.com, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 10:47 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sat, Aug 29, 2020 at 8:35 AM <trix@redhat.com> wrote:
> >
> > From: Tom Rix <trix@redhat.com>
> >
> > clang static analysis flags this problem

Also, Tom, please use ./scripts/get_maintainer.pl on your patches to
CC our mailing list; clang-built-linux@googlegroups.com.
-- 
Thanks,
~Nick Desaulniers
