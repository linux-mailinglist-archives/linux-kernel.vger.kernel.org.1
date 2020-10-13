Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8512928D38A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 20:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgJMSWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 14:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgJMSWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:22:16 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB10C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 11:22:16 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s21so424247oij.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQU/HWxUjE5KcaVkKr6x7ImCuzfm12rpWXAXMTQLR7w=;
        b=qb0hog0fdzmEyf44Mxts58dgsHy9M0kcBdqRS096OR6D3aBDfHKxygeVJzi+SUs3Y8
         vqlourzxhoYB3Z2ixH+zxmVtXa0bClslz8f5yhF7Oaw71WMv5Qv1Rx+9cM9WbEZcAEVR
         IhzkmDGXyher59+4fP65zFZNxR+MXLeqxwMEq5nVwxZDBBDh5mgzAT7S4CMswcbPNAbk
         283rB3goUUvorJQGZwe1zUHAy+fCmrK6I/SNSoNd9TYudL9vajdlBEmjxWisYbyN2Zph
         VkAMhGW/YxdaMTtpczCKp6DjMZh8CbZ8tJvDTAWgnTP9tqSTLLPI+auv2exJGTYxR87l
         08sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQU/HWxUjE5KcaVkKr6x7ImCuzfm12rpWXAXMTQLR7w=;
        b=HIhsG0layeIdFAc2yfPlLt6T2jOZEMIOQg9Tm2uNF64+No5U/QKSQxXDuPStVGIPLI
         MnjnIRHvorUW1bnXvKX9RMXUf/eHBMdYKlGXBc6k2UlQ5/GNBA6ACAxb/CTebA31urw1
         REexZIW3pgsQafv2u8QfK7l6kYoJeK6vfpyduEzkASnqx/Jahw5lYswe7r9ucZpvJaix
         GW3OQub7V+Xt9XCWA2N0oxQHKjEhDvqC77WqcUb1ExdxX1wlcZAV1Q7Alx7oV7JmR4fr
         z/z11Tdn0uRIf7mVFAq9KdQfu7GGs600MNTpHE2VKtYO32VJvwKt4asOQksXds/8aeX8
         IPXg==
X-Gm-Message-State: AOAM531h+5C6ONU5BRf1/DNWacJeahs0okVkHOyHE4G3vwB9SgEAXp4K
        aetKll6yas5QkPVDJZNSRjAt/66uDpy9vw4T7r+DTw==
X-Google-Smtp-Source: ABdhPJzLwa73ClyFXQV4Iricpvxjk6ag+d7iF8AL5IX5npsWnFx6Ekz6G6uBd1kcYp42Z4TytPr4AEsvtBUzNpuS8A8=
X-Received: by 2002:aca:6744:: with SMTP id b4mr666297oiy.62.1602613335792;
 Tue, 13 Oct 2020 11:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAA_a9xLcCuR+WFfNtpJgq14rGZfxcqsoVz5aNhL5XCLhV+TwNg@mail.gmail.com>
In-Reply-To: <CAA_a9xLcCuR+WFfNtpJgq14rGZfxcqsoVz5aNhL5XCLhV+TwNg@mail.gmail.com>
From:   Alex Qiu <xqiu@google.com>
Date:   Tue, 13 Oct 2020 11:22:04 -0700
Message-ID: <CAA_a9xKLrcgDNpNF0dCGohUoV4igtZWmYTwjkT_GOQ4hyjY+oQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (pmbus/isl68137) remove READ_TEMPERATURE_1
 telemetry for RAA228228
To:     Grant Peltier <grant.peltier.jg@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Vaughn <adam.vaughn.xh@renesas.com>,
        Guenter Roeck <groeck7@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jason Ling <jasonling@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason pointed me to the patch
https://github.com/torvalds/linux/commit/294f69e662d1570703e9b56e95be37a9fd3afba5.
Nvm...

- Alex Qiu

On Tue, Oct 13, 2020 at 11:18 AM Alex Qiu <xqiu@google.com> wrote:
>
> (Intercepting the email thread...)
>
> Hi Grant,
>
> Looks like you made a typo in your patch:
>
> > + case raa_dmpvr2_2rail_nontc:
> > + info->func[0] &= ~PMBUS_HAVE_TEMP;
> > + info->func[1] &= ~PMBUS_HAVE_TEMP;
> > + fallthrough;
>
> Did you mean "/* fallthrough */" instead of "fallthrough;"?
>
> - Alex Qiu
