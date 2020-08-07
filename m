Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6ECF23E6A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 06:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgHGEVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 00:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgHGEVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:21:45 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00938C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 21:21:43 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k12so667519otr.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 21:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qYITFFCTzMl0auXcN7JXwxoK9jsbfx6P4qD79kPDag=;
        b=Dl6DPgFOHHFyANsAY/7D1H+mdq6mnw+q58TToNxEYwXigHMrDW9DAs92o+4CRa8LTg
         qPG0BgKBKWE2cLaO6NLB8++dbF72BSsDNNleqg8bUroBBXPYFcOonhOiLVjr4GP/0hcc
         Xh57sMvhvEHQ9rqxNKzpbPbEtyacfksJBrnW9wRjooqSDrsMcqK9LpyzVzIqiTa+nMhR
         1Dxy8z/O4z9tvv0rakFwwDBYdmh9v+Fsxz3Uc/xuBtf8MPov5Lr6Fq8scDzta1toPZSs
         h00r8Eq5eFFJNUnEnD0Hinj+o0b+eoY8o35ouNfzPYRxx8LVteWervHcEa8yfxPifJ0k
         UHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qYITFFCTzMl0auXcN7JXwxoK9jsbfx6P4qD79kPDag=;
        b=tty/6aBXflPAQhNrC61uFBk+UTboUUQfUVIiVkVFCmGl/qwvCzShuVNh6ntRU2GqKL
         N95Gs9KmtdU7ynNdztB92QFEfHKKQ1/yLKTHY2uRannX8TjatGstSgccxfTEjXtSvJKW
         R2xpxdHVh5MpY2GVcVMSMWOHM3i65IsYxRwUl7r6TdF0LwXg7mkucWfGLLgCXDkkHQUO
         /vUaWLxLGi2fDDUqLp6AmNq4+5AJfuwnpHTuvC+a31f+KFBLOlnbE/5j/ga18UaxVIaq
         6c0gjOhLy94UazbLQX2OSH5UlhwAHw8rgEpKdClq9qWnN+Pp28SUGvfxHJTXg7veICQw
         AyXw==
X-Gm-Message-State: AOAM530/EoPmJyl7mY8hLCMInGLEEXZxWmSG/pX8I3WMDVAErCIaNg8M
        Kq50RA5QuYxmNW2rvRer5qGuaF7cEVQDwX7gcZTOBQ==
X-Google-Smtp-Source: ABdhPJziz4H+PEjaToTzzs/d94ISwILYb83vuyTn8xkIO3sD5OvQC2HthHapoZ+3GWgcAN9L6/CmUkAfuoazsdmmaEU=
X-Received: by 2002:a05:6830:3196:: with SMTP id p22mr10784830ots.102.1596774103264;
 Thu, 06 Aug 2020 21:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200807033248.8452-1-rdunlap@infradead.org>
In-Reply-To: <20200807033248.8452-1-rdunlap@infradead.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 6 Aug 2020 21:21:32 -0700
Message-ID: <CALAqxLV8vJVd+RN9WO1i=-ytuA643RmM8N_KxrfeZFVKiviRoQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: time: delete repeated words in comments
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 8:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Drop repeated words in kernel/time/.
> {when, one, into}
>

Acked-by: John Stultz <john.stultz@linaro.org>
(I'm sure I'm to blame)

thanks
-john
