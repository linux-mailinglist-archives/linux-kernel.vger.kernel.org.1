Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4772B13CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKMB1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgKMB1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:27:50 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA1FC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:27:50 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h15so7469233qkl.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HmLDKQifcLdaKwnv1yhpXrNGEbx7rBrNiP7sstYddQ=;
        b=DNmnD6DfRmrxx+VFgD5KSCTohfCGrsEHvQU66Hl/FDVsadmTIyh4AQrQTESYiF8XJg
         An5AMvPNcgj4n3ynzpkhnsUbzq/hUxLpow1gdEAewwc6E2LKkpTmYLSJ8o9ME1GpJu+b
         ftgDR64GM3EvZwhMZb5IC2LYy24jWubZ8l7AufSyFL+Dt+41R+YL4vSUQjiIvo+Oh4N+
         DBakCPea4cpcHnqPPU6SjjkfC9T9q8ckbgnsNU+FAwm2fnFf5/UI0l0iKoqHbycQBbUD
         PLj+40x9p7FnSndZVj5Cb9bgx2Bp3ABrVxjEARVvHLmYeKCVCBFMMoFhr3gLIExbmw/e
         X0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HmLDKQifcLdaKwnv1yhpXrNGEbx7rBrNiP7sstYddQ=;
        b=BrEDxthIy3H8CLKkMFcJTIM+2ousx+yjpXpMn632XATKkUCcIylSsp4xn8kS66mmDy
         fTp/2XWxSRoa7nRHBadYNQ7WJAD8+SXYCXhMUVTX0fYQgBGnHJtPtR8GrM1vR5KgZpo/
         AwBcuXGq4hBi+vV888b1LXVhcMQo4grHMqYO+M9M6bl4uZ5ldTAn/cInbDDpH2JH1FKF
         9S58M27nEFSo7sa9hOnG5Aed3KOAyxMYmJFZFXtvXBGPb0DTKxvXCpbnrVNJpNwPYqA3
         4Ua5z0jjgaOensNXd2q4PlRXxB1m56qv/Y1w6yVetShW3NyxfWmFshaekb1Z0/XmaVQs
         8P6w==
X-Gm-Message-State: AOAM533dY8FECMFNCTOb3IKb6d3SCedkRKyeXm0Fwt7XPAoEYgKWSWZH
        1Tu1aU+MsjuDecj3uId8Hh/2fQPXWdJYAbzg39tClZEe
X-Google-Smtp-Source: ABdhPJz+bEsMsrYDMuX0z2LsqM1R1/6iLmsSV0twpTjT8+GW21dHWhQZ7O4wIYZbfoBUDpP7bGITD8x35tYChvn2eB0=
X-Received: by 2002:ae9:de45:: with SMTP id s66mr2747117qkf.281.1605230869423;
 Thu, 12 Nov 2020 17:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20201113003633.8db2b4e4c5fecf8de0adfa65@kernel.org> <160520205132.303174.4876760192433315429.stgit@devnote2>
In-Reply-To: <160520205132.303174.4876760192433315429.stgit@devnote2>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Fri, 13 Nov 2020 09:27:38 +0800
Message-ID: <CADjb_WSx+sbxAz=p5dCN5PXzR5Zq2Nb3kgup-r8qNM1ftUMzDw@mail.gmail.com>
Subject: Re: [PATCH] bootconfig: Extend the magic check range to the preceding
 3 bytes
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 1:27 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Since Grub may align the size of initrd to 4 if user pass
> initrd from cpio, we have to check the preceding 3 bytes as well.
>
> Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
> Reported-by: Chen Yu <yu.chen.surf@gmail.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
Works for me, thanks!
Tested-by: Chen Yu <yu.chen.surf@gmail.com>

Best,
Chenyu
