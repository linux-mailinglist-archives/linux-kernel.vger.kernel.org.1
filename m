Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180CB279AE8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgIZQ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730164AbgIZQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:29:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62381C0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 09:29:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so1122392pjg.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ReZsLvHBneH04N8Loq9YJ9S6MWNTP72CPq7StQtiUsk=;
        b=flBuDFjylqO4PcpY2bHDwc92sMi/0GbduSVdkuQNfd88bmVK6DfigGBFUH2QBccrk2
         385Yim03CnMzoMGY7oZWhtOHqZer6SqZzNEY4WhKUkcI+yagFY8N4xPq4loZU+jTLeex
         HDG74TDBdazjHstF7s1FoKEAo65tC4nQ0BeU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ReZsLvHBneH04N8Loq9YJ9S6MWNTP72CPq7StQtiUsk=;
        b=drUukSo6FBwZcyYhCEKylfJHQmkAbpN049o6lcp5dLXJJ8SR+4MXghL94ORcfzmYi0
         k5cbnHyyEwhDY3l1dHZH3WwMZw3USmBSeFvCv+Ar/e3NUU2mu0U2vdPsKQjiU2aYdvO0
         pRYMKJtKQe8/kz95Jy006IIhbNBYcv29QeZtx57YlTIqds799MH9bzS4CAwBmOATc0JQ
         tQ0rLpL+f9ofVGbqDc9aMExRk0vn7KWmPg04IFvpFnAiS0Y8al7QeSUFCxc9oDYLFDZb
         17oktFztwa+/H/XCcZ25evz3GBSljTti1+WiuyN0xRW405zwVBCwUbz4DVWzaQCK3rYg
         caCQ==
X-Gm-Message-State: AOAM532qo0T46PrLJ0lJngHvA54azNo29K7RRKWskU5CTnMcPb7wphS3
        vkBGEOFpgseu/ecW1z7dGfkmQg==
X-Google-Smtp-Source: ABdhPJwd4IF1Fz4/85gg89M2RFijczjSa7iLtSh9kaFyp2cYD7D9Izg0ei9xFdzpxZhcWY/9odrHmw==
X-Received: by 2002:a17:902:b7c8:b029:d0:cbe1:e7b2 with SMTP id v8-20020a170902b7c8b02900d0cbe1e7b2mr4320915plz.35.1601137767826;
        Sat, 26 Sep 2020 09:29:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q16sm6358555pfj.117.2020.09.26.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 09:29:27 -0700 (PDT)
Date:   Sat, 26 Sep 2020 09:29:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, shuah@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, minyard@acm.org, arnd@arndb.de,
        mchehab@kernel.org, rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 00/11] Introduce Simple atomic and non-atomic counters
Message-ID: <202009260923.9A2606CFF6@keescook>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1601073127.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
>    7. Verified that the test module compiles in kunit env. and test
>       module can be loaded to run the test.

I meant write it using KUnit interfaces (e.g. KUNIT_EXPECT*(),
kunit_test_suite(), etc):
https://www.kernel.org/doc/html/latest/dev-tools/kunit/

Though I see the docs are still not updated[1] to reflect the Kconfig
(CONFIG_foo_KUNIT_TEST) and file naming conventions (foo_kunit.c).

-Kees

[1] https://lore.kernel.org/lkml/20200911042404.3598910-1-davidgow@google.com/

-- 
Kees Cook
