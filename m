Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27961B98CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 09:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD0HmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 03:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgD0HmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:42:13 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26C8C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:42:12 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j3so16452329ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ehox1gX7hX0ggxAjlHGH9e/EgYEXyAff8qtxqRj38E=;
        b=dBGgQhGDOqyw7ZfK7WrM5BhDrademhFoJloRMzO9PYcWFnW2Gu7dItBRntMIfCTbzi
         V9I4E+zLq5XxgA4GReqU23XKoUe4WUAnkhSg41RhlPWYc54h7FCLnUZDd752xEGBvfhu
         eRerSeC8dJZaiBVBUsTP6qd4fJmhbDOtH3KgcpH0ghdNA1SUU+Jvv8rywvDDcHPt0wAn
         AWK03yRby4J8TRCIUkV83VHB2mK5CC2uSYSgIqdME8KwVn5o0ySuBiM8MzhkHVt1HPYq
         zE6KkDjHoozJmnXu0j3Yr1eJ8OETPS8McgtOFyz2j3B5UstMng1houybZQQEtbnS77br
         V/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ehox1gX7hX0ggxAjlHGH9e/EgYEXyAff8qtxqRj38E=;
        b=pOUTNyCryAlYzcOvQlZIKeAgReQBTVuQCyff6YOumt2eYTQWpcKzvr7RjDi709sAXA
         g7uzHzM8g0fqlnG7Ss6lRTPexRtO+U2A3HN4Drdg8YIeFD5SJaWEyZaGGxMPCplFNiv+
         XHRqvOAFGGXh5YDODCMkEzlW7OVdwAja1r/anrKAMTJvIEbwpjx/rT2zF6Aahgm0A0nU
         zcKX/9aS/NiQs/1lf2jtz0vLIlyByZmtKDOXj46ZGlAtG5R/uZo+g2503i8HhzrnqMIp
         GIGLkVhVhYtGbkM6Fcc0uREg37QTpqQ1bAOGcV4Ox9mEYerjQoHgNwf8RsEHGkKg6UdN
         ynjQ==
X-Gm-Message-State: AGi0PuZBcomIsAax/ZUCJqYJCnBRGrEpn+tVTFjsddWoP6lBkOFqFOYl
        lCOA3c+NVJjsXkumAfOBvdHWoI6XnkNqktpcRTkQWg==
X-Google-Smtp-Source: APiQypLWDocP+ioptzSAmG+w1P2rb9ZNZ9N/t8QaMahiaDxyOL9SjMrefaRbpVk2W79vbXv+V3OR8ReSkL1xxUKDWVE=
X-Received: by 2002:a2e:864f:: with SMTP id i15mr7593765ljj.179.1587973331290;
 Mon, 27 Apr 2020 00:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200420080409.111693-1-maco@android.com> <20200420080409.111693-5-maco@android.com>
 <9eaa4dc8-cd8f-a4e9-e83d-f49f8b00ec0e@acm.org>
In-Reply-To: <9eaa4dc8-cd8f-a4e9-e83d-f49f8b00ec0e@acm.org>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 27 Apr 2020 09:42:00 +0200
Message-ID: <CAB0TPYELcpqcTB1Gc4-qszs2v4ywx+b0ejBkdSoikUXo9VMoQg@mail.gmail.com>
Subject: Re: [PATCH 4/4] loop: Add LOOP_SET_FD_AND_STATUS ioctl.
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 5:10 PM Bart Van Assche <bvanassche@acm.org> wrote:
> Should linux-api be Cc'ed for this patch or the entire patch series?
>  From https://www.kernel.org/doc/man-pages/linux-api-ml.html: "Among
> other things, a primary goal of the list is to help answer the question:
> How do we even know when an interface has been added or changed?".

Thanks for the suggestion, will add linux-api in the next series.

Martijn

>
> Thanks,
>
> Bart.
>
>
