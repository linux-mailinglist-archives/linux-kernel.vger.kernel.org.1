Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B552CF473
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbgLDS4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDS4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:56:55 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9270C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 10:56:14 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id f14so3645150pju.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=BabgtABiUfhimEJA8On2IJzMRIuNBST9b1rkNpp1/zM=;
        b=jlWQjTCABjt0T6VkmgDMzUer9qJfAm/W+dFL22LucG+QMS0Ysu+kc3L26p56TYv+ym
         sPLzRBTY9kE+7EExdFWbp+7VpfqOdXMEVzfl5XESfp7KyvR0I8jOwgjm4HhoXsitBrJ2
         XfH6fe++OTDy83zJ5O8YrMRs7T8xOQoLNN1oX5s07TM2iguwPPTvHBsq6PWxTgESFhkX
         g/Fw3IIlhYn9seSWFTZeJbFm4spVel7h5JG40fsN23Isw/F0TsTt24PH+VxXqMPkNli/
         tsXbZcIzld5tixUASBovbUmXvGZAcSNrLcfClWFTnM5gkArKaMNiQrhHC8vi/Lx96gTg
         lPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=BabgtABiUfhimEJA8On2IJzMRIuNBST9b1rkNpp1/zM=;
        b=KJ5blR+T/bBsas3qER/2R3qG11wqMbu0UWRYypOdteqhMcJDgHzOdIaflAo2WPRuVT
         fyy6GyF5biM3Qd1lU9YEhfbY8NzwMHZUPIge2GWnDRaaz8xM351VijJcmBQk0SvQU6ul
         F9BAz8ZjUWHM4mMFhtdg/U+sXXU6IX4m9d7ulCFfDIqQe5a5cFfFsuB+qfWxU0+Ffryn
         +WW3RK6MnFTaB/23dZax8RZwxH6QsrYQbieYzRzvZ1ylhHKJ0Kc8FEd/M6mwPTw4IJ4c
         M8hi/A/7B9cFGpzLYJi/Mxg89u+PqoreLCrcSUWmVJbkNnJCW4/hE3zik9OmVurLOpkl
         e2cA==
X-Gm-Message-State: AOAM532YyrblxU7Th+Wz7cvNM5r6iyRKsr5B64XSGWIaYfRs+92Xs8gU
        P7sNf/iu7iS3WkRRiFT5E+6/LFyaQu21yQ==
X-Google-Smtp-Source: ABdhPJy+gPA634gSSvLdgdEjcmdOlEPIk1D56342SNK5gUqMO5z2wBcLX/h6OAbkIld1ntKNuLLBZA==
X-Received: by 2002:a17:902:ee52:b029:da:4dee:1a54 with SMTP id 18-20020a170902ee52b02900da4dee1a54mr5030102plo.29.1607108174434;
        Fri, 04 Dec 2020 10:56:14 -0800 (PST)
Received: from [192.168.1.9] ([122.164.27.91])
        by smtp.gmail.com with ESMTPSA id d4sm2833964pjz.28.2020.12.04.10.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 10:56:13 -0800 (PST)
Message-ID: <dc46ab93e6b08fa6168591c7f6345b9dc91a81bb.camel@rajagiritech.edu.in>
Subject: BUG: KASAN   lib/test_kasan.c
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     aryabinin@virtuozzo.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     kasan-dev@googlegroups.com, lkml <linux-kernel@vger.kernel.org>
Date:   Sat, 05 Dec 2020 00:26:10 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

 detected   KASAN   BUG

[ related information ]

-------------------x-------------------x------------------------>
[   43.616259] BUG: KASAN: vmalloc-out-of-bounds in
vmalloc_oob+0x146/0x2c0

(gdb) l *vmalloc_oob+0x146/0x2c0
0xffffffff81b8b0b0 is in vmalloc_oob (lib/test_kasan.c:764).
759		kfree_sensitive(ptr);
760		KUNIT_EXPECT_KASAN_FAIL(test, kfree_sensitive(ptr));
761	}
762	
763	static void vmalloc_oob(struct kunit *test)
764	{
765		void *area;
766	
767		if (!IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
768			kunit_info(test, "CONFIG_KASAN_VMALLOC is not
enabled.");
(gdb) l *vmalloc_oob+0x146
0xffffffff81b8b1f6 is in vmalloc_oob (lib/test_kasan.c:779).
774		 * The MMU will catch that and crash us.
775		 */
776		area = vmalloc(3000);
777		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, area);
778	
779		KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char
*)area)[3100]);
780		vfree(area);
781	}
782	
783	static struct kunit_case kasan_kunit_test_cases[] = {
----------------x-----------------------------x-------------------->

Reported by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

-- 
software engineer
rajagiri school of engineering and technology - autonomous


