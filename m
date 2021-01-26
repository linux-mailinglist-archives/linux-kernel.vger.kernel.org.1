Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4211304F13
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392383AbhA0BmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbhAZSqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:46:10 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A594C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:45:30 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f1so14296017lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pguE7kAo2MFIwoKv2SY5mrzXdRjuGW27qIj/VJIdu1o=;
        b=XpWfM2ddOGS78nlzGQhmJNnXW5of3S6mig2nFp7pLl9UpJh6MSsQbDSLyti1DUSpj0
         HWM9ruzLLEQgneQFksUQwS0F/u2x1/5yq21RV8qqBu2SesPxZmAbJw4lLUMxWxX1iJ/n
         av5J4ZdxmaHAm6KwSDF8FXK04djMtGmXA4hCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pguE7kAo2MFIwoKv2SY5mrzXdRjuGW27qIj/VJIdu1o=;
        b=uImn3THWopIBqmiUBIe3fVvKZFwRhLa9UoBLzmWYuwI2y/5hmV1lzKv3/wCs08f6ll
         U2TiBQykchDlL6P1BWlFvL34U7Xrk/QB8PV5rKegsSp/ad/izaUx73UcmqACWiPaGZbb
         cBifDB5ljOPr/0KOtp6KmFi8tYRKRXtXQL7ILdWlbYfpADwXYffCdP6kG3dy/eHyIqAF
         uY+GMTU/0J6db+s19M4hCXCkZQzOLXj7HyYcNoqgGN6kBV9lMUsEkZg7xOGEYSSsdMKP
         ZkUoLuc7s8cHrnqPEER4O3OzkiOLRlFXuLV3ts5uiM/51a6axhimTQOYzvMxy6vJYF27
         MU3w==
X-Gm-Message-State: AOAM533Ml2rx1d5pErbqE7CVo9pnRoOYEJPzQr78iIDcjmjXuY/R8G7n
        uzOT57SHdqJp1XUx+HLW92aev26HRFSSgQ==
X-Google-Smtp-Source: ABdhPJzaHmi94GIcXyih0rlZ5/2hFEMWs1kDQb6D3OPIlFtPOPswB5gHJnMdZL6YkTbuoBtgKbuZAg==
X-Received: by 2002:a19:c144:: with SMTP id r65mr3123179lff.640.1611686728336;
        Tue, 26 Jan 2021 10:45:28 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t20sm1897599lji.36.2021.01.26.10.45.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 10:45:27 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id l12so18327932ljc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:45:27 -0800 (PST)
X-Received: by 2002:a2e:b70b:: with SMTP id j11mr3487266ljo.61.1611686726895;
 Tue, 26 Jan 2021 10:45:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
 <161160687463.28991.354987542182281928@build.alporthouse.com>
 <CAHk-=wh23BXwBwBgPmt9h2EJztnzKKf=qr5r=B0Hr6BGgZ-QDA@mail.gmail.com>
 <20210125213348.GB196782@linux.ibm.com> <161161117911.29150.13853544418926100149@build.alporthouse.com>
 <20210126162440.GC196782@linux.ibm.com>
In-Reply-To: <20210126162440.GC196782@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Jan 2021 10:45:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKbFUUhkRKvh4SHQcsUyG_kraLOTBLHUhc4GQ58ANBEw@mail.gmail.com>
Message-ID: <CAHk-=wgKbFUUhkRKvh4SHQcsUyG_kraLOTBLHUhc4GQ58ANBEw@mail.gmail.com>
Subject: Re: Linux 5.11-rc5
To:     Mike Rapoport <rppt@linux.ibm.com>, stable <stable@vger.kernel.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 8:25 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Mon, Jan 25, 2021 at 09:46:19PM +0000, Chris Wilson wrote:
> >
> > CI does confirm that the revert of d3921cb8be29 brings the machines back
> > to life.
>
> I still cannot see what could possibly go wrong, so let's revert
> d3921cb8be29 for now and I'll continue to work with Chris to debug this.

Ok, reverted in my tree.

And added stable to the cc, so that they know not to pick up that
commit d3921cb8be29, despite it being marked for stable.

            Linus
