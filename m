Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B7927296B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgIUPFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:05:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C27C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:05:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so9466193pfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=E3HUZZxUSuYAIS6Josi6Etr5CwzXWiSM9WplOQE3+/4=;
        b=i0b+v+UewEFdrK1rfJXPeWfXfJmpwcAzHDpTF99JMyh8QjSsAasPCDvGEzq3W7WSrD
         Ak5HU0JiITR+UAVrXDSiFjakr2vejiRDov67kX6px9IK50hhdqix6gpZmV059no5xG/t
         PA4PgimoAfeZIs94fRHaDlASikrNScVk9Nnqa8q//9Yt2jBCJNbAgRsfiiFsoGvXOQFn
         5NYI955SXhslt17AEOq1Bfe7PDtBQ7fzEdZlEEasE0clpHKqFZKaFjsgNh+uZf+VHY3V
         ClSSS8mSUWxHFVh2B1xubgXCU2A+8S4l8hlof6A03lkItjgg6YuH5LEz4QLk5Jj7KMO6
         J1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=E3HUZZxUSuYAIS6Josi6Etr5CwzXWiSM9WplOQE3+/4=;
        b=i7XE7WjMTHNfEZIta6ACa8aZ4nNC874kY0OB6uuCmXyATFTzQfgaqArep863tSI2dp
         nNywuIeTwZYfY6BBKBqURrCkUv0GQ30Ac+DSQkYn83OTdj2/ydr33TvNBooI4eYQmMlW
         upnr2BOBuTOM1tCFtK+J672uOSQgjnOv6ps+U8LYTn4oEYG9l1uVYXlGTzZv59vyhdPz
         r8HPqyq6S4lG7ydtxktUjSsj9p9hM4fo8zQC9nkXdvJFCxGDqf05DOSK4obGW3OohIVU
         NNnL/bLQlG/BbmFTN8LhgP7MXllwuV3NfHkU8HO9gFUfKzBYDTKG8uturzbdkXLnQESX
         N/sA==
X-Gm-Message-State: AOAM533IwE5R0vfoF4wg4u/PcerygPZfCgR/2qM76uVHQL8i4/hQt8yp
        Xf4iMghc2y0tcGhF5ze1N2O+5tX+8dKvYw==
X-Google-Smtp-Source: ABdhPJwDNe6fpLdzsdgYvdrV+5QTOe6R7R2KkNUljRPnUIXsBAaabMQORhFBC7M+iAUC7lSP2h/v/Q==
X-Received: by 2002:a17:902:b7c4:b029:d2:173:34ba with SMTP id v4-20020a170902b7c4b02900d2017334bamr368738plz.57.1600700738361;
        Mon, 21 Sep 2020 08:05:38 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 124sm12169946pfd.132.2020.09.21.08.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 08:05:37 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] PCI: dwc/meson: do not fail on wait linkup timeout
In-Reply-To: <20200921074953.25289-1-narmstrong@baylibre.com>
References: <20200921074953.25289-1-narmstrong@baylibre.com>
Date:   Mon, 21 Sep 2020 08:05:37 -0700
Message-ID: <7himc7cgqm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> When establish link timeouts, probe fails but the error is unrelated since
> the PCIe controller has been probed succesfully.
>
> Align with most of the other dw-pcie drivers and ignore return of
> dw_pcie_wait_for_link() in the host_init callback.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>
