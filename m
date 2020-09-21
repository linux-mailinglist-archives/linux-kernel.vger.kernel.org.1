Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A32735FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgIUWuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgIUWuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:50:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEF0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:50:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kk9so514213pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbaiVgf+FPhg9ry/RsD0C9yh5wWMVw6jOEGioOdbWqE=;
        b=Ijp/hNd6/7sAv+e8i4QuvZ1TZcYHmXVOVanj8liTef148wiep/O7NRPU96yjKyZSLB
         s+OMyGdR8Y0DvpnZKJXF7XSNr+IeUWur2TVrV1KVobeLZykqzXQyd4xFMcE4oox3WzP+
         4uK16IDlwG74r0KVWyCgxL2UY6sAs3e9iJao0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbaiVgf+FPhg9ry/RsD0C9yh5wWMVw6jOEGioOdbWqE=;
        b=E8Efz1lX1V+xyPoOEMF9ji511AIe8M5W0XYCpMWrfywy740Sph2WMN+prYITBtc8NR
         VigWNMplqmA5PYX9HR0c0MvlAAPrwAzcUs7R+iDJ0GlHGNfbUjdN72fukk97IOi+4KU3
         hxfGJ5LT3iQBFdMIG0sSggjXAElELmz7644ozsAxS9/ClALkQ/jh6JONZYWEKQfdaKYl
         kaaKo0gD9cycnnCfmrSddi7noIQMCWKptk3U3ryLqNyotTvfuDFuDcBTGr2Wxn9TJ+iW
         Egzv8skLxaKpLA32wz5aceAq00CCSHQo4laDWfISZrlQvZU3ewF6Dyaj9E09dGy2hrcm
         LgjA==
X-Gm-Message-State: AOAM531PbV4VQNQBHBt6fUnZAu9yzaQbt78y+ttxfj1fKSJC/Gv8hYXf
        Ms+0MBaUOvjQvhZDsXQtPa1/bw==
X-Google-Smtp-Source: ABdhPJxqm1yudoETtLwrlF5fTbHh4kr12BmpLuxsZlycuWMBlYrGke/hZarm7COyP8rkKyl6gfhF5A==
X-Received: by 2002:a17:90a:69e3:: with SMTP id s90mr1268771pjj.130.1600728601559;
        Mon, 21 Sep 2020 15:50:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9657:a5ff:feef:7b57])
        by smtp.gmail.com with ESMTPSA id c12sm1581569pfj.164.2020.09.21.15.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 15:50:00 -0700 (PDT)
From:   Sean O'Brien <seobrien@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sean O'Brien <seobrien@chromium.org>
Subject: Re: ping: [PATCH v3] HID: add vivaldi HID driver
Date:   Mon, 21 Sep 2020 15:49:55 -0700
Message-Id: <20200921224955.2701032-1-seobrien@chromium.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200909150254.1.I170489c0c2ac1538b3890abb5a92b95ad4f04d01@changeid>
References: <20200909150254.1.I170489c0c2ac1538b3890abb5a92b95ad4f04d01@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping.
