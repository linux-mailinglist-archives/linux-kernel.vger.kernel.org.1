Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620602C31C4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgKXUNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 15:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbgKXUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:13:40 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393D5C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 12:13:40 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 7so18510qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 12:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjrwSOgmK7tVwq8WvjS7LthFjsI+tsu+eyf3qqK2kfM=;
        b=ceTg5YmP47arROPC2Liz0mYMSHnqW9GuA7oK8Rrd2PPEJ6Ygre/fslMEfKH3xZsJZf
         ykvg8b30xjvim60a6CElFs8iOw4ZI//fFlxOOqxblxur0TFoMDOTb0Go45xUss3spoIB
         h9rtxVpDXmitlMiPFuUZXO8jJ07wAyt4EU4WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjrwSOgmK7tVwq8WvjS7LthFjsI+tsu+eyf3qqK2kfM=;
        b=DnM5f9ZVdtbxZKekYCdpBoW0HUZGtfob//CRjAWloAkCNo2v+F/oiLJx4B+SAs4ayg
         C+dTviktbsSi6ovaG28HdzEUfvh64b8T8ddM88IYk1wA29mO+4Dlwv8K1iNpNIw2Bruw
         cHuHz654RufnlrAt3o7b+ygR+8WtTjyeWnkdt7dqmL3978Dek3x3cqAcQPRmjJQtDFGN
         eyqYaG0K/OJmvJ0L4AlIz8V/swGP7ffMM+YqFKluq4iYTuWmkQrbNhKvqc0yhgFeggol
         UNqqvgQt+ictBieR8nLqyhnI8SWBy8ejvX8GzeM3Q3UmpDCplL/aeIXpcBJPb8UkyFz+
         b0Ag==
X-Gm-Message-State: AOAM5337rTaDkOPyZGXhEk/9xWz4sHecni4UGboJ5z63502ClEw6GDtB
        ezf0uwoi3BInSGYLVoIBg5OhcejnsHzsMXwl1PNlxw==
X-Google-Smtp-Source: ABdhPJyXA5fvd1TsMQp2qugJ5lv7k71ebl0ixrjc/JxV/SYTBZkFvEQGWkEXlTiBSFyS83C0bxAjnlW04S92/pKDkQY=
X-Received: by 2002:ac8:7345:: with SMTP id q5mr6306085qtp.297.1606248819400;
 Tue, 24 Nov 2020 12:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20201023214328.1262883-1-pmalani@chromium.org> <20201124132301.GC1008337@kuha.fi.intel.com>
In-Reply-To: <20201124132301.GC1008337@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 24 Nov 2020 12:13:28 -0800
Message-ID: <CACeCKackFrrtvkxma0acBP-mv_f7nGKtOuknCmy_YHynS38+Bg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] usb: typec: Consolidate syfs ABI documentation
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Tue, Nov 24, 2020 at 5:23 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Fri, Oct 23, 2020 at 02:43:26PM -0700, Prashant Malani wrote:
> > Both partner and cable have identity VDOs. These are listed separately
> > in the Documentation/ABI/testing/sysfs-class-typec. Factor these out
> > into a common location to avoid the duplication.
>
> This does not apply any more. Cany you resend these.
Thanks for the heads up. Resent here [1]

[1]: https://lore.kernel.org/linux-usb/20201124201033.592576-2-pmalani@chromium.org/

BR,

-Prashant
