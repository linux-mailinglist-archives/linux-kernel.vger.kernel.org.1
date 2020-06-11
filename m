Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A751F6CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 19:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgFKRgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgFKRgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:36:33 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DC7C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:36:33 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t25so6138064oij.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrCOk7vsq1IE7uGd57AzoLSP1ALvkvtrfTao0LV5h+4=;
        b=PjCLvAgUk17O5rGvaRSULcAXIKgAeNPYfQj4+nc/jEDzvDt79xSOJ9y90gnyDsej57
         d6kv8CTeKJDW3tgsSbIhUH7B684pz0QDJS1PAC3ELlVYxup3lQZTLhIejtwsgQQWCbBm
         whcIjLz3Q4YA0rJbpmM7ez8cXb5PsSzB5hLw90jsFbfweSA0DgsHHTj0a3UpXNkTiXsK
         FHCNP6NH+PXkniJe6PD0IrUkKYLC/AfJYgTbByfESpbB7Eh6RWa3w2B8JexkbcgtqPsr
         BKFM8ErfoR7rUDwZJTpr2FypGZPTKX734j7VFNPPb3SuZIWCuP8HJJ3I2VIKp5nax4vd
         X7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrCOk7vsq1IE7uGd57AzoLSP1ALvkvtrfTao0LV5h+4=;
        b=iCdh8H4EygKv4uMj0+2XC+Mn54VaUAEoTW/1Iq2sMoXjEYN883AAY1BEIQpBp5DB45
         Ipwyl7fMJmk9VQz4CCjoSxrOgBrOB+Hg6RmC7m1VukNiNyMxXwzL7gPkS6A2pcBh4ruO
         caofR8N7PY/Bj+zV42zwEqMmtlxzUbkwu+kMdwZZxHfqVz+c+PQLSXYilEKjDpgaHl4M
         PJRY9Oo5ra22m9qJZtLoyyKt8sc2iygKYNGsVXzAJvposS4I2Rb8spYDOn/lPoo1geDJ
         x2aDSRV5xH8KOR2MtLev4FC+3HjvKjvPdwrD46lu/YLi2jqeb+YlA/OysdOrcDwgiRsN
         wfrw==
X-Gm-Message-State: AOAM533ljgW6NC1cCIlkHtBH8ECxChMFStEZdMA4KXNqNJgQ6TvMHEqN
        Tiw8L190cHi3YnXWcTS/KaxpIcUr2d0UjXb1rLC8qw==
X-Google-Smtp-Source: ABdhPJzBOdT+Dsmoz25Sk2BkH7lQgOo+1veTThTfIOcpemZoPqBRr3Bokq20sHjcYAD8NriytacdHguqDLTVuu4eLUw=
X-Received: by 2002:aca:2108:: with SMTP id 8mr7354040oiz.10.1591896992417;
 Thu, 11 Jun 2020 10:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <1591880115-12721-1-git-send-email-mkrishn@codeaurora.org>
In-Reply-To: <1591880115-12721-1-git-send-email-mkrishn@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 11 Jun 2020 10:36:21 -0700
Message-ID: <CALAqxLWnXD4XzGU=7mkLCyAkN1ONB=NRne9y8PxPWGZg4hgX8Q@mail.gmail.com>
Subject: Re: [v1] drm/msm/dpu: request for display color blocks based on hw
 catalog entry
To:     Krishna Manikandan <mkrishn@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>, hoegsberg@chromium.org,
        nganji@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>, abhinavk@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 5:55 AM Krishna Manikandan
<mkrishn@codeaurora.org> wrote:
>
> From: Kalyan Thota <kalyan_t@codeaurora.org>
>
> Request for color processing blocks only if they are
> available in the display hw catalog and they are
> sufficient in number for the selection.
>
> Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>

Tested-by: John Stultz <john.stultz@linaro.org>

Thanks so much for the quick fix!
-john
