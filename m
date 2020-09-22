Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB46F274BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIVWEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVWEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:04:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30868C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:04:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t16so17734300edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gWapH+G9nYjlIO4hGELdVklKpsq8sACoI1gVBeSVnu4=;
        b=EITEgpF4ntktPf1T80SDT1pfY0hIUCg5rNxP+/V7+Qs4C/vIRyUSqCJNAD7rGrVo8R
         wa/Hz2OdcjU+Ex+h9jHzh+hDHc7moghyv+quzQunrZ0k0rkYXmUe/L9rLoHCFNXYZxj0
         gSym1XxRWJ/TNhYdC653fnU+aaH1N4ovNW0ZuRfA+6FxOX3XZ0w7mIkTLpBR6TEMW1RB
         OyrbTQxwWUyNZgak3n2GVEf3GyJBbmrc76wfmuf0qQv4XQXSuDQd/CWIqD8m1GbVX+fH
         WA53YoMMhVOMulz6xm3PF4+wmQwq2eY7FxxfojsEBGPE/+62r0cnlZpwqXDq/3Lw7eeH
         fGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gWapH+G9nYjlIO4hGELdVklKpsq8sACoI1gVBeSVnu4=;
        b=MCnhHM8Ln7Lr6d4f2ncTfwv9R8qS3uK83BMxWBfeFCxoxUrTtNTJFVWvZQN4LNCXzL
         gDOd6i8Gr7PctPsE4FvcBLZbxPC3K3/6xrEN4isUQlduVwc99lqAFzOCQKnf7ZGHpAuZ
         Mz4/VThefckNfpuCr256aHcsCjCwHQxrRvxq6HShrqhoTATEkqtF60dW7ynJ+/3TnBKu
         MHUsvQn5RbnnlzlymIpkhvWpVJe/s7tTMhiRcz2WMXR+V7FXUgIWmllKCH+PEH7Xj4ku
         U/upeP+4iPnAW4ajrt9Qa7P4bJKRVUlXcGCwwQ0ZLE96MBMPfdGH+2zYmOCnGMWPfEKG
         EKgg==
X-Gm-Message-State: AOAM530MUGCMjZ/qr89niaJt4EzaMDp/LOeqQzxblf8NPQjcVOkQuDMX
        UBZ/+a9NHNitBXkn82P/xgD0iT3ZLeBvLqUs4mKt1A==
X-Google-Smtp-Source: ABdhPJxOjj738nogRJo0/8+S11mLmjZ9RROKTTWqJgufMAjwv/PuRW560hU7CbGoKgbjldqG04qMMZK6zliXeHN5wrk=
X-Received: by 2002:a50:fe98:: with SMTP id d24mr6208341edt.223.1600812239432;
 Tue, 22 Sep 2020 15:03:59 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Wed, 23 Sep 2020 00:03:32 +0200
Message-ID: <CAG48ez3tZAb9JVhw4T5e-i=h2_DUZxfNRTDsagSRCVazNXx5qA@mail.gmail.com>
Subject: mmap locking in atomisp staging driver looks bogus
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this code in alloc_user_pages() in
drivers/staging/media/atomisp/pci/hmm/hmm_bo.c:

/*
 * Convert user space virtual address into pages list
 */
static int alloc_user_pages(struct hmm_buffer_object *bo,
                            const void __user *userptr, bool cached)
{
        int page_nr;
        int i;
        struct vm_area_struct *vma;
        struct page **pages;

        pages = [...]
[...]
        mmap_read_lock(current->mm);
        vma = find_vma(current->mm, (unsigned long)userptr);
        mmap_read_unlock(current->mm);
        if (!vma) {
[...]
                return -EFAULT;
        }
[...]
        /*
         * Handle frame buffer allocated in other kerenl space driver
         * and map to user space
         */
[...]
        if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
                page_nr = pin_user_pages((unsigned long)userptr, bo->pgnr,
                                         FOLL_LONGTERM | FOLL_WRITE,
                                         pages, NULL);
                bo->mem_type = HMM_BO_MEM_TYPE_PFN;
        } else {
                /*Handle frame buffer allocated in user space*/
[...]
                page_nr = get_user_pages_fast((unsigned long)userptr,
                                              (int)(bo->pgnr), 1, pages);
[...]
        }
[...]
}


This code looks extremely dodgy to me. After
mmap_read_unlock(current->mm), the vma can be freed, and the following
access to vma->vm_flags can be a use-after-free. Also,
pin_user_pages() must be called with the mmap lock held, and you're
calling it without holding that lock.
