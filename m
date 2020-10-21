Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9085929522E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504073AbgJUS0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438829AbgJUS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:26:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB967C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:26:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x13so1973948pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1FO9M9j075wuOALfoXxDUJe5XnERWTNac+Lhpl+//0M=;
        b=Gs0RQUdBzH+ye2gZxvGyB0vM44Vo1uzip3av9KXrzGiFzj6YVV0VumoXinNm+HrTGF
         a41sMv9p0md1kZicJUhprFfUc2BB4N5GTHHfL2/53CllymaxHzYWG3QlNvGhsWXHM1pO
         HVTwVuGQpK6iQIswHqk4r/fLpwesA1BVIPVKhHlesT4AYpwXtVOTZ5PYgNdMz0m4Cb0i
         wordHDyvWIPqUWCOjd7BYH0vG6llIyahcJ+PaLnLGlGlKtkBrCEO2OwG1EcFGudjEb4S
         DyyBwT22QxYCsC1524F991wBE4KrUgar6bkJqGLUz53wW0YbQAuEZvUKOIj57R/49kYh
         Cepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1FO9M9j075wuOALfoXxDUJe5XnERWTNac+Lhpl+//0M=;
        b=Jw6sKEuwpYcYgoxb3CO0MgYxIk3Az0kuwuvK2RJQG2M7sgTYA7c3z1eOA9OOH7WYzY
         xNUFU09Zsoe3Vi0LOv2mrm4b+OK5zXeprMjeG+zVqp/usSmuIm+vu3uedZTzAedAxpg7
         N6jD9D9ytiFOo2h0/MoBxJ1blSDqaTDEktIf32MNUvCn2X1wL13wrh6kTNnemd0Zb3Yd
         IlkH4XmmjZ8VITuyYNfKw328r11T7SzMrmKpUtLbhRtR4jGXssO8K2x/a+keTqdY7bUW
         IBY0ic7s+4jaHEGmg/tbCXsArrD/MXJaV2Rt4c/8okCUF/eCiIxBUd7mxCEljeAwU0sv
         nqhg==
X-Gm-Message-State: AOAM532I6HyZLtuX2kAd6fPJp4braoXP+Rdyffq3x+DV1L/TCxNXrsDR
        xajvvlYPaGiQs7wXrZCyepk=
X-Google-Smtp-Source: ABdhPJwP7EAt/uDM8x/2lBeocMVF3gYnnutiOkf68MN0f4x419/TMu9i75QIWYZrPndftnu7GsLn+g==
X-Received: by 2002:a63:5d03:: with SMTP id r3mr4341644pgb.2.1603304775269;
        Wed, 21 Oct 2020 11:26:15 -0700 (PDT)
Received: from adolin ([49.207.215.109])
        by smtp.gmail.com with ESMTPSA id a22sm3074560pfk.29.2020.10.21.11.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 11:26:14 -0700 (PDT)
Date:   Wed, 21 Oct 2020 23:56:10 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, christian.koenig@amd.com,
        Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        melissa.srw@gmail.com
Subject: [Outreachy kernel][PATCH] gpu: amd: Return boolean types instead of
 integer values
Message-ID: <20201021182610.4l65yg3y3nhzcac4@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statements for functions returning bool should use truth
and false instead of 1 and 0 respectively.

Modify cik_event_interrupt.c to return false instead of 0.

Issue found with Coccinelle.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 24b471734117..8e64c01565ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -66,12 +66,12 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
 	vmid  = (ihre->ring_id & 0x0000ff00) >> 8;
 	if (vmid < dev->vm_info.first_vmid_kfd ||
 	    vmid > dev->vm_info.last_vmid_kfd)
-		return 0;
+		return false;
 
 	/* If there is no valid PASID, it's likely a firmware bug */
 	pasid = (ihre->ring_id & 0xffff0000) >> 16;
 	if (WARN_ONCE(pasid == 0, "FW bug: No PASID in KFD interrupt"))
-		return 0;
+		return false;
 
 	/* Interrupt types we care about: various signals and faults.
 	 * They will be forwarded to a work queue (see below).
-- 
2.25.1

