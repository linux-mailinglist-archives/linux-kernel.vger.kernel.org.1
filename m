Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AC32ECD0B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbhAGJpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGJpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:45:46 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D51AC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:45:06 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id v126so4920375qkd.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gkZ6YBZc1TuDyrVRGbq/7fN83HRpfdis1YYIT6DC+Q=;
        b=XUX0BcoIa1MQ2jcMuATtV/lSqagHaVmb173j0UE8FAksPf0cENNwe06K9x9EyN/xij
         wf5RagTSVuw+GTnkcCTqtPvMabsfRvVjmCblHL9xl1iv3k3Yhy+cmQxf+Ro5otZvpM0h
         yfRsRQQef8iiX6B8LfBZ0/X6+3fYSnEqL6Q1MSg2dC7xiDynol+1c8zX5M+3V7XOGgp/
         5D8odmrKLEh0A+3UrF7oHzdKoJf/I5P+FIk4c4lAyP181Ce6ILIpCJCoz5GWjXbaQDKL
         G8/1e8OTsvfCUkYB8Kc1hJKbqHMMlBBh80re0nX73tg11ilb1hcDg+V6RYIC3WWHEGl2
         lCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gkZ6YBZc1TuDyrVRGbq/7fN83HRpfdis1YYIT6DC+Q=;
        b=XgbuF0qQLRNub7fRMIerr5wqoI04+qMhjYPNGz+Xx0zCNrwDJ6+4/bRwY+SiQZ7NkB
         GMGHgpYkv0ndH+0pGcIcHNVsF0z8IABXZPmw2gn4zH3vn2hFOjiDXBTyRLIKXMdKMahw
         diQCd8plY+gp/v8wzuCmjMqB8ZVe+6NF1Sn3h5Im0s5T5upOSR3Akn1/F239/eUvmjxo
         oR9t45HNH7RzjR031g8Fp2YEnjBSgssU9Vor7Eph8ipSvWNC5ysoF+NH16fZqyI9hooe
         +oxUqSIC4l/lfwNzu7n/+i9F4a//ofgsNi4HOL542ItaZBcXdox4hdjpaPPzLJyDeOqO
         F8EQ==
X-Gm-Message-State: AOAM531wDCNZXc1TgTSaA1R5m+jBrGm+Ct913iHBCO9EyvsClkdFEqvj
        g4WoQ1h6Vhq2eMeaXY02E26WQIU1jOEi0JeZ4tqOMQ==
X-Google-Smtp-Source: ABdhPJx7kwa5a7LxPnTXYQ5MyNqZ5CugH7qK0JJGeAQNJ5mrH4DPL3YL16IhEb8XYH5a2YOgkTl2U3E1RFcUPrE3IPc=
X-Received: by 2002:a05:620a:2051:: with SMTP id d17mr8211283qka.403.1610012704444;
 Thu, 07 Jan 2021 01:45:04 -0800 (PST)
MIME-Version: 1.0
References: <1609332331-2456-1-git-send-email-vjitta@codeaurora.org>
In-Reply-To: <1609332331-2456-1-git-send-email-vjitta@codeaurora.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 7 Jan 2021 10:44:53 +0100
Message-ID: <CAG_fn=V7LwUExnvVhAswj=VtEGPh9okB9ofzqnRfL2OV6qom5w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] lib: stackdepot: Add support to configure STACK_HASH_SIZE
To:     Vijayanand Jitta <vjitta@codeaurora.org>
Cc:     Minchan Kim <minchan@kernel.org>, dan.j.williams@intel.com,
        broonie@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ylal@codeaurora.org,
        vinmenon@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 1:46 PM <vjitta@codeaurora.org> wrote:
>
> From: Yogesh Lal <ylal@codeaurora.org>
>
> Use STACK_HASH_ORDER_SHIFT to configure STACK_HASH_SIZE.
I think "ORDER_SHIFT" is somewhat redundant, as "SMTH_ORDER" already
means this is a power of two we'll be using for shifting.
Leaving this up to you.

Alex
