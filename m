Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C982F718D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 05:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbhAOEQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 23:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732972AbhAOEQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 23:16:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4637FC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:16:05 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o10so11253761lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63J/tLzLebR+d+sU8VZA5VzH3xNPW+K+cgzDeTPBen4=;
        b=CdC54e4XPbsZ3GtDLtnS0hEk8yJVFWCjWeEE1NTkSB0i2IQrdp9OLp6mZJPcsM1BNL
         sJp/79LSbNj8NdFh8B2AG8NI0nt5+iIzCgFM55u/HovT+b6rocnqOCKV4MvZbYzWcof1
         cFLxmg6G7B4nxXs3a2FFm8vXc9U6a9mpM5dBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63J/tLzLebR+d+sU8VZA5VzH3xNPW+K+cgzDeTPBen4=;
        b=LU7oSTKJo80zkUPKNGczSJ+CfUl6pYVJkYJYhJ7tSwSQGS4qW01PL9sgkrCGjBKTVW
         VzVOSARHTdH3YgCt9NbVQEIPkZpKZrVZmFPf74tXoyhk7fMSd5+0DX6UTHQSAuOaUO5Q
         pi/t2/sUho9ov2r/2eNwDWdNocID6vgGkvFduQwQWIjJCTuTpuJn04UCxFV2s/eJ2vCk
         6g8McMhGq4IrK9zbSibNPmt6YyTCvJKj41nNAOS98gztoi4acfEVxkwyzobhKhoc/V1Y
         wYut4t81VVOO437wg03kX3Yg9k300tLtvnmPdRc4/W5XXdsQ2OBLBhULS7t0z2mSBLXL
         WX+Q==
X-Gm-Message-State: AOAM530TnAujWCR0y+yPXx9gkiNs2qMFe9IXmN01KQlcCfLC9NqPh2oS
        9DNcEsE69N0ET/qOA04X6v87IfJp6UvrQw==
X-Google-Smtp-Source: ABdhPJyHMM0Twpu8Wm/BZ0QFiHGjjxlEhAnLh+E8Ttg36EaTct9+INu61h/VW/9BOX8RykimRhru8Q==
X-Received: by 2002:ac2:44af:: with SMTP id c15mr4592033lfm.657.1610684163465;
        Thu, 14 Jan 2021 20:16:03 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 29sm754052lfr.304.2021.01.14.20.16.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 20:16:02 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id f11so8957105ljm.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:16:01 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr4400396lji.251.1610684161408;
 Thu, 14 Jan 2021 20:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20210114163206.4a562d82@gandalf.local.home> <161066015368.19482.10094410867880595092@build.alporthouse.com>
 <20210114170137.002763b3@gandalf.local.home>
In-Reply-To: <20210114170137.002763b3@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jan 2021 20:15:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgqPnjOUa0aDRHXC0UAePrM6kRUD9gR4g2x0mq91FD4xA@mail.gmail.com>
Message-ID: <CAHk-=wgqPnjOUa0aDRHXC0UAePrM6kRUD9gR4g2x0mq91FD4xA@mail.gmail.com>
Subject: Re: [Intel-gfx] [BUG] on reboot: bisected to: drm/i915: Shut down
 displays gracefully on reboot
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 2:01 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Thanks, I take it, it will be going into mainline soon.

Just got merged - it might be a good idea to verify that your problem is solved.

            Linus
