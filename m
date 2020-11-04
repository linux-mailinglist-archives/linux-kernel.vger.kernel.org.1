Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F882A6530
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 14:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgKDNaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 08:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgKDNaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:30:15 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7307DC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 05:30:15 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id f6so18073099ybr.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 05:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vo4Jr0HYChGyhOVKIPtWjLkJnFRHjKRshVVgShtXba4=;
        b=hhWJgER0GHnIQBly213/xXXnJMYOxsYDuZYCK429rmX5g8S0/En92g9ViwBd7Pax3v
         Jgn7hu2qkrvLvnE7wQg9fG5FCOH2uXk3CQKBEomKR8ZVYYJssntBHpI0VF1dyfbtl9Sf
         R1OW2iZOaMo/KU2IOdHWXtfRO09bOwYGzgrDJr4vtPXV/DIgaP4HP1P/RZVp7FAtAxom
         IIbN9iknvDbjOlRx0Lut5jK7YGv0zGT5J9eydAWcKE+vxJYctcTNlfdMXJ1PPqQYcs87
         YcZQhz9SeSOFdI4x8TtDWppXRuicOPdQyXMWTOmH1MhWSvYZtOGQliHjMsiqAINz4sL2
         J/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vo4Jr0HYChGyhOVKIPtWjLkJnFRHjKRshVVgShtXba4=;
        b=P+nZbQpqKArqPuj8558HAFUAKUbbxlZL0jkVUmGGi+/tYTAORI6BgPA7scoe3tY4jY
         5VKau69SV5e5lRTKCh2mu2U5iwsYKOVLfEk/4LcFaJYXT9QJg3gBPhDTe9+v0kHUxhAW
         P7iiyAtgwH2YkWmW0Ut4jALtbwA/rtRms2N0mya14cd76zq2vAgmGL3+lKY+ImfgXnu/
         QHrDyrH8ZtV64C0Vf7eQ9ybimHXR5avlhg668UpEtS1QntWg3phLUAqnPdDurJTtNmU/
         onbvHAzV+1+kszoP0QyFuVqXQtAJjHM4DB500caQlHJ5LAspwB9dWCA60gwpYZsZIWyK
         PzGg==
X-Gm-Message-State: AOAM530VDBK7IBXb+7+zEAfSt5ZTfzdqMTSrFvihVcgmzggELudOa6Jw
        umFPTSZJXAwRg06XztIg95zd37v2pA5I/hRxzkw=
X-Google-Smtp-Source: ABdhPJzLoIDQYlHGIrC103prMfXiWF5S7KA5SbsBO2a7VUUqcpjgRBKFQJyJIwFu1H1UyLScCWi9SNubw6T7FIEOFVQ=
X-Received: by 2002:a25:4102:: with SMTP id o2mr33410214yba.115.1604496614845;
 Wed, 04 Nov 2020 05:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20201103095828.515831-1-poeschel@lemonage.de>
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 4 Nov 2020 14:30:04 +0100
Message-ID: <CANiq72mDG8YJLcpKuE+noUQY5B9K6Cc71ado_dyLFVVf_xzKwA@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] Make charlcd device independent
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 10:58 AM <poeschel@lemonage.de> wrote:
>
> Changes in v6:
> - patch 2: Fix Kconfig so that auxdisplay is now a submenu again
> - patch 23: Fix some typos in commit message

Thanks a lot for all the work, Lars. Queued in -next.

Cheers,
Miguel
