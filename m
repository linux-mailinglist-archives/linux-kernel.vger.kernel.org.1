Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1C62CC82A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbgLBUnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388531AbgLBUnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:43:08 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886BFC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 12:42:27 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id q13so6822793lfr.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3btiNSHm6jRc+pdBtMLFUAxRzWlf/wPyv3Pzid5Qtc=;
        b=Z11LEqV8wdrsHfKnZ1gN+6MxuQLN4JBrl/ZQBEaq6vQOuLOGiyyvqkeCcPCYRhQDIv
         ZPmJT1ekDNw917/6qDlUXjz9Xu/yQOcMPNWuaxXaYoEorXu9QNfEuCP35vSG8m9tWndO
         8uCAyKVBZS5tHpQHBWAexF8LHzVQcFWUxGxD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3btiNSHm6jRc+pdBtMLFUAxRzWlf/wPyv3Pzid5Qtc=;
        b=oBlTh+pkdHJ5slodRZBiaZtDtYKTWtA3rnf3VqFylc+TC7Cx8ur/qqTFfsY+o/3p0/
         xoc/YdyM2JEmWOLEUC/KGEbnXjfTur5K+MFjwlygFVvJo46HduD5XOkS94P2nGzmUskz
         Mz3s9SVI+KwYfpIWf5JVzepfYdLWSrgRI0GSSQ5LJYbH2L/pGUGtw1TlygrZR1/g0vsM
         pFpTm3Mr6Vw8LJlDwbcjfX9H4NnIhEnypqZPeyuBHIM+C+cm6tANOs0pzKbsoNdMpe8n
         TG6LB5akNG0tSprvgPzHX/ddpw398m1gxqfe3njxNWa3NkfpT9sHsxclZO2wOHfGHycm
         e68Q==
X-Gm-Message-State: AOAM530+dlFoziUCv5yQBJXpwoKOXjvIFcGxtpoTVLc/Rp4uA1Y1bBYQ
        QTpThXGAhJCB0TAI9k/xz1tLW6MW0LXzEA==
X-Google-Smtp-Source: ABdhPJwL3swkcXDJlTt+V4w+oCuOgXG5Ukh4wjI3w7AdMq5GILHBdQeH52FpUt/GhvLcE4FMqJ3KCQ==
X-Received: by 2002:ac2:58d0:: with SMTP id u16mr1995500lfo.527.1606941745627;
        Wed, 02 Dec 2020 12:42:25 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 201sm809150lfa.190.2020.12.02.12.42.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 12:42:24 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id s27so6855811lfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:42:24 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr1907270lfy.352.1606941744281;
 Wed, 02 Dec 2020 12:42:24 -0800 (PST)
MIME-Version: 1.0
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com> <20201202021633.GA1455219@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201202021633.GA1455219@iweiny-DESK2.sc.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Dec 2020 12:42:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjiU5Fq7aG0-H6QN1ZsK-U3Hw1K310N2z_eCPPDTKeysA@mail.gmail.com>
Message-ID: <CAHk-=wjiU5Fq7aG0-H6QN1ZsK-U3Hw1K310N2z_eCPPDTKeysA@mail.gmail.com>
Subject: Re: [PATCH 1/2] uapi: fix statx attribute value overlap for DAX & MOUNT_ROOT
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 6:16 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> This will force a change to xfstests at a minimum.  And I do know of users who
> have been using this value.  But I have gotten inquires about using the feature
> so there are users out there.

If it's only a few tests that fail, I wouldn't worry about it, and the
tests should just be updated.

But if there are real user concerns, we may need to have some kind of
compat code. Because of the whole "no regressions" thing.

What would the typical failure cases be in practice?

            Linus
