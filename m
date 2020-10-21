Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41897294B07
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409462AbgJUKE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409397AbgJUKE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:04:26 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697BC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:04:25 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id m11so971816pff.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=c4CgoA3uOwuCr6KU0k3hWITFaxS6qaraKmWsHEdQhco=;
        b=MqvHRVZiQIdY6WKux6bIJxrvQVnEjCV8A4u3M2nSM8dRjWRdXtWVkC31qhqccIzZzl
         2IZelX9v7KTcHiKwpiOKSHDpbfkFikgtttK4H05Ei8oJ4fFySgM1XCoxllTJJEKEuj04
         1z51Sb3JWdIQmp7TlJKC0zy1gjlagiY6oDenhnkSqWnYgQjgYZ+fsDyPbWVEAFVEJNwm
         3hdUU+/qEaR405p1BkPM4w6f3HR0Uv1Y7Arm9SapSy2y39vtUYVAHuN/kyoxOKeCo7Sf
         aOcMDLHz6XbpZha5EVQPFDPp/UtZjpwqfw36fPOVWLa9V/b41oWNC2jXioP87Q5hvgWt
         3XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=c4CgoA3uOwuCr6KU0k3hWITFaxS6qaraKmWsHEdQhco=;
        b=OkCtk4sZqW/f3A4lVA0lTf7l8oL6cIGT60jcB+c6fmt94DdqkUwnvMxe9ZGJuWi8dX
         bdoH2CBDXOOR5gUqoB2/BN5hwrd4EKlP+dz//fBe5ZpgGUPNdg/e15zA33+BE9l0ydmn
         bkWP2X9kLT8xXwtpkPqObSqJMIb8D5x1SSYdt8cwLhPxC6PBca6TC3QQQHWLSwaXyoQt
         pbXP4gPcFi59ZhxbIK4d8FANOIoyn4iDcM5tbULS1E2hGHzLciZXLvxUL2GATFIX5FUm
         qZ4+uysd5pI+02i/RhbDsC1R8POCBju2c7Zizh8Z0KQFr1rggiGb+fjZWfp+bbgnI1ah
         GJCA==
X-Gm-Message-State: AOAM533986GDbywy6aEQ/eVwxll+im4svxH4EcIbJv2hGXL9/R6iFKu4
        9OuGQbGvIB+YZAFOEUBxMrXLF6FZGFhr54qX
X-Google-Smtp-Source: ABdhPJx0IttQCRs+PAdvXuWAbiLgj6p1WBRQnJIH6pqMrFeTRASQk6f2ZlcsMCYnX5JyV+bcZWIqO1tjqOtQxNRJ
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:a62:75d6:0:b029:152:6ead:63fa with SMTP
 id q205-20020a6275d60000b02901526ead63famr2824816pfc.38.1603274664428; Wed,
 21 Oct 2020 03:04:24 -0700 (PDT)
Message-ID: <000000000000da35b205b22b7886@google.com>
Date:   Wed, 21 Oct 2020 10:04:24 +0000
Subject: [PATCH v2] power: suspend: Replace dpm_watchdog by sleep timer
From:   <josephjang@google.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Oct 21, 2020 at 4:09 AM Joseph Jang <josephjang@google.com> wrote:
> >
> > Since dpm_watchdog just cover device power management, we proposed sleep
> > timer to cover not only device power management hang issues, but also
> > core power management hand issue.
> >
> > Add sleep timer and timeout handler to prevent device stuck during  
> suspend/
> > resume process. The timeout handler will dump disk sleep task at first
> > round timeout and trigger kernel panic at second round timeout.
> > The default timer for each round is defined in
> > CONFIG_PM_SLEEP_TIMER_TIMEOUT.

> Let me repeat the point that Greg has made already: Please don't
> replace the existing watchdog with something else, but try to extend
> it to cover your use case.

> As it stands, the patch is not applicable IMV.

> Thanks!

Thank you Rafael's promptly response.
Since dmp_watchdog was implement in drivers/base/power/main.c and it use  
stack memory for timer struct.
It is a little bit hard to use its API in kernel/power/suspend.c.
And from the call flow, we prefer to start/stop watchog timer in suspend.c  
only. It will also cover device
power management as well.

If you don't want to change Kconfig, I can keep original DPM_WATCHDOG.
But it is not easy to extend driver base API into core power base. Am I  
correct?

If you have some suggestion, please feel free to let me know, I will follow  
up.

Thank you,
Joseph.
