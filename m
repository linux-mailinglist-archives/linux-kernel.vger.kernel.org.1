Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87A52A5570
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389062AbgKCVSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731398AbgKCVR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:17:59 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCAEC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 13:17:53 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id d24so20591312ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 13:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jasiak-xyz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tstgg3vKoiDwsRipOpBFOIS+Y4+ArIdAGlRHw0sw9m8=;
        b=yERDrGyWs9LQaBc8vwTXKGtVCnBlE3wL/3bg3Dmyy7QT/M5SwRSfUaUTdKWJWntjLe
         Ro9kg3N03rypCKnbDYXnxiEfcYaQsF+tSx4fMNuwNIukZx0ukRnVS+me/VvpwUZzAyP0
         aQDKbrr7bji2ltGAkv/GpzEZAMLt4TLueRLRsFG317F8qiLMp2XYHiSgRFV9d7fIn351
         XnH+n3l3CNcyOUKizAzFS/PvmfyeacEAhaKKJymK+Us5UPAaPsloMulN4Thzoren2M29
         bhAMTyFwhEby/wO/cZFX+gwoTksjDZ+yLcCv5edSuzUwpgitb3TzbFSMspWpuzDeCBa+
         dxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tstgg3vKoiDwsRipOpBFOIS+Y4+ArIdAGlRHw0sw9m8=;
        b=f1SoX1tddIyl5rsgknL3IFlny3clPzf9M++vkQe5J9QFkNfz0XHAvOhrH4ROUVTh6m
         b+o1fHHE6d+B7fDeNxgsTOkgMYWJg16gwFGOIcidiIYZDVXeRZ4c0AA8mvuyv1ZMRho5
         hkJmZYF1whEtJzvxVnNCk9MeSsGlzjBTHPFEF3g5nnY2+iapmRj7ZBbHny+/HUnsAbd0
         dS8MKPYx42TzBKjibdXEeR/lGOhlnnOh0yS3MpPM8DlqDSmHop+Zs/RFUkxTfBRHC5k/
         L5T4BwwHv/92TrkXYqPWJN6Xc4XN70LvtzbrKbpu30j+GJ5wa1oXy0mgBUFm/Z9zuFXi
         cwRA==
X-Gm-Message-State: AOAM530bgA+EoRoC++ov52JGTyNaaGb/R59svZw0tt3dPHXYEkIidqWq
        FPNWHp8tV/kFisB8bPw8EmYymQ==
X-Google-Smtp-Source: ABdhPJy+wuMCdOzonwK9ZUMWakHw+7Idzq8eUv964AirLZNn3GMX/fDHIgH3xkMOd07Gtao35i3YCg==
X-Received: by 2002:a2e:b0cc:: with SMTP id g12mr10210749ljl.403.1604438271390;
        Tue, 03 Nov 2020 13:17:51 -0800 (PST)
Received: from gmail.com (wireless-nat-78.ip4.greenlan.pl. [185.56.211.78])
        by smtp.gmail.com with ESMTPSA id f78sm4271820lfd.271.2020.11.03.13.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 13:17:50 -0800 (PST)
Date:   Tue, 3 Nov 2020 22:17:47 +0100
From:   =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201103211747.GA3688@gmail.com>
References: <20201101212738.GA16924@gmail.com>
 <20201102122638.GB23988@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102122638.GB23988@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have written small patch that fixes problem for me and doesn't break
x86_64.

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3e01d8f2ab90..cf0b97309975 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1285,12 +1285,27 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	return ret;
 }
 
+#if defined(CONFIG_X86) && !defined(CONFIG_64BIT)
+SYSCALL_DEFINE6(fanotify_mark,
+			int, fanotify_fd, unsigned int, flags, __u32, mask0,
+			__u32, mask1, int, dfd, const char  __user *, pathname)
+{
+	return do_fanotify_mark(fanotify_fd, flags,
+#ifdef __BIG_ENDIAN
+				((__u64)mask0 << 32) | mask1,
+#else
+				((__u64)mask1 << 32) | mask0,
+#endif
+				 dfd, pathname);
+}
+#else
 SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
 			      __u64, mask, int, dfd,
 			      const char  __user *, pathname)
 {
 	return do_fanotify_mark(fanotify_fd, flags, mask, dfd, pathname);
 }
+#endif
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE6(fanotify_mark,


-- 

Paweł Jasiak
