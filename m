Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE1525B314
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 19:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgIBRlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 13:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBRll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:41:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECDEC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 10:41:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c2so100944ljj.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+3fzIDZD6dB4Dw6aLJ8wyJ60xmGq/K5MrVPSuFfpYg=;
        b=Dk4d2sKC9aHKI0/Jp4sIy5gZVnevd126YEnMPVUCxfGj2azHnWnaDF8qKQEVfAT+Mg
         5OkseLzs6rYWX6xbPHAyOXgj2Vcuuo+JWH+rhknFrZgh9CMYO50wFa1JD4fiLIAn/Vob
         5ZyfVDjLlq8ZFXy3EZlU93BiOqVhXsNyfQTVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+3fzIDZD6dB4Dw6aLJ8wyJ60xmGq/K5MrVPSuFfpYg=;
        b=Qa8D0azsooMiUPt4GEQPaNmMffPhI2dFQYSfp35cSOv1jFBBqT4gdgFIiIulG5GA89
         DzCTtnRDNfM1pV+a+KKhrq8Bt1LsSoIpNggwDcMwCSozR9pN6xI7/kHPley4x3vx6aXD
         5o7hpkGNfFkzXL3x7uI1Ec51Zy3jsqA4NccbmXXjibuOSLve4FmEKv4g8T9NVTtloDcH
         daMC1EeZWBbaUmcfSuJzGhX/AJgPpMhKjef+o8/wIwcOZG36kmVjCHaqXi/BkltEizt0
         nBt0k46d0LwWWYqH+NEif+cBf8slcO2JnODv+VttMBwpl/klreA/tMQ+1u477uLoe4yK
         XhPA==
X-Gm-Message-State: AOAM530E85UQqc9yDxH7ZAJQqqYqBFRh6PeltnkkQQlO17fZpvBR1n1A
        AsXmsVvcBYib5yFK5Evg1eF2UeFGDiO7+g==
X-Google-Smtp-Source: ABdhPJyDCSipLW2roac2URB8QU9bDY/W0WHQrPv+1T17sNkZfXJh71dob3J2bLtbUJIan8tQb0jRXA==
X-Received: by 2002:a2e:9607:: with SMTP id v7mr3692724ljh.174.1599068498429;
        Wed, 02 Sep 2020 10:41:38 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id b15sm54832lji.140.2020.09.02.10.41.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 10:41:37 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id w14so167430ljj.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 10:41:37 -0700 (PDT)
X-Received: by 2002:a2e:b5a3:: with SMTP id f3mr3579210ljn.70.1599068497154;
 Wed, 02 Sep 2020 10:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200902085513.748149-1-leon@kernel.org> <20200902085513.748149-4-leon@kernel.org>
In-Reply-To: <20200902085513.748149-4-leon@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Sep 2020 10:41:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLHGi31Mpc6ObCYD8ho8Yy=0UqGyo6E_Ocv4XaFcEkKA@mail.gmail.com>
Message-ID: <CAHk-=wiLHGi31Mpc6ObCYD8ho8Yy=0UqGyo6E_Ocv4XaFcEkKA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 3/4] gcov: Protect from uninitialized number of
 functions provided by GCC 10.2
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 1:55 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> This trace is seen because n_function value provided by GCC through
> __gcov_init() is ridiculously high, in my case it was 2698213824,
> which probably means that the field is not initialized.

This seems to be wrong - since a different (smaller) uninitialized
value will succeed in the kcalloc, but will then walk some random
array size when copying and fail later instead.

So this doesn't actually seem to _fix_ anything, it just hides one
special case of bogus values.

              Linus
