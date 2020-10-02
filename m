Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E22281ECA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgJBXAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:00:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D833C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 16:00:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id y14so1789462pgf.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JuO3l5D3g+3T4SopoCD1TZFCSQFWdr/9/z0cbTHWU18=;
        b=B1baeRItQM93CJgK/YQaUbahw9W1IYNY7bMP2HAJr7olWXk3R7xYuQbTuve+4PtRhi
         j9be8RFID77t45nV1YB8hFQ4gHp1lYjQkDZ58bSVGkCBmcDxrLnn3MYI+6rVhemK78si
         BJ6RKv0c7UBvMtfkb6NQmugokTqrIlAuj0PgM88zx1UQXOXQV7wgudSSZgexyFcaWX0F
         Oqy38o3bX+0R1OKQdWTl8HMo5FwTNdkw2tMa337wAL/zr4RhPn0nLFZmSYL/Fqp3NYri
         4vHrJxiBOdZhK7U+IMIxPjlnl7qzGyWhMkDd7dXcHtq9UYXQi+ofXtIf6lKw/fjf1OQs
         6vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JuO3l5D3g+3T4SopoCD1TZFCSQFWdr/9/z0cbTHWU18=;
        b=X19jA1E6K/XMk5faVpv4NM+LIJQJWLBNBA6ideI4rJRsaq/L6uFxXeCl6WT1CV8ESb
         nn8WlLHMG/ft/X2FxETRDUADRItNxl1efVABW9CJFfWmkmTde9sQl8n4z+z/qoWml37J
         amkEcUOJ+MQOmhLbvtrmQs/xUGdoglTmN7iDbq9Zg7unUz6AN3haimUTY3/zj9hw/fuy
         40ULmJSdxxbKfkkgkx3HGgNu13ygbavIOA32kP+BbhAs0fdb2dRDyRCijGSIbTj3t4Q3
         hJunl4ETqiP3GxTusXGXCOspcl5jdEjOx9SAnhXeudRk7DNqfXCpUe4D5uixZVhWleOg
         Jczw==
X-Gm-Message-State: AOAM530vjKUx5HgSZ969sB84ZDibi0lKGoROOCIIcxtL71ROBQSTHELa
        hxQOEE73x8rd7fiEZcFNlmXxVA==
X-Google-Smtp-Source: ABdhPJzn4JlwbkeCh9IWyceUYlpcHYJn0xrj6G9mjjr10oe8uHor+PZAi4+w1vypBagk+phU6kVkOw==
X-Received: by 2002:a63:c74f:: with SMTP id v15mr4169592pgg.143.1601679621965;
        Fri, 02 Oct 2020 16:00:21 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id t3sm2616889pje.43.2020.10.02.16.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 16:00:21 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] reset: Add reset controller API
In-Reply-To: <20201001132758.12280-1-aouledameur@baylibre.com>
References: <20201001132758.12280-1-aouledameur@baylibre.com>
Date:   Fri, 02 Oct 2020 16:00:20 -0700
Message-ID: <7hh7rckzcr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amjad Ouled-Ameur <aouledameur@baylibre.com> writes:

> The current reset framework API does not allow to release what is done by
> reset_control_reset(), IOW decrement triggered_count. Add the new
> reset_control_resettable() call to do so.
>
> When reset_control_reset() has been called once, the counter
> triggered_count, in the reset framework, is incremented i.e the resource
> under the reset is in-use and the reset should not be done again.
> reset_control_resettable() would be the way to state that the resource is 
> no longer used and, that from the caller's perspective, the reset can be 
> fired again if necessary.
>
> This patch will fix a usb suspend warning seen on the libretech-cc
> related to the shared reset line. This warning was addressed by the 
> previously reverted commit 7a410953d1fb ("usb: dwc3: meson-g12a: fix shared
> reset control use")

Could you also send a patch that shows how your new feature can be used
to fix the problem that was originally fixed by that patch (and still
exists, now that it was reverted.)

Thanks,

Kevin
