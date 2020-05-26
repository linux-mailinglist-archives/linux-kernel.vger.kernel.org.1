Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E051C6DC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 11:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgEFJ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 05:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728663AbgEFJ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:57:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9619C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 02:57:32 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 188so801513lfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IciAwSgUVdB2/0PlCfDzeZhlzx2IzeWzIis4PFV64U=;
        b=rjnasmRUS1qEdjQp+ja6ha+agOWNjFUJ0msq1PCXadJGzv7jxsQw6WX+NoEgi2nRWQ
         KCdRe7egxySgra2xJjU2E/AXfi0H7SNJVzEGctfHwMYVzWtkPFNj62uxoq3xhoRsr1Nb
         r3OhCQW9bCzOSwwCvogQnjH0NHyzKOXeCsqr4Qha1IkNlOFtq9X1SnfpNQqWE+MWQdKv
         G3UyZzqao+FN4/VlQPr4Jy/EyIAFIKuihtkJ0swRQTBVAVUNmgGrTF1xtH4wmBwyCus/
         S/+wx9Wl1EaSF62yyCN0rVRaw4bmGSaj//EWLvwNBXkV5M7+adjdhIC/5VMpESg6YA1Q
         27BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IciAwSgUVdB2/0PlCfDzeZhlzx2IzeWzIis4PFV64U=;
        b=iWqthbWhBMB5pxa0bra7TT4NZGpi0rMLP0bKQSdDp/lNWabICv7zFK2+SNoCSMS4bg
         lgcI4uy22ZzXcAZE5HORvRVcLzdDJD8Aj96aAq6rJEwPzX94cReivuRFM9h8qMw0EyOC
         eo2EEXhMD1kPXvLXBz6tgfN/vy0juODOynBbw1puzLYAxhR/isvl37sgbNq/8DdOJM6Z
         1jqAw5ZemknI5CGObId35Y9ytE4tsY3UATVO4Odvf29MM42thN44LrPZlytZP+r0UfTo
         HNuECdsQRrlDqMM5Edx1fq9ZTFzm1racNKi9jyyWsUegtYs4y9GBlpX16bj172nwhFG4
         4/bA==
X-Gm-Message-State: AGi0PuYiwx3skR3JUHB2WNiICqyD9YJ84VHqDiIZSkjf8B2EBM3evGzK
        6umgXi72RVVzX43ssCTGWbl0X9+vMUIlcXMGmQafCQ==
X-Google-Smtp-Source: APiQypKjKckRZENGEavMmGfKLuKsPiGZebpMxZI0LFDcf1uG4zlU1bqJhKI4tYpjLuic788pKPSvUVEiOIwiVaqSoXY=
X-Received: by 2002:ac2:5988:: with SMTP id w8mr4606822lfn.75.1588759051401;
 Wed, 06 May 2020 02:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-11-maco@android.com>
 <7d73bafe-5228-b02e-5b53-4a41543aebe3@gmail.com>
In-Reply-To: <7d73bafe-5228-b02e-5b53-4a41543aebe3@gmail.com>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 6 May 2020 11:57:20 +0200
Message-ID: <CAB0TPYGKmbeNt94CSMhXd0EuFpSM14DEYAwoGdhY79s=H9o1+g@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 11:44 AM Michael Kerrisk (man-pages) >
> Can we have also a patch for the loop.4 manual page please?

Ack, will do when the series lands.

Best,
Martijn

>
> Thanks,
>
> Michael
>
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
