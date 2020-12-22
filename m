Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2DE2E0F74
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 21:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgLVUjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 15:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLVUjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 15:39:10 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C3C061793
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 12:38:30 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id t6so8029007plq.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 12:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=w7wUorTulI1SLGLyUAtcsZM5JvELPWd2Jp06S7SjCVY=;
        b=ZNsgbNsRLxQLY7+11c14jHqKYzrHQmsqrg+2m3ddf/Ug+scMbC5go73SdBpHMpQPyB
         FJvf7yfTrnVexb1ow0kk7CQzb2GRgaAKJLzXYhW+AMwQoJT8XPclFaqDzu06DNB+CE5b
         gpM3g+Xh7axYHWU2/IgxH7oBU0Zn4r0jSYQmlxCZtrm0DZiozBRJdv/1YToFSbMoo2Id
         u2Eg77AGoZCB8QKdLxHb08aagEkZ3b4wLNrs2/eTCpNxNU5wZ4HEbmxT14k41CXmXYhI
         2KGtcBnabjtrtI/HH4vQtz7s91OwZtX1Dq3vbbQGyKuJJGyLQWJg94hsYWuf/v3eusrS
         lOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=w7wUorTulI1SLGLyUAtcsZM5JvELPWd2Jp06S7SjCVY=;
        b=dRgVdqKQIorzl1Tn8Cz1UcGnn3yGwt7bRyTZ7ALc7O73ptpd+JLWt0QfIngPGuncQ+
         ULAO029+Z81cke/skyTjYZJTUsiGH3Uq4frVB9APIZbUOMvUvl/vmUh3esaTZb6/Z1mB
         jLt5Jhz4OHQr+5peuLdNzod46XvOZxfZ1lHMJoSJ4p1/pfrsXQ/s8Ec+WGu4+fThtK1t
         bQQ7EwMvfjWKOCc5mdCUj29610izN1G1yGUqQDEr0H6U/+iXv7tiUo65HKIEZhoTp45n
         B0W9eVohi0n3Z3ajYopfmgaLW6sSD/SHxD3au8oU0/aJqYsRiTRB+0Qon7bgYSrBHQaD
         RoCg==
X-Gm-Message-State: AOAM531L4fLIRWiIdbFMiqO+L5yI/Zm86tVrL2ZuP61Wd9VMAktYtlP6
        ia5zoHhQ5whdDqQRnOAACLMnhg==
X-Google-Smtp-Source: ABdhPJyrUEeQS+6tCykxcXi4wBUYC0ygmbARaXIsYIp63WsLg3f/qvwDb9rwYmvpLbj3fuqqf4mwnw==
X-Received: by 2002:a17:90a:301:: with SMTP id 1mr23852780pje.195.1608669509537;
        Tue, 22 Dec 2020 12:38:29 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g30sm21624684pfr.152.2020.12.22.12.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 12:38:28 -0800 (PST)
Date:   Tue, 22 Dec 2020 12:38:28 -0800 (PST)
X-Google-Original-Date: Tue, 22 Dec 2020 12:38:26 PST (-0800)
Subject:     Re: [PATCH v1 0/5] dm: dm-user: New target that proxies BIOs to userspace
In-Reply-To: <20201222143616.GB12885@redhat.com>
CC:     Christoph Hellwig <hch@infradead.org>, josef@toxicpanda.com,
        bvanassche@acm.org, corbet@lwn.net, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, song@kernel.org, dm-devel@redhat.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, agk@redhat.com,
        michael.christie@oracle.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     snitzer@redhat.com
Message-ID: <mhng-26d96d8e-77aa-415b-a8ee-518a0e91b6ef@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020 06:36:16 PST (-0800), snitzer@redhat.com wrote:
> On Tue, Dec 22 2020 at  8:32am -0500,
> Christoph Hellwig <hch@infradead.org> wrote:
>
>> On Mon, Dec 14, 2020 at 07:00:57PM -0800, Palmer Dabbelt wrote:
>> > I haven't gotten a whole lot of feedback, so I'm inclined to at least have some
>> > reasonable performance numbers before bothering with a v2.
>>
>> FYI, my other main worry beside duplicating nbd is that device mapper
>> really is a stacked interface that sits on top of other block device.
>> Turning this into something else that just pipes data to userspace
>> seems very strange.
>
> I agree.  Only way I'd be interested is if it somehow tackled enabling
> much more efficient IO.  Earlier discussion in this thread mentioned
> that zero-copy and low overhead wasn't a priority (because it is hard,
> etc).  But the hard work has already been done with io_uring.  If
> dm-user had a prereq of leaning heavily on io_uring and also enabled IO
> polling for bio-based then there may be a win to supporting it.
>
> But unless lower latency (or some other more significant win) is made
> possible I just don't care to prop up an unnatural DM bolt-on.

I don't remember if I mentioned this in the thread, but it was definately in
the Plumbers talk, but I'd had the general idea bouncing around that it would
be possible to write a high-performance version of this using an interface
similar to the one provided here while relying on io_uring for the
high-performance userspace.  That definately won't work with exactly the
current interface, but my hope was to avoid writing my own high-performance
ring buffer.  My worry was that it'll be too tricky to map this all to
zero-copy, and I guess I forgot about it.

Now that you bring it up, it certainly seems worth taking a shot at.  We'd
essentially have the best of both worlds: userspace implementations that want
to be simple could just use read()/write(), while those that want to be higher
performance could have their implicit ring buffer.

I'm currently trying to put together a benchmarking setup that is of sufficient
fidelity that I would believe the numbers, which is really why I don't have any
performance numbers yet (no sense posting numbers I would shoot down :)).  I'll
try to remember to take a shot at an io_uring based userspace (probably with
some dm-user interface modifications) to see how it feels.
