Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA3E1EE030
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 10:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgFDIz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 04:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgFDIz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:55:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05165C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:55:28 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l27so5229070ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1cyPRerltnuf6OiO7zJfaJBlJDvo/vDR9533o+NbRzk=;
        b=f+Lz97I9fYwRYsY1POv4BsWh7sUNv4BwjVfHmAFW+Z0LJmUxUd/I2VZj/A64TA7MPT
         pehLmYFlyB2KmT0oVWyHVVPADXZ4TH++UGj5eo9+51dg818r2EbyPG4wWWhVHyp98pBk
         Smrt++8CCAh/W90dkqBCeWHyBCw5gCvR/nIU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cyPRerltnuf6OiO7zJfaJBlJDvo/vDR9533o+NbRzk=;
        b=IyyFsYHPFdYl9rj3Zis3mq0iZpXXu+agUX47enPLC3Hb8gfJh44j8W56ui8kkeMLxF
         IjZyZM0+wYohzubb3rDCSLhPt8WhNcKst+1LQlDGrTxK0VAVUhMd3nWKjV4xYzFVRrAz
         YSKnsbASA5Q0BIR9io4ViluSgYq7G8SFIVCBrndGPT52IsNZyCMJsGgNqdUEmz6S3dGP
         rWNtGaR3tfdR5HwGFMxRGY1I/uDc8GNmNSdgr1tOErj+nHkAeba8iG5GmLzq+xwWw1KG
         AhBTqFnr1luDsg7TiBDqjids24gpk4E8PJSWcogZ7UyhuclILy3scRu/HXNKMKDJMOD4
         E/Nw==
X-Gm-Message-State: AOAM532zRgtGtpG18dedfMs7KbNAlTwRtpAbNYGeWuJoBj1Tq+QDzKz+
        9eOhu1TN01cWMP4yjcn3j0fvVE1WjrvbtyaphwB9Jg==
X-Google-Smtp-Source: ABdhPJzQs5HWOaGr4oBKOUkG5SV+qx7C50ZekirwI6OrNE+rcVx1U6hY4cJ6QS1W+QqIhe4fn6OY1LGz4Eio1g316Pc=
X-Received: by 2002:a17:906:1947:: with SMTP id b7mr2876662eje.320.1591260926736;
 Thu, 04 Jun 2020 01:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <874ks212uj.fsf@m5Zedd9JOGzJrf0>
In-Reply-To: <874ks212uj.fsf@m5Zedd9JOGzJrf0>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 4 Jun 2020 10:55:15 +0200
Message-ID: <CAJfpegux+mVxbBH7UbrGWHrQ-7Si211GwSED3h339nERgpeYJw@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: initialize error in ovl_copy_xattr
To:     Yuxuan Shui <yshuiv7@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 5:20 AM Yuxuan Shui <yshuiv7@gmail.com> wrote:
>
>
> In ovl_copy_xattr, if all the xattrs to be copied are overlayfs private
> xattrs, the copy loop will terminate without assigning anything to the
> error variable, thus returning an uninitialized value.
>
> If ovl_copy_xattr is called from ovl_clear_empty, this uninitialized
> error value is put into a pointer by ERR_PTR(), causing potential
> invalid memory accesses down the line.
>
> This commit initialize error with 0. This is the correct value because
> when there's no xattr to copy, because all xattrs are private,
> ovl_copy_xattr should succeed.
>
> This bug is discovered with the help of INIT_STACK_ALL and clang.
>
> Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>

Thanks, applied.

Miklos
