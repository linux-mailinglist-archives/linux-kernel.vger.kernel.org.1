Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCE22A5D31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgKDDmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgKDDmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:42:01 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD403C061A4D;
        Tue,  3 Nov 2020 19:42:01 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id b12so9635956plr.4;
        Tue, 03 Nov 2020 19:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSNNg6rYK/2/3zMiCn7BVDgvDm2yt6YpivUg4E2b7qg=;
        b=Eee9uyEBokutGcZmxsxbWlwTPI9+6UK0YY/s4IG9UBhCWJcrRz1aPIJqpwFOrhdtcP
         qKjJGsWH+Zrp1qfpYAxhS+ce3gF/RyVH2ket900cp/GKOyHNKfz+RJYokZ/DhI3Sek0s
         CWO9NAX2+jEle2FosDxMBvLiTkUztAnMRPINWQ9pWuwEV5bKSf6JkyTcn92QxT7rNrp8
         /MYoVtLTHmtLrL2YhYnLJmQByKJ6IFGStdTPLuCoLshJldyln6u7PRdr5xguPwtcCfv0
         H8NPL0HtagkPa1R/+PeOGpdyslWJu3+Lmk/le9Z55YI3uqWkOC/YzaCLme/00uua6oKJ
         fjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSNNg6rYK/2/3zMiCn7BVDgvDm2yt6YpivUg4E2b7qg=;
        b=YJrUzMS0T748gkjGSpTO1XbGqXm8uE9vV69JYfKqi8oKl9TgFuVjdE7bgeoDvtVLsX
         9sh0y+Dep669J9+8G7XkPeKe1KqB+LaJMefTsXDJOtVZy2zkCdwJ4VytZ0CVNpfP9r32
         D6T/Bef7RBci/gFUqP2WaoIbLyJeVU3nI3a9BTDGHhGerDHOHhkJUQiBs5ROWjkspg1/
         yUgfNu6NV7kBb7d82pYpwIYkXgz1E4fArSLmV/wlCbLa7DExkatrwjaoJRU/HYUfxrb/
         HQoYk14O5R3iXOEwVV0HV4MOOWkgrOgqi2vxv3qImp5dNSZpVXn8gnxh1Cl7UsG0NFyy
         UyxA==
X-Gm-Message-State: AOAM530VhGySQvZCx93Sh8Vft056d1RN3Fr6eELQbWcGycxAo0N+OvYP
        sQ7HgqoJeO0kzBk6Q1w2Cuc=
X-Google-Smtp-Source: ABdhPJzTUPqvEVHdXh8/tPX+GVRxd0volMRGpuZMOHEDx98UjovYisD1LXmoY9qUZ1lVXLSwK0Xqvw==
X-Received: by 2002:a17:902:704b:b029:d3:eca2:d221 with SMTP id h11-20020a170902704bb02900d3eca2d221mr26808634plt.74.1604461321228;
        Tue, 03 Nov 2020 19:42:01 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 192sm593180pfz.200.2020.11.03.19.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 19:42:00 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Vivek Unune <npcomplete13@gmail.com>
Cc:     florian.fainelli@broadcom.com, Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: BCM5301X: Linksys EA9500 add fixed partitions
Date:   Tue,  3 Nov 2020 19:41:59 -0800
Message-Id: <20201104034159.565501-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201101200804.2460-1-npcomplete13@gmail.com>
References: <e64d76cc-90bb-5b54-04de-fde21542e4fe@gmail.com> <20201101200804.2460-1-npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  1 Nov 2020 15:08:03 -0500, Vivek Unune <npcomplete13@gmail.com> wrote:
> This router has dual paritions to store trx firmware image and
> dual partitions for nvram. The second one in each of these cases acts
> as a backup store.
> 
> When tested with OpenWrt, the default partition parser causes two issues:
> 
> 1. It labels both nvram partitions as nvram. In factory, second one is
> labeled devinfo.
> 2. It parses second trx image and tries to create second 'linux' partition
> and fails with - cannot create duplicate 'linux' partition
> 
> The following patch works around both of these issues.
> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
