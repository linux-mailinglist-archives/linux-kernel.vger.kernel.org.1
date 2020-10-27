Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEB8299D08
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437529AbgJ0AD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:03:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37733 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbgJ0ADU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:03:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id 126so6702929pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 17:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kOeq1g287+GGSCiS+f4nbcLAhdeTzX+XBwJflSIWBX8=;
        b=N7IH9OuwFMJ0qRHvdYJTl5bCflDKaGKk7wYawS9VR9SYHW2/B/YFVZinxSDW/XBMKY
         dZ713XCoapl9r9hIaBkjcpKVBDwqItYAEADvMm9iKvgxcmnMxcnRpzLA+V6m/+AxppWb
         6DIHRAs28ntBR0j0b1M87HGTzENXJMxOsplheFNfXczszhrMyScIjeKi4xcSCTRabhuY
         mm6lqIo+SH3ONicX2fFBlsHetP/CFwISGjP55XNIkE5Zg2Gd1uA7w/pTsNwdBaDTKIvE
         AGt1PW2b7RcTfTx94nXiCIRNWlt8MVTavLeneWOZ5J/rsnKgA7DhTuxOXoI+sJYY1+UH
         QSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kOeq1g287+GGSCiS+f4nbcLAhdeTzX+XBwJflSIWBX8=;
        b=s/giMzFVI2SWhKo81xX/bfKvZhwDcovRAvTPwiHkVlg29Avm7Sv4Fb9+VfGSp25yEM
         wIJLtjcvSxZrm9N0TxGcL95L/Fhu6xjCjOE3Pij9MypIHM/VX+1vLRsYnU11Us4eCtqL
         FWm71LZoWSfT3OOnvu5El/IiRiBCRbtuADANJkZKuhsvHYdqVfluiPARX9kCej6BgJBg
         GDP/pqDXEY1yhQoh/P8275kGa82xlYz00VRxeoUegVC7TbwPLMG3mo2EHe4sem62Re0K
         ALQjndVNBgbrwxkkySWyEiEpuThptqYI6kxqT9R7td986AiskYYeE/jm8zmZgREi4UG5
         hLZQ==
X-Gm-Message-State: AOAM533PF22jgCDoB7SmNpKveP5rmrXu2nj/CGh2el/ebfZTx/iyVof+
        sn6L65MMqrI982KKJiniprFdlaZN3lYS+Q==
X-Google-Smtp-Source: ABdhPJx+HCMqLMYeLDZyOL1Ms1ziooQrerOaYKwrIkghgSRglBi7cGb2U9trvBboe/C7Q6dnm5YGxQ==
X-Received: by 2002:a05:6a00:8c5:b029:13e:ce2c:88bd with SMTP id s5-20020a056a0008c5b029013ece2c88bdmr213910pfu.0.1603756999622;
        Mon, 26 Oct 2020 17:03:19 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j23sm11968779pgm.76.2020.10.26.17.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 17:03:19 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Kyle Huey <me@kylehuey.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] Fix compat regression in process_vm_rw()
Message-ID: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk>
Date:   Mon, 26 Oct 2020 18:03:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removal of compat_process_vm_{readv,writev} didn't change
process_vm_rw(), which always assumes it's not doing a compat syscall.
Instead of passing in 'false' unconditionally for 'compat', make it
conditional on in_compat_syscall().

Fixes: c3973b401ef2 ("mm: remove compat_process_vm_{readv,writev}")
Reported-by: Kyle Huey <me@kylehuey.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index fd12da80b6f2..05676722d9cd 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -273,7 +273,8 @@ static ssize_t process_vm_rw(pid_t pid,
 		return rc;
 	if (!iov_iter_count(&iter))
 		goto free_iov_l;
-	iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r, false);
+	iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r,
+				in_compat_syscall());
 	if (IS_ERR(iov_r)) {
 		rc = PTR_ERR(iov_r);
 		goto free_iov_l;

-- 
Jens Axboe

