Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F6F277730
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgIXQu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXQu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:50:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF9C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 09:50:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z19so2252711pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nVLEl40wEjrSHc0Fo3frFBWNyHJV0Pp0G2WwPeGBD7w=;
        b=Z1k9nH4UEFtPGCSYHH+RpAyfohXzX5eV74hMhkRA2uQTJO/Fq8KKcZiD3c0u8owRbW
         2flavPYLZJpwtTZPiA2rcNcgT3NxVOW33Vnv6DcOsL3fjqf7dch+5Fl905LUgmP6pm4V
         iYlQwW1iRJ7q+P84Bp1PtCwP7fp/y3PhOg7WuWUUpMhgFMcTp0H6ohFEZI1TkwTPm5Gt
         AJG768t/TCC3m2f6MHGUH4I5L7FRXcMMEz1cVHd+BW21/OiCtX9R4f0R7ZXzItal+6X2
         WsFi/ZZK06sEXdkSPfFjPCsTMnQk+i6Tpsi5eR70YQzKmgxmKT3IzRHJjb8otLI5OxLs
         lBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nVLEl40wEjrSHc0Fo3frFBWNyHJV0Pp0G2WwPeGBD7w=;
        b=G3BpirdRlgDYkwJzEC++QUTzpgwRBBHn8t0vJaE0HePoNX6DOomx8yc/2D/HRmPSro
         kbwv2rYOC0em38iPya+QwUftjbBG7L6WI6a3uhlzp4JGGbuEG7LY6OxGkoIk+gwrV4VN
         lTO3KCpAXufFmdG4Sb8v5Cn6Tzn6YasFCDRV9A+DHB/drpG2IJakRUqrfjJJDpjuDYHz
         4SHtBSzGKm+h9PvvZcL6/2Op88D53DH9krqLV48u84rCuBnHgWCjvNgNOzI7gMs/2rfk
         XCrwXv4GwdcxOahk0P3R8GvyzHpYJRAL3gKo92lfujYw8mI0iSHOaRpgHs4w6q2j67Ls
         W22A==
X-Gm-Message-State: AOAM531VnkUCBZDH3cPi+TckJNHvbRF6icoNIhQrlRWh0CIK1v/O/X1s
        djTsBhHre7FSzwGgXJoKUN9JYvRxtvoaGQf9
X-Google-Smtp-Source: ABdhPJz2r7wXPKnOm5/n1d+FqTKlu7pEKDZstm/xZsNC4APYItCZbjU2dEWrBfr6rm/C5Vw8LpRKpA==
X-Received: by 2002:aa7:96c7:0:b029:142:38cd:13de with SMTP id h7-20020aa796c70000b029014238cd13demr23352pfq.66.1600966256826;
        Thu, 24 Sep 2020 09:50:56 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id e1sm34265pfl.162.2020.09.24.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 09:50:56 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
Subject: Re: [PATCH] mailbox: cancel timer before starting it
In-Reply-To: <20200923123916.1115962-1-jbrunet@baylibre.com>
References: <20200923123916.1115962-1-jbrunet@baylibre.com>
Date:   Thu, 24 Sep 2020 09:50:55 -0700
Message-ID: <7hr1qr9l00.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> If the txdone is done by polling, it is possible for msg_submit() to start
> the timer while txdone_hrtimer() callback is running. If the timer needs
> recheduling, it could already be enqueued by the time hrtimer_forward_now()
> is called, leading hrtimer to loudly complain.
>
> WARNING: CPU: 3 PID: 74 at kernel/time/hrtimer.c:932 hrtimer_forward+0xc4/0x110
> CPU: 3 PID: 74 Comm: kworker/u8:1 Not tainted 5.9.0-rc2-00236-gd3520067d01c-dirty #5
> Hardware name: Libre Computer AML-S805X-AC (DT)
> Workqueue: events_freezable_power_ thermal_zone_device_check
> pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
> pc : hrtimer_forward+0xc4/0x110
> lr : txdone_hrtimer+0xf8/0x118
> [...]
>
> Canceling the timer before starting it ensure that the timer callback is
> not running when the timer is started, solving this race condition.
>
> Fixes: 0cc67945ea59 ("mailbox: switch to hrtimer for tx_complete polling")
> Reported-by: Da Xue <da@libre.computer>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
