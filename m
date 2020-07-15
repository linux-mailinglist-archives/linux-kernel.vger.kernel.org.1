Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3132217D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 00:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGOWgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 18:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGOWgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:36:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6EEC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:36:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so3703478pjq.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gliI3+mbOLjFYTYhq4JPmZZcpIJ6gSqx989RSM0IZLQ=;
        b=rkvpMRd8QS9ENcJ1YyIQz/td9SZxOtg0A9LSACePjmHLGZeV9yskHVMEWo1UMXCSyI
         4zw/Vu2v55QHpxxzsVohxesMKQIyRFkEyvkaOAnJTHZ5WXHEn3FIk4EtspUcG60IqQLR
         Q1DHUowUAfvHpwfLo3DVF89EPQyfKAZW7IolCYN7IElAZbdbW0Wm9N0vp6VUSZIa4391
         lFHLaLvt/9FVeBnj9XZ54pcI2XXSYh6ZNVzeWFXuysrfHqf+rg+uk3XSQDa7a9FnLaMj
         Bf73tCqOxP5604pm4Pg+A4Iqj77Ef6l4KYsf4mr+M5M7CQXX/SzTLtguUa79WffWwPAD
         oObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gliI3+mbOLjFYTYhq4JPmZZcpIJ6gSqx989RSM0IZLQ=;
        b=s9aSLWzeRShN6HZ595UJfasyksy0eVRkackySkJHV0utFPF05zEob1HJ9asPYdTc0a
         370RO57aECc9H7fyNMH0VLZnY97wbUTmFeBUfqMgZKbWEa4Poyonf7ulg+8nNiGGXYHf
         ffAmCCsABTDvXjYQMpimbLEBhNP6Bcyq4PFMK0ZpeX4050JDo93O6fdP4KCk8jLvAnzQ
         dQecOorWnQNzoCnyYxOTx47rx9DhFdw2HtxO9QTUFGCVqiv6FphUphE1I2dOo//oqMBu
         XwpJ6LvuQ2MvbzQpFkRZKZxSroKFGWXxeQNZk8xFQp0CJCkv4Br+6TjvuebNb1miIc1F
         T//w==
X-Gm-Message-State: AOAM533F9BpgPZ9aEq1VwVANhMcWDRqU6DwaQZghC0pW5HpIqSvM/Rrs
        b8qX+oYN+sZTSs3Y4ryhuK39XdxpezHHkQZE/ODrPQ==
X-Google-Smtp-Source: ABdhPJyFjXbhEx7aQZ4KS+whn0NgudGxyMsb33mHtEpmQna2CbB7MGaTFgQcEpVWQQXeD7EDsqUfdIIAqTlxsFcD5g0=
X-Received: by 2002:a17:90b:3683:: with SMTP id mj3mr1861019pjb.91.1594852611852;
 Wed, 15 Jul 2020 15:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200521191800.136035-1-saravanak@google.com> <20200521191800.136035-2-saravanak@google.com>
 <20200715221356.GA219557@roeck-us.net>
In-Reply-To: <20200715221356.GA219557@roeck-us.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 15 Jul 2020 15:36:16 -0700
Message-ID: <CAGETcx_BTg5A7Cf8_Y61=_nUZJ4QVYXJwSOALvpZi8oDgm6Vng@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] driver core: Expose device link details in sysfs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 3:14 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> On Thu, May 21, 2020 at 12:17:58PM -0700, Saravana Kannan wrote:
> > It's helpful to be able to look at device link details from sysfs. So,
> > expose it in sysfs.
> >
> > Say device-A is supplier of device-B. These are the additional files
> > this patch would create:
> >
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> This patch creates a lot of noise in linux-next when booting various
> qemu images. Example log output as well as bisect results below.
> Reverting the patch fixes the problem.

Thanks for reporting it. Marek reported it last night too. I'll take a
look at this before the end of the week (probably tomorrow).

-Saravana
