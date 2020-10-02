Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9207E281F13
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgJBXbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBXbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:31:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DB4C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 16:31:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so1823963pgo.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0QRLbEJdGZQDTrvNnzz/vd1A9XIJGgSIja/bYa4Qi8I=;
        b=I9eSjLtFYW0xyA8OksbjBEp/gD+qxmzF/I7xANj86pIOK+zHGY1MBdFNXFf1WlrLZ/
         PV1Ih0AFJY7TLavkLhgofFPqGkhe98vrydUVgTh9cZ0aEu/R9wjsuA4GhjLcNcrclFbU
         UliWPRHaQsu9UPHZuRwyzVspffzZZi3Mc8fOPWYpPPrY9gzy2HtzKWrMAEHT7veoRJcK
         7Jdf+ufWykmdYxw6hfrSDbRcX7fIi4S15Ktd465xZQQw9+b/4zWhwF5K9AtwrL38cQ8h
         z+5g7eoeQIlh1wogWRBZbA5w4d2lRewj0PK+TOUepfVoEjCi/z/s2FUB+VvbnvumIH6C
         YCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0QRLbEJdGZQDTrvNnzz/vd1A9XIJGgSIja/bYa4Qi8I=;
        b=nwo4i2ikYocgX54JjSxE2pmbNxYCLf+6SJxCenD0jLRXy7cl9Lr0TXxm1emiBFwHen
         rPoJPEAwgcFtI2IzWRAI1gzrGEAm7cYFIkgTD3Iyp2l0bjuLL/9M/cMKm8UJ96qw4GkR
         aLxiNNIbQ47gtSm1+ENiwgMYifNmPKs95A64kGXf+CqPzy7p+Re8g5AEczqaZEicA5qJ
         GlAzWhe8CGWx97MpaG/Fm0xY9clokzryTNxZFTRMqJsqum7M7A8Y4sQLrOs5PU/8fi93
         CYIpotMd8ZMwynIWdFxI3YlXM7Q7W2V/IA2R+a/nc2ulsQrhV3nIwy6i8Rsz6pj7qZLt
         I6nA==
X-Gm-Message-State: AOAM5331atZGx9EQKsdgpCmirh6KD90mW5noSPqtc5lNkB8An/6zUBCo
        LWmN6DirSNgD1MwX+5uZ8F0=
X-Google-Smtp-Source: ABdhPJw73LPDi16JTCtCO5zXNZyiqmqhLHjswVaUqoKuYBEoW58r2/ceig7gm7PEEc5WeSZGmal/AQ==
X-Received: by 2002:a62:1b86:0:b029:13e:d13d:a05b with SMTP id b128-20020a621b860000b029013ed13da05bmr5067399pfb.33.1601681470073;
        Fri, 02 Oct 2020 16:31:10 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id f9sm2643706pju.8.2020.10.02.16.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 16:31:09 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     Alex Elder <elder@linaro.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] staging: greybus: use __force when assigning __u8 value to snd_ctl_elem_type_t
Date:   Sat,  3 Oct 2020 07:30:56 +0800
Message-Id: <20201002233057.74462-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002233057.74462-1-coiby.xu@gmail.com>
References: <20201002233057.74462-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(struct gb_audio_ctl_elem_info*)->type has the type of __u8 so there is no
concern about the byte order. __force is safe to use.

Found by sparse,

$ make C=2 drivers/staging/greybus/
drivers/staging/greybus/audio_topology.c:185:24: warning: cast to restricted snd_ctl_elem_type_t

Suggested-by: Alex Elder <elder@linaro.org>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/staging/greybus/audio_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 2091031659de..662e3e8b4b63 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -182,7 +182,7 @@ static int gbcodec_mixer_ctl_info(struct snd_kcontrol *kcontrol,
 	/* update uinfo */
 	uinfo->access = data->access;
 	uinfo->count = data->vcount;
-	uinfo->type = (snd_ctl_elem_type_t)info->type;
+	uinfo->type = (__force snd_ctl_elem_type_t)info->type;
 
 	switch (info->type) {
 	case GB_AUDIO_CTL_ELEM_TYPE_BOOLEAN:
-- 
2.28.0

