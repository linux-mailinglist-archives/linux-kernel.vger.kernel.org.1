Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EDB2F02FF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 20:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbhAITBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 14:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbhAITBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 14:01:02 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72999C0617A2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 11:00:21 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x20so31019689lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6Uz/uNKuxv8kpeBK6zjNMwa2VjYpAJbjFDMrzffj6I=;
        b=B5MuZOKUiCj7xkpKI58UwPgj+2Ygq8bPiwFnSM6GgJ3giVH0HlyrHQVOus3hpeAH+e
         ihkFNtQrr7VFzpBW/oNSs7g/4YiRSUG5HnzO4DWt6vSIVmtECXfeVEUA3WxEVCPzhO83
         q5CbQWf/kWSe6EhP4nvdYTWFSoqBeuXlzrhSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6Uz/uNKuxv8kpeBK6zjNMwa2VjYpAJbjFDMrzffj6I=;
        b=XA9uidi1XuEgtpSr54bcW59vb1AA6novNXok8cjtGPB/uAD7WfzwnYuhrzktq4IKNg
         i6ER3ul78UH/QdBz+VSS1j07iAvqS+DMqRsEQ3v9n2vravnrss3hHKhcnPWs0k85rzcn
         u9Nea7Y2wWVKOerLYZVEqkME3mHmJGm77Ao2yxyQt4ou8uXtPeNV44ExMgHbYm6BmpPd
         XF4NlvygrFmbsHLJrXJrIC3dtHEqS0NfKPNlGMp7DBnIhdsnctVa+IKvVgyjLsvoeOts
         92pYcW1OJIV/vJxKzGjjTKY0HOxrjvHJMDUdKv3F9++qN+r+sphzeTEbXQEW63bd7XNz
         2Iug==
X-Gm-Message-State: AOAM532j+gYrQK6qCJqt0wUxGtaf8wWH45J+qJF4Gh1l+GzlONGVcBH8
        eCXCQg4x2Wxnkl1wFokq2XzN4uNYNDg42w==
X-Google-Smtp-Source: ABdhPJyo73xSzaVkKG5PkqTlZ1Q1xzSW2aYlc+V4nL8tYh35lHLNjGEe8ade5jfrmXpJUl2HuBEYmQ==
X-Received: by 2002:ac2:4d91:: with SMTP id g17mr3752771lfe.254.1610218818440;
        Sat, 09 Jan 2021 11:00:18 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 68sm2682704ljj.23.2021.01.09.11.00.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 11:00:17 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id o10so20200258lfl.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 11:00:17 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr3759713lfg.40.1610218817016;
 Sat, 09 Jan 2021 11:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20210109064602.GU6918@magnolia>
In-Reply-To: <20210109064602.GU6918@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Jan 2021 11:00:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibYWuriC4m-zjU10J65peMDAFTjY2EGjTV=COgg1saPw@mail.gmail.com>
Message-ID: <CAHk-=wibYWuriC4m-zjU10J65peMDAFTjY2EGjTV=COgg1saPw@mail.gmail.com>
Subject: Re: [PATCH] maintainers: update my email address
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 10:46 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> Change my email contact ahead of a likely painful eleven-month migration
> to a certain cobalt enteprisey groupware cloud product that will totally
> break my workflow.  Some day I may get used to having to email being
> sequestered behind both claret and cerulean oath2+sms 2fa layers, but
> for now I'll stick with keying in one password to receive an email vs.
> the required four.

So I appreciate this email coming from your old email address, but I
also just want to note that as long as you then use the oracle email
address for sending email, commit authorship, and "Signed-off-by:" (or
Acked-by etc) addresses, those tend to be the ones that _primarily_
get used when people then CC you on issues.

Well, at least that's how I work. The MAINTAINERS file tends to be the
secondary one.

But I wish you best of luck with the new email setup ;)

            Linus
