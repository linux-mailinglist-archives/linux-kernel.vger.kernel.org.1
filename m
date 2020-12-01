Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6E2C94D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgLABrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgLABrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:47:11 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC296C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:46:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y4so620014edy.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+5BnXN0m77zeqbV9n5TCbwnpu1hY0RqzGtMEds/qCk=;
        b=rWNSLZccHLQMDZM511qECtn11KzmY9V1pm3NFzbNx9FNIAvMfbJZ5PhH7y7RJpOQFh
         NkY3FA5HR5Hf5mnziwzJM9svdIja4C0kx6z3oxGLOS+IWW7J2arI2VO2kc+FMAzkt1h2
         n3Fu6rpF2T9mB3i+lPu0V5lqbvqCIRttoYP6vG3JP3T1bZe9839Cf9PCkUMZa/6GKJLR
         11hBNNHNXJjNQ6JpUlNcuCZpCATMj4pAhtQHYEEhiz06MWPMl+cm1R7IUOpdNJnRcS7M
         ji5eScauaoh3xBsM9+ys81gjfuZGq+OdTLnNHeiZB9TB+mVemzSANEyYFu7dJH/1++BW
         tZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+5BnXN0m77zeqbV9n5TCbwnpu1hY0RqzGtMEds/qCk=;
        b=bsiLycFNsuVBeiQ4V3yYKyk7tGadsSW/XtP5z4d+0jpPZgkC494ggvGzk30+m6koSo
         UJHlLNG6rOAvJBcWLSi4zEEiXx8ag0zaIdtRV89X8Kqyy0XQd1Cyja2WRc389N8npkR2
         Mns6MAR3G/yJllOuL4xzu+E0bVmHvEFnOEKnIg0HRrZbCkUkFcURWJqgIqh32e+ZgyLk
         vQUeZ2yBdC4JGXUQt+JV+ieHJNFTlhwuMLdbHiJmQSHgEINmyVzgbL3sK5Bdwp9TqTta
         fGYVm+Jh7puMPEGonKFQXOQWUggjYECT4IN553F5LONc4TNSCbAjlw3gp6v4zseT6C0g
         zneA==
X-Gm-Message-State: AOAM532Yvq0mBzqPmw/ii+MtvhvR0X1SDz4xJa7M6bkOGxONfw+P8mGz
        ut/9kVQ27+aKlozjrM7Eyew1ZgA0kcV+KaHdc6bjd8gXFBs2Gw==
X-Google-Smtp-Source: ABdhPJyE+VpI66Bcq/qfk08x/yZj1ODh2sqzTbdACmS4BeDJH4RaasYLVZ8GxiVk5NOYT/7J2KzzyDhHSnpV/Yf3Gmo=
X-Received: by 2002:a50:e0ce:: with SMTP id j14mr697382edl.18.1606787185958;
 Mon, 30 Nov 2020 17:46:25 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
In-Reply-To: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 30 Nov 2020 17:46:22 -0800
Message-ID: <CAPcyv4i0ek7znehtJD25VHNsGeKNVdxjL+S1y3M-uqiQOyF0-A@mail.gmail.com>
Subject: Re: mapcount corruption regression
To:     "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Yi Zhang <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 5:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Kirill, Willy, compound page experts,
>
> I am seeking some debug ideas about the following splat:
>
> BUG: Bad page state in process lt-pmem-ns  pfn:121a12

Looks to be a similar signature that Yi Zhang is seeing:

http://lore.kernel.org/r/51e938d1-aff7-0fa4-1a79-f77ac8bb2f8b@redhat.com
