Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ED228BBC1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389851AbgJLPYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388984AbgJLPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:24:54 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DAC0613D0;
        Mon, 12 Oct 2020 08:24:53 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id n65so9949763ybg.10;
        Mon, 12 Oct 2020 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPv7827Nls0k4D3zdHYccFHp2qugyVVdkpLdlibXylE=;
        b=jhTqLk8ziijLvUmU9B6FFv5qWVvghvIypTAAz4yDCb9Tsi07ce4ra6Lli4ckhNWrbA
         EDa+N9c5x2h9k4XpELr+JUw7zrtC6/HKjyfsYBKxiel+fSM+iDuFaswXd53hTourKfUp
         ZF69WNsQgr07CooGA4khxMVxCJFStjve1Jhw0I6T35ExN/wINwszRJ2AcDqrmaUsYA/9
         MDoIw7DuOQmKE5G4heILz7Sqhy0DeLMTmAmzOj6pebb6Y7WzUBIF2xFEh++TrYse8cK9
         +UPxQYwAClmqUW0SApmurYJ9osCJOZnWrz+t0aqH6ZFSYO/4JEfUAI3iUJsTsBfdB4GV
         ICVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPv7827Nls0k4D3zdHYccFHp2qugyVVdkpLdlibXylE=;
        b=g7iChwzBHL/e1B1QlfnxSd0U6iWG6cJ0iL8oR8NPsegS40nHV3a4bvYNz3tUk2HxJL
         QBMOJuxR8GF2wdsxqmms4nLUYBbenboZmX1PSkIfam/kQ8gnqPQjbTy6UhoY8dfquCIL
         O7WbdU5b3CWQPBOgV2HK0lySjS+iNeZvkDbgfkbogfY/SsoeKQcSvFUgGkiu/4R2dBL6
         xclrMbCI3aGBSZF/ChvkhcOI9SHlfTTrF1oksk2GC5TF3+xTP7hVUS3bSgn3bd4jAdWw
         Ak2wrrickgPxlohw7DfKWN2KpbjH19vLbe8sz3Oe/025I0Z8sAXAceSsjAsepItCqHIl
         fe9A==
X-Gm-Message-State: AOAM531DucJWz371GIh5IFiRhl4SB6Awv8yRK7gisPbEoaYEjLPwDyy7
        n4BcDadrhYAdbkgGwFPS+GiWKgTp8QnXEaQRzOU=
X-Google-Smtp-Source: ABdhPJzT3A0THw8y5w7vuVFfaZQvrSDF6frvTQvfecNoHOrr6gPbO1w+ylVW9oKfyAfyhRhKATdYfCiVF3YktX4UYHA=
X-Received: by 2002:a25:e046:: with SMTP id x67mr31850217ybg.342.1602516293133;
 Mon, 12 Oct 2020 08:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com> <alpine.DEB.2.21.2010121550300.6487@felia>
In-Reply-To: <alpine.DEB.2.21.2010121550300.6487@felia>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 12 Oct 2020 16:24:16 +0100
Message-ID: <CADVatmN7d+Oy5iHTUK=azHsvFq9+s0rdcjUTz5m_K4Xrf+JvZA@mail.gmail.com>
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Mon, Oct 12, 2020 at 3:11 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
>
>
> On Sun, 11 Oct 2020, Sudip Mukherjee wrote:
>
> > Add a comment explaining why find_tt() will not return error even though
> > find_tt() is checking for NULL and other errors.
> >
> > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
>
> I get the intent of the comment but there is a large risk that somebody
> could remove the find_tt() call before the calling the function and there
> is no chance to then see later that the comment is actually wrong.

Removing the find_tt() will mean a major rework of the code.

>
> I guess you want to link this comment here to a code line above and
> request anyone touching the line above to reconsider the comment then.
>
> But there is no 'concept' for such kind of requests to changes and
> comments.
>
> So, the comment is true now, but might be true or wrong later.

If it is wrong later due to some code change then I guess someone will
need to send a patch to correct the comment.

>
> I am wondering if such comment deserves to be included if we cannot check
> its validity later...

I am failing to understand why will you not be able to check its
validity later. You just need to read the code to check it.

>
> I would prefer a simple tool that could check that your basic assumption
> on the code is valid and if it the basic assumption is still valid,
> just shut up any stupid tool that simply does not get that these calls
> here cannot return any error.
>
> We encountered this issue because of clang analyzer complaining, but it is
> clear that it is a false positive of that (smart but) incomplete tool.

I dont think it is a false positive. The error return value is not
checked and that is true. Only that it is not applicable because of
the way the coding is done.

>
> Do you intend to add comment for all false positives from all tools or are
> we going to find a better solution than that?

I think tools will always give you some false positives and you will
need to read the code to know if its false positive or not. I dont
think there is any tool yet which will only give true positives.


-- 
Regards
Sudip
