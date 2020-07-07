Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7724D216335
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 02:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGGA5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 20:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGGA47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:56:59 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB0C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 17:56:59 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id r7so9021148vkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 17:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0U+Ae9VUStW4ggEhVdvGzjNMlpXyTeUY/9gfTY0/ec=;
        b=utZXuTrrhdNVvBHa1uweiJE4wi7wuw2yaj43gZoKVA+qQ/6IXeglgpTFncFc45q4ND
         xHb/E0aE4+EHzVpKgNpesgrAOJlG3Cecc1+o1aN1nGqNxny5/dSHdSbeNbt8Gx+5Jy4d
         U0adT/ZKYdmYq5vzD/F7dPXHiYT5Brm13Ur9F1y48aJOToL/HPM5vU7MZ4kMFsPUNFur
         hNpvFdJlGj/vIa9735IUUtO17dbYeotu04ZtBzAOKp8zrb++93ecNoOrFyLaVZG6kX+J
         fYAKztNMx7FwrQy9Y+dYCt6e1dHMuSJ/ThTdQ0+C1AAtm18ddSH8UAdBPirsWmTPSgrR
         rrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0U+Ae9VUStW4ggEhVdvGzjNMlpXyTeUY/9gfTY0/ec=;
        b=pdlBxVMGXgt6yVpFUtW5sG3I6ep/NZJB09sexS/A8B6kZaQdt7nKubMt2blcQ94fr4
         g/C7mFP8seWSpqSeC4Re7RkgAQrStWKRzXURDZAeKpTCDmEiR2t26A4tIXCvga7RqBqF
         i26XKWDXI0+5XSvlrUrauX+qeD2/7AMhAJ0dBOw2DDRuEZNsvsFLU4iUnvomsLdkVYN5
         A9MmfLx2nhVjl6vDWhN/iCWd6qaAy/a5UV/0DsAZWI+JhzJQiOPxBkYXL+TWvHN4b0C+
         OPnnAD5t4wTqlNSf8gzNMsNTBUW4N+oUyB7rLE/oWrk374ifc1pjURAWIvNQ7yFKb/UQ
         Xevw==
X-Gm-Message-State: AOAM532sa+rZCHcd2HzAu/qOQJW9v3PXT+4bnifAGfCyIT0ov0aqHo4t
        e4ELakgoN/uvxTQocjRv5qoZUuOILpIbRYCVysaE1Q==
X-Google-Smtp-Source: ABdhPJypuhUMCtj7x1ckYaC6Q89LU+doEAJ8U+ir85soCY7TokFB47XjJ5t2vzKQFIEK/maz9ZHoQTHnpvT5bIXg0Wo=
X-Received: by 2002:a1f:978d:: with SMTP id z135mr20253309vkd.86.1594083400343;
 Mon, 06 Jul 2020 17:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200707002203.2494094-1-linchuyuan@google.com>
 <20200707002203.2494094-3-linchuyuan@google.com> <1d6c34f5-6da2-a081-3d13-559f9dbbe352@roeck-us.net>
In-Reply-To: <1d6c34f5-6da2-a081-3d13-559f9dbbe352@roeck-us.net>
From:   Chu Lin <linchuyuan@google.com>
Date:   Mon, 6 Jul 2020 17:56:29 -0700
Message-ID: <CAKCA56AYnkD1gqZQjhJwv6aCTRNV2axB88aD-6QVrJHc=VxBNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] hwmon:max6697: fixing the type issue where the
 comparison is always true
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kais Belgaied <belgaied@google.com>,
        Jason Ling <jasonling@google.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhongqi Li <zhongqil@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 5:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/6/20 5:22 PM, Chu Lin wrote:
> >   - Use reverse christmas tree order convension
> >   - fix the type issue where comparision is always true
> >   - Change the line limit to 100 char instead of 80 char
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Chu Lin <linchuyuan@google.com>
>
> Unless I am missing something, this patch fixes the first patch
> of the series. This is not reviewable. Please combine with the
> first patch.
>
> Thanks,
> Guenter
Sorry, I will fix it.

Chu
