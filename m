Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B711727295E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgIUPEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:04:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0566BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:04:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l126so9487247pfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=C4nRQfx2qYF9dFDBskG/JyOe47RPw5Dquf61du0N5A8=;
        b=agqNsv691BnrvFzNyxBbpHelbarCY+MdPY8sJNs3xWPg3dBXcHJCqrpBcnoFBvpaGk
         t+9hnp0oga7Wt9JC4R8VokWxnTtBZ7rxUTcW1vxWQ2xq/psilOat09agPwjgo0Lr6+ZI
         4SVo3SG9LZh0N2NX/uidZ4EL+OXZk/u7wzcCZ0l4k2zeGZcQMD5+q+0Vhglq3vylEqcY
         QGXsdSA2MH/dV+po0pRrWoL4fD74CLimUWB6pCORYvAJdgyWUP1lb559v6F5zVdrOSAb
         +Ei/3OtGyCRkERSwUKJhD5qD2qG7ZNTDJhAAv13/+0tGGSKMGP35nqWi/SK37mPSq5QY
         FPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=C4nRQfx2qYF9dFDBskG/JyOe47RPw5Dquf61du0N5A8=;
        b=ikwqQdwwablmq/so00B6CersKxM4WzL199qDeyDIF4hVnkQNZMjxiOxas0gtWhmHot
         dNWg3egfjQsp8gPrBC1KXSj9h8mf8uFjnwFMuc0s9IMeAgXi0WDVeb6m1ZlUavDcFdBU
         Bm1YT5MP2G1tTRjR7AmSlNbTw/Cg+LP2DUUdBKg3/Ysnev6MZ+fBfPhke+wLE9rm++CS
         H1vEYjYMWcvEfS+Iz+Fswf3P46sx+qDV+vwQpgZp5jWxD/vfJEfxCKXZHkoSCwfhy8JS
         DeizI1heYW+qrIu8ekW8/T8aunWpdXFZ3kpUjZmqOZb1D1W02ALeosBIb6uH2uWAKSMi
         WhIg==
X-Gm-Message-State: AOAM531YFfi3cblYSAKxfqlQ2B9TIjpsUOSexb7jXjGHVlznBz89C3yu
        D9EeTSQ2IKEcIemIllqN4Uidzw==
X-Google-Smtp-Source: ABdhPJw871DXIKluSOo8DCgvKaAuFfj3403gaNC33ggwTlepiDipW1oSGIgho1PTVmka+2IO3LMruA==
X-Received: by 2002:a17:902:7c0c:b029:d1:f38b:713b with SMTP id x12-20020a1709027c0cb02900d1f38b713bmr337499pll.44.1600700681460;
        Mon, 21 Sep 2020 08:04:41 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id k6sm12230168pfh.92.2020.09.21.08.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 08:04:40 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Liu Shixin <liushixin2@huawei.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH -next] rtc: meson: simplify the return expression of meson_vrtc_probe
In-Reply-To: <20200919100856.1639319-1-liushixin2@huawei.com>
References: <20200919100856.1639319-1-liushixin2@huawei.com>
Date:   Mon, 21 Sep 2020 08:04:40 -0700
Message-ID: <7hlfh3cgs7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liu Shixin <liushixin2@huawei.com> writes:

> Simplify the return expression.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
