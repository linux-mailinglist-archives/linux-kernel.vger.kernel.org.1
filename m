Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728DD300C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbhAVSlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbhAVSXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:23:03 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7854FC0617AB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:20:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id g12so8996334ejf.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9J+BrlLYgTspJD9ye4jQWIk1CnW/3Fa8FFYzOeIfBjg=;
        b=pNsesT89U7y5KJ1pEZlTSDCIUB5uvizLU78Mu0wTiEKOO6D/10eVKYuCXomHEVIoF1
         uUJBOkyDvdVYAkJxpIDPAbraxpqDhBjCb3We1hpwVHhnm9pxK7YLrAnL2iJrRhrDdgnc
         s/uSwg4i//AxxRlFCtZ8B1u1eZC6WxDLPAvQOrJErEpEwdS561izyrWaMWQsqPaNZDPy
         y6LiZyvwSyCL58UYszo6WQrXpvjyyEkV6G4/YcX049kuaJ78b4FotKTG33jnjbXjrs52
         1rEF6piabrfbjVRBjQ/mkxavp7GALCttEbLKv/dB3uan96JCtAEZutKrMpbfLDeQeBJe
         gPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9J+BrlLYgTspJD9ye4jQWIk1CnW/3Fa8FFYzOeIfBjg=;
        b=oj/EFkCUpasgEnlYCJ6A00gB1dBonYPhau7Rx1L1KkeLer2TonHjgG3ScMrqRoqyIe
         ox/9eHBc2RpMjVpo1kGZGULCFw6eVJFKTvLhbMFRtoFxjQYw7xx3y3gL7i91XnMwryKI
         gzk1pUjQvzhj8P7aTrxh28u62r8SxfXySoUYsBIUYZqHmV9GnxAFEyXgwF83F41GMoe5
         cy8nB8ieMOtxfP4S9x5ywuXtutgEB+RSNj4ufFXl36F/lkImseaBqbTOuwyioLLp1t0D
         7OsAMDppdC2AFLJp3VcV4MAxafWwU8+mNqpBzPSH4fCBitDCm5hy4GQcM8j5zSmu8HAi
         bu+A==
X-Gm-Message-State: AOAM530TBlziO/i3wYHjKzmNIrgPh6FZn/aEsEIL+fiUayoVBcAYg5cU
        Z3C24Wtdhzq45ujxahsPnzl5e6FUrROARg==
X-Google-Smtp-Source: ABdhPJyqm3+gKiCprsqFB+RUq/U8eR1CKgZSuBsW/tlTEJqKlqoa9pAtScGwg5GqO/PqylyRRvoGiQ==
X-Received: by 2002:a17:906:1958:: with SMTP id b24mr3742722eje.263.1611339638190;
        Fri, 22 Jan 2021 10:20:38 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h16sm6003359eds.21.2021.01.22.10.20.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:20:37 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 3/6] block, bfq: increase time window for waker detection
Date:   Fri, 22 Jan 2021 19:19:45 +0100
Message-Id: <20210122181948.35660-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122181948.35660-1-paolo.valente@linaro.org>
References: <20210122181948.35660-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tests on slower machines showed current window to be way too
small. This commit increases it.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fdc5e163b2fe..43e2c39cf7b5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1931,7 +1931,7 @@ static void bfq_add_request(struct request *rq)
 		if (bfqd->last_completed_rq_bfqq &&
 		    !bfq_bfqq_has_short_ttime(bfqq) &&
 		    ktime_get_ns() - bfqd->last_completion <
-		    200 * NSEC_PER_USEC) {
+		    4 * NSEC_PER_MSEC) {
 			if (bfqd->last_completed_rq_bfqq != bfqq &&
 			    bfqd->last_completed_rq_bfqq !=
 			    bfqq->waker_bfqq) {
-- 
2.20.1

