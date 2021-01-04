Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2632E9CE4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbhADSSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbhADSSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:18:10 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A732FC061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 10:17:29 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o13so66601972lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 10:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nxs/g6TU6k+3ccAxWF3RmI3wwmsghsbxSfcyPJnj/yE=;
        b=aU3EveDTHVgrRuQoFlRYqzfsZL5PVBtqBHAghkzv90SxCacKkYgqK0oz8N2aFLuSWv
         o9YlFu+tAfUMqjhpA9cSRvWsPTjus8T+Og3w33OQsA3aR8vIGht1AH7jvtAP8kPvzaS/
         L86nkINnFDxWEccDGvypL8FSTXbiRq6Kack1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nxs/g6TU6k+3ccAxWF3RmI3wwmsghsbxSfcyPJnj/yE=;
        b=gv7/tiNKYGw0KkFLX4M9U6pRWx0x7HnnUkX4EZH4jcob6J6uTX9IHLI1ysOlamKBn1
         Lk5PlAEaE4KJytHSB3OL3C7etloicCyS8UEA6ZcaKrU2By1dSHzGbnHOCpDCCCUWfFXB
         WyyBkkf2hRnWX0YQM4IAJP1kUq9jSdscXeEb4Oh6jJKhDAjArTrb5659s0OrGO+Bv9n5
         /PPIKhdXpR8uU1GAy+RqBqklR9EAYGTxfJlaO0nlVF96xI0IYoQDCMMpdis7SKy7X7Zy
         zU5qJGzh24w6EKdern6iuofHZDPo25YwNd+iZyUMpX21wVrlU0gheqL7REZ0wdWWNIBq
         jcXw==
X-Gm-Message-State: AOAM531Wm2PHpWILDjb3RZo6cmuUD+10yhdhV6DfxQ/JZT9nsD+ffVWO
        SCdlRfoHbN/fMPTcvDfhY00aY5TDGl2Gkw==
X-Google-Smtp-Source: ABdhPJwIXc0Lmju5P51dROxKNb5fK5zYNdcs2vxB6gAh+mTTngP8rX1t768D0W4GV6fFSMlemjpOCw==
X-Received: by 2002:ac2:5c08:: with SMTP id r8mr32290024lfp.12.1609784247491;
        Mon, 04 Jan 2021 10:17:27 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id v7sm7346883lfg.9.2021.01.04.10.17.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 10:17:26 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id m12so66551677lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 10:17:26 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr34245988ljj.465.1609784245871;
 Mon, 04 Jan 2021 10:17:25 -0800 (PST)
MIME-Version: 1.0
References: <365031.1608567254@warthog.procyon.org.uk> <CAHk-=whRD1YakfPKE72htDBzTKA73x3aEwi44ngYFf4WCk+1kQ@mail.gmail.com>
 <257074.1609763562@warthog.procyon.org.uk>
In-Reply-To: <257074.1609763562@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Jan 2021 10:17:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFom7xhs5SHcWi1toxrBDwmyhBmVmGOqn9e3g6+bf5sw@mail.gmail.com>
Message-ID: <CAHk-=wjFom7xhs5SHcWi1toxrBDwmyhBmVmGOqn9e3g6+bf5sw@mail.gmail.com>
Subject: Re: [RFC][PATCH] afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=y
To:     David Howells <dhowells@redhat.com>
Cc:     Daniel Axtens <dja@axtens.net>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 4:32 AM David Howells <dhowells@redhat.com> wrote:
>
> How about the attached, then?  I

That looks like the right thing, but I didn't check how the name[]
array (or the overflow[] one) is actually used. But I assume you've
tested this.

Do you want me to apply the patch as-is, or will I be getting a pull
request with this (and the number-of-slots calculation thing you
mention in the commit message)?

               Linus
