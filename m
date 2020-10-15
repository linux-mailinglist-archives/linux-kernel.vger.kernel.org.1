Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C5728F548
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbgJOOww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388348AbgJOOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:52:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C936C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:52:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a4so3422533lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bB0aML9iHly6lbfGENfyVAF9mzhMQjNP2v7ZMJRbBXc=;
        b=NYyuUoopM6Ye/9aTGGSOB131XjOnZjL/iS+3AOgzlbjqNBYntDH3hqF9Sa8z6T7qQO
         TFbfBig10huD73ZxXtbp6+MdY78PqWl46lNCDHJM4oMUiyPL/JbUuvpvSBlkaqgZ+tnf
         4zRprFMtakP7gVcQDwkAdzbbj2XVtPuDEL9MU8CfwnT1R/eg7qkNqGvCLhyf384K4Eut
         b5SOmAz6vqebc7qQRJZYfeOlodwWqVbroH95UIzhduCysDyNOWbP7yByoNfEyMNtzxlG
         STrJsFujUqu9tnOPCTY18x7xbvka2+B252zj3bRFlJvrvd7gKBrRxazqpkew1qU6YVZY
         V1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bB0aML9iHly6lbfGENfyVAF9mzhMQjNP2v7ZMJRbBXc=;
        b=NkqQeZedmhWjCIC0uNHQP/ZlBV+7HkNjm+Inu9mzo8076xN+Z4sIOE3z0BmOz9BLZF
         KTi+OqNUFSoC6Q28y+bpFkNnJ97eseDoP6klHPZHY8li1TxVyBtjrDXmHjWV0MXHgRdt
         F6U8zPmrKXt/2LJ/7t01XpVUWFyembYuFNukA0k+0tG4FQv/KVmzT3qRwnP/pyJba8+M
         cxYpG4p4rUtjBjzAQFFnLTv0YYOhiuRXOimK8cHG8aAGVFuOX/9lzU3iHyHHVXs7jVAN
         Wqm9uwcBWQnWzmt9Qh5sS2DzB70vZ5wzk+JIBsBenPiOs0IeGu3SCALYSQJM2VE5H0v7
         n7oA==
X-Gm-Message-State: AOAM532Do2D86QZAOMg6hKdKHWCnrSea47WlIP7bNgyuHqkSNhqaekst
        if7E/pN7fRTtAQeOJwVDq5ZBqpbOI2ssd7mTpLU=
X-Google-Smtp-Source: ABdhPJyx30xOfI/dCOEDwzdW1JN7ZaYBa0FLpSKwq8j154fT2ykNaCexw1AjUCzXXU/XmYTVCAGEXsCBq8BdXAsciwU=
X-Received: by 2002:a2e:9ccd:: with SMTP id g13mr1537362ljj.127.1602773570017;
 Thu, 15 Oct 2020 07:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201014175342.152712-1-jandryuk@gmail.com> <20201014175342.152712-3-jandryuk@gmail.com>
 <d8a8ed95-ed55-4ccf-1b54-8d97db908742@suse.com>
In-Reply-To: <d8a8ed95-ed55-4ccf-1b54-8d97db908742@suse.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 15 Oct 2020 10:52:38 -0400
Message-ID: <CAKf6xpv4Kborx8-0UvadyyzPRGg0TLfD1RWxmkM1PnfPKuXOaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] xen: Kconfig: nest Xen guest options
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 5:42 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wro=
te:
>
> On 14.10.20 19:53, Jason Andryuk wrote:
> > Moving XEN_512GB allows it to nest under XEN_PV.  That also allows
> > XEN_PVH to nest under XEN as a sibling to XEN_PV and XEN_PVHVM giving:
> >
> > [*]   Xen guest support
> > [*]     Xen PV guest support
> > [*]       Limit Xen pv-domain memory to 512GB
> > [*]       Xen PV Dom0 support
>
> This has currently a wrong text/semantics:
>
> It should be split to CONFIG_XEN_DOM0 and CONFIG_XEN_PV_DOM0.
>
> Otherwise the backends won't be enabled per default for a PVH-only
> config meant to be Dom0-capable.
>
> You don't have to do that in your patches if you don't want to, but
> I wanted to mention it with you touching this area of Kconfig.

Yes, good point.  I had not considered that.

> > [*]     Xen PVHVM guest support
> > [*]     Xen PVH guest support
> >
> > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks,
Jason
