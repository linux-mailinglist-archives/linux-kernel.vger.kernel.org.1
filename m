Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B562AE652
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 03:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbgKKCV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 21:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgKKCV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 21:21:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FD8C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:21:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w4so792651ybq.21
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C5CJXWtztogE8YGBqU6z1Oq0yEo7wNJFt1eX9+HlMtc=;
        b=k+jciPx6CWVV41y0DFUewoeFIV6SfcBQMoy2ESs5LNChqv0ObN0B1B/rfq8vbrWWG0
         heCk4rKfzOGxxHZm+BO3kAGjUqowwBnd5wzLt4B/6l+XPcbiY0cN5XpGZmt/jnXslOoc
         43kmzeEBbNGbO084siFjeDmLUwdToI8gNVUpArmhz/qwGD3/QV32cklxfMwqolgysbJ7
         AF/hMsLDz63vWpiL/to+3/KCe99EcVPnYpSy5hbWnTQ9GT7jQo+e743d7fsjdzGFkMTD
         2glgL1c49i8OS/vtZZpEdxXbuTF2vWtaMrl7J5jrKLUXxNbfe8OH1D45cV9kR2TLpSOl
         +WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C5CJXWtztogE8YGBqU6z1Oq0yEo7wNJFt1eX9+HlMtc=;
        b=sMCd3zkNBESGklH42/Klhg0hbCNEtCJYqyspbI7TEty5nauFxTe8GXwsMvxHq2tXUj
         Ac+k8eBvBD45WCCUs/WNVrQsSE6mGcVU2Ht2l8EHVNfUUKRSjTdRc2FPXYpuTHpslPCe
         M9UHSyo4/SpPCKsIaKZfxUtP+UPWptkqnl71hrb9/Z13zQ2ZYzvyK5p6js7WtsAvlywj
         HtvcO16nUZShA2vx0u0jy9dt8YXdmeOkyR3JL+OtDTpPCJVbUzvtwI2ZSfWrUwbVFdO1
         ej2qyIW/adSKtv1RzWea4N5/gjvSifu7Q3s+Yf+RtitsYZtYXjYuPJhK8KEU6SQWieyO
         p3mw==
X-Gm-Message-State: AOAM533wM5LdPpqLFxcZulR+m/lgH2RVWT1YVuUPhz89UxTFspitKGIj
        YQLKwcCabomklRKXvTUnkPiNTiVqRlLBAU7uPEU=
X-Google-Smtp-Source: ABdhPJxvxcfPlRvAs53Nfpq0r7dtScIlARHBVcwQzof4jhhEpU7A+HIt5nl8mHAB+KrrAMucIS0r20+3TCh+MWXSprw=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:8809:: with SMTP id
 c9mr30786370ybl.521.1605061284396; Tue, 10 Nov 2020 18:21:24 -0800 (PST)
Date:   Tue, 10 Nov 2020 18:21:22 -0800
In-Reply-To: <20201029101432.47011-3-hch@lst.de>
Message-Id: <20201111022122.1039505-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201029101432.47011-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: Re: [PATCH 2/2] mm: simplify follow_pte{,pmd}
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     hch@lst.de
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I think this patch may be causing a regression for us for s390?
https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/432129279#L768

(via https://lore.kernel.org/linux-mm/20201029101432.47011-3-hch@lst.de)
