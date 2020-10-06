Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47D4284BFA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgJFMtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbgJFMtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601988547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZBKb+A4AjD/YLqb4lLjroz5xjo40raS3WxNaMhMdzQs=;
        b=XynzfXc5tgNrJU4Xw2ObNoLkJNP8pV/+oWScsZwgC85YhfQsqGgLNIcg2eqG8W+k68TWpe
        xoBBPYBK5PvYMWBpMXV3yNwOWKpT6hK4hs1n6u5KTiooDbwoBO/b3x32WRoXNTa67wCpcx
        JFgWgCrB91Y+yvYVDhyrsW3XaXEL1I8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-SuT4vETOMFe72ZN3I1sGrw-1; Tue, 06 Oct 2020 08:49:06 -0400
X-MC-Unique: SuT4vETOMFe72ZN3I1sGrw-1
Received: by mail-ej1-f72.google.com with SMTP id s20so5772243ejx.19
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 05:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZBKb+A4AjD/YLqb4lLjroz5xjo40raS3WxNaMhMdzQs=;
        b=cWz1waW5zdaoppKZtOSmF+aKntsx+j2vFyoK2FgOBJufeayzpcHPO2OfxOWktXkSW3
         J/IFJ2QWyzzhfWRvjNsO+nF8LWhNSFwgeuipVNOjbZC6Wid95VuP50zQD7sxztbMkq0b
         8PIfgNTYqL/fI9p6xe7ZNrNm0Hr+2Ub379GXUbh+e4DE4unuHGTbUESyKIzxmTFQ3hLu
         XEJsEywHytUSZ1DJBbswAz0Oh8opC/aCC7o/rFqzl5CWWhJZ434Afq4dSUlJ4tA/mUou
         qWvt3ywgBN6/tIUd2vGv7D9e9iHYc3g2UNeZ2aJKeAjLloQrWel3yd9+IUCCYzMlPmt+
         soCQ==
X-Gm-Message-State: AOAM530W/YDtgPw4MiGW+x4FWPMlO5FHI3B3+m7qnToKeOGZnLux5DIT
        aKbM+wlSlVVDQvUvpfPrpTfvm6Aql5w7frU4qdaGXjRNIa2Sd/Jzipx+BE4aN+gW8B9lKini1+e
        R3FLbT9i8n732Vc4WhtOpLzge
X-Received: by 2002:aa7:c68b:: with SMTP id n11mr5061737edq.340.1601988543297;
        Tue, 06 Oct 2020 05:49:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/jjA5Z9ix4lK1yg5De40DAcoQzeacAmqcAPY8CNgcOSOdKWyNJHR/jV/h7IXoU5v8NSmzWg==
X-Received: by 2002:aa7:c68b:: with SMTP id n11mr5061720edq.340.1601988543026;
        Tue, 06 Oct 2020 05:49:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m19sm2018197ejj.91.2020.10.06.05.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 05:49:02 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.9-3
Message-ID: <bbd61184-175c-f1c2-d196-70b73145891b@redhat.com>
Date:   Tue, 6 Oct 2020 14:49:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

First of all sorry for this second last-minute pdx86 pull-req.

The main reason for the first pull-req was fixing 2 regressions
in 5.8 with Tablet Mode reporting seen on various laptop models
which has been reported by a lot of users, because this
regression causes the (builtin) keyboard and touchpad to not
work on these laptops.

These regressions were caused by the asus-nb-wmi and the
intel-vbtn drivers both receiving recent patches to start
reporting Tablet Mode / to report it on more models.

Due to a miscommunication between Andy and me, Andy's
earlier pull-req only contained the fix for the intel-vbtn
driver and not the fix for the asus-nb-wmi code.

This pull-req contains a single patch fixing the asus-nb-wmi
code. This patch has been in use (as a downstream fix) in
Fedora's kernels for 2 weeks now without issues.

Regards,

Hans

The following changes since commit 720ef73d1a239e33c3ad8fac356b9b1348e68aaf:

   platform/x86: thinkpad_acpi: re-initialize ACPI buffer size when reuse (2020-10-05 12:20:42 +0300)

are available in the Git repository at:

   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.9-3

for you to fetch changes up to 1797d588af15174d4a4e7159dac8c800538e4f8c:

   platform/x86: asus-wmi: Fix SW_TABLET_MODE always reporting 1 on many different models (2020-10-06 09:48:05 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.9-3

One final pdx86 fix for Tablet Mode reporting regressions (which
make the keyboard and touchpad unusable) on various Asus notebooks.

This fix has been tested as a downstream patch in Fedora kernels for
approx. 2 weeks with no problems being reported.

----------------------------------------------------------------
Hans de Goede (1):
       platform/x86: asus-wmi: Fix SW_TABLET_MODE always reporting 1 on many different models

  drivers/platform/x86/asus-nb-wmi.c | 32 ++++++++++++++++++++++++++++++++
  drivers/platform/x86/asus-wmi.c    | 16 +++++++++-------
  drivers/platform/x86/asus-wmi.h    |  1 +
  3 files changed, 42 insertions(+), 7 deletions(-)

