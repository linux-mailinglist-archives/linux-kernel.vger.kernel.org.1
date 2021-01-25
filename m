Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E374B302C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbhAYULY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732240AbhAYUIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:08:46 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBE3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:08:01 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id a12so1771074qvo.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EsmJo5oovzpiXmuqZ5cSfYBminZGw3Bg63uNHCPKszo=;
        b=ENSG3oZS14wDgHi3pz1j8HF5s1yaseO5q088aeOljcRi0mhRWG8GFqZoY64FFpGKHz
         Ehh0As5KPGIsykN2tP9K/cW1Mx7tYXboztSO25LumKZlfsa04jw093aDne2S45EAkTvW
         8KTMdHG8I0f+yryjY1/p2OAICg5Q86DPpl9Zzax2POqYCRsqnhDlGmzNevSNqj7S8VmM
         2hNb/FJX2dZ1IJUcbPSckd64Tj+kfkQsVh7+shwh6EMgI487xNNck/TbjNvLzt0itjpw
         a+ekZZzaLHxe8KbdSqqedb9D3a2VpLuS2sUl9v4h8Yc6QRZwZf6MHNgysvPGgTuF0hup
         r64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EsmJo5oovzpiXmuqZ5cSfYBminZGw3Bg63uNHCPKszo=;
        b=Zwhaof3O0yk8cvq+qG4PZDy3SA7x8liGZjvOhr0Y1MEIMf96lL5itI7aoFlMpApmWJ
         4+U+gr5hVf0TY0JU/Rh+31gtK5oW2yWhUSzonRGLqYNZTOw2lAxCB1HCd9/YDtFJ2fJ8
         yC17CQR1MsBujh7fLbblfu2npZ95Qw+jfbV328Glo3xfmtw3aqA+If2gAopJQrAkBuJI
         oHKcOp7MC8GVsStK4bY+ShLa9gBztAtrJwAmuUQbs6tnEfcw3x0JSKxb9w75o4mSOoy3
         TDO+1WqYNRl1O6JYJy7iNlzcycMU++VTs7GGJLzYmxoKcNtkyEwUrRqFPOreZtrLSo2k
         4lVw==
X-Gm-Message-State: AOAM533dOKhCc/AeAZegI8tNl5Z/NsKYZ6hM2L1ktcDwk4jfQQiFO6Gf
        C8iec576rJKPWTaa283EDynZvI7MRjQ=
X-Google-Smtp-Source: ABdhPJziezI5V9r9KODuMOvf9In7Hp3LFS7fHTA+FlCc+wSy66UtmD7QLxk7HAhDdwFOow6ERd/5HLV08S4=
Sender: "oupton via sendgmr" <oupton@oupton2.c.googlers.com>
X-Received: from oupton2.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:136])
 (user=oupton job=sendgmr) by 2002:ad4:580f:: with SMTP id dd15mr2428478qvb.40.1611605280552;
 Mon, 25 Jan 2021 12:08:00 -0800 (PST)
Date:   Mon, 25 Jan 2021 20:07:56 +0000
In-Reply-To: <20200914133626.hlsvu5kces3wsirr@google.com>
Message-Id: <20210125200756.1249239-1-oupton@google.com>
Mime-Version: 1.0
References: <20200914133626.hlsvu5kces3wsirr@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: Re: [BUG]: KVM: arm64: Fix symbol dependency in __hyp_call_panic_nvhe
From:   Oliver Upton <oupton@google.com>
To:     dbrazdil@google.com
Cc:     hns@goldelico.com, linux-kernel@vger.kernel.org, maz@kernel.org,
        sashal@kernel.org, Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> That means we have two options:
> (a) define __hyp_panic_string in a different .c file in all pre-5.9 branches, or
> (b) revert the backported patch.
> 
> The patch was needed in 5.9 and should stay there. It wasn't needed in earlier
> versions because the symbol was being kept alive by another user. It did "fix"
> the inline asm semantics, but the problem was never triggered in pre-5.9.
> 
> Sasha, with this and the GCC bug in mind, would you agree that (b) is the
> better course of action?

Sasha,

Any chance we can get this patch reverted as David has suggested? It was
backported to 5.4 LTS in commit 653ae33b030b ("KVM: arm64: Fix symbol dependency in __hyp_call_panic_nvhe")
and is causing build issues with a 4.9.4 vintage of GCC.

Thanks!

--
Oliver
