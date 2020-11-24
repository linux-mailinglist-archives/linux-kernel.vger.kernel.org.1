Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3982E2C22BF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbgKXKUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbgKXKUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:37 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F43AC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:20:36 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id x24so5773603pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aa9wVaM8Q5G5htOYE8QAYbIy5Fdksi5AaGTsBR4y4oA=;
        b=cdMmPcjltFHlpI6gksl2/fIsFh/bq+VaUHcbdhE/devIEAQmawCgLno2bE6iZ7pIce
         5cIF64CvU29pPHCIGXWjf6jAa7fPaV9sl1tES5Zb5qQrsQ8Xm+HDvr2OhbE0lveavydv
         6xhsUSzwQLPbbIesaT90J5mN0Dj/SVpeghm9DCXXtzrr85HvMF2vyDQAqURubBqr9eo0
         9Q+UjnYOinXTRh5JM0BR4NmMlfZBHbHhOvfWfuJas3glKPaJ6peSQXvdtvl4AwkteVZ2
         XRKYYnujZvkWcQKfD7U/G1siM1Op+vGF5ZePDaGyXwnO++V7NlcAYHf3w7tebfffIgOE
         T1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aa9wVaM8Q5G5htOYE8QAYbIy5Fdksi5AaGTsBR4y4oA=;
        b=FyAUWPwESOQroGW+NMrKmA7aI5g6GqVLg36BpbKnEW/xQyNOwTGF61oIZIdNhwcTAa
         94O9gmKrBPV2083mNqArem2lRH3mKAd9YVowtppj9y5mrsSCBb1MaI/0onj/cJ25Xdik
         rQHz8Dk5DWLPUU4MhsMj9i5iN5JMM26daaUd7/9K2Oa8B5/x8ZrGk+kUURRLl2HSXCow
         jqBQYgu2WVFGGKktUzElqWcxdIOqsv4NcI9PXn7GHuhAFuwP9tckqgoESLyFJoZr3zLy
         sSHgSvYzAwHJVClXITkhA1tZbgewXDTaOd9pY2BD6ffLW+MPI+5J1ouair1PVLCmEHYG
         azYQ==
X-Gm-Message-State: AOAM530BEyHcPS6n8Yreb7BhWWmn24kZOSocodIzFcR1g/5A5GjEbqxO
        auGjFn4s9Nv4MCIyZgrjC6HOChqlFY9sPcA0mKdJww==
X-Google-Smtp-Source: ABdhPJxHor7IGuJelK1d4M+d7EIxn6vn8x+okbkfDnW+bIIWQwIOXtmWu92du9sRke6kFN6MNd/ZNf4uAIV6Li8N/8c=
X-Received: by 2002:a17:90a:e604:: with SMTP id j4mr4166491pjy.19.1606213236082;
 Tue, 24 Nov 2020 02:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20201116155008.118124-1-robert.foss@linaro.org> <cf0b935d-3ccd-8360-1b52-89fab0b181eb@linux.intel.com>
In-Reply-To: <cf0b935d-3ccd-8360-1b52-89fab0b181eb@linux.intel.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 24 Nov 2020 11:20:25 +0100
Message-ID: <CAG3jFyssMMHpi4WgWmeDjuVYKz12UwJoBT0WoOsdB4PZxnuqSw@mail.gmail.com>
Subject: Re: [PATCH] media: ov8856: Remove 3280x2464 mode
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ben Kao <ben.kao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 at 10:42, Bingbu Cao <bingbu.cao@linux.intel.com> wrote:
>
> Hi, Robert
>
> I remember that the full size of ov8856 image sensor is 3296x2480 and we can get the 3280x2464
> frames based on current settings.
>
> Do you have any issues with this mode?

As far as I can tell using the 3280x2464 mode actually yields an
output resolution that is 3264x2448.

What does your hardware setup look like? And which revision of the
sensor are you using?
