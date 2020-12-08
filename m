Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0EE2D3237
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbgLHScu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgLHSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:32:49 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F249C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 10:32:09 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id t22so21195733ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 10:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZM54iolf0NIBnlTpIg0weCrnfZMFH7sMy0/zmKYmnyA=;
        b=QFhzyPFNVmpiYok59DOMe1RBLDV0yzug03dRhZq76ksgefRCx3kA341Zk8/3xGwIru
         K+IgYfuLNFelin6TjpWW3fCsVBAe1X86PXvlpDEQHaWL+8wxFnjEygGMMGKfelINjfUO
         D6P0IcQbV2pd7q/lgx+48CJvFgkkpVAdyekk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZM54iolf0NIBnlTpIg0weCrnfZMFH7sMy0/zmKYmnyA=;
        b=MLB4l/YwR+dzFuS0FyMVR8RdIAZz6SWTRyXiZB6gZnzUnLEsx1HQMtvui8o/RmPBxi
         XemeD26TbO+nGgHqHv31tTMWqDiYPhT1+6prxxpOK8JB0YwPPzfPTP8Gp+1PQAsgiNzT
         +A9YPWQXcmNxY9VfJBHFCRxFLU0riwUD06ZR0eA5Cp7UYiVkrmFm3hvCfAgI6v6AZUGr
         XaJcxRRsSotrCa1TOTcA1JS02yUiGJQTu2EampwoSo0IUHdITSPkiFAKArhu7vTT4DqI
         xbsMQrW7Zfn2erqwIcAsc5Pnao/QHjuujsXwVJFMo3t33TetrBkMotPE+GTz3CshFt0O
         U42g==
X-Gm-Message-State: AOAM532a/op0VkBCkj36Z2Etim04vjZQeZuyNi9Pk28oJ5DtZirM2iUQ
        zcn21z1qU9wR0NcSxczRnMlHaBMp6MECLw==
X-Google-Smtp-Source: ABdhPJwbVveokGZra8fvkkk30gTcmfv7njIOeLyy0CaVJnpfE/1lfJVGl2o53Z41gPwiZEI470GjNw==
X-Received: by 2002:a2e:850f:: with SMTP id j15mr51120lji.34.1607452327363;
        Tue, 08 Dec 2020 10:32:07 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id r201sm1043786lff.268.2020.12.08.10.32.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 10:32:06 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id u18so25305947lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 10:32:05 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr4141572lfl.41.1607452325575;
 Tue, 08 Dec 2020 10:32:05 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2012081813310.2680@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2012081813310.2680@hadrien>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 10:31:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=R7uAoaVK9ewDPdCYDn1i3i19uoOzXEW5Nn8UV-1_AA@mail.gmail.com>
Message-ID: <CAHk-=wi=R7uAoaVK9ewDPdCYDn1i3i19uoOzXEW5Nn8UV-1_AA@mail.gmail.com>
Subject: Re: problem booting 5.10
To:     Julia Lawall <julia.lawall@inria.fr>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nicolas.palix@univ-grenoble-alpes.fr,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 9:37 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> We have not succeeded to boot 5.10 on our Intel(R) Xeon(R) CPU E7-8870 v4 @
> 2.10GHz server.  Previous versions (eg 4.19 - 5.9) boot fine.  We have
> tried various rcs.

So the problem started with rc1?

Could you try bisecting - even partially? If you do only six
bisections, the number of suspect commits drops from 15k to about 230
- which likely pinpoints the suspect area.

That said, your traces certainly makes me go "Hmm. Some thing broke in
SCSI device scanning", with the primary one being the
wait_for_completion() one - the rest of the stuck processes seem to be
stuck in async_synchronize_cookie_domain() and are presumably waiting
for this kthread that is waiting for the scan to finish.

So I'm adding SCSI people to the cc, just in case they go "Hmm..".

Martin & co - in the next email Julia also quotes

> [   51.355655][    T7] scsi 0:0:14:0: Direct-Access     ATA      ST2000LM015-2E81 SDM1 PQ: 0 ANSI: 6
> Gave up waiting for root file system device.  Common problems:[..]

which seems to be more of the same pattern with the SCSI scanning failure.

Of course, it could be some non-scsi patch that causes this, but.. A
bisect would hopefully clarify.

Leaving the (simplified) backtrace quoted below.

                   Linus

>The backtrace for rc7 is shown below.
>
> [  253.207171][  T979] INFO: task kworker/u321:2:1278 blocked for more than 120 seconds.
> [  253.224089][  T979]       Tainted: G            E     5.10.0-rc7 #3
> [  253.239209][  T979] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  253.256990][  T979] task:kworker/u321:2  state:D stack:    0 pid: 1278 ppid:     2 flags:0x00004000
> [  253.275552][  T979] Workqueue: events_unbound async_run_entry_fn
> [  253.290687][  T979] Call Trace:
> [  253.302491][  T979]  __schedule+0x31e/0x890
> [  253.315353][  T979]  schedule+0x3c/0xa0
> [  253.327688][  T979]  schedule_timeout+0x274/0x310
> [  253.379283][  T979]  wait_for_completion+0x8a/0xf0
> [  253.392327][  T979]  scsi_complete_async_scans+0x107/0x170
> [  253.406115][  T979]  __scsi_add_device+0xf7/0x130
> [  253.418974][  T979]  ata_scsi_scan_host+0x98/0x1c0
> [  253.431948][  T979]  async_run_entry_fn+0x39/0x160
> [  253.444853][  T979]  process_one_work+0x24c/0x490
