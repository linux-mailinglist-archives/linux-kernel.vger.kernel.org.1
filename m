Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC2B2D46A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbgLIQVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbgLIQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:21:35 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D3FC0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 08:20:54 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id r24so1177289vsg.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 08:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftrjIMacRnCDUW60B5wDdWIgLtC6j6ITMAxZ0z4dcsk=;
        b=HgrvSW72NUDBACx2rcJOdsk9j2ywqmTiRhxzfml2ObmeS9/p68ApjmmEUiVuFFixel
         U8V/3sWV/jT/RnYtuN76/jqqa0beH35lqx0GkOdrSQB8kmGRwv6xH/mpxgBW9stqYh98
         TB1KeZ8zKUBTeHyC8I0eCxJ7EFkcfOUQYVVWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftrjIMacRnCDUW60B5wDdWIgLtC6j6ITMAxZ0z4dcsk=;
        b=KraaKTiJ04lA+pW9XaTODe085f1ZVMGOd3Sz8+o3ugD/DviyWQEXry9Z4yIqUEJa0y
         FKHSaY1ie0r5NWFGYOkzUs2SM7qr1L66+El/B0h/dqZn+/Q72NxBZH3/k7RghEYSfEmz
         eNuIPOoOYycPaCVTbk6t2CFcfDYwrn8Kipkj+qF3c0z3ruBB4PUPDjvneVlfm0/zi7hj
         tWSeHHERs9v/i9E9QJfxjfYtTJ0DdGDx+xTTCecf6d1j0fNtZikiDGWbVZkb/oEplc/Q
         Dg3+c/26sYkiD/p03VLwpOzvAO5SNJkVVjELqA3n6Nhw/LJoyJZjx/B6uAR+prXf6DsL
         k/Lw==
X-Gm-Message-State: AOAM5332Be+5F9kmy1RKdGXfFiexE9mZdLmgBA6DRZDSritMCED8GhDK
        lgj8pkNNEUY4Q6QJvvDkfuch8PNN5l0g14GyK/UI9w==
X-Google-Smtp-Source: ABdhPJzZZ3IkQz7rOL8NyykGCELcBs/amTcJ+Xv2OgUQT+RVIeDoKVuHGvs38tWdvxSIhPXmjhSG0BuRFZBayhnap/U=
X-Received: by 2002:a67:ed57:: with SMTP id m23mr2755029vsp.7.1607530854236;
 Wed, 09 Dec 2020 08:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-4-mszeredi@redhat.com>
 <CAOQ4uxhti+COYB3GhfMcPFwpfBRYQvr98oCO9wwS029W5e0A5g@mail.gmail.com> <CAJfpegsGpS=cym2NpnS6H-uMyLMKdbLpE1QxiDz4GQU1s-dYfg@mail.gmail.com>
In-Reply-To: <CAJfpegsGpS=cym2NpnS6H-uMyLMKdbLpE1QxiDz4GQU1s-dYfg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 9 Dec 2020 17:20:43 +0100
Message-ID: <CAJfpeguvt-Mia9YmT55q3R9tSFocpgq7FzjDKJgnaOEQsaBNVA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] ovl: check privs before decoding file handle
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 11:13 AM Miklos Szeredi <miklos@szeredi.hu> wrote:

> Hard link indexing should work without fh decoding, since it is only
> encoding the file handle to search for the index entry, and encoding
> is not privileged.

Tested this a bit and while hard link indexing does work,  inode
lookup is broken since it uses the origin inode as a key (which is not
available) instead of using the origin value directly.  This is
fixable, but needs a fair amount of restructuring, so let's just
postpone this and disable index for now, as you suggested.

Thanks,
Miklos
