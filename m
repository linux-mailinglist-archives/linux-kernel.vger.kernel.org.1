Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D862CAE17
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgLAVMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgLAVMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:12:54 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D8AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 13:12:14 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q22so1703043pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKDkcpBHYJ418QnKHndhzHHrqp0qTvvUo1Ka4JFkIjs=;
        b=NfbkqhzXRx6xdHtZ4P5YsCq1Gh3ULOW6s+lWcdGuoQIQTXQtJf4FKlWF2M5LDdC5pg
         Y5gXlGQ7gysPCZ5vleJ/HGiDLKqdNfjZpu/ZgrMImWU5uBLkQscHMtAXLlEroCsq5QCQ
         m/4z7Y3kS2bKUmFcVV4HAbCA7ZKNm+GED9ByU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKDkcpBHYJ418QnKHndhzHHrqp0qTvvUo1Ka4JFkIjs=;
        b=hAgG9d5ly07tYw2n7ufZdoNnis0xCo2w2YyUQ1Xo4ESrFnB26Lrr+nYx4tmCoBZvnV
         Y7mHqxTxihZYSH8TG/q4eKJOa1g9a3oYJBA54g+1fw5xGXTEYbsI5vggvVR5NWaxmAe4
         qDugMTBlVJYHnYGem21lqXi6yJVYCjiBdkGaetiHGjM3WafXURX1uxPhm7NfVNdtxU5x
         jKJ9I6Ko1xNDOc0/mMBeZRjfnO2VNPCD7GdN5AHpAuqtwldKjla29uilz4R6wistWRbG
         I0zDAx/pF/JcDOgcNFesX4tHjCExj8lcPohiYcMeG/OSbyuYdSikHBK/0j9TbxzwmGlj
         aZqA==
X-Gm-Message-State: AOAM530PP9GKjsmbxvERRbtDkQ+fLJtaPSpu36YPQ+8xCWo625WykX2C
        L34qO6idtX3WqTHh52ME8TJ/+1ilmeT1W2+P
X-Google-Smtp-Source: ABdhPJxiQYvA+XXPUoSkXs1JD6os1hp4Kj00buq/VcWl/IZVckV7jqtQ4p9UdygLUvqC2QBoW0FXew==
X-Received: by 2002:a63:6405:: with SMTP id y5mr3568055pgb.445.1606857133780;
        Tue, 01 Dec 2020 13:12:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e14sm455396pgv.64.2020.12.01.13.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 13:12:12 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        Christoph Hellwig <hch@lst.de>,
        Colin Cross <ccross@android.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Tony Luck <tony.luck@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/9] pstore/zone: cap the maximum device size
Date:   Tue,  1 Dec 2020 13:11:21 -0800
Message-Id: <160685706687.2724892.9289969466453217944.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016132047.3068029-2-hch@lst.de>
References: <20201016132047.3068029-1-hch@lst.de> <20201016132047.3068029-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 15:20:39 +0200, Christoph Hellwig wrote:
> Introduce an abritrary 128MiB cap to avoid malloc failures when using
> a larger block device.

I've applied 1-3 of the series to for-next/pstore, thanks!

[1/9] pstore/zone: cap the maximum device size
      https://git.kernel.org/kees/c/cbf82e35031b
[2/9] pstore/blk: update the command line example
      https://git.kernel.org/kees/c/45a8af4412b1
[3/9] pstore/blk: remove {un,}register_pstore_blk
      https://git.kernel.org/kees/c/b6f8ed33ab2b

(I tweaked #3 with a small added comment.)

-- 
Kees Cook

