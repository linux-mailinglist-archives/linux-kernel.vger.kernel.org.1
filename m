Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BD92C4843
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgKYT1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgKYT1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:27:04 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA961C061A4F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:27:03 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id r23so1077857uak.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbHWiqal0hTnnP0+s/LzA+vytzA77Sj1yZGY5laK5Mo=;
        b=bPok7N0lQn8HawChGhsoakYuwCJGVv+1qvsPy3DCBQinvN9qAKU6rmDN2+UTxrdqpS
         7R08fQSZZT1oEwe16U/Rzis1FttPkr5y6H0xH1uC5YpiC3EjKKhYDMCL+WqYQIU+/vVb
         oxBMRoPt5NBNwOZXcirj0UkHLdmnZZu8RpCNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbHWiqal0hTnnP0+s/LzA+vytzA77Sj1yZGY5laK5Mo=;
        b=IRw7krgn4oo+VEwf40+6J4MFGgqd9oKbEeTmn16OLR7IvsBXWiCWhGSJorRqb+aL0W
         qE4tqFHcSXYdkIY+AVbQC1wsmgZUNmm7Pwp7+IoAb5Q2apVKZCULbsEhTo2PgshKFJOn
         QwpMiqH/NlqHL8QOT0e6MVkG8ZQU166p4mQRB6aw8M2PQEShhvXOWxGwZ+1GzemxrIi2
         PEh8/J2Qukz48PmNhiZNqxfYw9Nx787h6AqXzof5ejT4YjLyU0EOmKDL7kYxfFatWq+/
         mmOPq7jheakLPLTLoUeUY6Y18F8+DGKnbsdcf+hMcIr2dQnMt2FfLo3hgaLElF9mglAk
         0oCA==
X-Gm-Message-State: AOAM533Hjgyo2WOtG8VjKRqLtGL5D+84g5L1wtWoYcKktRj7hvP2WBrZ
        /bmj2nxSeZ4eyy2QCvh92LbGdAqFSy6czDLLgicNHw==
X-Google-Smtp-Source: ABdhPJx9J1bIU6bHhGpNGQ4brFDMFFNfIyzdlnirgZrJOSCe9LO5Ysc+DA2CqJNjVLb6FJg1vAaP7fPFEEcGQ0yoxVM=
X-Received: by 2002:ab0:35c8:: with SMTP id x8mr3968146uat.72.1606332422949;
 Wed, 25 Nov 2020 11:27:02 -0800 (PST)
MIME-Version: 1.0
References: <1927370.1606323014@warthog.procyon.org.uk>
In-Reply-To: <1927370.1606323014@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 25 Nov 2020 20:26:52 +0100
Message-ID: <CAJfpegvc5FjU-X1DxNtPjJLgEp_gT228kqk2Va31nk7GjZbPBQ@mail.gmail.com>
Subject: Re: UAPI value collision: STATX_ATTR_MOUNT_ROOT vs STATX_ATTR_DAX
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, sandeen@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 5:57 PM David Howells <dhowells@redhat.com> wrote:
>
> Hi Linus, Miklos, Ira,
>
> It seems that two patches that got merged in the 5.8 merge window collided and
> no one noticed until now:
>
> 80340fe3605c0 (Miklos Szeredi     2020-05-14 184) #define STATX_ATTR_MOUNT_ROOT         0x00002000 /* Root of a mount */
> ...
> 712b2698e4c02 (Ira Weiny          2020-04-30 186) #define STATX_ATTR_DAX                        0x00002000 /* [I] File is DAX */
>
> The question is, what do we do about it?  Renumber one or both of the
> constants?

<uapi/linux/stat.h>:
 * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
 * semantically.  Where possible, the numerical value is picked to correspond
 * also.

<uapi/linux/fs.h>:
#define FS_DAX_FL 0x02000000 /* Inode is DAX */

The DAX one can be the same value as FS_DAX_FL, the placement (after
STATX_ATTR_VERITY, instead of before) seems to confirm this intention.

Not that I care too much, the important thing is to have distinct values.
Thanks,
Miklos
