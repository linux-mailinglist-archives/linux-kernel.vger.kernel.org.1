Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB61BAF97
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 22:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgD0Uet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 16:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgD0Uet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:34:49 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9EC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:34:48 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so19085451ljb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4dBzvzaYSmwe+gN0bTSxOguahuOK70qElh1uq5WJTY=;
        b=uCMDj0u3BZLTUsCCRaRdr9xL9loSXFm7wGZEF7Ya1WoOmLRGy+nA1AMMNXR/ILJZVw
         z8y4K4UI1gIuel/XaDugIU1GIeoXHJYXmAJ4/SejjNBnmMN8IxPFUZt/FnZg1mBDJnmC
         8rkdL7wa67XKNfQhX9nVJln/EqqVnmaen/3TUFAldcbLr+xTor60OpBWNATy369XqToC
         e3/tNcque2dmIaoRPmusn3BazbMH3ZXWjAcB/IKIMqzXaw8KsmhUm8dkDv59SBstlAca
         whboOeW+ydNPEEjw6fPQutYz4fkfXkJ8NqlM4WJcMSF31Y/p8hOSDl05n7ZqzNrJSHFM
         UbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4dBzvzaYSmwe+gN0bTSxOguahuOK70qElh1uq5WJTY=;
        b=p7B/oYCm4rL0DPSzwATbeZsB3eM5l0nQnFO0/gX/Cr22mm+qBAfD7We/NjAI0P66Qm
         2BNwLayqaeBtY0s0EdCV1ySNvs2krEFbkBndk2bQAf66KNr69GdgwIwR0wFLum4PEW7A
         KKCoDAdZjAzNbbDjH5tLKDVp3nZmHvPUVdQaIeh0l16T16n2+rw24OGohHyC/wOL4PcB
         ZEo9fs29nvYCwBMUkc3FhtuM6skmqbRf8Ib9X+pvh/cZEX3QLHkJemaFqVp//mbBvXaw
         M2b9J4v3q7yf5HtDJLJKX3PORxXSYcjrNY76OEg6q6gPvwEEORRNzxDgR5gp1U/21+Uc
         tctQ==
X-Gm-Message-State: AGi0PubjugLqd6bWTsU0DRShtTSaV5H0uzmK+GPszEx4qY9GVn8mQCOs
        MBvW2Ui5UsdOU2a+/0FT2ioEhoHnpAoqPwdB6SC8aw==
X-Google-Smtp-Source: APiQypJ0k6z02gQOm9RJYPAfBsYkzEtyCANSfITp19EEVZRfK4V472Q83W1EunxwohzuVywk3Dyj5f6RuGciuIt8I1E=
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr15758173ljk.134.1588019686261;
 Mon, 27 Apr 2020 13:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200427074222.65369-1-maco@android.com> <20200427170613.GA13686@lst.de>
In-Reply-To: <20200427170613.GA13686@lst.de>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 27 Apr 2020 22:34:35 +0200
Message-ID: <CAB0TPYGZc_n-b5xtNsbJxEiqpLMqE=RcXGuy7C2vbY18mKZ6_A@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Add a new LOOP_SET_FD_AND_STATUS ioctl
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Apr 27, 2020 at 7:06 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I've just been looking over the loop driver for other reasons,
> and noticed that setting the block size still isn't possible
> with LOOP_SET_FD_AND_STATUS as far as I can tell.  Might that
> be worth it?

That's a good point, I didn't think about it because that path is no
longer slow in our setup, but I think it makes sense to include it.

> Also maybe an explicit direct I/O flag, and maybe
> enough padding with a future proof flags bitmap that we can easily
> extend it for new features if they pop up?

Sounds good. I'm thinking these flags should be separate from
LO_FLAGS_; even though there is already a LO_FLAGS_DIRECT_IO, as far
as I can tell it can only be used to tell whether it's enabled, not to
actually enable it. And it would just get confusing if we add more
flags later. Maybe something like LO_FD_STATUS_FLAG_DIRECT_IO ?

Thanks,
Martijn
