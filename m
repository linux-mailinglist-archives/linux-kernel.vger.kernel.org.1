Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AF52FA845
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407475AbhARSE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407365AbhARSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:04:28 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9E0C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:03:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id bx12so4576753edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bPc1DkcUWa0STJdzdfkKlnki1jjWfZoqqpAJuAAzpTQ=;
        b=mLys9pdbnZOJkTj20tbb8YYtBhXa8EY6E4XZgyzcssp5+NtH4GX1OmPAxI/27v0Izy
         bOgS1g2Gk8+H9+F1TqEjD8i9KGUspkJNmKwt8JEBLsO1jg73tIiMiApDI/yWvtLVh9iq
         84tcLazvRvwBINPr/DzQ/4z+gNRfLaoJpnPh+uHp5Z2WwvkEfE7jJtieb+YqLrF9+ONr
         VyBVAd80Eq805e/TCsb91lcRQpBOIOO6Y/TI72K23BSi5xDgbDOjy3FiREcrNkWUdCr3
         Nwpm1EWKvs2PYFBl62uK+bBTovIbgY4m+PUp/VkC/11s/s9dcgLGPrKtocoWkZFtZqeU
         vSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bPc1DkcUWa0STJdzdfkKlnki1jjWfZoqqpAJuAAzpTQ=;
        b=UaWbZZdcrC+IzT9qZq9rpcrlqoEzVGS0Y0aqptWJQkdO5Lrtrnx8EY7TgmlzOiocjP
         /oZgww2WHxhTJDrb2q12wY5FC0s+AeGagHa6/aD3K9n2bTgclcM1L2ZMX5o1IEVsrBx+
         82mWaEhnruohoxIvNNiNfnt4EE81jJ1Ac7YlNccaoKxT4HAIMs89DBDdOAUMYQ5Vqkcq
         94LrowUki5Ix0J2TiDVqUt0B6e7gN4KJJmPxMPBwqNIZ+Wuk2anP4BzfI0LQ5Iv+B4pR
         OO8DO4JQ28RAq1w2Jj4J0k1YA34cB2vpUOThnvAaFUV9V0+y7e+sYIcfz4HLbSY8g5AJ
         tq9w==
X-Gm-Message-State: AOAM533ERBE1qftVpdAaKrW1JV8GlVJltdzb42IW8pfU3G2xkCsAQMQ2
        maZ6d9ckWTlz5h5hrMLz2X1y8kf9vIg=
X-Google-Smtp-Source: ABdhPJwdCBuD+ZY2ffKZvnCN9M6Bz1MCEjARnDUhp36fMFtPpyKbQDiXT5ijHZP74g8KIp5GS+ngEg==
X-Received: by 2002:a05:6402:34c3:: with SMTP id w3mr521093edc.3.1610993019441;
        Mon, 18 Jan 2021 10:03:39 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:4449:7b65:bfa0:95f5])
        by smtp.gmail.com with ESMTPSA id x5sm10651160edi.35.2021.01.18.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 10:03:38 -0800 (PST)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     daniel@ffwll.ch, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Let lockdep complain when locks are taken while waiting for userspace.
Date:   Mon, 18 Jan 2021 19:03:33 +0100
Message-Id: <20210118180334.43714-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

because of the Vulkan graphics API we have a specialized synchronization object to handle both inter process as well as process to hardware synchronization.

The problem is now that when drivers call this interface with some lock help it is trivial to create a deadlock when those locks are also needed in a page fault for example.

The idea of this patch is now to let lockdep complain when any locks are called when the interface is used.

Please review and/or comment.

Thanks,
Christian.


